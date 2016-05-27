using System;
using System.Linq;
using System.Web.Mvc;
using System.Diagnostics;
using System.Data.Entity.Validation;

using IoTPoC.Data.Model;

namespace AzureWebApp.Controllers
{
    public class CallButtonController : Controller
    {
        // GET: CallButton
        public ActionResult CBEndPoint()
        {
            // track request
            logRequest();

            // process response
            processResponse();

            return View();
        }

        private void processResponse()
        {
            // add CallButton data in the header
            Response.AddHeader("Wakeup", "255m");
            Response.Charset = "us-ascii";
        }

        private void logRequest()
        {
            // track request
            var logInfo = new CallButtonLog();
            logInfo.LogTime = DateTime.Now;
            logInfo.LogRequest = Request.Url.ToString();
            logInfo.Ip = Request.UserHostAddress;

            var cbName = Request.QueryString["cbname"];
            var callButton = findOrCreateCallButtonDevice(cbName);
            if (callButton.Id != 0)
            {
                logInfo.CallButtonDeviceId = callButton.Id;
            }
            else
            {
                logInfo.CallButtonDevice = callButton;
            }

            // process params
            var logParms = Request.QueryString.Count;
            if (logParms > 0)
            {
                //logInfo.CallButtonLogParams = new CallButtonLogParams[logParms];

                for (int i = 0; i < logParms; i++)
                {
                    var logParam = new CallButtonLogParams();

                    logParam.Param = Request.QueryString.GetKey(i);
                    logParam.Value = Request.QueryString.Get(i);
                    logInfo.CallButtonLogParams.Add(logParam);
                }
            }

            // save info into the database
            persistLogInfo(logInfo);
        }

        private void persistLogInfo(CallButtonLog logInfo)
        {
            // persists into db
            using (IoTPoCDBEntities dbIoTPoC = new IoTPoCDBEntities())
            {
                try
                {
                    dbIoTPoC.CallButtonLogSet.Add(logInfo);
                    dbIoTPoC.SaveChanges();
                }
                catch (DbEntityValidationException dbEx)
                {
                    foreach (var validationErrors in dbEx.EntityValidationErrors)
                    {
                        foreach (var validationError in validationErrors.ValidationErrors)
                        {
                            Trace.TraceInformation("Property: {0} Error: {1}",
                                                    validationError.PropertyName,
                                                    validationError.ErrorMessage);
                        }
                    }
                }
            }
        }

        private CallButtonDevice findOrCreateCallButtonDevice(string cbName)
        {
            CallButtonDevice device = null;

            // persists into db
            using (IoTPoCDBEntities dbIoTPoC = new IoTPoCDBEntities())
            {
                device = (from devices in dbIoTPoC.CallButtonDeviceSet
                    where devices.Name == cbName
                    select devices).FirstOrDefault();
                }

            if (device == null)
            {
                device = new CallButtonDevice();
                device.Name = cbName;
                device.MAC = "NOTREGISTRED";
            }

            return device;
        }
    }
}