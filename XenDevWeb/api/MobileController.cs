using System;
using System.Collections.Generic;
using System.Drawing;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Threading;
using System.Threading.Tasks;
using System.Web;
using System.Web.Http;
using System.Web.Http.Cors;
using XenDevWeb.api.param;
using XenDevWeb.api.view;
using XenDevWeb.dao;
using XenDevWeb.domain;
using XenDevWeb.Utils;

namespace XenDevWeb.api
{
    [EnableCors(origins: "*", headers: "*", methods: "*")]
    [RoutePrefix("api/MobileController")]
    public class MobileController : ApiController
    {
        protected CultureInfo culture;

        [Route("login")]
        [AcceptVerbs("GET", "POST")]
        public async Task<IHttpActionResult> login(LoginRequest request)
        {
            LoginResponse response = new LoginResponse();
            response.success = true;

            using (XenDevWebDbContext ctx = new XenDevWebDbContext())
            {
                UserAccountDAO uaDAO = new UserAccountDAO(ctx);

                UserAccount ua = uaDAO.findByCredential(request.username,
                                                         Encryption.encrypt(request.password, true));

                if (ua == null || ua.enabled == false)
                {
                    response.success = false;
                    response.access_token = string.Empty;
                }
                else
                {
                    response.success = true;

                    string newToken = string.Format("{0}{1}", DateTime.Now.Ticks
                                                          , Guid.NewGuid());
                    response.access_token = Encryption.encrypt(newToken, true).Replace("+", "_");
                    response.uaId = ua.id.ToString();
                    response.imageUser = string.Format(Constants.URL_API_GETIMAGE, WebUtils.getAppServerPath(), ua.imageUserFileName, Constants.TYPE_USER_IMAGE);

                    UserAccount dbua = uaDAO.findById(ua.id, true);
                    dbua.token = response.access_token;
                    dbua.lastUpdate = DateTime.Now;
                    uaDAO.update(dbua);
                }
            }
            return Ok(response);
        }

        [Route("signUp")]
        [AcceptVerbs("GET", "POST")]
        public async Task<IHttpActionResult> signUp(SignUpRequest request)
        {
            SignUpResponse response = new SignUpResponse();
            response.success = false;

            using (XenDevWebDbContext ctx = new XenDevWebDbContext())
            {
                CompanyDAO comDAO = new CompanyDAO(ctx);
                UserAccountDAO uaDAO = new UserAccountDAO(ctx);
                EmailServerDAO emailDAO = new EmailServerDAO(ctx);

                Company comCheckName = comDAO.findByName(request.companyName, false);
                if(comCheckName != null)
                {
                    response.errorMessage = string.Format("Company Name {0} already exists.", request.companyName);
                    return Ok(response);
                }

                UserAccount uaCheckUsername= uaDAO.findByUsername(request.userName, false);
                if (uaCheckUsername != null)
                {
                    response.errorMessage = string.Format("Username {0} already exists.", request.companyName);
                    return Ok(response);
                }

                UserAccount uaCheckEmail = uaDAO.findByEmail(request.email, false);
                if(uaCheckEmail != null)
                {
                    response.errorMessage = string.Format("Email {0} already exists.", request.companyName);
                    return Ok(response);
                }

                Company com = new Company();
                com.name = request.companyName;
                com.nameEng = request.companyName;
                com.enabled = false;
                com.creationDate = DateTime.Now;
                com.lastUpdate = DateTime.Now;
                com.users = new List<UserAccount>();

                UserAccount ua = new UserAccount();
                ua.empNo = string.Format("{0}{1}", DateTime.Now.Ticks
                                                          , Guid.NewGuid());
                ua.language = Constants.LANGUAGE_EN;
                ua.username = request.userName;
                ua.email = request.email;
                ua.password = Encryption.encrypt(request.password, true);
                ua.creationDate = DateTime.Now;
                ua.lastUpdate = DateTime.Now;
                string newActivationCode = string.Format("{0}{1}", DateTime.Now.Ticks
                                                      , Guid.NewGuid());
                ua.activationCode = Encryption.encrypt(newActivationCode, true)
                                              .Replace("+", "_");
                com.users.Add(ua);
                comDAO.create(com);

                Company objUpdate = comDAO.findById(com.id, true);
                objUpdate.code = string.Format("C{0:yy}{1:00000}", DateTime.Now, com.id);
                objUpdate.lastUpdate = DateTime.Now;
                comDAO.update(objUpdate);

                string resetLink = WebUtils.getAppServerPath() + "/activate.aspx?activationCode=" + ua.activationCode;
                string emailSubject = "Register";
                string emailBody = EmailUtil.getEmailActivationCodeBodyHTML(resetLink, ua.username);

                EmailServer emailServer = emailDAO.getRecentRecord(false);
                bool sendSuccess = EmailUtil.sendEMail(emailServer.stmpAddress,
                                                       int.Parse(emailServer.port),
                                                       emailServer.username,
                                                       emailServer.password,
                                                       emailServer.senderAddress,
                                                       ua.email,
                                                       null,
                                                       emailSubject,
                                                       emailBody);

                if (sendSuccess)
                {
                    response.success = true;
                }
                else
                {
                    response.errorMessage = "Email send failed!.";
                }                    
            }

            return Ok(response);
        }

