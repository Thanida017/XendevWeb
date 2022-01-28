using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using XenDevWeb.domain;

namespace XenDevWeb.dao
{
    public class ApprovalHierarchyDAO
    {
        private XenDevWebDbContext ctx;

        public ApprovalHierarchyDAO(XenDevWebDbContext ctx)
        {
            this.ctx = ctx;
        }

        public ApprovalHierarchy findById(long id, bool forUpdate)
        {
            List<ApprovalHierarchy> objs = null;
            if (forUpdate)
            {
                objs = (from e in ctx.approvalHierarchies
                        where e.id == id
                        select e)
                        .ToList();
            }
            else
            {
                objs = (from e in ctx.approvalHierarchies.AsNoTracking()
                        where e.id == id
                        select e)
                      .ToList();
            }

            return (objs != null && objs.Count > 0) ? objs[0] : null;
        }

        public ApprovalHierarchy findByCode(string code, bool forUpdate)
        {
            if (code == null || code.Length == 0)
            {
                return null;
            }

            List<ApprovalHierarchy> objs = null;
            if (forUpdate)
            {
                objs = (from e in ctx.approvalHierarchies
                        where e.code != null && e.code.Trim().ToLower().CompareTo(code.Trim().ToLower()) == 0
                        select e).OrderBy(o => o.code).ToList();
            }
            else
            {
                objs = (from e in ctx.approvalHierarchies.AsNoTracking()
                        where e.code != null && e.code.Trim().ToLower().CompareTo(code.Trim().ToLower()) == 0
                        select e).OrderBy(o => o.code).ToList();
            }
            return (objs != null && objs.Count > 0) ? objs[0] : null;
        }

        public List<ApprovalHierarchy> getAllApprovalHierachy(bool forUpdate)
        {
            List<ApprovalHierarchy> objs = null;

            if (forUpdate)
            {
                objs = (from e in ctx.approvalHierarchies
                        select e)
                        .OrderBy(o => o.id)
                        .ToList();
            }
            else
            {
                objs = (from e in ctx.approvalHierarchies.AsNoTracking()
                        select e)
                        .OrderBy(o => o.id)
                        .ToList();
            }

            return objs;
        }

        public List<ApprovalHierarchy> getAllApprovalHierachyByUserCompanyId(long id, bool forUpdate)
        {
            List<ApprovalHierarchy> objs = null;

            if (forUpdate)
            {
                objs = (from e in ctx.approvalHierarchies
                        where e.project.company.id == id
                        select e)
                        .OrderBy(o => o.id)
                        .ToList();
            }
            else
            {
                objs = (from e in ctx.approvalHierarchies.AsNoTracking()
                        where e.project.company.id == id
                        select e)
                        .OrderBy(o => o.id)
                        .ToList();
            }

            return objs;
        }

        public List<ApprovalHierarchy> getAllApprovalHierachyIdByUserCompanyId(long ahId, long uaComId, bool forUpdate)
        {
            List<ApprovalHierarchy> objs = null;

            if (forUpdate)
            {
                objs = (from e in ctx.approvalHierarchies
                        where e.id == ahId && e.project.company.id == uaComId && e.isEnabled == true
                        select e)
                        .OrderBy(o => o.id)
                        .ToList();
            }
            else
            {
                objs = (from e in ctx.approvalHierarchies.AsNoTracking()
                        where e.id == ahId && e.project.company.id == uaComId && e.isEnabled == true
                        select e)
                        .OrderBy(o => o.id)
                        .ToList();
            }

            return objs;
        }

        public List<ApprovalHierarchy> getApprovalEnabled(bool forUpdate)
        {
            List<ApprovalHierarchy> objs = null;

            if (forUpdate)
            {
                objs = (from e in ctx.approvalHierarchies
                        select e)
                        .Where(o => o.isEnabled == true)
                        .OrderBy(o => o.id)
                        .ToList();
            }
            else
            {
                objs = (from e in ctx.approvalHierarchies.AsNoTracking()
                        select e)
                        .Where(o => o.isEnabled == true)
                        .OrderBy(o => o.id)
                        .ToList();
            }

            return objs;
        }

        public void create(ApprovalHierarchy obj)
        {
            ctx.approvalHierarchies.Add(obj);
            ctx.SaveChanges();
        }

        public void update(ApprovalHierarchy obj)
        {
            bool isAttched = ctx.ChangeTracker.Entries<ApprovalHierarchy>().Any(e => e.Entity.id == obj.id);
            if (!isAttched)
            {
                ctx.approvalHierarchies.Attach(obj);
                ctx.Entry(obj).State = System.Data.Entity.EntityState.Modified;
                ctx.SaveChanges();
                ctx.Detach(obj);
            }
            else
            {
                ctx.SaveChanges();
            }
        }

        public void delete(ApprovalHierarchy obj)
        {
            ctx.approvalHierarchies.Remove(obj);
            ctx.SaveChanges();
        }
    }
}