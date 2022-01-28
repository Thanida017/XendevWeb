using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using XenDevWeb.domain;

namespace XenDevWeb.dao
{
    public class ApplicationChangeDAO
    {
        private XenDevWebDbContext ctx;

        public ApplicationChangeDAO(XenDevWebDbContext ctx)
        {
            this.ctx = ctx;
        }

        public ApplicationChange findById(long id, bool forUpdate)
        {
            List<ApplicationChange> objs = null;
            if (forUpdate)
            {
                objs = (from e in ctx.applicationChanges
                        select e)
                           .Where(i => i.id == id)
                           .ToList();
            }
            else
            {
                objs = (from e in ctx.applicationChanges.AsNoTracking()
                        select e)
                         .Where(i => i.id == id)
                         .ToList();
            }

            return (objs != null && objs.Count > 0) ? objs[0] : null;
        }

        public ApplicationChange findByCode(string code, bool forUpdate)
        {
            List<ApplicationChange> objs = null;
            if (forUpdate)
            {
                objs = (from e in ctx.applicationChanges
                        select e)
                           .Where(i => i.changeCode == code)
                           .ToList();
            }
            else
            {
                objs = (from e in ctx.applicationChanges.AsNoTracking()
                        select e)
                         .Where(i => i.changeCode == code)
                         .ToList();
            }

            return (objs != null && objs.Count > 0) ? objs[0] : null;
        }

        public void create(ApplicationChange c)
        {
            ctx.applicationChanges.Add(c);
            ctx.SaveChanges();
        }

        public void update(ApplicationChange c)
        {
            bool isAttched = ctx.ChangeTracker.Entries<ApplicationChange>().Any(e => e.Entity.id == c.id);
            if (!isAttched)
            {
                ctx.applicationChanges.Attach(c);
                ctx.Entry(c).State = System.Data.Entity.EntityState.Modified;
                ctx.SaveChanges();
                ctx.Detach(c);
            }
            else
            {
                ctx.SaveChanges();
            }
        }

        public void delete(ApplicationChange c)
        {
            ctx.applicationChanges.Remove(c);
            ctx.SaveChanges();
        }

        public List<ApplicationChange> getAllApplicationChange(bool forUpdate)
        {
            if (forUpdate)
            {
                return (from e in ctx.applicationChanges
                        select e)
                        .OrderBy(i => i.changeCode)
                        .ToList();
            }


            return (from e in ctx.applicationChanges.AsNoTracking()
                    select e)
                        .OrderBy(i => i.changeCode)
                        .ToList();
        }

        public List<ApplicationChange> getAllApplicationChange(bool forUpdate, long projectId)
        {
            if (forUpdate)
            {
                return (from e in ctx.applicationChanges
                        select e)
                        .Where(e => e.appAsset != null && e.appAsset.project != null
                                     && e.appAsset.project.id == projectId)
                        .OrderBy(i => i.changeCode)
                        .ToList();
            }


            return (from e in ctx.applicationChanges.AsNoTracking()
                    select e)
                    .Where(e => e.appAsset != null && e.appAsset.project != null
                                     && e.appAsset.project.id == projectId)
                    .OrderBy(i => i.changeCode)
                    .ToList();
        }
    }
}