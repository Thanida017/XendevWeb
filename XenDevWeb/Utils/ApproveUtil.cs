using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using XenDevWeb.dao;
using XenDevWeb.domain;

namespace XenDevWeb.Utils
{
    public class ApproveUtil
    {
        public XenDevWebDbContext ctx { get; set; }

        public ApproveUtil(XenDevWebDbContext ctx)
        {
            this.ctx = ctx;
        }

        public ApplicationChangeTrx getNextAppChangeApprover(ApplicationChange changeWithTracking)
        {
            ApprovalHierarchyDetailDAO ahDAO = new ApprovalHierarchyDetailDAO(this.ctx);
            List<ApprovalHierarchyDetail> details = ahDAO.getNextApprovalHier(changeWithTracking.appAsset.project.id,
                                                                              APPROVAL_TYPE.HIER_APP_CHANGE,
                                                                              true);
            if (details == null || details.Count == 0)
            {
                return null;
            }

            ApplicationChangeTrx act = null;

            //1. If no approval before, return the first step
            if (changeWithTracking.approvalTrxes == null || changeWithTracking.approvalTrxes.Count == 0)
            {
                act = new ApplicationChangeTrx();
                act.approvalDetail = details[0];
                act.applicationChange = changeWithTracking;
                act.status = APP_CHANGE_TRX_STATUS.NEW;
                act.creationDate = DateTime.Now;
                act.lastUpdate = DateTime.Now;
            }
            //2. find next step
            else
            {
                int currentStep = changeWithTracking.approvalTrxes.Select(o => o.approvalDetail.authority)
                                                                         .Max();

                //2.1 Extract all approve with the same authority level
                List<ApprovalHierarchyDetail> sameLevels = details.Where(o => o.authority == currentStep).ToList();

                //2.2 check that the same level had all approved
                List<int> assignedUserIds = changeWithTracking.approvalTrxes
                                                              .Select(o => o.approvalDetail.userAccount.id).ToList();
                List<ApprovalHierarchyDetail> unAssignedSameLevel = sameLevels.Where(o => assignedUserIds.Contains(o.userAccount.id) == false)
                                                                              .ToList();

                //2.3 there is someone at the same level exists
                if (unAssignedSameLevel != null && unAssignedSameLevel.Count > 0)
                {
                    act = new ApplicationChangeTrx();
                    act.approvalDetail = unAssignedSameLevel[0];
                    act.applicationChange = changeWithTracking;
                    act.status = APP_CHANGE_TRX_STATUS.NEW;
                    act.creationDate = DateTime.Now;
                    act.lastUpdate = DateTime.Now;
                }
                else
                {
                    //2.4 find someone at higher level
                    List<ApprovalHierarchyDetail> higherLevels = details.Where(o => o.authority > currentStep)
                                                                        .OrderBy(o => o.authority)
                                                                        .ToList();
                    if (higherLevels == null || higherLevels.Count == 0)
                    {
                        return null;
                    }

                    act = new ApplicationChangeTrx();
                    act.approvalDetail = higherLevels[0];
                    act.applicationChange = changeWithTracking;
                    act.status = APP_CHANGE_TRX_STATUS.NEW;
                    act.creationDate = DateTime.Now;
                    act.lastUpdate = DateTime.Now;
                }
            }

            return act;
        }

        public ApprovalTransactions getNextRequirementApprover(Requirement reqWithTracking)
        {
            ApprovalHierarchyDetailDAO ahDAO = new ApprovalHierarchyDetailDAO(this.ctx);
            List<ApprovalHierarchyDetail> details = ahDAO.getNextApprovalHier(reqWithTracking.meetingNote.project.id,
                                                                              APPROVAL_TYPE.HIER_REQUIREMENT,
                                                                              true);
            if (details == null || details.Count == 0)
            {
                return null;
            }

            ApprovalTransactions att = null;

            //1. If no approval before, return the first step
            if (reqWithTracking.approvalTrxes == null || reqWithTracking.approvalTrxes.Count == 0)
            {
                att = new ApprovalTransactions();
                att.approvalDetail = details[0];
                att.requirement = reqWithTracking;
                att.status = APPROVAL_STATUS.APPROVAL_TYPE_NEW;
                att.creationDate = DateTime.Now;
                att.lastUpdate = DateTime.Now;
            }
            //2. find next step
            else
            {
                int currentStep = reqWithTracking.approvalTrxes.Select(o => o.approvalDetail.authority)
                                                                         .Max();

                //2.1 Extract all approve with the same authority level
                List<ApprovalHierarchyDetail> sameLevels = details.Where(o => o.authority == currentStep).ToList();

                //2.2 check that the same level had all approved
                List<int> assignedUserIds = reqWithTracking.approvalTrxes
                                                                     .Select(o => o.approvalDetail.userAccount.id).ToList();
                List<ApprovalHierarchyDetail> unAssignedSameLevel = sameLevels.Where(o => assignedUserIds.Contains(o.userAccount.id) == false)
                                                                              .ToList();

                //2.3 there is someone at the same level exists
                if (unAssignedSameLevel != null && unAssignedSameLevel.Count > 0)
                {
                    att = new ApprovalTransactions();
                    att.approvalDetail = unAssignedSameLevel[0];
                    att.requirement = reqWithTracking;
                    att.status = APPROVAL_STATUS.APPROVAL_TYPE_NEW;
                    att.creationDate = DateTime.Now;
                    att.lastUpdate = DateTime.Now;
                }
                else
                {
                    //2.4 find someone at higher level
                    List<ApprovalHierarchyDetail> higherLevels = details.Where(o => o.authority > currentStep)
                                                                        .OrderBy(o => o.authority)
                                                                        .ToList();
                    if (higherLevels == null || higherLevels.Count == 0)
                    {
                        return null;
                    }

                    att = new ApprovalTransactions();
                    att.approvalDetail = higherLevels[0];
                    att.requirement = reqWithTracking;
                    att.status = APPROVAL_STATUS.APPROVAL_TYPE_NEW;
                    att.creationDate = DateTime.Now;
                    att.lastUpdate = DateTime.Now;
                }
            }

            return att;
        }


    }
}