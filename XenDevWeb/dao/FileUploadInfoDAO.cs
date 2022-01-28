using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using XenDevWeb.domain;

namespace XenDevWeb.dao
{
    public class FileUploadInfoDAO
    {
        private XenDevWebDbContext ctx;

        public FileUploadInfoDAO(XenDevWebDbContext ctx)
        {
            this.ctx = ctx;
        }

        public void create(FileUploadInfo obj)
        {
            ctx.fileUploadInfoes.Add(obj);
            ctx.SaveChanges();
        }

        public void update(FileUploadInfo c)
        {
            bool isAttched = ctx.ChangeTracker.Entries<FileUploadInfo>().Any(e => e.Entity.id == c.id);
            if (!isAttched)
            {
                ctx.fileUploadInfoes.Attach(c);
                ctx.Entry(c).State = System.Data.Entity.EntityState.Modified;
                ctx.SaveChanges();
                ctx.Detach(c);
            }
            else
            {
                ctx.SaveChanges();
            }
        }

        public void delete(FileUploadInfo obj)
        {
            ctx.fileUploadInfoes.Remove(obj);
            ctx.SaveChanges();
        }

        public FileUploadInfo findById(long id, bool forUpdate)
        {
            List<FileUploadInfo> objs = null;

            if (forUpdate)
            {
                objs = (from e in ctx.fileUploadInfoes
                        where e.id == id
                        select e)
                        .ToList();
            }
            else
            {
                objs = (from e in ctx.fileUploadInfoes.AsNoTracking()
                        where e.id == id
                        select e)
                        .ToList();
            }
            return (objs != null && objs.Count > 0) ? objs[0] : null;
        }

        public FileUploadInfo findByOriginalFileName(string originalFileName, bool forUpdate)
        {
            List<FileUploadInfo> objs = null;

            if (forUpdate)
            {
                objs = (from e in ctx.fileUploadInfoes
                        where e.originalFileName != null && e.originalFileName.Trim().ToLower().CompareTo(originalFileName.Trim().ToLower()) == 0
                        select e)
                        .OrderBy(o => o.originalFileName)
                        .ToList();
            }
            else
            {
                objs = (from e in ctx.fileUploadInfoes.AsNoTracking()
                        where e.originalFileName != null && e.originalFileName.Trim().ToLower().CompareTo(originalFileName.Trim().ToLower()) == 0
                        select e)
                        .OrderBy(o => o.originalFileName)
                        .ToList();
            }
            return (objs != null && objs.Count > 0) ? objs[0] : null;
        }

        public FileUploadInfo findByServerFileName(string serverFileName, bool forUpdate)
        {
            List<FileUploadInfo> objs = null;

            if (forUpdate)
            {
                objs = (from e in ctx.fileUploadInfoes
                        where e.serverFileName != null && e.serverFileName.Trim().ToLower().CompareTo(serverFileName.Trim().ToLower()) == 0
                        select e)
                        .OrderBy(o => o.serverFileName)
                        .ToList();
            }
            else
            {
                objs = (from e in ctx.fileUploadInfoes.AsNoTracking()
                        where e.serverFileName.ToLower().CompareTo(serverFileName.ToLower()) == 0
                        select e)
                        .OrderBy(o => o.serverFileName)
                        .ToList();
            }
            return (objs != null && objs.Count > 0) ? objs[0] : null;
        }

        public List<FileUploadInfo> getAllFileUploadInfo(bool forUpdate)
        {
            List<FileUploadInfo> objs = null;

            if (forUpdate)
            {
                objs = (from e in ctx.fileUploadInfoes
                        select e)
                        .ToList();
            }
            else
            {
                objs = (from e in ctx.fileUploadInfoes.AsNoTracking()
                        select e)
                        .ToList();
            }

            return objs;
        }
    }
}