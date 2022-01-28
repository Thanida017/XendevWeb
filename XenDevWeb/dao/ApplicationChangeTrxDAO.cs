using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using XenDevWeb.domain;

namespace XenDevWeb.dao
{
    public class ApplicationChangeTrxDAO
    {
        private XenDevWebDbContext ctx;

        public ApplicationChangeTrxDAO(XenDevWebDbContext ctx)
        {
            this.ctx = ctx;
        }

        public ApplicationChangeTrx findById(long id, bool forUpdate)
        {
            List<ApplicationChangeTrx> objs = null;
            if (forUpdate)
            {
                objs = (from e in ctx.applicationChangeTrxs
                        select e)
                           .Where(i => i.id == id)
                           .ToList();
            }
            else
            {
                objs = (from e in ctx.applicationChangeTrxs.AsNoTracking()
                        select e)
                         .Where(i => i.id == id)
                         .ToList();
            }

            return (objs != null && objs.Count > 0) ? objs[0] : null;
        }

        public void create(ApplicationChangeTrx c)
        {
            ctx.applicationChangeTrxs.Add(c);
            ctx.SaveChanges();
        }

        public void update(ApplicationChangeTrx c)
        {
            bool isAttched = ctx.ChangeTracker.Entries<ApplicationChangeTrx>().Any(e => e.Entity.id == c.id);
            if (!isAttched)
            {
                ctx.applicationChangeTrxs.Attach(c);
                ctx.Entry(c).State = System.Data.Entity.EntityState.Modified;
                ctx.SaveChanges();
                ctx.Detach(c);
            }
            else
            {
                ctx.SaveChanges();
            }
        }

        public void delete(ApplicationChangeTrx c)
        {
            ctx.applicationChangeTrxs.Remove(c);
            ctx.SaveChanges();
        }

        public List<ApplicationChangeTrx> getAllApplicationChangeTrx(bool forUpdate)
        {
            if (forUpdate)
            {
                return (from e in ctx.applicationChangeTrxs
                        select e)
                        .OrderBy(i => i.creationDate)
                        .ToList();
            }


            return (from e in ctx.applicationChangeTrxs.AsNoTracking()
                    select e)
                        .OrderBy(i => i.creationDate)
                        .ToList();
        }
    }
}