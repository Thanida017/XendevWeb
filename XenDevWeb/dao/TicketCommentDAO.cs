using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using XenDevWeb.domain;

namespace XenDevWeb.dao
{
    public class TicketCommentDAO
    {
        private XenDevWebDbContext ctx;

        public TicketCommentDAO(XenDevWebDbContext ctx)
        {
            this.ctx = ctx;
        }

        public TicketComment findById(long id, bool forUpdate)
        {
            List<TicketComment> objs = null;
            if (forUpdate)
            {
                objs = (from e in ctx.ticketComments
                        where e.id == id
                        select e)
                        .ToList();
            }
            else
            {
                objs = (from e in ctx.ticketComments.AsNoTracking()
                        where e.id == id
                        select e)
                      .ToList();
            }

            return (objs != null && objs.Count > 0) ? objs[0] : null;
        }

        public TicketComment findByTicketId(long id, bool forUpdate)
        {
            List<TicketComment> objs = null;
            if (forUpdate)
            {
                objs = (from e in ctx.ticketComments
                        where e.ticket.id == id
                        select e)
                        .ToList();
            }
            else
            {
                objs = (from e in ctx.ticketComments.AsNoTracking()
                        where e.ticket.id == id
                        select e)
                      .ToList();
            }

            return (objs != null && objs.Count > 0) ? objs[0] : null;
        }


        public List<TicketComment> getAllTicketComments(bool forUpdate)
        {
            List<TicketComment> objs = null;

            if (forUpdate)
            {
                objs = (from e in ctx.ticketComments
                        select e)
                        .OrderBy(o => o.id)
                        .ToList();
            }
            else
            {
                objs = (from e in ctx.ticketComments.AsNoTracking()
                        select e)
                        .OrderBy(o => o.id)
                        .ToList();
            }

            return objs;
        }

        public List<TicketComment> getAllTicketCommentsByTicketId(long id , bool forUpdate)
        {
            List<TicketComment> objs = null;

            if (forUpdate)
            {
                objs = (from e in ctx.ticketComments
                        where e.ticket != null && e.ticket.id == id
                        select e)
                        .OrderBy(o => o.id)
                        .ToList();
            }
            else
            {
                objs = (from e in ctx.ticketComments.AsNoTracking()
                        where e.ticket != null && e.ticket.id == id
                        select e)
                        .OrderBy(o => o.id)
                        .ToList();
            }

            return objs;
        }

        public void create(TicketComment obj)
        {
            ctx.ticketComments.Add(obj);
            ctx.SaveChanges();
        }

        public void update(TicketComment obj)
        {
            bool isAttched = ctx.ChangeTracker.Entries<TicketComment>().Any(e => e.Entity.id == obj.id);
            if (!isAttched)
            {
                ctx.ticketComments.Attach(obj);
                ctx.Entry(obj).State = System.Data.Entity.EntityState.Modified;
                ctx.SaveChanges();
                ctx.Detach(obj);
            }
            else
            {
                ctx.SaveChanges();
            }
        }

        public void delete(TicketComment obj)
        {
            ctx.ticketComments.Remove(obj);
            ctx.SaveChanges();
        }
    }
}