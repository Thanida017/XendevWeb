namespace XenDevWeb.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class _20220125 : DbMigration
    {
        public override void Up()
        {
            CreateTable(
                "dbo.EstimationRequests",
                c => new
                    {
                        id = c.Long(nullable: false, identity: true),
                        companyName = c.String(),
                        personName = c.String(),
                        email = c.String(),
                        phoneNumber = c.String(),
                        projectName = c.String(),
                        description = c.String(unicode: false, storeType: "text"),
                        status = c.Int(nullable: false),
                        styleWeb = c.Boolean(nullable: false),
                        styleMobile = c.Boolean(nullable: false),
                        styleDesktop = c.Boolean(nullable: false),
                        inputExcel = c.Boolean(nullable: false),
                        inputFormEntry = c.Boolean(nullable: false),
                        inputFile = c.Boolean(nullable: false),
                        inputOther = c.Boolean(nullable: false),
                        inputOtherDetail = c.String(),
                        migrateOldDatabase = c.Boolean(nullable: false),
                        migrateExcel = c.Boolean(nullable: false),
                        migrateOther = c.Boolean(nullable: false),
                        migrateOtherDetail = c.String(),
                        mustIntergrate = c.Boolean(nullable: false),
                        creationDate = c.DateTime(nullable: false),
                        lastUpdate = c.DateTime(nullable: false),
                    })
                .PrimaryKey(t => t.id);
            
            CreateTable(
                "dbo.Reports",
                c => new
                    {
                        id = c.Long(nullable: false, identity: true),
                        name = c.String(),
                        description = c.String(),
                        creationDate = c.DateTime(nullable: false),
                        lastUpdate = c.DateTime(nullable: false),
                        estimationRequest_id = c.Long(),
                    })
                .PrimaryKey(t => t.id)
                .ForeignKey("dbo.EstimationRequests", t => t.estimationRequest_id)
                .Index(t => t.estimationRequest_id);
            
        }
        
        public override void Down()
        {
            DropForeignKey("dbo.Reports", "estimationRequest_id", "dbo.EstimationRequests");
            DropIndex("dbo.Reports", new[] { "estimationRequest_id" });
            DropTable("dbo.Reports");
            DropTable("dbo.EstimationRequests");
        }
    }
}
