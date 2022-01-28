using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using XenDevWeb.domain;

namespace XenDevWeb.dao
{
    public class ApplicationAssetDAO
    {
        private XenDevWebDbContext ctx;

        public ApplicationAssetDAO(XenDevWebDbContext ctx)
        {
            this.ctx = ctx;
        }

        public ApplicationAsset findById(long id, bool forUpdate)
        {
            List<ApplicationAsset> objs = null;
            if (forUpdate)
            {
                objs = (from e in ctx.applicationAssets
                        select e)
                           .Where(i => i.id == id)
                           .ToList();
            }
            else
            {
                objs = (from e in ctx.applicationAssets.AsNoTracking()
                        select e)
                         .Where(i => i.id == id)
                         .ToList();
            }

            return (objs != null && objs.Count > 0) ? objs[0] : null;
        }

        public void create(ApplicationAsset c)
        {
            ctx.applicationAssets.Add(c);
            ctx.SaveChanges();
        }

        public void update(ApplicationAsset c)
        {
            bool isAttched = ctx.ChangeTracker.Entries<ApplicationAsset>().Any(e => e.Entity.id == c.id);
            if (!isAttched)
            {
                ctx.applicationAssets.Attach(c);
                ctx.Entry(c).State = System.Data.Entity.EntityState.Modified;
                ctx.SaveChanges();
                ctx.Detach(c);
            }
            else
            {
                ctx.SaveChanges();
            }
        }

        public void delete(ApplicationAsset c)
        {
            ctx.applicationAssets.Remove(c);
            ctx.SaveChanges();
        }

        public List<ApplicationAsset> getAllApplicationAsset(bool forUpdate)
        {
            if (forUpdate)
            {
                return (from e in ctx.applicationAssets
                        select e)
                        .OrderBy(i => i.assetFileName)
                        .ToList();
            }


            return (from e in ctx.applicationAssets.AsNoTracking()
                    select e)
                        .OrderBy(i => i.assetFileName)
                        .ToList();
        }

        public List<ApplicationAsset> getAllApplicationAsset(long idProject, bool forUpdate)
        {
            if (forUpdate)
            {
                return (from e in ctx.applicationAssets
                        select e)
                        .Where(e=> e.project != null && e.project.id == idProject)
                        .OrderBy(i => i.assetFileName)
                        .ToList();
            }


            return (from e in ctx.applicationAssets.AsNoTracking()
                    select e)
                        .Where(e => e.project != null && e.project.id == idProject)
                        .OrderBy(i => i.assetFileName)
                        .ToList();
        }

        public List<ApplicationAsset> getAllEnabledApplicationAsset(bool forUpdate)
        {
            if (forUpdate)
            {
                return (from e in ctx.applicationAssets
                        where e.enabled
                        select e)
                        .OrderBy(i => i.assetFileName)
                        .ToList();
            }


            return (from e in ctx.applicationAssets.AsNoTracking()
                    where e.enabled
                    select e)
                        .OrderBy(i => i.assetFileName)
                        .ToList();
        }
    }
}