        [Route("resetPwd")]
        [AcceptVerbs("GET", "POST")]
        public async Task<IHttpActionResult> ResetPwd(ResetPwdRequest request)
        {
            ResetPwdResponse response = new ResetPwdResponse();
            response.success = false;

            using (XenDevWebDbContext ctx = new XenDevWebDbContext())
            {
                bool isValid = isValidToken(ctx, request.uid, request.token);
                if (isValid)
                {
                    UserAccountDAO uDAO = new UserAccountDAO(ctx);
                    UserAccount requester = uDAO.findById(request.uid, false);

                    string oldPassword = request.op;
                    string newPassword = request.np;

                    UserAccount user = uDAO.findByCredential(requester.username,
                                                            Encryption.encrypt(oldPassword, true));

                    if (user.id == request.uid)
                    {
                        UserAccount dbUser = uDAO.findById(request.uid, true);
                        dbUser.password = Encryption.encrypt(newPassword, true);
                        dbUser.token = null;
                        dbUser.lastUpdate = DateTime.Now;
                        uDAO.update(dbUser);

                        response.success = true;
                    }
                }
            }
            return Ok(response);
        }

        private bool isValidToken(XenDevWebDbContext ctx, long userId, string token)
        {
            UserAccountDAO uaDAO = new UserAccountDAO(ctx);
            UserAccount ua = uaDAO.findById(userId, false);

            if (ua == null || ua.enabled == false || ua.token == null)
            {
                return false;
            }

            int dd = DateTime.Now.Day;
            int mm = DateTime.Now.Month;
            int yy = DateTime.Now.Year;
            int p = (dd * mm) + yy;

            string raw = ua.token + p.ToString();
            string cypher = Encryption.ComputeSha256Hash(raw);

            int mdd = DateTime.Now.Day;
            int mmm = DateTime.Now.Month;
            int myy = DateTime.Now.Year;
            int mp = (dd * mm) + yy;

            string mraw = token + mp.ToString();
            string mcypher = Encryption.ComputeSha256Hash(mraw);

            return cypher.CompareTo(mcypher) == 0;
        }

        [Route("tokenValidate")]
        [AcceptVerbs("GET", "POST")]
        public async Task<IHttpActionResult> TokenValidate(TokenValidateRequest request)
        {
            TokenValidateResponse response = new TokenValidateResponse();
            response.success = false;

            using (XenDevWebDbContext ctx = new XenDevWebDbContext())
            {
                bool isValid = isValidToken(ctx, request.uid, request.token);
                if (isValid)
                {
                    response.success = true;
                }
                else
                {
                    UserAccountDAO uDAO = new UserAccountDAO(ctx);
                    UserAccount dbUser = uDAO.findById(request.uid, true);
                    dbUser.token = null;
                    dbUser.lastUpdate = DateTime.Now;
                    uDAO.update(dbUser);

                    response.success = false;
                }
            }

            return Ok(response);
        }

        [Route("updateUserAccountProfile")]
        [AcceptVerbs("GET", "POST")]
        public async Task<IHttpActionResult> UpdateUserAccountProfile(UpdateUserAccountProfileRequest request)
        {
            UpdateUserAccountProfileResponse response = new UpdateUserAccountProfileResponse();
            response.success = false;
            using (XenDevWebDbContext ctx = new XenDevWebDbContext())
            {
                UserAccountDAO uDAO = new UserAccountDAO(ctx);
                UserAccount dbUser = uDAO.findById(request.uaId, true);
                if (dbUser != null)
                {
                    dbUser.firstName = request.firstName;
                    dbUser.lastName = request.lastName;
                    dbUser.email = request.email;
                    dbUser.imageUserFileName = WebUtils.writeImageBase64ToImageToDisk(request.imageUserFileNameBase64.Replace("data:image/jpeg;base64,", ""), Constants.USERACCOUNT_IMG_FOLDER);
                    dbUser.lastUpdate = DateTime.Now;
                    uDAO.update(dbUser);
                    response.success = true;
                }
            }
            return Ok(response);
        }

