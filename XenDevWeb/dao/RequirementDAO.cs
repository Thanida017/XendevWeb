using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using XenDevWeb.domain;

namespace XenDevWeb.dao
{
    public class RequirementDAO
    {
        private XenDevWebDbContext ctx;

        public RequirementDAO(XenDevWebDbContext ctx)
        {
            this.ctx = ctx;
        }

        public Requirement findById(long id, bool forUpdate)
        {
            List<Requirement> objs = null;
            if (forUpdate)
            {
                objs = (from e in ctx.requirements
                        select e)
                           .Where(i => i.id == id)
                           .ToList();
            }
            else
            {
                objs = (from e in ctx.requirements.AsNoTracking()
                        select e)
                         .Where(i => i.id == id)
                         .ToList();
            }

            return (objs != null && objs.Count > 0) ? objs[0] : null;
        }

        public Requirement findByCode(string code, bool forUpdate)
        {
            List<Requirement> objs = null;
            if (forUpdate)
            {
                objs = (from e in ctx.requirements
                        select e)
                        .Where(i => i.code != null && i.code.ToLower().CompareTo(code.ToLower()) == 0)
                        .ToList();
            }
            else
            {
                objs = (from e in ctx.requirements.AsNoTracking()
                        select e)
                        .Where(i => i.code != null && i.code.ToLower().CompareTo(code.ToLower()) == 0)
                        .ToList();
            }

            return (objs != null && objs.Count > 0) ? objs[0] : null;
        }

        public Requirement findByTitle(string title, bool forUpdate)
        {
            List<Requirement> objs = null;
            if (forUpdate)
            {
                objs = (from e in ctx.requirements
                        select e)
                        .Where(i => i.title != null && i.title.CompareTo(title) == 0)
                        .ToList();
            }
            else
            {
                objs = (from e in ctx.requirements.AsNoTracking()
                        select e)
                        .Where(i => i.title != null && i.title.CompareTo(title) == 0)
                        .ToList();
            }

            return (objs != null && objs.Count > 0) ? objs[0] : null;
        }

        public void create(Requirement c)
        {
            ctx.requirements.Add(c);
            ctx.SaveChanges();
        }

        public void update(Requirement c)
        {
            bool isAttched = ctx.ChangeTracker.Entries<Requirement>().Any(e => e.Entity.id == c.id);
            if (!isAttched)
            {
                ctx.requirements.Attach(c);
                ctx.Entry(c).State = System.Data.Entity.EntityState.Modified;
                ctx.SaveChanges();
                ctx.Detach(c);
            }
            else
            {
                ctx.SaveChanges();
            }
        }

        public void delete(Requirement c)
        {
            ctx.requirements.Remove(c);
            ctx.SaveChanges();
        }

        public List<Requirement> getAllRequirement(bool forUpdate)
        {
            if (forUpdate)
            {
                return (from e in ctx.requirements
                        select e)
                        .OrderByDescending(i => i.lastUpDate)
                        .ToList();
            }


            return (from e in ctx.requirements.AsNoTracking()
                    select e)
                        .OrderByDescending(i => i.lastUpDate)
                        .ToList();
        }

	public List<Requirement> getRequirementByProject(long projectId, bool forUpdate)
        {
            List<Requirement> objs = null;
            if (forUpdate)
            {
                objs = (from e in ctx.requirements
                        where e.meetingNote != null && e.meetingNote.project != null &&
                              e.meetingNote.project.id == projectId &&
                              e.status != REQUIREMENT_STATUS.CANCEL &&
                              e.status != REQUIREMENT_STATUS.COMPOSING
                        select e)
                       .OrderByDescending(o => o.creationDate)
                       .ToList();
            }
            else
            {
                objs = (from e in ctx.requirements.AsNoTracking()
                        where e.meetingNote != null && e.meetingNote.project != null &&
                              e.meetingNote.project.id == projectId &&
                              e.status != REQUIREMENT_STATUS.CANCEL &&
                              e.status != REQUIREMENT_STATUS.COMPOSING
                        select e)
                       .OrderByDescending(o => o.creationDate)
                       .ToList();

            }
            return objs;
        }

        public Requirement getLastId(bool forUpdate)
        {
            List<Requirement> objs = null;
            if (forUpdate)
            {
                objs = (from e in ctx.requirements
                        select e)
                           .OrderByDescending(i => i.lastUpDate)
                           .ToList();
            }
            else
            {
                objs = (from e in ctx.requirements.AsNoTracking()
                        select e)
                         .OrderByDescending(i => i.lastUpDate)
                         .ToList();
            }

            return (objs != null && objs.Count > 0) ? objs[0] : null;
        }

    }
}