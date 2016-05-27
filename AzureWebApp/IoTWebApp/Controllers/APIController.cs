using System;
using System.Linq;
using System.Web.Mvc;
using System.Diagnostics;
using System.Data.Entity.Validation;

using IoTPoC.Data.Model;

namespace AzureWebApp.Controllers
{
    public class APIController : Controller
    {
        // GET: NotifiyInfo
        public ActionResult NotifyInfo()
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
            var logInfo = new ActivityLog();
            logInfo.LogTime = DateTime.Now;
            logInfo.LogRequest = Request.Url.ToString();
            logInfo.SourceIP = Request.UserHostAddress;

            var cbName = Request.QueryString["cbname"];
            var callButton = findOrCreateCallButtonDevice(cbName);
            if (callButton.Id != 0)
            {
                logInfo.FK_DeviceId = callButton.Id;
            }
            else
            {
                logInfo.Device = callButton;
            }

            // process params
            var logParms = Request.QueryString.Count;
            if (logParms > 0)
            {
                //logInfo.CallButtonLogParams = new CallButtonLogParams[logParms];

                for (int i = 0; i < logParms; i++)
                {
                    var logParam = new LogParams();

                    logParam.Param = Request.QueryString.GetKey(i);
                    logParam.Value = Request.QueryString.Get(i);
                    logInfo.LogParams.Add(logParam);
                }
            }

            // save info into the database
            persistLogInfo(logInfo);
        }

        private void persistLogInfo(ActivityLog logInfo)
        {
            // persists into db
            using (IoTPoCDBEntities dbIoTPoC = new IoTPoCDBEntities())
            {
                try
                {
                    dbIoTPoC.ActivityLogSet.Add(logInfo);
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
                    throw dbEx;
                }
            }
        }

        private Device findOrCreateCallButtonDevice(string cbName)
        {
            Device device = null;

            // persists into db
            using (IoTPoCDBEntities dbIoTPoC = new IoTPoCDBEntities())
            {
                device = (from devices in dbIoTPoC.DeviceSet
                    where devices.Name == cbName
                    select devices).FirstOrDefault();
                }

            if (device == null)
            {
                device = new Device();
                device.Name = cbName;
                device.MAC = "NOTREGISTRED";
                device.Type = "UNKNOWN";
            }

            return device;
        }
    }
}