using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using XenDevWeb.domain;

namespace XenDevWeb.dao
{
    public class CompanyDAO
    {
        private XenDevWebDbContext ctx;

        public CompanyDAO(XenDevWebDbContext ctx)
        {
            this.ctx = ctx;
        }

        public Company findById(long id, bool forUpdate)
        {
            List<Company> objs = null;
            if (forUpdate)
            {
                objs = (from e in ctx.companys
                            select e)
                           .Where(i => i.id == id)
                           .ToList();
            }
            else
            {
                objs = (from e in ctx.companys.AsNoTracking()
                            select e)
                         .Where(i => i.id == id)
                         .ToList();
            }

            return (objs != null && objs.Count > 0) ? objs[0] : null;
        }

        public Company findByName(string name, bool forUpdate)
        {
            List<Company> objs = null;
            if (forUpdate)
            {
                objs = (from e in ctx.companys
                        where e.name != null && e.name.ToLower().CompareTo(name.ToLower()) == 0
                        select e)
                        .ToList();
            }
            else
            {
                objs = (from e in ctx.companys.AsNoTracking()
                        where e.name != null && e.name.ToLower().CompareTo(name.ToLower()) == 0
                        select e)
                        .ToList();
            }

            return (objs != null && objs.Count > 0) ? objs[0] : null;
        }

        public void create(Company c)
        {
            ctx.companys.Add(c);
            ctx.SaveChanges();
        }

        public void update(Company c)
        {
            bool isAttched = ctx.ChangeTracker.Entries<Company>().Any(e => e.Entity.id == c.id);
            if (!isAttched)
            {
                ctx.companys.Attach(c);
                ctx.Entry(c).State = System.Data.Entity.EntityState.Modified;
                ctx.SaveChanges();
                ctx.Detach(c);
            }
            else
            {
                ctx.SaveChanges();
            }
        }

        public void delete(Company c)
        {
            ctx.companys.Remove(c);
            ctx.SaveChanges();
        }
        
        public List<Company> getAllCompanies(bool forUpdate)
        {
            if (forUpdate)
            {
                return (from e in ctx.companys
                        select e)
                        .OrderBy(i => i.code)
                        .ToList();
            }


            return (from e in ctx.companys.AsNoTracking()
                    select e)
                        .OrderBy(i => i.code)
                        .ToList();
        }

        public List<Company> getAllEnabledCompanies(bool forUpdate)
        {
            if (forUpdate)
            {
                return (from e in ctx.companys
                        where e.enabled == true
                        select e)
                        .OrderBy(i => i.code)
                        .ToList();
            }


            return (from e in ctx.companys.AsNoTracking()
                    where e.enabled == true
                    select e)
                        .OrderBy(i => i.code)
                        .ToList();
        }

        public Company findByCode(string code, bool forUpdate)
        {
            List<Company> objs = null;
            if (forUpdate)
            {
                objs = (from e in ctx.companys
                            select e)
                           .Where(i => i.code != null && i.code.ToLower().CompareTo(code.ToLower()) == 0)
                           .ToList();
            }
            else
            {
                objs = (from e in ctx.companys.AsNoTracking()
                            select e)
                         .Where(i => i.code != null && i.code.ToLower().CompareTo(code.ToLower()) == 0)
                         .ToList();
            }

            return (objs != null && objs.Count > 0) ? objs[0] : null;
        }

        public Company findByTaxId(string taxId, bool forUpdate)
        {
            List<Company> objs = null;
            if (forUpdate)
            {
                objs = (from e in ctx.companys
                            select e)
                           .Where(i => i.taxId != null && i.taxId.Trim().CompareTo(taxId.Trim()) == 0)
                           .ToList();
            }
            else
            {
                objs = (from e in ctx.companys.AsNoTracking()
                            select e)
                          .Where(i => i.taxId != null && i.taxId.Trim().ToLower().CompareTo(taxId.Trim().ToLower()) == 0)
                          .ToList();
            }
            return (objs != null && objs.Count > 0) ? objs[0] : null;
        }
        
    }
}