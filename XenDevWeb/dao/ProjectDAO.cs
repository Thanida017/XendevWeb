using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using XenDevWeb.domain;

namespace XenDevWeb.dao
{
    public class ProjectDAO
    {
        private XenDevWebDbContext ctx;

        public ProjectDAO(XenDevWebDbContext ctx)
        {
            this.ctx = ctx;
        }

        public Project findByProjectId(long id, bool forUpdate)
        {
            List<Project> objs = null;
            if (forUpdate)
            {
                objs = (from e in ctx.projects
                        select e)
                       .Where(e => e.id == id)
                       .ToList();
            }
            else
            {
                objs = (from e in ctx.projects.AsNoTracking()
                        select e)
                      .Where(e => e.id == id)
                      .ToList();
            }

            return (objs != null && objs.Count > 0) ? objs[0] : null;
        }

        public Project findByProjectCode(string code, bool forUpdate)
        {
            List<Project> objs = null;
            if (forUpdate)
            {
                objs = (from e in ctx.projects
                        select e)
                       .Where(i => i.code != null && i.code.ToLower().CompareTo(code.ToLower()) == 0)
                       .ToList();
            }
            else
            {
                objs = (from e in ctx.projects.AsNoTracking()
                        select e)
                       .Where(i => i.code != null && i.code.ToLower().CompareTo(code.ToLower()) == 0)
                       .ToList();
            }

            return (objs != null && objs.Count > 0) ? objs[0] : null;
        }

        public Project findByProjectName(string name, bool forUpdate)
        {
            List<Project> objs = null;
            if (forUpdate)
            {
                objs = (from e in ctx.projects
                       select e)
                       .Where(i => i.name != null && i.name.ToLower().CompareTo(name.ToLower()) == 0)
                       .ToList();
            }
            else
            {
                objs = (from e in ctx.projects.AsNoTracking()
                       select e)
                       .Where(i => i.name != null && i.name.ToLower().CompareTo(name.ToLower()) == 0)
                       .ToList();
            }

            return (objs != null && objs.Count > 0) ? objs[0] : null;
        }

        public List<Project> getAllProject(bool forUpdate)
        {
            List<Project> objs = null;
            if (forUpdate)
            {
                objs = (from e in ctx.projects
                        select e)
                       .OrderBy(o => o.id)
                       .ToList();
            }
            else
            {
                objs = (from e in ctx.projects.AsNoTracking()
                        select e)
                       .OrderBy(o => o.id)
                       .ToList();

            }
            return objs;
        }

        public List<Project> getAllProjectByUserCompanyId(long id, bool forUpdate)
        {
            List<Project> objs = null;
            if (forUpdate)
            {
                objs = (from e in ctx.projects
                        where e.company.id == id
                        select e)
                       .OrderBy(o => o.id)
                       .ToList();
            }
            else
            {
                objs = (from e in ctx.projects.AsNoTracking()
                        where e.company.id == id
                        select e)
                       .OrderBy(o => o.id)
                       .ToList();

            }
            return objs;
        }

        public List<Project> getCompanyProject(long companyId, bool forUpdate)
        {
            List<Project> objs = null;
            if (forUpdate)
            {
                objs = (from e in ctx.projects
                        where e.company != null && e.company.id == companyId
                        select e)
                       .OrderBy(o => o.id)
                       .ToList();
            }
            else
            {
                objs = (from e in ctx.projects.AsNoTracking()
                        where e.company != null && e.company.id == companyId
                        select e)
                       .OrderBy(o => o.id)
                       .ToList();

            }
            return objs;
        }

        public void create(Project c)
        {
            ctx.projects.Add(c);
            ctx.SaveChanges();
        }

        public void update(Project c)
        {
            bool isAttched = ctx.ChangeTracker.Entries<Project>().Any(e => e.Entity.id == c.id);
            if (!isAttched)
            {
                ctx.projects.Attach(c);
                ctx.Entry(c).State = System.Data.Entity.EntityState.Modified;
                ctx.SaveChanges();
                ctx.Detach(c);
            }
            else
            {
                ctx.SaveChanges();
            }
        }

        public void delete(Project c)
        {
            ctx.projects.Remove(c);
            ctx.SaveChanges();
        }
        
    }
}