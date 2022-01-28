using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using XenDevWeb.domain;

namespace XenDevWeb.dao
{
    public class UserAccountDAO
    {
        private XenDevWebDbContext ctx;

        public UserAccountDAO(XenDevWebDbContext ctx)
        {
            this.ctx = ctx;
        }

        public UserAccount findById(long id, bool forUpdate)
        {
            List<UserAccount> users = null;
            if (forUpdate)
            {
                users = (from e in ctx.userAccounts
                         select e)
                        .Where(i => i.id == id)
                        .ToList();
            }
            else
            {
                users = (from e in ctx.userAccounts.AsNoTracking()
                         select e)
                        .Where(i => i.id == id)
                        .ToList();
            }

            return (users != null && users.Count > 0) ? users[0] : null;
        }

        public List<UserAccount> getAllUser(bool forUpdate)
        {
            List<UserAccount> objs = null;
            if (forUpdate)
            {
                objs = (from e in ctx.userAccounts
                        select e)
                       .OrderBy(o => o.id)
                       .ToList();
            }
            else
            {
                objs = (from e in ctx.userAccounts.AsNoTracking()
                        select e)
                       .OrderBy(o => o.id)
                       .ToList();

            }
            return objs;
        }

        public List<UserAccount> getAllUserEnable(bool forUpdate)
        {
            List<UserAccount> objs = null;
            if (forUpdate)
            {
                objs = (from e in ctx.userAccounts
                        where e.enabled
                        select e)
                       .OrderBy(o => o.id)
                       .ToList();
            }
            else
            {
                objs = (from e in ctx.userAccounts.AsNoTracking()
                        where e.enabled
                        select e)
                       .OrderBy(o => o.id)
                       .ToList();

            }
            return objs;
        }

        public void create(UserAccount c)
        {
            ctx.userAccounts.Add(c);
            ctx.SaveChanges();
        }

        public void update(UserAccount c)
        {
            bool isAttched = ctx.ChangeTracker.Entries<UserAccount>().Any(e => e.Entity.id == c.id);
            if (!isAttched)
            {
                ctx.userAccounts.Attach(c);
                ctx.Entry(c).State = System.Data.Entity.EntityState.Modified;
                ctx.SaveChanges();
                ctx.Detach(c);
            }
            else
            {
                ctx.SaveChanges();
            }
        }

        public void delete(UserAccount c)
        {
            ctx.userAccounts.Remove(c);
            ctx.SaveChanges();
        }
        
        public List<UserAccount> getCompanyUserAccount(long compId)
        {
            {
                return (from e in ctx.userAccounts.AsNoTracking()
                        where e.company.id == compId
                        select e)
                        .OrderBy(i => i.empNo)
                        .ToList();
            }
        }

        public UserAccount findByEmpNo(string empNo, bool forUpdate)
        {
            List<UserAccount> accs = null;
            if (forUpdate)
            {
                accs = (from e in ctx.userAccounts
                        where e.empNo.ToLower().CompareTo(empNo.ToLower()) == 0
                        select e)
                        .ToList();
            }
            else
            {
                accs = (from e in ctx.userAccounts.AsNoTracking()
                        where e.empNo.ToLower().CompareTo(empNo.ToLower()) == 0
                        select e)
                        .ToList();
            }

            return (accs != null && accs.Count > 0) ? accs[0] : null;
        }

        public UserAccount findByUsername(string username, bool forUpdate)
        {
            List<UserAccount> accs = null;
            if (forUpdate)
            {
                accs = (from e in ctx.userAccounts
                        where e.username.ToLower().CompareTo(username.ToLower()) == 0
                        select e)
                        .ToList();
            }
            else
            {
                accs = (from e in ctx.userAccounts.AsNoTracking()
                        where e.username.ToLower().CompareTo(username.ToLower()) == 0
                        select e)
                        .ToList();
            }

            return (accs != null && accs.Count > 0) ? accs[0] : null;
        }
        
        public UserAccount findByCredential(string username, string password)
        {
            List<UserAccount> accs = (from e in ctx.userAccounts.AsNoTracking()
                                      where e.password.CompareTo(password) == 0 &&
                                            e.username.ToLower().CompareTo(username.ToLower()) == 0
                                      select e)
                                    .ToList();

            return (accs != null && accs.Count > 0) ? accs[0] : null;
        }

        public UserAccount findByActivationCode(string activationCode, bool forUpdate)
        {
            List<UserAccount> accs = null;
            if (forUpdate)
            {
                accs = (from e in ctx.userAccounts
                        where e.activationCode.ToLower().CompareTo(activationCode.ToLower()) == 0
                        select e)
                        .ToList();
            }
            else
            {
                accs = (from e in ctx.userAccounts.AsNoTracking()
                        where e.email.ToLower().CompareTo(activationCode.ToLower()) == 0
                        select e)
                        .ToList();
            }

            return (accs != null && accs.Count > 0) ? accs[0] : null;
        }

        public UserAccount findByEmail(string email, bool forUpdate)
        {
            List<UserAccount> accs = null;
            if (forUpdate)
            {
                accs = (from e in ctx.userAccounts
                        where e.email.ToLower().CompareTo(email.ToLower()) == 0
                        select e)
                        .ToList();
            }
            else
            {
                accs = (from e in ctx.userAccounts.AsNoTracking()
                        where e.email.ToLower().CompareTo(email.ToLower()) == 0
                        select e)
                        .ToList();
            }

            return (accs != null && accs.Count > 0) ? accs[0] : null;
        }

    }
}