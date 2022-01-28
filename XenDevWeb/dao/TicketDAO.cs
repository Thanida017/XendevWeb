using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using XenDevWeb.domain;

namespace XenDevWeb.dao
{
    public class TicketDAO
    {
        private XenDevWebDbContext ctx;
        public TicketDAO(XenDevWebDbContext ctx)
        {
            this.ctx = ctx;
        }

        public Ticket findById(long id, bool forUpdate)
        {
            List<Ticket> objs = null;
            if (forUpdate)
            {
                objs = (from e in ctx.tickets
                        where e.id == id && e.ticket_type == TICKET_TYPE.CLIENT
                        select e)
                        .ToList();
            }
            else
            {
                objs = (from e in ctx.tickets.AsNoTracking()
                        where e.id == id && e.ticket_type == TICKET_TYPE.CLIENT
                        select e)
                      .ToList();
            }

            return (objs != null && objs.Count > 0) ? objs[0] : null;
        }

        public Ticket findByStaffTicketTypeInternalId(long id, bool forUpdate)
        {
            List<Ticket> objs = null;
            if (forUpdate)
            {
                objs = (from e in ctx.tickets
                        where e.id == id && e.ticket_type == TICKET_TYPE.INTERNAL
                        select e)
                        .ToList();
            }
            else
            {
                objs = (from e in ctx.tickets.AsNoTracking()
                        where e.id == id && e.ticket_type == TICKET_TYPE.INTERNAL
                        select e)
                      .ToList();
            }

            return (objs != null && objs.Count > 0) ? objs[0] : null;
        }

        public Ticket findByStaffTicketTypeClientId(long id, bool forUpdate)
        {
            List<Ticket> objs = null;
            if (forUpdate)
            {
                objs = (from e in ctx.tickets
                        where e.id == id && e.ticket_type == TICKET_TYPE.CLIENT
                        select e)
                        .ToList();
            }
            else
            {
                objs = (from e in ctx.tickets.AsNoTracking()
                        where e.id == id && e.ticket_type == TICKET_TYPE.CLIENT
                        select e)
                      .ToList();
            }

            return (objs != null && objs.Count > 0) ? objs[0] : null;
        }

        public Ticket findByTicketNumberTicketTypeInternal(string ticketNumber, bool forUpdate)
        {
            List<Ticket> objs = null;
            if (forUpdate)
            {
                objs = (from e in ctx.tickets
                        select e)
                           .Where(i => i.ticketNumber != null && 
                                  i.ticketNumber.ToLower().CompareTo(ticketNumber.ToLower()) == 0 &&
                                  i.ticket_type == TICKET_TYPE.INTERNAL)
                           .ToList();
            }
            else
            {
                objs = (from e in ctx.tickets.AsNoTracking()
                        select e)
                           .Where(i => i.ticketNumber != null && 
                                  i.ticketNumber.ToLower().CompareTo(ticketNumber.ToLower()) == 0 &&
                                  i.ticket_type == TICKET_TYPE.INTERNAL)
                           .ToList();
            }

            return (objs != null && objs.Count > 0) ? objs[0] : null;
        }

        public Ticket findByTicketNumberTicketTypeClient(string ticketNumber, bool forUpdate)
        {
            List<Ticket> objs = null;
            if (forUpdate)
            {
                objs = (from e in ctx.tickets
                        select e)
                           .Where(i => i.ticketNumber != null &&
                                  i.ticketNumber.ToLower().CompareTo(ticketNumber.ToLower()) == 0 &&
                                  i.ticket_type == TICKET_TYPE.CLIENT)
                           .ToList();
            }
            else
            {
                objs = (from e in ctx.tickets.AsNoTracking()
                        select e)
                           .Where(i => i.ticketNumber != null &&
                                  i.ticketNumber.ToLower().CompareTo(ticketNumber.ToLower()) == 0 &&
                                  i.ticket_type == TICKET_TYPE.CLIENT)
                           .ToList();
            }

            return (objs != null && objs.Count > 0) ? objs[0] : null;
        }