        [Route("getProfile")]
        [AcceptVerbs("GET", "POST")]
        public async Task<IHttpActionResult> GetProfile(GetProfileRequest request)
        {
            GetProfileResponse response = new GetProfileResponse();
            response.success = false;
            using (XenDevWebDbContext ctx = new XenDevWebDbContext())
            {
                UserAccountDAO uDAO = new UserAccountDAO(ctx);
                UserAccount dbUser = uDAO.findById(request.uaId, false);
                if (dbUser != null)
                {
                    response.firstName = dbUser.firstName;
                    response.lastName = dbUser.lastName;
                    response.email = dbUser.email;
                    if(dbUser.imageUserFileName != null)
                    {
                        response.urlPathIamge = string.Format(Constants.URL_API_GETIMAGE, WebUtils.getAppServerPath(), dbUser.imageUserFileName, Constants.TYPE_USER_IMAGE);
                    }                    
                    response.success = true;
                }
            }
            return Ok(response);
        }

        [Route("getProject")]
        [AcceptVerbs("GET", "POST")]
        public async Task<IHttpActionResult> GetProject(ProjectRequest request)
        {
            ProjectResponse response = new ProjectResponse();
            response.success = false;

            using (XenDevWebDbContext ctx = new XenDevWebDbContext())
            {
                UserAccountDAO uDAO = new UserAccountDAO(ctx);
                UserAccount dbUser = uDAO.findById(request.uaId, false);

                if (dbUser != null && dbUser.company != null)
                {
                    response.success = true;
                    response.projectView = new List<ProjectView>();
                    List<Project> projects = dbUser.company.projects.OrderByDescending(o => o.lastUpdate).ToList();
                    foreach (Project pj in projects)
                    {
                        ProjectView pjView = new ProjectView();
                        pjView.pjId = pj.id.ToString();
                        pjView.name = pj.name;
                        pjView.description = pj.description;
                        pjView.lastUpdate = pj.lastUpdate;
                        pjView.projectColor = pj.projectColor;
                        pjView.textProjectImage = pj.name.Substring(0, 1);
                        pjView.remainingMandays = pj.remainingMandays;
                        pjView.totalManDay = pj.totalManDay;
                        if (pj.bannerImageFileName != null)
                        {
                            pjView.bannerImageFileName = string.Format(Constants.URL_API_GETIMAGE, WebUtils.getAppServerPath(), pj.bannerImageFileName, Constants.TYPE_PROJECT_IMAGE);
                        }
                        else
                        {
                            pjView.bannerImageFileName = string.Format(Constants.URL_API_GETIMAGE, WebUtils.getAppServerPath(), "imageEmpty.png", Constants.TYPE_EMPTY_IMAGE);
                        }
                        
                        response.projectView.Add(pjView);
                    }
                }

            }
            return Ok(response);
        }

        [Route("getMeetingNote")]
        [AcceptVerbs("GET", "POST")]
        public async Task<IHttpActionResult> GetMeetingNote(MeetingNoteRequest request)
        {
            MeetingNoteResponse response = new MeetingNoteResponse();
            response.success = false;

            using (XenDevWebDbContext ctx = new XenDevWebDbContext())
            {
                ProjectDAO pjDAO = new ProjectDAO(ctx);
                Project pj = pjDAO.findByProjectId(request.pjId, false);
                if (pj != null && pj.meetingNotes != null)
                {
                    response.success = true;
                    response.meetingNoteViews = new List<MeetingNoteView>();

                    pj.meetingNotes = pj.meetingNotes.OrderByDescending(e => e.lastUpdate).ToList();
                    foreach (MeetingNote mt in pj.meetingNotes)
                    {
                        MeetingNoteView mtView = new MeetingNoteView();
                        mtView.lastUpdate = string.Format("{0:dd MMM yyyy HH:mm}", mt.lastUpdate);
                        mtView.meetingDateTime = string.Format("{0 :dd MMM yyyy HH:mm}", mt.meetingDateTime);
                        mtView.textMeetingDateTime = string.Format("{0:dd}", mt.meetingDateTime);
                        mtView.meetingColor = mt.meetingNoteColor != null ? mt.meetingNoteColor : "#78CD51";
                        mtView.text = mt.text;
                        mtView.meetingNoteImageViews = new List<MeetingNoteImageView>();
                        foreach(domain.Image ig in mt.images)
                        {
                            MeetingNoteImageView iView = new MeetingNoteImageView();
                            iView.serverImageFileName = string.Format(Constants.URL_API_GETIMAGE, WebUtils.getAppServerPath(), ig.serverImageFileName, Constants.TYPE_MEETING_NOTE_IMAGE);
                            mtView.meetingNoteImageViews.Add(iView);
                        }
                        response.meetingNoteViews.Add(mtView);
                    }
                }

            }
            return Ok(response);
        }

