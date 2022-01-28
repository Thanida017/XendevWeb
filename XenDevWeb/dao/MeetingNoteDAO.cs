using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using XenDevWeb.domain;

namespace XenDevWeb.dao
{
    public class MeetingNoteDAO
    {
        private XenDevWebDbContext ctx;

        public MeetingNoteDAO(XenDevWebDbContext ctx)
        {
            this.ctx = ctx;
        }

        public MeetingNote findById(long id, bool forUpdate)
        {
            List<MeetingNote> objs = null;
            if (forUpdate)
            {
                objs = (from e in ctx.meetingNotes
                        select e)
                           .Where(i => i.id == id)
                           .ToList();
            }
            else
            {
                objs = (from e in ctx.meetingNotes.AsNoTracking()
                        select e)
                         .Where(i => i.id == id)
                         .ToList();
            }

            return (objs != null && objs.Count > 0) ? objs[0] : null;
        }

        public void create(MeetingNote c)
        {
            try
            {
                ctx.meetingNotes.Add(c);
                ctx.SaveChanges();
            }
            catch(Exception ex)
            {

            }
           
        }

        public void update(MeetingNote c)
        {
            bool isAttched = ctx.ChangeTracker.Entries<MeetingNote>().Any(e => e.Entity.id == c.id);
            if (!isAttched)
            {
                ctx.meetingNotes.Attach(c);
                ctx.Entry(c).State = System.Data.Entity.EntityState.Modified;
                ctx.SaveChanges();
                ctx.Detach(c);
            }
            else
            {
                ctx.SaveChanges();
            }
        }

        public void delete(MeetingNote c)
        {
            ctx.meetingNotes.Remove(c);
            ctx.SaveChanges();
        }

        public List<MeetingNote> getAllMeetingNotes(bool forUpdate)
        {
            if (forUpdate)
            {
                return (from e in ctx.meetingNotes
                        select e)
                        .OrderBy(i => i.id)
                        .ToList();
            }


            return (from e in ctx.meetingNotes.AsNoTracking()
                    select e)
                        .OrderBy(i => i.id)
                        .ToList();
        }

        public List<MeetingNote> getAllMeetingNoteFromProjectId(long projectd, bool forUpdate)
        {
            List<MeetingNote> objs = null;
            if (forUpdate)
            {
                objs = (from e in ctx.meetingNotes
                        where e.project.id == projectd
                        select e)
                       .OrderBy(o => o.id)
                       .ToList();
            }
            else
            {
                objs = (from e in ctx.meetingNotes.AsNoTracking()
                        where e.project.id == projectd
                        select e)
                       .OrderBy(o => o.id)
                       .ToList();

            }
            return objs;
        }

        public List<MeetingNote> getAllNote(long projectId, DateTime dateFrom, DateTime dateTo, bool forUpdate)
        {
            List<MeetingNote> objs = null;
            if (forUpdate)
            {
                objs = (from e in ctx.meetingNotes
                        where e.creationDate >= dateFrom
                            && e.creationDate <= dateTo
                            && e.project.id == projectId
                        select e)
                       .ToList();
            }
            else
            {
                objs = (from e in ctx.meetingNotes.AsNoTracking()
                        where e.creationDate >= dateFrom
                            && e.creationDate <= dateTo
                            && e.project.id == projectId
                        select e)
                       .ToList();

            }
            return objs;
        }

        public List<MeetingNote> getAllNoteEnable(long projectId, DateTime dateFrom, DateTime dateTo, bool forUpdate)
        {
            List<MeetingNote> objs = null;
            if (forUpdate)
            {
                objs = (from e in ctx.meetingNotes
                        where e.creationDate >= dateFrom
                            && e.creationDate <= dateTo
                            && e.project.id == projectId
                            && e.isEnabled
                        select e)
                       .ToList();
            }
            else
            {
                objs = (from e in ctx.meetingNotes.AsNoTracking()
                        where e.creationDate >= dateFrom
                            && e.creationDate <= dateTo
                            && e.project.id == projectId
                            && e.isEnabled
                        select e)
                       .ToList();

            }
            return objs;
        }
    }
}