using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using XenDevWeb.domain;

namespace XenDevWeb.dao
{
    public class ReportDAO
    {
        private XenDevWebDbContext ctx;

        public ReportDAO(XenDevWebDbContext ctx)
        {
            this.ctx = ctx;
        }

        public Report findById(long id, bool forUpdate)
        {
            List<Report> objs = null;
            if (forUpdate)
            {
                objs = (from e in ctx.reports
                        select e)
                           .Where(i => i.id == id)
                           .ToList();
            }
            else
            {
                objs = (from e in ctx.reports.AsNoTracking()
                        select e)
                         .Where(i => i.id == id)
                         .ToList();
            }

            return (objs != null && objs.Count > 0) ? objs[0] : null;
        }

        public Report findByName(string name, bool forUpdate)
        {
            List<Report> objs = null;
            if (forUpdate)
            {
                objs = (from e in ctx.reports
                        select e)
                           .Where(i => i.name.ToLower().CompareTo(name.ToLower()) == 0)
                           .ToList();
            }
            else
            {
                objs = (from e in ctx.reports.AsNoTracking()
                        select e)
                         .Where(i => i.name.ToLower().CompareTo(name.ToLower()) == 0)
                         .ToList();
            }

            return (objs != null && objs.Count > 0) ? objs[0] : null;
        }

        public void create(Report c)
        {
            ctx.reports.Add(c);
            ctx.SaveChanges();
        }

        public void update(Report c)
        {
            bool isAttched = ctx.ChangeTracker.Entries<Report>().Any(e => e.Entity.id == c.id);
            if (!isAttched)
            {
                ctx.reports.Attach(c);
                ctx.Entry(c).State = System.Data.Entity.EntityState.Modified;
                ctx.SaveChanges();
                ctx.Detach(c);
            }
            else
            {
                ctx.SaveChanges();
            }
        }

        public void delete(Report c)
        {
            ctx.reports.Remove(c);
            ctx.SaveChanges();
        }

        public List<Report> getAllReports(bool forUpdate)
        {
            List<Report> objs = null;

            if (forUpdate)
            {
                objs = (from e in ctx.reports
                        select e)
                        .OrderBy(o => o.id)
                        .ToList();
            }
            else
            {
                objs = (from e in ctx.reports.AsNoTracking()
                        select e)
                        .OrderBy(o => o.id)
                        .ToList();
            }

            return objs;
        }
    }
}