        [Route("getProgress")]
        [AcceptVerbs("GET", "POST")]
        public async Task<IHttpActionResult> GetProgress(ApplicationChangeRequest request)
        {
            ApplicationChangeResponse response = new ApplicationChangeResponse();
            response.success = false;

            using (XenDevWebDbContext ctx = new XenDevWebDbContext())
            {
                ProjectDAO pjDAO = new ProjectDAO(ctx);
                Project pj = pjDAO.findByProjectId(request.pjId, false);

                response.appChanges = new List<ApplicationChangeView>();
                if (pj != null && pj.applicationAssets != null)
                {
                    response.success = true;
                    List<ApplicationChange> changes = pj.applicationAssets.Where(o => o.enabled)
                                                                          .SelectMany(o => o.applicationChanges)
                                                                          .OrderByDescending(o => o.lastUpdate).ToList();

                    foreach (ApplicationChange ac in changes)
                    {
                        switch (ac.changeType)
                        {
                            case CHANGE_TYPE.NEW_FEATURE:
                                ApplicationChangeView appChangeView = new ApplicationChangeView();
                                appChangeView.appChangeId = ac.id.ToString();
                                appChangeView.assetFileName = ac.appAsset.assetFileName;
                                appChangeView.description = ac.description;
                                appChangeView.lastUpdate = ac.lastUpdate;
                                appChangeView.textAssetFileNameImage = ac.appAsset.assetFileName.Substring(0, 1);
                                appChangeView.applicationColor = ac.applicationChangColor != null ? ac.applicationChangColor:"#78CD51";
                                if (ac.createdBy != null)
                                {
                                    appChangeView.createdBy = string.Format("By {0}", ac.createdBy.firstName);
                                }
                                response.appChanges.Add(appChangeView);
                                break;
                        }

                    }

                    if (response.appChanges != null && response.appChanges.Count > 0)
                    {
                        response.appChanges = response.appChanges.OrderByDescending(e => e.lastUpdate).ToList();
                    }                    
                }

            }
            return Ok(response);
        }

        [Route("getRequirement")]
        [AcceptVerbs("GET", "POST")]
        public async Task<IHttpActionResult> GetRequirement(GetRequirementRequest request)
        {
            GetRequirementResponse response = new GetRequirementResponse();
            using (XenDevWebDbContext ctx = new XenDevWebDbContext())
            {
                UserAccountDAO uaDAO = new UserAccountDAO(ctx);
                RequirementDAO reqDAO = new RequirementDAO(ctx);
                ProjectDAO pjDAO = new ProjectDAO(ctx);
                ApproveUtil approveUtil = new ApproveUtil(ctx);

                UserAccount ua = uaDAO.findById(request.uaId, false);
                Project pj = pjDAO.findByProjectId(request.pjId, false);
                if (ua != null && pj != null)
                {
                    response.success = true;
                    response.reqViews = new List<RequirementView>();
                    List<Requirement> reqAll = reqDAO.getRequirementByProject(pj.id, false);

                    if(reqAll == null)
                    {
                        return Ok(response);
                    }

                    reqAll = reqAll.OrderBy(o => o.approvalTrxes.Count)
                                   .ThenByDescending(o => o.lastUpDate).ToList();

                    foreach (Requirement req in reqAll)
                    {
                        if (!req.checkUserApproved(ua.id))
                        {
                            continue;
                        }
                        List<ApprovalTransactions> lastApprovalTrxes = req.approvalTrxes.OrderByDescending(o => o.id).ToList();

                        RequirementView reqView = new RequirementView();
                        reqView.title = req.title;
                        reqView.meetingDateTime = req.meetingNote.meetingDateTime;
                        reqView.shortDescription = req.description;
                        reqView.checkWaitApproval = (req.status == REQUIREMENT_STATUS.AWAIT_APPROVAL && lastApprovalTrxes[0].approvalDetail.userAccount.id == ua.id);
                        reqView.manDays = req.manDays;
                        reqView.timelineApprovalTrxes = new List<TimelineApprovalTrxesView>();
                        
                        reqView.approvalId = lastApprovalTrxes.Count > 0 ? lastApprovalTrxes[0].id : 0;

                        foreach (ApprovalTransactions approvalTrxes in req.approvalTrxes)
                        {
                            if (approvalTrxes.approvalResultDate.HasValue)
                            {
                                TimelineApprovalTrxesView approvalTrxView = new TimelineApprovalTrxesView();

                                switch (approvalTrxes.status)
                                {
                                    case APPROVAL_STATUS.APPROVAL_TYPE_NEW:
                                        continue;
                                    case APPROVAL_STATUS.APPROVAL_TYPE_ACCEPTED:
                                        approvalTrxView.title = "Accepted";
                                        approvalTrxView.circleColor = "#4caf50";
                                        break;
                                    case APPROVAL_STATUS.APPROVAL_TYPE_REJECT:
                                        string rejectReason = approvalTrxes.rejectReason != null ? approvalTrxes.rejectReason.name : approvalTrxes.otherRejectReason;
                                        approvalTrxView.title = "Reject Reason";
                                        approvalTrxView.rejectReason = string.Format("Reject Reason {0}", rejectReason);
                                        approvalTrxView.circleColor = "#ff0057";
                                        break;
                                }
                                approvalTrxView.time = string.Format("{0:dd}/{0:MM}/{0:yyyy} ", approvalTrxes.approvalResultDate);
                                approvalTrxView.approvalResultDate = approvalTrxes.approvalResultDate.Value;
                                approvalTrxView.description = string.Format("{0} {1}", approvalTrxes.approvalDetail.userAccount.firstName, approvalTrxes.approvalDetail.userAccount.lastName);
                                approvalTrxView.imageUrl  = string.Format(Constants.URL_API_GETIMAGE, WebUtils.getAppServerPath(), approvalTrxes.approvalDetail.userAccount.imageUserFileName, Constants.TYPE_USER_IMAGE);
                                //reqView.checkWaitApproval = (approvalTrxes.status == APPROVAL_STATUS.APPROVAL_TYPE_NEW && approvalTrxes.approvalDetail.userAccount.id == request.uaId);
                                reqView.timelineApprovalTrxes.Add(approvalTrxView);
                            }  
                        }

                        response.reqViews.Add(reqView);
                    }

                    response.reqViews = response.reqViews.OrderByDescending(o => o.checkWaitApproval).ToList();
                }

            }
            return Ok(response);
        }

