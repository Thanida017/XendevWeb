using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using XenDevWeb.domain;

namespace XenDevWeb.dao
{
    public class RejectReasonDAO
    {
        private XenDevWebDbContext ctx;

        public RejectReasonDAO(XenDevWebDbContext ctx)
        {
            this.ctx = ctx;
        }

        public RejectReason findById(long id, bool forUpdate)
        {
            List<RejectReason> objs = null;
            if (forUpdate)
            {
                objs = (from e in ctx.rejectReasons
                        select e)
                           .Where(i => i.id == id)
                           .ToList();
            }
            else
            {
                objs = (from e in ctx.rejectReasons.AsNoTracking()
                        select e)
                         .Where(i => i.id == id)
                         .ToList();
            }

            return (objs != null && objs.Count > 0) ? objs[0] : null;
        }

        public RejectReason findByCode(string code, bool forUpdate)
        {
            List<RejectReason> objs = null;
            if (forUpdate)
            {
                objs = (from e in ctx.rejectReasons
                               select e)
                        .Where(i => i.code != null && i.code.CompareTo(code) == 0)
                        .ToList();
            }
            else
            {
                objs = (from e in ctx.rejectReasons.AsNoTracking()
                               select e)
                        .Where(i => i.code != null && i.code.CompareTo(code) == 0)
                        .ToList();
            }

            return (objs != null && objs.Count > 0) ? objs[0] : null;
        }

        public void create(RejectReason c)
        {
            ctx.rejectReasons.Add(c);
            ctx.SaveChanges();
        }

        public void update(RejectReason c)
        {
            bool isAttched = ctx.ChangeTracker.Entries<RejectReason>().Any(e => e.Entity.id == c.id);
            if (!isAttched)
            {
                ctx.rejectReasons.Attach(c);
                ctx.Entry(c).State = System.Data.Entity.EntityState.Modified;
                ctx.SaveChanges();
                ctx.Detach(c);
            }
            else
            {
                ctx.SaveChanges();
            }
        }

        public void delete(RejectReason c)
        {
            ctx.rejectReasons.Remove(c);
            ctx.SaveChanges();
        }

        public List<RejectReason> getAllRejectReason(bool forUpdate)
        {
            if (forUpdate)
            {
                return (from e in ctx.rejectReasons
                        select e)
                        .OrderBy(i => i.name)
                        .ToList();
            }


            return (from e in ctx.rejectReasons.AsNoTracking()
                    select e)
                        .OrderBy(i => i.name)
                        .ToList();
        }
    }
}