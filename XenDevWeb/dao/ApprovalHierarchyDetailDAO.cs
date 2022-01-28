using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using XenDevWeb.domain;

namespace XenDevWeb.dao
{
    public class ApprovalHierarchyDetailDAO
    {
        private XenDevWebDbContext ctx;

        public ApprovalHierarchyDetailDAO(XenDevWebDbContext ctx)
        {
            this.ctx = ctx;
        }

        public ApprovalHierarchyDetail findById(long id, bool forUpdate)
        {
            List<ApprovalHierarchyDetail> objs = null;
            if (forUpdate)
            {
                objs = (from e in ctx.approvalHierarchyDetails
                        where e.id == id
                        select e)
                        .ToList();
            }
            else
            {
                objs = (from e in ctx.approvalHierarchyDetails.AsNoTracking()
                        where e.id == id
                        select e)
                      .ToList();
            }

            return (objs != null && objs.Count > 0) ? objs[0] : null;
        }

        public List<ApprovalHierarchyDetail> getAllApprovalHierachyById(long id ,bool forUpdate)
        {
            List<ApprovalHierarchyDetail> objs = null;

            if (forUpdate)
            {
                objs = (from e in ctx.approvalHierarchyDetails
                        where e.approvalHierachy.id == id && e.isEnabled == true
                        select e)
                        .OrderBy(o => o.id)
                        .ToList();
            }
            else
            {
                objs = (from e in ctx.approvalHierarchyDetails.AsNoTracking()
                        where e.approvalHierachy.id == id && e.isEnabled == true
                        select e)
                        .OrderBy(o => o.id)
                        .ToList();
            }

            return objs;
        }

        public List<ApprovalHierarchyDetail> getAllApprovalHierachyByIdAndUserCompanyId(long id, long uaComId, bool forUpdate)
        {
            List<ApprovalHierarchyDetail> objs = null;

            if (forUpdate)
            {
                objs = (from e in ctx.approvalHierarchyDetails
                        where e.approvalHierachy.id == id && e.approvalHierachy.project.company.id == uaComId && e.isEnabled == true
                        select e)
                        .OrderBy(o => o.id)
                        .ToList();
            }
            else
            {
                objs = (from e in ctx.approvalHierarchyDetails.AsNoTracking()
                        where e.approvalHierachy.id == id && e.approvalHierachy.project.company.id == uaComId && e.isEnabled == true
                        select e)
                        .OrderBy(o => o.id)
                        .ToList();
            }

            return objs;
        }

        public List<ApprovalHierarchyDetail> getAllApprovalHierachyDetail(bool forUpdate)
        {
            List<ApprovalHierarchyDetail> objs = null;

            if (forUpdate)
            {
                objs = (from e in ctx.approvalHierarchyDetails
                        select e)
                        .OrderBy(o => o.id)
                        .ToList();
            }
            else
            {
                objs = (from e in ctx.approvalHierarchyDetails.AsNoTracking()
                        select e)
                        .OrderBy(o => o.id)
                        .ToList();
            }

            return objs;
        }

        public void create(ApprovalHierarchyDetail obj)
        {
            ctx.approvalHierarchyDetails.Add(obj);
            ctx.SaveChanges();
        }

        public void update(ApprovalHierarchyDetail obj)
        {
            bool isAttched = ctx.ChangeTracker.Entries<ApprovalHierarchyDetail>().Any(e => e.Entity.id == obj.id);
            if (!isAttched)
            {
                ctx.approvalHierarchyDetails.Attach(obj);
                ctx.Entry(obj).State = System.Data.Entity.EntityState.Modified;
                ctx.SaveChanges();
                ctx.Detach(obj);
            }
            else
            {
                ctx.SaveChanges();
            }
        }

        public void delete(ApprovalHierarchyDetail obj)
        {
            ctx.approvalHierarchyDetails.Remove(obj);
            ctx.SaveChanges();
        }

        public List<ApprovalHierarchyDetail> getNextApprovalHier(long projectId, APPROVAL_TYPE flowType, bool forUpdate)
        {
            List<ApprovalHierarchyDetail> objs = null;
            if (forUpdate)
            {
                objs = (from e in ctx.approvalHierarchyDetails
                        where e.approvalHierachy.approval_type == flowType &&
                              e.isEnabled &&
                              e.approvalHierachy.isEnabled &&
                              e.approvalHierachy.project.id == projectId
                        select e)
                        .OrderBy(o => o.authority)
                        .ToList();
            }
            else
            {
                objs = (from e in ctx.approvalHierarchyDetails.AsNoTracking()
                        where e.approvalHierachy.approval_type == flowType &&
                              e.isEnabled &&
                              e.approvalHierachy.isEnabled &&
                              e.approvalHierachy.project.id == projectId
                        select e)
                        .OrderBy(o => o.authority)
                        .ToList();
            }
            return objs;
        }

    }
}