        [Route("getChange")]
        [AcceptVerbs("GET", "POST")]
        public async Task<IHttpActionResult> GetChange(ApplicationChangeRequest request)
        {
            ApplicationChangeResponse response = new ApplicationChangeResponse();
            response.success = false;

            using (XenDevWebDbContext ctx = new XenDevWebDbContext())
            {
                ProjectDAO pjDAO = new ProjectDAO(ctx);
                Project pj = pjDAO.findByProjectId(request.pjId, false);

                response.appChanges = new List<ApplicationChangeView>();
                if (pj != null && pj.applicationAssets != null)
                {                   
                    response.success = true;
                    List<ApplicationChange> changes = pj.applicationAssets.Where(o => o.enabled)
                                                                          .SelectMany(o => o.applicationChanges)
                                                                          .OrderByDescending(o => o.lastUpdate)
                                                                          .ToList();
                    if(changes == null)
                    {
                        return Ok(response);
                    }

                    changes = changes.OrderBy(o => o.approvalTrxes.Count)
                                     .ThenByDescending(t => t.lastUpdate)
                                     .ToList();

                    foreach (ApplicationChange ac in changes)
                    {
                        if (!ac.checkUserApproved(request.uaId))
                        {
                            continue;
                        }

                        List<ApplicationChangeTrx>  approvalTrxes = ac.approvalTrxes.OrderByDescending(e => e.id).ToList();
                        ApplicationChangeTrx trx = approvalTrxes[0];

                        ApplicationChangeView appChangeView = new ApplicationChangeView();
                        appChangeView.appChangeId = ac.id.ToString();
                        appChangeView.assetFileName = ac.appAsset.assetFileName;
                        appChangeView.description = ac.description;
                        appChangeView.lastUpdate = ac.lastUpdate;
                        appChangeView.applicationColor = ac.applicationChangColor != null ? ac.applicationChangColor : "#78CD51";
                        appChangeView.textAssetFileNameImage = ac.appAsset.assetFileName.Substring(0, 1);
                        if (ac.createdBy != null)
                        {
                            appChangeView.createdBy = string.Format("By {0}", ac.createdBy.firstName);
                        }
                        appChangeView.manDays = ac.manDays;
                        appChangeView.appChangeTrxId = trx.id;
                        appChangeView.isCanApprove = (ac.approvalStatus == APPROVAL_STATUS.APPROVAL_TYPE_NEW && trx.approvalDetail.userAccount.id == request.uaId);

                        appChangeView.timelineChangeTrxes = new List<TimelineApplicationChangeTrxView>();
                        foreach (ApplicationChangeTrx ctrx in ac.approvalTrxes)
                        {
                            TimelineApplicationChangeTrxView trxView = new TimelineApplicationChangeTrxView();
                            switch (ctrx.status)
                            {
                                case APP_CHANGE_TRX_STATUS.NEW:
                                    continue;
                                case APP_CHANGE_TRX_STATUS.CUSTOMER_ACCEPT:
                                    trxView.title = HttpContext.GetGlobalResourceObject("GlobalResource", "customer_accept", culture).ToString();
                                    trxView.time = string.Format("{0:dd}/{0:MM}/{0:yyyy} ", ctrx.changeCompleteDate);
                                    trxView.circleColor = "#4caf50";
                                    break;
                                case APP_CHANGE_TRX_STATUS.CUSTOMER_REJECT:
                                    trxView.title = HttpContext.GetGlobalResourceObject("GlobalResource", "customer_reject", culture).ToString();
                                    trxView.time = string.Format("{0:dd}/{0:MM}/{0:yyyy} ", ctrx.changeRejectDate);
                                    string rejectReason = ctrx.rejectReason != null ? ctrx.rejectReason.name : ctrx.otherRejectReason;
                                    trxView.rejectReason = string.Format("{0}", rejectReason);
                                    trxView.circleColor = "#ff0057";
                                    break;
                                case APP_CHANGE_TRX_STATUS.CODE_CHANGED:
                                case APP_CHANGE_TRX_STATUS.DEVELOPER_CANCEL:
                                    continue;
                            }
                            trxView.description = string.Format("{0} {1}", ctrx.approvalDetail.userAccount.firstName, ctrx.approvalDetail.userAccount.lastName);
                            trxView.imageUrl = string.Format(Constants.URL_API_GETIMAGE, WebUtils.getAppServerPath(), ctrx.approvalDetail.userAccount.imageUserFileName, Constants.TYPE_USER_IMAGE);
                            appChangeView.timelineChangeTrxes.Add(trxView);
                        }

                        response.appChanges.Add(appChangeView);
                    }


                    response.appChanges = response.appChanges.OrderByDescending(o => o.isCanApprove).ToList();
                }

            }
            return Ok(response);
        }

