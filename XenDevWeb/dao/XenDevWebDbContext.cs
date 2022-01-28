using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using XenDevWeb.domain;

using System.Data.Entity;
using System.Data.Entity.Infrastructure;

namespace XenDevWeb.dao
{
    public class XenDevWebDbContext : DbContext
    {
        public DbSet<Project> projects { get; set; }

        public DbSet<UserAccount> userAccounts { get; set; }

        public DbSet<Company> companys { get; set; }

        public DbSet<MeetingNote> meetingNotes { get; set; }

        public DbSet<Image> imags { get; set; }

        public DbSet<ApplicationAsset> applicationAssets { get; set; }

        public DbSet<ApplicationChange> applicationChanges { get; set; }

        public DbSet<ApplicationChangeTrx> applicationChangeTrxs { get; set; }

        public DbSet<RejectReason> rejectReasons { get; set; }

        public DbSet<StaffAccount> staffAccounts { get; set; }

        public DbSet<FileUploadInfo> fileUploadInfoes { get; set; }

        public DbSet<Ticket> tickets { get; set; }

        public DbSet<EmailServer> emailServers { get; set; }

        public DbSet<TicketComment> ticketComments { get; set; }

        public DbSet<ApprovalHierarchy> approvalHierarchies { get; set; }

        public DbSet<ApprovalHierarchyDetail> approvalHierarchyDetails { get; set; }

        public DbSet<TicketAssignment> ticketAssignments { get; set; }

        public DbSet<Requirement> requirements { get; set; }

        public DbSet<ApprovalTransactions> approvalTransactions { get; set; }

        public DbSet<ProjectMandays> projectMandays { get; set; }

        public DbSet<EstimationRequest> estimationRequests { get; set; }

        public DbSet<Report> reports { get; set; }


        public void Detach(object entity)
        {
            IObjectContextAdapter _ctx = ((IObjectContextAdapter)this);
            _ctx.ObjectContext.Detach(entity);
        }
    }
}