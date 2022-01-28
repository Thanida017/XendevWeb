using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using XenDevWeb.domain;

namespace XenDevWeb.dao
{
    public class EstimationRequestDAO
    {
        private XenDevWebDbContext ctx;

        public EstimationRequestDAO(XenDevWebDbContext ctx)
        {
            this.ctx = ctx;
        }

        public EstimationRequest findById(long id, bool forUpdate)
        {
            List<EstimationRequest> objs = null;
            if (forUpdate)
            {
                objs = (from e in ctx.estimationRequests
                        select e)
                           .Where(i => i.id == id)
                           .ToList();
            }
            else
            {
                objs = (from e in ctx.estimationRequests.AsNoTracking()
                        select e)
                         .Where(i => i.id == id)
                         .ToList();
            }

            return (objs != null && objs.Count > 0) ? objs[0] : null;
        }

        public EstimationRequest findByCompanyName(string company, bool forUpdate)
        {
            List<EstimationRequest> objs = null;
            if (forUpdate)
            {
                objs = (from e in ctx.estimationRequests
                        select e)
                           .Where(i => i.companyName.ToLower().CompareTo(company.ToLower()) == 0)
                           .ToList();
            }
            else
            {
                objs = (from e in ctx.estimationRequests.AsNoTracking()
                        select e)
                         .Where(i => i.companyName.ToLower().CompareTo(company.ToLower()) == 0)
                         .ToList();
            }

            return (objs != null && objs.Count > 0) ? objs[0] : null;
        }

        public EstimationRequest findByProjectName(string project, bool forUpdate)
        {
            List<EstimationRequest> objs = null;
            if (forUpdate)
            {
                objs = (from e in ctx.estimationRequests
                        select e)
                           .Where(i => i.projectName.ToLower().CompareTo(project.ToLower()) == 0)
                           .ToList();
            }
            else
            {
                objs = (from e in ctx.estimationRequests.AsNoTracking()
                        select e)
                         .Where(i => i.projectName.ToLower().CompareTo(project.ToLower()) == 0)
                         .ToList();
            }

            return (objs != null && objs.Count > 0) ? objs[0] : null;
        }

        public void create(EstimationRequest c)
        {
            ctx.estimationRequests.Add(c);
            ctx.SaveChanges();
        }

        public void update(EstimationRequest c)
        {
            bool isAttched = ctx.ChangeTracker.Entries<EstimationRequest>().Any(e => e.Entity.id == c.id);
            if (!isAttched)
            {
                ctx.estimationRequests.Attach(c);
                ctx.Entry(c).State = System.Data.Entity.EntityState.Modified;
                ctx.SaveChanges();
                ctx.Detach(c);
            }
            else
            {
                ctx.SaveChanges();
            }
        }

        public void delete(EstimationRequest c)
        {
            ctx.estimationRequests.Remove(c);
            ctx.SaveChanges();
        }

        public List<EstimationRequest> getAllEstimations(bool forUpdate)
        {
            List<EstimationRequest> objs = null;

            if (forUpdate)
            {
                objs = (from e in ctx.estimationRequests
                        select e)
                        .OrderBy(o => o.id)
                        .ToList();
            }
            else
            {
                objs = (from e in ctx.estimationRequests.AsNoTracking()
                        select e)
                        .OrderBy(o => o.id)
                        .ToList();
            }

            return objs;
        }
    }
}