        [Route("getApplicationChangeTrx")]
        [AcceptVerbs("GET", "POST")]
        public async Task<IHttpActionResult> GetApplicationChangeTrx(ApplicationChangeTrxRequest request)
        {
            ApplicationChangeTrxResponse response = new ApplicationChangeTrxResponse();
            response.success = false;
            culture = CultureInfo.CreateSpecificCulture(Thread.CurrentThread.CurrentUICulture.TwoLetterISOLanguageName);
            using (XenDevWebDbContext ctx = new XenDevWebDbContext())
            {
                UserAccountDAO uaDAO = new UserAccountDAO(ctx);
                ApplicationChangeDAO pjDAO = new ApplicationChangeDAO(ctx);
                ApplicationChange appChange = pjDAO.findById(request.appChangeId, false);

                bool isValid = isValidToken(ctx, request.uaId, request.token);

                response.appChangeTrx = new ApplicationChangeTrxView();
                if (isValid && appChange != null && appChange.approvalTrxes  != null)
                {
                    response.success = true;
                    appChange.approvalTrxes  = appChange.approvalTrxes.OrderByDescending(e => e.id).ToList();
                    ApplicationChangeTrx trx = appChange.approvalTrxes [0];
                    response.appChangeTrx.manDays = appChange.manDays;

                    response.appChangeTrx.idAppChangeTrx = trx.id.ToString();
                    response.appChangeTrx.changeDetails = trx.changeDetails;
                    response.appChangeTrx.lastUpdate = string.Format("{0:dd/MMM/yyyy}", trx.lastUpdate);
                    response.appChangeTrx.isCanApprove = (trx.approvalDetail != null &&
                                                          trx.approvalDetail.userAccount != null &&
                                                          trx.approvalDetail.userAccount.id == request.uaId && trx.status == APP_CHANGE_TRX_STATUS.NEW);
                    switch (trx.status)
                    {
                        case APP_CHANGE_TRX_STATUS.NEW:
                            response.appChangeTrx.status = HttpContext.GetGlobalResourceObject("GlobalResource", "new_chang", culture).ToString();
                            break;
                        case APP_CHANGE_TRX_STATUS.CUSTOMER_ACCEPT:
                            response.appChangeTrx.status = HttpContext.GetGlobalResourceObject("GlobalResource", "customer_accept", culture).ToString();
                            break;
                        case APP_CHANGE_TRX_STATUS.CUSTOMER_REJECT:
                            response.appChangeTrx.status = HttpContext.GetGlobalResourceObject("GlobalResource", "customer_reject", culture).ToString();
                            break;
                        case APP_CHANGE_TRX_STATUS.CODE_CHANGED:
                            response.appChangeTrx.status = HttpContext.GetGlobalResourceObject("GlobalResource", "code_changed", culture).ToString();
                            break;
                        case APP_CHANGE_TRX_STATUS.DEVELOPER_CANCEL:
                            response.appChangeTrx.status = HttpContext.GetGlobalResourceObject("GlobalResource", "developer_cancel", culture).ToString();
                            break;
                    }

                    if (appChange.changeType == CHANGE_TYPE.NEW_FEATURE)
                    {
                        response.appChangeTrx.isCanApprove = false;
                    }

                    response.appChangeTrx.images = new List<ImageView>();
                    foreach (domain.Image ig in trx.images)
                    {
                        ImageView imgView = new ImageView();
                        imgView.urlImage = string.Format(Constants.URL_API_GETIMAGE, WebUtils.getAppServerPath(), ig.serverImageFileName, Constants.TYPE_APPLICATION_CHANGE_IMAGE);
                        response.appChangeTrx.images.Add(imgView);
                    }                
                }

            }
            return Ok(response);
        }

