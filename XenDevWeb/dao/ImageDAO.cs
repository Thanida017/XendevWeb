using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using XenDevWeb.domain;

namespace XenDevWeb.dao
{
    public class ImageDAO
    {
        private XenDevWebDbContext ctx;

        public ImageDAO(XenDevWebDbContext ctx)
        {
            this.ctx = ctx;
        }

        public Image findById(long id, bool forUpdate)
        {
            List<Image> objs = null;
            if (forUpdate)
            {
                objs = (from e in ctx.imags
                        select e)
                           .Where(i => i.id == id)
                           .ToList();
            }
            else
            {
                objs = (from e in ctx.imags.AsNoTracking()
                        select e)
                         .Where(i => i.id == id)
                         .ToList();
            }

            return (objs != null && objs.Count > 0) ? objs[0] : null;
        }

        public Image findByServerImageFileName(string serverImageFileName, bool forUpdate)
        {
            List<Image> objs = null;
            if (forUpdate)
            {
                objs = (from e in ctx.imags
                        where e.serverImageFileName.CompareTo(serverImageFileName) == 0
                        select e)
                           .ToList();
            }
            else
            {
                objs = (from e in ctx.imags.AsNoTracking()
                        where e.serverImageFileName.CompareTo(serverImageFileName) == 0
                        select e)
                         .ToList();
            }

            return (objs != null && objs.Count > 0) ? objs[0] : null;
        }

        public List<Image> getAllImagrByTicketId(long id, bool forUpdate)
        {
            List<Image> objs = null;

            if (forUpdate)
            {
                objs = (from e in ctx.imags
                        where e.ticket != null && e.ticket.id == id
                        select e)
                        .OrderBy(o => o.id)
                        .ToList();
            }
            else
            {
                objs = (from e in ctx.imags.AsNoTracking()
                        where e.ticket != null && e.ticket.id == id
                        select e)
                        .OrderBy(o => o.id)
                        .ToList();
            }

            return objs;
        }
        
        public void create(Image c)
        {
            ctx.imags.Add(c);
            ctx.SaveChanges();
        }

        public void update(Image c)
        {
            bool isAttched = ctx.ChangeTracker.Entries<Image>().Any(e => e.Entity.id == c.id);
            if (!isAttched)
            {
                ctx.imags.Attach(c);
                ctx.Entry(c).State = System.Data.Entity.EntityState.Modified;
                ctx.SaveChanges();
                ctx.Detach(c);
            }
            else
            {
                ctx.SaveChanges();
            }
        }

        public void delete(Image c)
        {
            ctx.imags.Remove(c);
            ctx.SaveChanges();
        }
        
        public List<Image> getAllCompanies(bool forUpdate)
        {
            if (forUpdate)
            {
                return (from e in ctx.imags
                        select e)
                        .OrderBy(i => i.id)
                        .ToList();
            }


            return (from e in ctx.imags.AsNoTracking()
                    select e)
                        .OrderBy(i => i.id)
                        .ToList();
        }

        public List<Image> getAllTicketById(long id, bool forUpdate)
        {
            List<Image> objs = null;

            if (forUpdate)
            {
                objs = (from e in ctx.imags
                        where e.ticket != null && e.ticket.id == id
                        select e)
                        .OrderBy(o => o.id)
                        .ToList();
            }
            else
            {
                objs = (from e in ctx.imags.AsNoTracking()
                        where e.ticket != null && e.ticket.id == id
                        select e)
                        .OrderBy(o => o.id)
                        .ToList();
            }

            return objs;
        }

        public List<Image> getAllCommentById(long id, bool forUpdate)
        {
            List<Image> objs = null;

            if (forUpdate)
            {
                objs = (from e in ctx.imags
                        where e.ticketComment != null && e.ticketComment.id == id
                        select e)
                        .OrderBy(o => o.id)
                        .ToList();
            }
            else
            {
                objs = (from e in ctx.imags.AsNoTracking()
                        where e.ticketComment != null && e.ticketComment.id == id
                        select e)
                        .OrderBy(o => o.id)
                        .ToList();
            }

            return objs;
        }
    }
}