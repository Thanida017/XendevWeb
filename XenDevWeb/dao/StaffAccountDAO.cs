using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using XenDevWeb.domain;

namespace XenDevWeb.dao
{
    public class StaffAccountDAO
    {
        private XenDevWebDbContext ctx;

        public StaffAccountDAO(XenDevWebDbContext ctx)
        {
            this.ctx = ctx;
        }

        public StaffAccount findById(long id, bool forUpdate)
        {
            List<StaffAccount> users = null;
            if (forUpdate)
            {
                users = (from e in ctx.staffAccounts
                         select e)
                        .Where(i => i.id == id)
                        .ToList();
            }
            else
            {
                users = (from e in ctx.staffAccounts.AsNoTracking()
                         select e)
                        .Where(i => i.id == id)
                        .ToList();
            }

            return (users != null && users.Count > 0) ? users[0] : null;
        }

        public List<StaffAccount> getAllStaffAccount(bool forUpdate)
        {
            List<StaffAccount> objs = null;
            if (forUpdate)
            {
                objs = (from e in ctx.staffAccounts
                        select e)
                       .OrderBy(o => o.id)
                       .ToList();
            }
            else
            {
                objs = (from e in ctx.staffAccounts.AsNoTracking()
                        select e)
                       .OrderBy(o => o.id)
                       .ToList();

            }
            return objs;
        }

        public List<StaffAccount> getAllEnableStaffAccount(bool forUpdate)
        {
            List<StaffAccount> objs = null;
            if (forUpdate)
            {
                objs = (from e in ctx.staffAccounts
                        where e.enabled
                        select e)
                       .OrderBy(o => o.firstName)
                       .ThenBy(o => o.lastName)
                       .ToList();
            }
            else
            {
                objs = (from e in ctx.staffAccounts.AsNoTracking()
                        where e.enabled
                        select e)
                       .OrderBy(o => o.firstName)
                       .ThenBy(o => o.lastName)
                       .ToList();

            }
            return objs;
        }

        public void create(StaffAccount c)
        {
            ctx.staffAccounts.Add(c);
            ctx.SaveChanges();
        }

        public void update(StaffAccount c)
        {
            bool isAttched = ctx.ChangeTracker.Entries<StaffAccount>().Any(e => e.Entity.id == c.id);
            if (!isAttched)
            {
                ctx.staffAccounts.Attach(c);
                ctx.Entry(c).State = System.Data.Entity.EntityState.Modified;
                ctx.SaveChanges();
                ctx.Detach(c);
            }
            else
            {
                ctx.SaveChanges();
            }
        }

        public void delete(StaffAccount c)
        {
            ctx.staffAccounts.Remove(c);
            ctx.SaveChanges();
        }

        public StaffAccount findByEmpNo(string empNo, bool forUpdate)
        {
            List<StaffAccount> accs = null;
            if (forUpdate)
            {
                accs = (from e in ctx.staffAccounts
                        where e.empNo.ToLower().CompareTo(empNo.ToLower()) == 0
                        select e)
                        .ToList();
            }
            else
            {
                accs = (from e in ctx.staffAccounts.AsNoTracking()
                        where e.empNo.ToLower().CompareTo(empNo.ToLower()) == 0
                        select e)
                        .ToList();
            }

            return (accs != null && accs.Count > 0) ? accs[0] : null;
        }

        public StaffAccount findByUsername(string username, bool forUpdate)
        {
            List<StaffAccount> accs = null;
            if (forUpdate)
            {
                accs = (from e in ctx.staffAccounts
                        where e.username.ToLower().CompareTo(username.ToLower()) == 0
                        select e)
                        .ToList();
            }
            else
            {
                accs = (from e in ctx.staffAccounts.AsNoTracking()
                        where e.username.ToLower().CompareTo(username.ToLower()) == 0
                        select e)
                        .ToList();
            }

            return (accs != null && accs.Count > 0) ? accs[0] : null;
        }

        public StaffAccount findByCredential(string username, string password)
        {
            List<StaffAccount> accs = (from e in ctx.staffAccounts.AsNoTracking()
                                      where e.password.CompareTo(password) == 0 &&
                                            e.username.ToLower().CompareTo(username.ToLower()) == 0
                                      select e)
                                    .ToList();

            return (accs != null && accs.Count > 0) ? accs[0] : null;
        }
    }
}