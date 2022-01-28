using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using XenDevWeb.domain;

namespace XenDevWeb.dao
{
    public class EmailServerDAO
    {
        private XenDevWebDbContext ctx;

        public EmailServerDAO(XenDevWebDbContext ctx)
        {
            this.ctx = ctx;
        }

        public void create(EmailServer obj)
        {
            ctx.emailServers.Add(obj);
            ctx.SaveChanges();
        }

        public void update(EmailServer c)
        {
            bool isAttched = ctx.ChangeTracker.Entries<EmailServer>().Any(e => e.Entity.id == c.id);

            if (!isAttched)
            {
                ctx.emailServers.Attach(c);
                ctx.Entry(c).State = System.Data.Entity.EntityState.Modified;
                ctx.SaveChanges();
                ctx.Detach(c);
            }
            else
            {
                ctx.SaveChanges();
            }
        }

        public EmailServer getRecentRecord(bool forUpdate)
        {
            List<EmailServer> objs = null;

            if (forUpdate)
            {
                objs = (from e in ctx.emailServers
                        select e)
                        .OrderByDescending(o => o.id)
                        .ToList();
            }
            else
            {
                objs = (from e in ctx.emailServers.AsNoTracking()
                        select e)
                        .OrderByDescending(o => o.id)
                        .ToList();
            }
            return (objs != null && objs.Count > 0) ? objs[0] : null;
        }
    }
}