        public List<Ticket> getAllProblems(long userId, bool forUpdate)
        {
            List<Ticket> objs = null;

            if (forUpdate)
            {
                objs = (from e in ctx.tickets
                        where e.requester != null && e.requester.id == userId
                              && e.ticket_type == TICKET_TYPE.CLIENT
                        select e)
                        .OrderBy(o => o.id)
                        .ToList();
            }
            else
            {
                objs = (from e in ctx.tickets.AsNoTracking()
                        where e.requester != null && e.requester.id == userId
                              && e.ticket_type == TICKET_TYPE.CLIENT
                        select e)
                        .OrderBy(o => o.id)
                        .ToList();
            }

            return objs;
        }
        
        public List<Ticket> getAllProblems(bool forUpdate)
        {
            List<Ticket> objs = null;

            if (forUpdate)
            {
                objs = (from e in ctx.tickets
                        select e)
                        .OrderBy(o => o.id)
                        .ToList();
            }
            else
            {
                objs = (from e in ctx.tickets.AsNoTracking()
                        select e)
                        .OrderBy(o => o.id)
                        .ToList();
            }

            return objs;
        }

        public List<Ticket> getAllProblemsStaff(bool forUpdate)
        {
            List<Ticket> objs = null;

            if (forUpdate)
            {
                objs = (from e in ctx.tickets
                        where e.ticket_type == TICKET_TYPE.INTERNAL
                        select e)
                        .OrderBy(o => o.id)
                        .ToList();
            }
            else
            {
                objs = (from e in ctx.tickets.AsNoTracking()
                        where e.ticket_type == TICKET_TYPE.INTERNAL
                        select e)
                        .OrderBy(o => o.id)
                        .ToList();
            }

            return objs;
        }
        
        public List<Ticket> getAllProblemsBydateFromTo(DateTime dateFrom, DateTime dateto, bool forUpdate)
        {
            List<Ticket> objs = null;

            if (forUpdate)
            {
                objs = (from e in ctx.tickets
                        where e.project != null && e.project.creationDate >= dateFrom &&
                              e.project.lastUpdate <= dateto
                        select e)
                        .OrderBy(o => o.id)
                        .ToList();
            }
            else
            {
                objs = (from e in ctx.tickets.AsNoTracking()
                        where e.project != null && e.project.creationDate >= dateFrom &&
                              e.project.lastUpdate <= dateto
                        select e)
                        .OrderBy(o => o.id)
                        .ToList();
            }

            return objs;
        }

        public List<Ticket> getAllProblemsTypeNew(DateTime dateFrom, DateTime dateto, bool forUpdate)
        {
            List<Ticket> objs = null;

            if (forUpdate)
            {
                objs = (from e in ctx.tickets
                        where e.project != null && e.project.creationDate >= dateFrom &&
                              e.project.lastUpdate <= dateto &&
                              e.status == TICKET_STATUS.NEW
                        select e)
                        .OrderBy(o => o.id)
                        .ToList();
            }
            else
            {
                objs = (from e in ctx.tickets.AsNoTracking()
                        where e.project != null && e.project.creationDate >= dateFrom &&
                              e.project.lastUpdate <= dateto &&
                              e.status == TICKET_STATUS.NEW
                        select e)
                        .OrderBy(o => o.id)
                        .ToList();
            }

            return objs;
        }

        public List<Ticket> getAllProblemsTypeON_REVIEW(DateTime dateFrom, DateTime dateto, bool forUpdate)
        {
            List<Ticket> objs = null;

            if (forUpdate)
            {
                objs = (from e in ctx.tickets
                        where e.project != null && e.project.creationDate >= dateFrom &&
                              e.project.lastUpdate <= dateto &&
                              e.status == TICKET_STATUS.ON_REVIEW
                        select e)
                        .OrderBy(o => o.id)
                        .ToList();
            }
            else
            {
                objs = (from e in ctx.tickets.AsNoTracking()
                        where e.project != null && e.project.creationDate >= dateFrom &&
                              e.project.lastUpdate <= dateto &&
                              e.status == TICKET_STATUS.ON_REVIEW
                        select e)
                        .OrderBy(o => o.id)
                        .ToList();
            }

            return objs;
        }

