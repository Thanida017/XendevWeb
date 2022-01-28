namespace XenDevWeb.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class _202201252154 : DbMigration
    {
        public override void Up()
        {
            AddColumn("dbo.EstimationRequests", "comment", c => c.String(unicode: false, storeType: "text"));
        }
        
        public override void Down()
        {
            DropColumn("dbo.EstimationRequests", "comment");
        }
    }
}
