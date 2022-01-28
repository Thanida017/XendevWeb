using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using XenDevWeb.domain;

namespace XenDevWeb.dao
{
    public class ProjectMandaysDAO
    {
        private XenDevWebDbContext ctx;

        public ProjectMandaysDAO(XenDevWebDbContext ctx)
        {
            this.ctx = ctx;
        }

        public ProjectMandays findById(long id, bool forUpdate)
        {
            List<ProjectMandays> objs = null;
            if (forUpdate)
            {
                objs = (from e in ctx.projectMandays
                        select e)
                           .Where(i => i.id == id)
                           .ToList();
            }
            else
            {
                objs = (from e in ctx.projectMandays.AsNoTracking()
                        select e)
                         .Where(i => i.id == id)
                         .ToList();
            }

            return (objs != null && objs.Count > 0) ? objs[0] : null;
        }

        public ProjectMandays findByPONumber(string poNumber, bool forUpdate)
        {
            List<ProjectMandays> objs = null;
            if (forUpdate)
            {
                objs = (from e in ctx.projectMandays
                        select e)
                           .Where(i => i.poNumber != null && i.poNumber.ToLower().CompareTo(poNumber.ToLower()) == 0)
                           .ToList();
            }
            else
            {
                objs = (from e in ctx.projectMandays.AsNoTracking()
                        select e)
                         .Where(i => i.poNumber != null && i.poNumber.ToLower().CompareTo(poNumber.ToLower()) == 0)
                         .ToList();
            }

            return (objs != null && objs.Count > 0) ? objs[0] : null;
        }

        public void create(ProjectMandays c)
        {
            ctx.projectMandays.Add(c);
            ctx.SaveChanges();
        }

        public void update(ProjectMandays c)
        {
            bool isAttched = ctx.ChangeTracker.Entries<ProjectMandays>().Any(e => e.Entity.id == c.id);
            if (!isAttched)
            {
                ctx.projectMandays.Attach(c);
                ctx.Entry(c).State = System.Data.Entity.EntityState.Modified;
                ctx.SaveChanges();
                ctx.Detach(c);
            }
            else
            {
                ctx.SaveChanges();
            }
        }

        public void delete(ProjectMandays c)
        {
            ctx.projectMandays.Remove(c);
            ctx.SaveChanges();
        }

        public List<ProjectMandays> getAllProjectMandays(bool forUpdate)
        {
            if (forUpdate)
            {
                return (from e in ctx.projectMandays
                        select e).ToList();
            }


            return (from e in ctx.projectMandays.AsNoTracking()
                    select e).ToList();
        }

        public ProjectMandays findByProjectId(long id, bool forUpdate)
        {
            List<ProjectMandays> objs = null;
            if (forUpdate)
            {
                objs = (from e in ctx.projectMandays
                        select e)
                           .Where(i => i.project.id == id)
                           .ToList();
            }
            else
            {
                objs = (from e in ctx.projectMandays.AsNoTracking()
                        select e)
                         .Where(i => i.project.id == id)
                         .ToList();
            }

            return (objs != null && objs.Count > 0) ? objs[0] : null;
        }

        public List<ProjectMandays> getAllProjectMandaysByProjectId(long id, bool forUpdate)
        {
            List<ProjectMandays> objs = null;

            if (forUpdate)
            {
                objs = (from e in ctx.projectMandays
                        where e.project != null && e.project.id == id
                        select e)
                        .OrderBy(o => o.id)
                        .ToList();
            }
            else
            {
                objs = (from e in ctx.projectMandays.AsNoTracking()
                        where e.project != null && e.project.id == id
                        select e)
                        .OrderBy(o => o.id)
                        .ToList();
            }

            return objs;
        }
    }
}