        public List<Ticket> getAllProblemsTypeASSIGNED(DateTime dateFrom, DateTime dateto, bool forUpdate)
        {
            List<Ticket> objs = null;

            if (forUpdate)
            {
                objs = (from e in ctx.tickets
                        where e.project != null && e.project.creationDate >= dateFrom &&
                              e.project.lastUpdate <= dateto &&
                              e.status == TICKET_STATUS.ASSIGNED
                        select e)
                        .OrderBy(o => o.id)
                        .ToList();
            }
            else
            {
                objs = (from e in ctx.tickets.AsNoTracking()
                        where e.project != null && e.project.creationDate >= dateFrom &&
                              e.project.lastUpdate <= dateto &&
                             e.status == TICKET_STATUS.ASSIGNED
                        select e)
                        .OrderBy(o => o.id)
                        .ToList();
            }

            return objs;
        }

        public List<Ticket> getAllProblemsTypeSOLVED(DateTime dateFrom, DateTime dateto, bool forUpdate)
        {
            List<Ticket> objs = null;

            if (forUpdate)
            {
                objs = (from e in ctx.tickets
                        where e.project != null && e.project.creationDate >= dateFrom &&
                              e.project.lastUpdate <= dateto &&
                              e.status == TICKET_STATUS.SOLVED
                        select e)
                        .OrderBy(o => o.id)
                        .ToList();
            }
            else
            {
                objs = (from e in ctx.tickets.AsNoTracking()
                        where e.project != null && e.project.creationDate >= dateFrom &&
                              e.project.lastUpdate <= dateto &&
                              e.status == TICKET_STATUS.SOLVED
                        select e)
                        .OrderBy(o => o.id)
                        .ToList();
            }

            return objs;
        }

        public List<Ticket> getAllProblemsTypeCLOSED(DateTime dateFrom, DateTime dateto, bool forUpdate)
        {
            List<Ticket> objs = null;

            if (forUpdate)
            {
                objs = (from e in ctx.tickets
                        where e.project != null && e.project.creationDate >= dateFrom &&
                              e.project.lastUpdate <= dateto &&
                              e.status == TICKET_STATUS.CLOSED
                        select e)
                        .OrderBy(o => o.id)
                        .ToList();
            }
            else
            {
                objs = (from e in ctx.tickets.AsNoTracking()
                        where e.project != null && e.project.creationDate >= dateFrom &&
                              e.project.lastUpdate <= dateto &&
                              e.status == TICKET_STATUS.CLOSED
                        select e)
                        .OrderBy(o => o.id)
                        .ToList();
            }

            return objs;
        }

        public List<Ticket> getAllProblemsTypeCANCEL(DateTime dateFrom, DateTime dateto, bool forUpdate)
        {
            List<Ticket> objs = null;

            if (forUpdate)
            {
                objs = (from e in ctx.tickets
                        where e.project != null && e.project.creationDate >= dateFrom &&
                              e.project.lastUpdate <= dateto &&
                              e.status == TICKET_STATUS.CANCEL
                        select e)
                        .OrderBy(o => o.id)
                        .ToList();
            }
            else
            {
                objs = (from e in ctx.tickets.AsNoTracking()
                        where e.project != null && e.project.creationDate >= dateFrom &&
                              e.project.lastUpdate <= dateto &&
                              e.status == TICKET_STATUS.CANCEL
                        select e)
                        .OrderBy(o => o.id)
                        .ToList();
            }

            return objs;
        }

        public void create(Ticket obj)
        {
            ctx.tickets.Add(obj);
            ctx.SaveChanges();
        }

        public void update(Ticket obj)
        {
            bool isAttched = ctx.ChangeTracker.Entries<Ticket>().Any(e => e.Entity.id == obj.id);
            if (!isAttched)
            {
                ctx.tickets.Attach(obj);
                ctx.Entry(obj).State = System.Data.Entity.EntityState.Modified;
                ctx.SaveChanges();
                ctx.Detach(obj);
            }
            else
            {
                ctx.SaveChanges();
            }
        }

        public void delete(Ticket obj)
        {
            ctx.tickets.Remove(obj);
            ctx.SaveChanges();
        }

        public string getNextTicketNumber()
        {
            string prefix = "MLT";  //MetaLink Ticket

            string seqSQL = @"DECLARE @ReturnValue INT
                              EXEC @ReturnValue = GetNextTicketValue
                              SELECT @ReturnValue";
            List<int> ids = ctx.Database.SqlQuery<int>(seqSQL).ToList();
            int runningNumber = ids[0];
            string result = string.Format("{0}{1:yyMMdd}-{2:D4}", prefix
                                                               , DateTime.Now
                                                               , runningNumber);


            return result;
        }
    }
}