        [Route("acceptApplicationChangeTrx")]
        [AcceptVerbs("GET", "POST")]
        public async Task<IHttpActionResult> AcceptApplicationChangeTrx(AcceptApplicationChangeTrxRequest request)
        {
            AcceptApplicationChangeTrxResponse response = new AcceptApplicationChangeTrxResponse();
            response.success = false;
            using (XenDevWebDbContext ctx = new XenDevWebDbContext())
            {
                UserAccountDAO uaDAO = new UserAccountDAO(ctx);
                ApplicationChangeDAO acDAO = new ApplicationChangeDAO(ctx);
                ApplicationChangeTrxDAO acTrxDAO = new ApplicationChangeTrxDAO(ctx);
                ProjectDAO pjDAO = new ProjectDAO(ctx);
                ApproveUtil approveUtil = new ApproveUtil(ctx);

                UserAccount ua = uaDAO.findById(request.uaId, true);
                Project pj = pjDAO.findByProjectId(request.pjId, true);
                ApplicationChangeTrx acTrx = acTrxDAO.findById(request.appChangeTrxId, true);

                if (ua != null && acTrx != null && pj != null)
                {
                    double remainingMandays = pj.remainingMandays - acTrx.applicationChange.manDays;
                    if(remainingMandays < 0)
                    {
                        response.errorMessage = "Not enough man day, remaining " + acTrx.applicationChange.manDays;
                    }
                    else
                    {
                        response.success = true;
                        acTrx.status = APP_CHANGE_TRX_STATUS.CUSTOMER_ACCEPT;
                        acTrx.lastUpdate = DateTime.Now;
                        acTrx.changeCompleteDate = DateTime.Now;
                        acTrxDAO.update(acTrx);

                        ApplicationChangeTrx aTrx = approveUtil.getNextAppChangeApprover(acTrx.applicationChange);
                        if (aTrx != null)
                        {
                            acTrxDAO.create(aTrx);
                        }
                        else
                        {
                            ApplicationChange ac = acDAO.findById(acTrx.applicationChange.id, true);
                            ac.approvalStatus = APPROVAL_STATUS.APPROVAL_TYPE_ACCEPTED;
                            ac.lastUpdate = DateTime.Now;
                            acDAO.update(ac);

                            pj.remainingMandays = remainingMandays;
                            pj.lastUpdate = DateTime.Now;
                            pjDAO.update(pj);
                        }
                    }
                }
                else
                {
                    response.errorMessage = "no information found";
                }

            }

            return Ok(response);
        }

        [Route("acceptApprovalTransactions")]
        [AcceptVerbs("GET", "POST")]
        public async Task<IHttpActionResult> AcceptApprovalTransactions(ApprovalTransactionsRequest request)
        {
            ApprovalTransactionsResponse response = new ApprovalTransactionsResponse();
            response.success = false;
            using (XenDevWebDbContext ctx = new XenDevWebDbContext())
            {
                ApprovalTransactionsDAO atDAO = new ApprovalTransactionsDAO(ctx);
                RequirementDAO reqDAO = new RequirementDAO(ctx);
                ProjectDAO pjDAO = new ProjectDAO(ctx);
                ApproveUtil approveUtil = new ApproveUtil(ctx);

                ApprovalTransactions at = atDAO.findById(request.approvalId, true);
                Project pj = pjDAO.findByProjectId(request.pjId, true);
                if (at != null && at.requirement != null && pj != null)
                {
                    double remainingMandays = pj.remainingMandays - at.requirement.manDays;
                    if (remainingMandays < 0)
                    {
                        response.errorMessage = "Not enough man day, remaining " + at.requirement.manDays;
                    }
                    else
                    {
                        at.approvalResultDate = DateTime.Now;
                        at.status = APPROVAL_STATUS.APPROVAL_TYPE_ACCEPTED;
                        atDAO.update(at);

                        ApprovalTransactions approvalnextRequirement = approveUtil.getNextRequirementApprover(at.requirement);
                        if (approvalnextRequirement != null)
                        {
                            atDAO.create(approvalnextRequirement);
                        }
                        else
                        {
                            Requirement req = reqDAO.findById(at.requirement.id, true);
                            req.status = REQUIREMENT_STATUS.ACCEPTED;
                            req.lastUpDate = DateTime.Now;
                            reqDAO.update(req);

                            pj.remainingMandays = remainingMandays;
                            pj.lastUpdate = DateTime.Now;
                            pjDAO.update(pj);
                        }

                        response.success = true;
                    }                   
                }
                else
                {
                    response.errorMessage = "Not approval!";
                }
                   
            }
            return Ok(response);
        }

