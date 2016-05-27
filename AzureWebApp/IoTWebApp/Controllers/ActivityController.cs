using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using IoTPoC.Data.Model;

namespace AzureWebApp.Controllers
{
    public class ActivityController : Controller
    {
        private IoTPoCDBEntities db = new IoTPoCDBEntities();

        // GET: Activity
        public ActionResult Index()
        {
            var activityLogSet = db.ActivityLogSet.Include(a => a.Device);
            return View(activityLogSet.ToList());
        }

        // GET: Activity
        public ActionResult ViewLogParams(long? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            ActivityLog activityLog = db.ActivityLogSet.Find(id);
            if (activityLog == null)
            {
                return HttpNotFound();
            }
            return View(activityLog.LogParams.ToList());
        }

        // GET: Activity/Details/5
        public ActionResult Details(long? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            ActivityLog activityLog = db.ActivityLogSet.Find(id);
            if (activityLog == null)
            {
                return HttpNotFound();
            }
            return View(activityLog);
        }

        // GET: Activity/Create
        public ActionResult Create()
        {
            ViewBag.FK_DeviceId = new SelectList(db.DeviceSet, "Id", "Name");
            return View();
        }

        // POST: Activity/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "Id,LogTime,LogRequest,SourceIP,FK_DeviceId")] ActivityLog activityLog)
        {
            if (ModelState.IsValid)
            {
                db.ActivityLogSet.Add(activityLog);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.FK_DeviceId = new SelectList(db.DeviceSet, "Id", "Name", activityLog.FK_DeviceId);
            return View(activityLog);
        }

        // GET: Activity/Edit/5
        public ActionResult Edit(long? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            ActivityLog activityLog = db.ActivityLogSet.Find(id);
            if (activityLog == null)
            {
                return HttpNotFound();
            }
            ViewBag.FK_DeviceId = new SelectList(db.DeviceSet, "Id", "Name", activityLog.FK_DeviceId);
            return View(activityLog);
        }

        // POST: Activity/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "Id,LogTime,LogRequest,SourceIP,FK_DeviceId")] ActivityLog activityLog)
        {
            if (ModelState.IsValid)
            {
                db.Entry(activityLog).State = System.Data.Entity.EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.FK_DeviceId = new SelectList(db.DeviceSet, "Id", "Name", activityLog.FK_DeviceId);
            return View(activityLog);
        }

        // GET: Activity/Delete/5
        public ActionResult Delete(long? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            ActivityLog activityLog = db.ActivityLogSet.Find(id);
            if (activityLog == null)
            {
                return HttpNotFound();
            }
            return View(activityLog);
        }

        // POST: Activity/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(long id)
        {
            ActivityLog activityLog = db.ActivityLogSet.Find(id);
            db.ActivityLogSet.Remove(activityLog);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
