using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using XenDevWeb.domain;

namespace XenDevWeb.dao
{
    public class TicketAssignmentDAO
    {
        private XenDevWebDbContext ctx;
        public TicketAssignmentDAO(XenDevWebDbContext ctx)
        {
            this.ctx = ctx;
        }

        public TicketAssignment findById(long id, bool forUpdate)
        {
            List<TicketAssignment> objs = null;
            if (forUpdate)
            {
                objs = (from e in ctx.ticketAssignments
                        select e)
                        .Where(i => i.id == id)
                        .ToList();
            }
            else
            {
                objs = (from e in ctx.ticketAssignments.AsNoTracking()
                         select e)
                        .Where(i => i.id == id)
                        .ToList();
            }

            return (objs != null && objs.Count > 0) ? objs[0] : null;
        }

        public TicketAssignment findByAssignTo(long id, bool forUpdate)
        {
            List<TicketAssignment> objs = null;
            if (forUpdate)
            {
                objs = (from e in ctx.ticketAssignments
                        select e)
                        .Where(i => i.assignTo.id == id)
                        .ToList();
            }
            else
            {
                objs = (from e in ctx.ticketAssignments.AsNoTracking()
                        select e)
                        .Where(i => i.assignTo.id == id)
                        .ToList();
            }

            return (objs != null && objs.Count > 0) ? objs[0] : null;
        }

        public TicketAssignment findByTicketID(long id, bool forUpdate)
        {
            List<TicketAssignment> objs = null;
            if (forUpdate)
            {
                objs = (from e in ctx.ticketAssignments
                        select e)
                        .Where(i => i.ticket.id == id)
                        .ToList();
            }
            else
            {
                objs = (from e in ctx.ticketAssignments.AsNoTracking()
                        select e)
                        .Where(i => i.ticket.id == id)
                        .ToList();
            }

            return (objs != null && objs.Count > 0) ? objs[0] : null;
        }

        public List<TicketAssignment> getAllTicketTypeInternalById(long id, bool forUpdate)
        {
            List<TicketAssignment> objs = null;

            if (forUpdate)
            {
                objs = (from e in ctx.ticketAssignments
                        where e.ticket != null && e.ticket.id == id &&
                        e.ticket.ticket_type == TICKET_TYPE.INTERNAL
                        select e)
                        .OrderBy(o => o.id)
                        .ToList();
            }
            else
            {
                objs = (from e in ctx.ticketAssignments.AsNoTracking()
                        where e.ticket != null && e.ticket.id == id &&
                        e.ticket.ticket_type == TICKET_TYPE.INTERNAL
                        select e)
                        .OrderBy(o => o.id)
                        .ToList();
            }

            return objs;
        }

        public List<TicketAssignment> getAllTicketTypeClientById(long id, bool forUpdate)
        {
            List<TicketAssignment> objs = null;

            if (forUpdate)
            {
                objs = (from e in ctx.ticketAssignments
                        where e.ticket != null && e.ticket.id == id &&
                        e.ticket.ticket_type == TICKET_TYPE.CLIENT
                        select e)
                        .OrderBy(o => o.id)
                        .ToList();
            }
            else
            {
                objs = (from e in ctx.ticketAssignments.AsNoTracking()
                        where e.ticket != null && e.ticket.id == id &&
                        e.ticket.ticket_type == TICKET_TYPE.CLIENT
                        select e)
                        .OrderBy(o => o.id)
                        .ToList();
            }

            return objs;
        }

        public List<TicketAssignment> getAllTicketByAssignToId(long id, bool forUpdate)
        {
            List<TicketAssignment> objs = null;

            if (forUpdate)
            {
                objs = (from e in ctx.ticketAssignments
                        where e.assignTo != null && e.assignTo.id == id
                        select e)
                        .OrderBy(o => o.id)
                        .ToList();
            }
            else
            {
                objs = (from e in ctx.ticketAssignments.AsNoTracking()
                        where e.assignTo != null && e.assignTo.id == id
                        select e)
                        .OrderBy(o => o.id)
                        .ToList();
            }

            return objs;
        }

        public List<TicketAssignment> getAllTicketAssignments(bool forUpdate)
        {
            List<TicketAssignment> objs = null;

            if (forUpdate)
            {
                objs = (from e in ctx.ticketAssignments
                        select e)
                        .OrderBy(o => o.id)
                        .ToList();
            }
            else
            {
                objs = (from e in ctx.ticketAssignments.AsNoTracking()
                        select e)
                        .OrderBy(o => o.id)
                        .ToList();
            }

            return objs;
        }
        
        public void create(TicketAssignment obj)
        {
            ctx.ticketAssignments.Add(obj);
            ctx.SaveChanges();
        }

        public void update(TicketAssignment obj)
        {
            bool isAttched = ctx.ChangeTracker.Entries<Ticket>().Any(e => e.Entity.id == obj.id);
            if (!isAttched)
            {
                ctx.ticketAssignments.Attach(obj);
                ctx.Entry(obj).State = System.Data.Entity.EntityState.Modified;
                ctx.SaveChanges();
                ctx.Detach(obj);
            }
            else
            {
                ctx.SaveChanges();
            }
        }

        public void delete(TicketAssignment obj)
        {
            ctx.ticketAssignments.Remove(obj);
            ctx.SaveChanges();
        }

        public List<TicketAssignment> getAllTickets(bool forUpdate)
        {
            List<TicketAssignment> objs = null;

            if (forUpdate)
            {
                objs = (from e in ctx.ticketAssignments
                        where e.ticket != null
                        select e)
                        .OrderBy(o => o.ticket.id)
                        .ToList();
            }
            else
            {
                objs = (from e in ctx.ticketAssignments.AsNoTracking()
                        where e.ticket != null
                        select e)
                        .OrderBy(o => o.ticket.id)
                        .ToList();
            }

            return objs;
        }
    }
}