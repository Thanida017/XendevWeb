using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using XenDevWeb.domain;

namespace XenDevWeb.dao
{
    public class ApprovalTransactionsDAO
    {
        private XenDevWebDbContext ctx;

        public ApprovalTransactionsDAO(XenDevWebDbContext ctx)
        {
            this.ctx = ctx;
        }

        public ApprovalTransactions findById(long id, bool forUpdate)
        {
            List<ApprovalTransactions> objs = null;
            if (forUpdate)
            {
                objs = (from e in ctx.approvalTransactions
                        select e)
                       .Where(e => e.id == id)
                       .ToList();
            }
            else
            {
                objs = (from e in ctx.approvalTransactions.AsNoTracking()
                        select e)
                      .Where(e => e.id == id)
                      .ToList();
            }

            return (objs != null && objs.Count > 0) ? objs[0] : null;
        }

        public List<ApprovalTransactions> getAllApprovalTransactions(bool forUpdate)
        {
            List<ApprovalTransactions> objs = null;
            if (forUpdate)
            {
                objs = (from e in ctx.approvalTransactions
                        select e)
                       .OrderBy(o => o.id)
                       .ToList();
            }
            else
            {
                objs = (from e in ctx.approvalTransactions.AsNoTracking()
                        select e)
                       .OrderBy(o => o.id)
                       .ToList();

            }
            return objs;
        }

        public void create(ApprovalTransactions c)
        {
            ctx.approvalTransactions.Add(c);
            ctx.SaveChanges();
        }

        public void update(ApprovalTransactions c)
        {
            bool isAttched = ctx.ChangeTracker.Entries<ApprovalTransactions>().Any(e => e.Entity.id == c.id);
            if (!isAttched)
            {
                ctx.approvalTransactions.Attach(c);
                ctx.Entry(c).State = System.Data.Entity.EntityState.Modified;
                ctx.SaveChanges();
                ctx.Detach(c);
            }
            else
            {
                ctx.SaveChanges();
            }
        }

        public void delete(ApprovalTransactions c)
        {
            ctx.approvalTransactions.Remove(c);
            ctx.SaveChanges();
        }
    }
}