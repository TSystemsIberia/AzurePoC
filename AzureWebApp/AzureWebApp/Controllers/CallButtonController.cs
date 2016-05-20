using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace AzureWebApp.Controllers
{
    public class CallButtonController : Controller
    {
        // GET: CallButton
        public ActionResult CBEndPoint()
        {
            // add CallButton data in the header
            Response.AddHeader("Wakeup", "255m");
            Response.Charset = "us-ascii";
            return View();
        }
    }
}