        [Route("rejectApprovalTransactions")]
        [AcceptVerbs("GET", "POST")]
        public async Task<IHttpActionResult> RejectApprovalTransactions(RejectApprovalTransactionsRequest request)
        {
            RejectApprovalTransactionsResponse response = new RejectApprovalTransactionsResponse();
            response.success = false;
            using (XenDevWebDbContext ctx = new XenDevWebDbContext())
            {
                ApprovalTransactionsDAO atDAO = new ApprovalTransactionsDAO(ctx);
                RejectReasonDAO rejDAO = new RejectReasonDAO(ctx);
                RequirementDAO reqDAO = new RequirementDAO(ctx);

                ApprovalTransactions at = atDAO.findById(request.approvalId, true);

                if (at != null)
                {
                    RejectReason reject = rejDAO.findByCode(request.rejectCode, true);
                    at.rejectReason = reject;
                    at.otherRejectReason = request.otherRejectReason;
                    at.rejectNote = request.rejectNote;
                    at.approvalResultDate = DateTime.Now;
                    at.lastUpdate = DateTime.Now;
                    at.status = APPROVAL_STATUS.APPROVAL_TYPE_REJECT;
                    atDAO.update(at);

                    Requirement req = reqDAO.findById(at.requirement.id, true);
                    req.status = REQUIREMENT_STATUS.REJECTED;
                    req.lastUpDate = DateTime.Now;

                    foreach (ApprovalTransactions atupdate in req.approvalTrxes)
                    {
                        atupdate.status = APPROVAL_STATUS.APPROVAL_TYPE_REJECT;
                        atupdate.approvalResultDate = DateTime.Now;
                        atupdate.lastUpdate = DateTime.Now;
                    }

                    reqDAO.update(req);

                    response.success = true;
                }               
            }

            return Ok(response);
        }

        [Route("rejectApplicationChangeTrx")]
        [AcceptVerbs("GET", "POST")]
        public async Task<IHttpActionResult> RejectApplicationChangeTrx(RejectApplicationChangeTrxRequest request)
        {
            RejectApplicationChangeTrxResponse response = new RejectApplicationChangeTrxResponse();
            response.success = false;
            using (XenDevWebDbContext ctx = new XenDevWebDbContext())
            {
                UserAccountDAO uaDAO = new UserAccountDAO(ctx);
                ApplicationChangeDAO acDAO = new ApplicationChangeDAO(ctx);
                ApplicationChangeTrxDAO acTrxDAO = new ApplicationChangeTrxDAO(ctx);
                RejectReasonDAO rejDAO = new RejectReasonDAO(ctx);

                UserAccount ua = uaDAO.findById(request.uaId, true);
                ApplicationChangeTrx acTrx = acTrxDAO.findById(request.appChangeTrxId, true);
                RejectReason reject = rejDAO.findByCode(request.rejectCode, true);

                if (ua != null && acTrx != null)
                {
                    response.success = true;
                    acTrx.rejectReason = reject;
                    acTrx.rejectNote = request.rejectNote;
                    acTrx.otherRejectReason = request.otherRejectReason;
                    acTrx.status = APP_CHANGE_TRX_STATUS.CUSTOMER_REJECT;
                    acTrx.lastUpdate = DateTime.Now;
                    acTrx.changeRejectDate = DateTime.Now;
                    acTrx.lastUpdate = DateTime.Now;
                    acTrxDAO.update(acTrx);

                    ApplicationChange ac = acDAO.findById(acTrx.applicationChange.id, true);
                    ac.approvalStatus = APPROVAL_STATUS.APPROVAL_TYPE_REJECT;
                    ac.lastUpdate = DateTime.Now;

                    foreach (ApplicationChangeTrx trxe in ac.approvalTrxes )
                    {
                        trxe.status = APP_CHANGE_TRX_STATUS.CUSTOMER_REJECT;
                        trxe.changeRejectDate = DateTime.Now;
                        acTrx.lastUpdate = DateTime.Now;
                    }

                    acDAO.update(ac);
                    response.success = true;
                }

            }

            return Ok(response);
        }

        [Route("getRejectReason")]
        [AcceptVerbs("GET", "POST")]
        public async Task<IHttpActionResult> GetRejectReason(RejectReasonRequest request)
        {
            RejectReasonResponse response = new RejectReasonResponse();
            response.success = false;
            using (XenDevWebDbContext ctx = new XenDevWebDbContext())
            {
                response.success = true;
                RejectReasonDAO rejDAO = new RejectReasonDAO(ctx);
                List<RejectReason> reReasons = rejDAO.getAllRejectReason(false);
                reReasons = reReasons.OrderByDescending(o => o.lastUpdate).ToList();
                response.rejectReasons = new List<RejectReasonView>();
                RejectReasonView rejView = new RejectReasonView();
                rejView.value = "other_reason";
                rejView.label = "เหตุผลอื่นๆ.";
                response.rejectReasons.Add(rejView);

                foreach (RejectReason reReason in reReasons)
                {
                    rejView = new RejectReasonView();
                    rejView.value = reReason.code;
                    rejView.label = string.Format("{0} ({1}) ",reReason.name, reReason.code);
                    response.rejectReasons.Add(rejView);
                }
            }

            return Ok(response);
        }
    }
}