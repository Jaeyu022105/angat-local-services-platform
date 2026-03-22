<%@ Page Title="Profile" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="GROUP6_ANGAT.Profile" MaintainScrollPositionOnPostback="true" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div id="page-hero">
        <div class="hero-circles">
            <div class="c1"></div>
            <div class="c2"></div>
        </div>
        <div class="page-hero-inner">
            <span class="hero-badge"><i class='bx bx-user'></i> My Account</span>
            <h2>Aking <strong>Profile</strong></h2>
            <p class="hero-desc">I-manage ang inyong account, listings, at applications.</p>
        </div>
        <div class="wave">
            <svg viewBox="0 0 1440 80" xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="none">
                <path d="M0,80 L1440,80 L1440,80 L0,80 Z" fill="#ffffff"/>
            </svg>
        </div>
    </div>

    <div class="section section-light">

        <%-- ===== PROFILE INFO ===== --%>
        <div class="profile-grid" style="grid-template-columns: 1fr 1.8fr 1fr;">
    <%-- Left: avatar + quick info --%>
    <div class="profile-card" style="text-align:center;">
        <div class="profile-avatar-wrap">
            <asp:Image ID="imgProfile" runat="server" CssClass="profile-avatar" />
        </div>
        <div class="profile-meta">
            <h3><asp:Label ID="lblProfileName" runat="server" /></h3>
            <p class="profile-email"><asp:Label ID="lblProfileEmail" runat="server" /></p>
        </div>
            <div class="form-group" style="text-align:center;">
                <label>Palitan ang Profile Picture</label>
                <label for="<%= fuProfileImage.ClientID %>" 
                        class="btn-outline-green" 
                        style="cursor:pointer; display:inline-block; margin-bottom:8px;">
                    <i class='bx bx-upload'></i> Pumili ng Larawan
                </label>
                <asp:FileUpload ID="fuProfileImage" runat="server" style="display:none;" />
                <span id="fileNameDisplay" style="font-size:0.85rem; color:#64748b; display:block;text-align:center;">Walang napiling file</span>
            </div>
        <asp:Button ID="btnUploadPhoto" runat="server" Text="I-save ang Larawan"
            CssClass="btn-outline" OnClick="BtnSaveProfile_Click" />
        <asp:Label ID="lblProfileMessage" runat="server" CssClass="login-helper" />
    </div>

    <%-- Middle: edit form --%>
    <div class="profile-card">
        <h3>I-edit ang Profile</h3>
        <p style="color:var(--text-soft); font-size:0.9rem; margin-bottom:20px;">
            Ayusin ang inyong impormasyon.
        </p>
        <div class="form-group">
            <label>Buong Pangalan</label>
            <asp:TextBox ID="txtFullName" runat="server"></asp:TextBox>
        </div>
        <div class="form-group">
            <label>Email Address <span class="optional">(optional)</span></label>
            <asp:TextBox ID="txtEmail" runat="server" TextMode="Email"></asp:TextBox>
        </div>
        <div class="form-group">
            <label>Phone Number</label>
            <asp:TextBox ID="txtPhone" runat="server" placeholder="09XXXXXXXXX"></asp:TextBox>
        </div>
        <div class="form-group">
            <label>Address</label>
            <asp:TextBox ID="txtAddress" runat="server" placeholder="House No., Street"></asp:TextBox>
        </div>
        <div class="form-group">
            <label>Barangay</label>
            <asp:TextBox ID="txtBarangay" runat="server"></asp:TextBox>
        </div>
        <asp:Button ID="btnSaveProfile" runat="server" Text="I-save ang Profile"
            CssClass="btn-green" OnClick="BtnSaveProfile_Click" />
    </div>

    <%-- Right: change password --%>
    <div class="profile-card">
        <h3>Palitan ang Password</h3>
        <p style="color:var(--text-soft); font-size:0.9rem; margin-bottom:20px;">
            Para sa seguridad, palitan ang password kapag kinakailangan.
        </p>
        <div class="form-group">
            <label>Kasalukuyang Password</label>
            <asp:TextBox ID="txtCurrentPassword" runat="server" TextMode="Password"></asp:TextBox>
        </div>
        <div class="form-group">
            <label>Bagong Password</label>
            <asp:TextBox ID="txtNewPassword" runat="server" TextMode="Password"></asp:TextBox>
        </div>
        <div class="form-group">
            <label>Kumpirmahin ang Bagong Password</label>
            <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password"></asp:TextBox>
        </div>
        <asp:Button ID="btnChangePassword" runat="server" Text="Palitan ang Password"
            CssClass="btn-outline" OnClick="BtnChangePassword_Click" />
        <asp:Label ID="lblPasswordMessage" runat="server" CssClass="login-helper" />
    </div>
</div>

        <%-- ===== TABS ===== --%>
        <div class="profile-tabs" style="margin-top:40px;">
            <div class="profile-tab-nav">
                <button type="button" class="profile-tab-btn active" data-tab="applications">
                    <i class='bx bx-file'></i> Aking Applications
                </button>
                <button type="button" class="profile-tab-btn" data-tab="requests">
                    <i class='bx bx-wrench'></i> Aking Requests
                </button>
                <button type="button" class="profile-tab-btn" data-tab="listings">
                    <i class='bx bx-briefcase'></i> Aking Mga Trabaho
                </button>
                <button type="button" class="profile-tab-btn" data-tab="servicelistings">
                    <i class='bx bx-store-alt'></i> Aking Mga Serbisyo
                </button>
                <button type="button" class="profile-tab-btn" data-tab="businesslistings">
                    <i class='bx bx-store'></i> Aking Negosyo Listings
                </button>
            </div>

            <%-- Global alert --%>
            <asp:Panel ID="pnlApplicationsMessage" runat="server" CssClass="form-alert" Visible="false" style="margin-top:16px;">
                <asp:Label ID="lblApplicationsMessage" runat="server" />
            </asp:Panel>
            <asp:Panel ID="pnlServiceMessage" runat="server" CssClass="form-alert" Visible="false" style="margin-top:16px;">
                <asp:Label ID="lblServiceMessage" runat="server" />
            </asp:Panel>
            <asp:Panel ID="pnlBusinessMessage" runat="server" CssClass="form-alert" Visible="false" style="margin-top:16px;">
                <asp:Label ID="lblBusinessMessage" runat="server" />
            </asp:Panel>

            <%-- TAB 1: My Applications --%>
            <div class="profile-tab-content active" id="tab-applications">
                <asp:Panel ID="pnlNoApplications" runat="server" CssClass="empty-state" Visible="false" />

                <%-- Active Applications --%>
                <h4 style="font-size:1rem; font-weight:700; color:#1e293b; margin-bottom:16px;">
                    <i class='bx bx-time-five' style="color:#15803d;"></i> Aktibong Applications
                </h4>
                <div style="display:grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap:20px; margin-bottom:40px; align-items:start;">
                    <asp:Repeater ID="rptApplications" runat="server" OnItemCommand="RptApplications_ItemCommand">
                        <ItemTemplate>
                            <div class="app-card" data-application-id='<%# Eval("ApplicationId") %>'
                                style="display:flex; flex-direction:column; gap:12px; background:#fff; padding:20px; border-radius:12px; border:1px solid #e2e8f0; align-self:start;">
                                <div style="display:flex; justify-content:space-between; align-items:flex-start;">
                                    <h4 style="font-size:1rem; font-weight:700; color:#1e293b; margin:0;"><%# Eval("JobTitle") %></h4>
                                    <span class="app-status <%# Eval("Status").ToString().Replace("_Archived","").ToLower() %>">
                                        <%# Eval("Status").ToString().Replace("_Archived","") %>
                                    </span>
                                </div>
                                <p class="app-location" style="margin:0;">
                                    <i class='bx bx-map'></i> Brgy. <%# Eval("Barangay") %>, Biñan
                                </p>
                                <div class="app-meta">
                                    <span class="app-pay"><%# GetPayLabel(Eval("PayMin"), Eval("PayMax"), Eval("PayRate")) %></span>
                                    <span><%# Eval("AppliedAt", "{0:MMM dd, yyyy}") %></span>
                                </div>
                                <p class="app-tags" style="margin:0;"><%# FormatTags(Eval("Tags")) %></p>

                                <%-- Show employer contact only when Approved --%>
                                <%# Eval("Status").ToString() == "Approved" ? "" : "<!--" %>
                                <div style="border-top:1px solid #cbd5e1; padding-top:12px; margin-top:4px;">
                                    <p style="margin:0 0 8px 0; font-size:0.85rem; font-weight:700; color:#15803d;">
                                        <i class='bx bx-phone-call'></i> I-contact ang employer dito:
                                    </p>
                                    <p style="margin:0; font-size:0.9rem; font-weight:700; color:#1e293b;">
                                        <i class='bx bx-user'></i> <%# Eval("EmployerName") %>
                                    </p>
                                    <p style="margin:4px 0 0 0; font-size:0.85rem; color:#475569;">
                                        <i class='bx bx-envelope'></i> <%# Eval("EmployerEmail") %>
                                    </p>
                                    <p style="margin:4px 0 0 0; font-size:0.85rem; color:#475569;">
                                        <i class='bx bx-phone'></i> <%# Eval("EmployerPhone") %>
                                    </p>
                                </div>
                                <%# Eval("Status").ToString() == "Approved" ? "" : "-->" %>

                                <div class="app-actions">
                                    <asp:LinkButton ID="btnRetract" runat="server"
                                        CssClass="btn-outline app-retract"
                                        CommandName="Retract"
                                        CommandArgument='<%# Eval("ApplicationId") %>'
                                        Visible='<%# Eval("Status").ToString() == "Pending" %>'>
                                        I-retract
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnArchive" runat="server"
                                        CssClass="btn-outline app-retract"
                                        CommandName="Archive"
                                        CommandArgument='<%# Eval("ApplicationId") %>'
                                        Visible='<%# Eval("Status").ToString() == "Approved" || Eval("Status").ToString() == "Rejected" %>'>
                                        I-archive
                                    </asp:LinkButton>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
                <%-- Closed/Retracted Applications --%>
                <h4 style="font-size:1rem; font-weight:700; color:#94a3b8; margin-bottom:16px;">
                    <i class='bx bx-archive' style="color:#94a3b8;"></i> Saradong Applications
                </h4>
                <div style="display:grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap:20px;">
                    <asp:Repeater ID="rptApplicationsClosed" runat="server">
                        <ItemTemplate>
                            <div class="app-card" data-application-id='<%# Eval("ApplicationId") %>'
                                style="display:flex; flex-direction:column; gap:12px; background:#f8fafc; padding:20px; border-radius:12px; border:1px solid #e2e8f0; opacity:0.75;">
                                <div style="display:flex; justify-content:space-between; align-items:flex-start;">
                                    <h4 style="font-size:1rem; font-weight:700; color:#94a3b8; margin:0;"><%# Eval("JobTitle") %></h4>
                                    <span class="app-status <%# Eval("Status").ToString().Replace("_Archived","").ToLower() %>">
                                        <%# Eval("Status").ToString().Replace("_Archived","") %>
                                    </span>
                                </div>
                                <p class="app-location" style="margin:0; color:#94a3b8;">
                                    <i class='bx bx-map'></i> Brgy. <%# Eval("Barangay") %>, Biñan
                                </p>
                                <div class="app-meta">
                                    <span class="app-pay"><%# GetPayLabel(Eval("PayMin"), Eval("PayMax"), Eval("PayRate")) %></span>
                                    <span><%# Eval("AppliedAt", "{0:MMM dd, yyyy}") %></span>
                                </div>
                                <p class="app-tags" style="margin:0;"><%# FormatTags(Eval("Tags")) %></p>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>

            <%-- TAB 2: My Service Requests --%>
            <div class="profile-tab-content" id="tab-requests">
                <asp:Panel ID="pnlNoServiceRequests" runat="server" CssClass="empty-state" Visible="false" />

                <%-- Active Requests --%>
                <h4 style="font-size:1rem; font-weight:700; color:#1e293b; margin-bottom:16px;">
                    <i class='bx bx-time-five' style="color:#15803d;"></i> Aktibong Requests
                </h4>
                <div style="display:grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap:20px; margin-bottom:40px;align-items:start;">
                    <asp:Repeater ID="rptServiceRequests" runat="server" OnItemCommand="RptServiceRequests_ItemCommand">
                        <ItemTemplate>
                            <div class="app-card" data-request-id='<%# Eval("RequestId") %>'
                                style="display:flex; flex-direction:column; gap:12px; background:#fff; padding:20px; border-radius:12px; border:1px solid #e2e8f0; align-self:start;">
                                <div style="display:flex; justify-content:space-between; align-items:flex-start;">
                                    <h4 style="font-size:1rem; font-weight:700; color:#1e293b; margin:0;"><%# Eval("ServiceTitle") %></h4>
                                    <span class="app-status <%# Eval("Status").ToString().Replace("_Archived","").ToLower() %>">
                                        <%# Eval("Status").ToString().Replace("_Archived","") %>
                                    </span>
                                </div>
                                <p class="app-location" style="margin:0;">
                                    <i class='bx bx-map'></i> Brgy. <%# Eval("Barangay") %>, Biñan
                                </p>
                                <div class="app-meta">
                                    <span class="app-pay"><%# GetPayLabel(Eval("RateMin"), Eval("RateMax"), Eval("RateType")) %></span>
                                    <span><%# Eval("RequestedAt", "{0:MMM dd, yyyy}") %></span>
                                </div>
                                <p class="app-tags" style="margin:0;"><%# FormatTags(Eval("Tags")) %></p>

                                <%-- Show poster contact only when Approved --%>
                                <%# Eval("Status").ToString() == "Approved" ? "" : "<!--" %>
                                <div style="border-top:1px solid #94a3b8; padding-top:12px; margin-top:4px;">
                                    <p style="margin:0 0 8px 0; font-size:0.85rem; font-weight:700; color:#15803d;">
                                        <i class='bx bx-phone-call'></i> I-contact ang service poster dito:
                                    </p>
                                    <p style="margin:0; font-size:0.9rem; font-weight:700; color:#1e293b;">
                                        <i class='bx bx-user'></i> <%# Eval("PosterName") %>
                                    </p>
                                    <p style="margin:4px 0 0 0; font-size:0.85rem; color:#475569;">
                                        <i class='bx bx-envelope'></i> <%# Eval("PosterEmail") %>
                                    </p>
                                    <p style="margin:4px 0 0 0; font-size:0.85rem; color:#475569;">
                                        <i class='bx bx-phone'></i> <%# Eval("PosterPhone") %>
                                    </p>
                                </div>
                                <%# Eval("Status").ToString() == "Approved" ? "" : "-->" %>

                                <div class="app-actions">
                                    <asp:LinkButton ID="btnRetractService" runat="server"
                                        CssClass="btn-outline app-retract"
                                        CommandName="RetractService"
                                        CommandArgument='<%# Eval("RequestId") %>'
                                        Visible='<%# Eval("Status").ToString() == "Pending" %>'>
                                        I-retract
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnArchiveService" runat="server"
                                        CssClass="btn-outline app-retract"
                                        CommandName="ArchiveService"
                                        CommandArgument='<%# Eval("RequestId") %>'
                                        Visible='<%# Eval("Status").ToString() == "Approved" || Eval("Status").ToString() == "Rejected" %>'>
                                        I-archive
                                    </asp:LinkButton>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>

                <%-- Closed Requests --%>
                <h4 style="font-size:1rem; font-weight:700; color:#94a3b8; margin-bottom:16px;">
                    <i class='bx bx-archive' style="color:#94a3b8;"></i> Saradong Requests
                </h4>
                <div style="display:grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap:20px;">
                    <asp:Repeater ID="rptServiceRequestsClosed" runat="server">
                        <ItemTemplate>
                            <div class="app-card" data-request-id='<%# Eval("RequestId") %>'
                                style="display:flex; flex-direction:column; gap:12px; background:#f8fafc; padding:20px; border-radius:12px; border:1px solid #e2e8f0; opacity:0.75;">
                                <div style="display:flex; justify-content:space-between; align-items:flex-start;">
                                    <h4 style="font-size:1rem; font-weight:700; color:#94a3b8; margin:0;"><%# Eval("ServiceTitle") %></h4>
                                    <span class="app-status <%# Eval("Status").ToString().Replace("_Archived","").ToLower() %>">
                                        <%# Eval("Status").ToString().Replace("_Archived","") %>
                                    </span>
                                </div>
                                <p class="app-location" style="margin:0; color:#94a3b8;">
                                    <i class='bx bx-map'></i> Brgy. <%# Eval("Barangay") %>, Biñan
                                </p>
                                <div class="app-meta">
                                    <span class="app-pay"><%# GetPayLabel(Eval("RateMin"), Eval("RateMax"), Eval("RateType")) %></span>
                                    <span><%# Eval("RequestedAt", "{0:MMM dd, yyyy}") %></span>
                                </div>
                                <p class="app-tags" style="margin:0;"><%# FormatTags(Eval("Tags")) %></p>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>

            <%-- TAB 3: My Job Listings --%>
            <div class="profile-tab-content" id="tab-listings">
                <asp:Panel ID="pnlNoListings" runat="server" CssClass="empty-state" Visible="false"/>
                    

                <%-- Active Listings --%>
                <h4 style="font-size:1rem; font-weight:700; color:#1e293b; margin-bottom:16px;">
                    <i class='bx bx-time-five' style="color:#15803d;"></i> Aktibong Job Listings
                </h4>
                <div style="display:grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap:20px; margin-bottom:40px;">
                    <asp:Repeater ID="rptMyListings" runat="server"
                        OnItemDataBound="RptMyListings_ItemDataBound"
                        OnItemCommand="RptMyListings_ItemCommand">
                        <ItemTemplate>
                            <%# Convert.ToBoolean(Eval("IsActive")) ? "" : "<!--" %>
                            <div class="app-card" data-job-id='<%# Eval("JobId") %>'
                                style="display:flex; flex-direction:column; gap:12px; background:#fff; padding:20px; border-radius:12px; border:1px solid #e2e8f0; align-self:start;">
                                <div style="display:flex; justify-content:space-between; align-items:flex-start;">
                                    <h4 style="font-size:1rem; font-weight:700; color:#1e293b; margin:0;"><%# Eval("JobTitle") %></h4>
                                    <asp:Literal ID="litStatus" runat="server" />
                                </div>
                                <p class="app-location" style="margin:0;">
                                    <i class='bx bx-map'></i> Brgy. <%# Eval("Barangay") %>, Biñan
                                </p>
                                <div class="app-meta" style="display:flex; justify-content:space-between; gap:8px;">
                                    <span class="app-pay"><%# GetPayLabel(Eval("PayMin"), Eval("PayMax"), Eval("PayRate")) %></span>
                                    <span><%# Eval("PostedAt", "{0:MMM dd, yyyy}") %></span>
                                </div>
                                <p class="app-tags" style="margin:0;"><%# FormatTags(Eval("Tags")) %></p>
                                <p style="font-size:0.82rem; color:var(--text-soft); margin-top:6px;">
                                    <i class='bx bx-group'></i> <strong><%# Eval("Slots") %></strong> slot/s natitira
                                </p>
                                <div class="app-actions">
                                    <asp:LinkButton ID="btnDeleteListing" runat="server"
                                        CssClass="btn-outline app-retract"
                                        CommandName="DeleteListing"
                                        CommandArgument='<%# Eval("JobId") %>'
                                        UseSubmitBehavior="false">
                                        I-delete
                                    </asp:LinkButton>
                                </div>

                                <asp:HiddenField ID="hfListingJobId" runat="server" Value='<%# Eval("JobId") %>' />

                            <div class="applicants-block">
                                <h5>Mga Applicants</h5>
                                <asp:Panel ID="pnlNoApplicants" runat="server" CssClass="empty-state" Visible="false">
                                    <p>Wala pang applicants.</p>
                                </asp:Panel>
                                <asp:Repeater ID="rptApplicants" runat="server" OnItemCommand="RptApplicants_ItemCommand">
                                    <ItemTemplate>
                                        <div class="applicant-row" data-application-id='<%# Eval("ApplicationId") %>'>
                                            <div style="display:flex; justify-content:space-between; align-items:flex-start; gap:8px; width:100%;">
                                                <div style="flex:1; min-width:0; overflow:hidden;">
                                                    <strong><%# Eval("FullName") %></strong>
                                                    <div class="applicant-meta"><%# Eval("Phone") %></div>
                                                    <div class="applicant-meta" style="overflow-wrap:break-word; word-break:break-all;"><%# !string.IsNullOrEmpty(Eval("Email").ToString()) ? Eval("Email").ToString() : "" %></div>
                                                    <div class="applicant-meta"><%# Eval("AppliedAt", "{0:MMM dd, yyyy}") %></div>
                                                    <div style="display:flex; gap:30px; margin-top:6px; flex-wrap:wrap">
                                                        <asp:LinkButton ID="btnApprove" runat="server"
                                                            CssClass="btn-outline-green app-retract"
                                                            CommandName="Approve"
                                                            CommandArgument='<%# Eval("ApplicationId") %>'
                                                            Visible='<%# Eval("Status").ToString() == "Pending" %>'
                                                            style="padding:8px 17px; font-size:0.75rem; border-radius:20px; min-width:70px; text-align:center;">
                                                            Approve
                                                        </asp:LinkButton>
                                                        <asp:LinkButton ID="btnReject" runat="server"
                                                            CssClass="btn-outline-red app-retract"
                                                            CommandName="Reject"
                                                            CommandArgument='<%# Eval("ApplicationId") %>'
                                                            Visible='<%# Eval("Status").ToString() == "Pending" %>'
                                                            style="padding:8px 17px; font-size:0.75rem; border-radius:20px; min-width:70px; text-align:center;">
                                                            Reject
                                                        </asp:LinkButton>
                                                    </div>
                                                </div>
                                                <span class="app-status <%# Eval("Status").ToString().Replace("_Archived","").ToLower() %>" style="white-space:nowrap; flex-shrink:0;">
                                                    <%# Eval("Status").ToString().Replace("_Archived","") %>
                                                </span>
                                            </div>
                                        </div>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </div>
                            </div>
                            <%# Convert.ToBoolean(Eval("IsActive")) ? "" : "-->" %>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>

                <%-- Deleted Listings --%>
                <h4 style="font-size:1rem; font-weight:700; color:#94a3b8; margin-bottom:16px;">
                    <i class='bx bx-archive' style="color:#94a3b8;"></i> Na-delete na Listings
                </h4>
                <div style="display:grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap:20px;">
                    <asp:Repeater ID="rptMyListingsDeleted" runat="server">
                        <ItemTemplate>
                            <div class="app-card" data-job-id='<%# Eval("JobId") %>'
                                style="display:flex; flex-direction:column; gap:12px; background:#f8fafc; padding:20px; border-radius:12px; border:1px solid #e2e8f0; opacity:0.75;">
                                <div style="display:flex; justify-content:space-between; align-items:flex-start;">
                                    <h4 style="font-size:1rem; font-weight:700; color:#94a3b8; margin:0;"><%# Eval("JobTitle") %></h4>
                                    <span class="app-status deleted">Deleted</span>
                                </div>
                                <p class="app-location" style="margin:0; color:#94a3b8;">
                                    <i class='bx bx-map'></i> Brgy. <%# Eval("Barangay") %>, Biñan
                                </p>
                                <div class="app-meta">
                                    <span class="app-pay"><%# GetPayLabel(Eval("PayMin"), Eval("PayMax"), Eval("PayRate")) %></span>
                                    <span><%# Eval("PostedAt", "{0:MMM dd, yyyy}") %></span>
                                </div>
                                <p class="app-tags" style="margin:0;"><%# FormatTags(Eval("Tags")) %></p>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>

            <%-- TAB 4: My Service Listings --%>
            <div class="profile-tab-content" id="tab-servicelistings">
                <asp:Panel ID="pnlNoServiceListings" runat="server" CssClass="empty-state" Visible="false"/>

                <%-- Active Service Listings --%>
                <h4 style="font-size:1rem; font-weight:700; color:#1e293b; margin-bottom:16px;">
                    <i class='bx bx-time-five' style="color:#15803d;"></i> Aktibong Service Listings
                </h4>
                <div style="display:grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap:20px; margin-bottom:40px;">
                    <asp:Repeater ID="rptServiceListings" runat="server"
                        OnItemCommand="RptServiceListings_ItemCommand"
                        OnItemDataBound="RptServiceListings_ItemDataBound">
                        <ItemTemplate>
                            <div class="app-card" data-service-id='<%# Eval("ServiceId") %>'
                                style="display:flex; flex-direction:column; gap:12px; background:#fff; padding:20px; border-radius:12px; border:1px solid #e2e8f0; align-self:start;">
                                <div style="display:flex; justify-content:space-between; align-items:flex-start;">
                                    <h4 style="font-size:1rem; font-weight:700; color:#1e293b; margin:0;"><%# Eval("ServiceTitle") %></h4>
                                    <asp:Literal ID="litServiceStatus" runat="server" />
                                </div>
                                <p class="app-location" style="margin:0;">
                                    <i class='bx bx-map'></i> Brgy. <%# Eval("Barangay") %>, Biñan
                                </p>
                                <div class="app-meta">
                                    <span class="app-pay"><%# GetPayLabel(Eval("RateMin"), Eval("RateMax"), Eval("RateType")) %></span>
                                    <span><%# Eval("PostedAt", "{0:MMM dd, yyyy}") %></span>
                                </div>
                                <p class="app-tags" style="margin:0;"><%# FormatTags(Eval("Tags")) %></p>
                                <div class="app-actions">
                                    <asp:LinkButton ID="btnDeleteServiceListing" runat="server"
                                        CssClass="btn-outline app-retract"
                                        CommandName="DeleteServiceListing"
                                        CommandArgument='<%# Eval("ServiceId") %>'>
                                        I-delete
                                    </asp:LinkButton>
                                </div>

                                <asp:HiddenField ID="hfListingServiceId" runat="server" Value='<%# Eval("ServiceId") %>' />
                            <asp:Panel ID="pnlApplicantsBlock" runat="server">
                                <div class="applicants-block">
                                    <h5>Mga Requests</h5>
                                    <asp:Panel ID="pnlNoServiceApplicants" runat="server" CssClass="empty-state" Visible="false">
                                        <p>Wala pang requests.</p>
                                    </asp:Panel>
                                    <asp:Repeater ID="rptServiceApplicants" runat="server" OnItemCommand="RptServiceApplicants_ItemCommand">
                                        <ItemTemplate>
                                            <div class="applicant-row" data-request-id='<%# Eval("RequestId") %>'>
                                                <div style="display:flex; justify-content:space-between; align-items:flex-start; gap:8px; width:100%;">
                                                    <div style="flex:1; min-width:0; overflow:hidden;">
                                                        <strong><%# Eval("FullName") %></strong>
                                                        <div class="applicant-meta"><%# Eval("Phone") %></div>
                                                        <div class="applicant-meta" style="overflow-wrap:break-word; word-break:break-all;"><%# !string.IsNullOrEmpty(Eval("Email").ToString()) ? Eval("Email").ToString() : "" %></div>
                                                        <div class="applicant-meta"><%# Eval("RequestedAt", "{0:MMM dd, yyyy}") %></div>
                                                       <div style="display:flex; gap:30px; margin-top:6px; flex-wrap:wrap">
                                                            <asp:LinkButton ID="btnApproveService" runat="server"
                                                                CssClass="btn-outline-green app-retract"
                                                                CommandName="ApproveService"
                                                                CommandArgument='<%# Eval("RequestId") %>'
                                                                Visible='<%# Eval("Status").ToString() == "Pending" %>'
                                                                style="padding:8px 17px; font-size:0.75rem; border-radius:20px; min-width:70px; text-align:center;">
                                                                Approve
                                                            </asp:LinkButton>
                                                            <asp:LinkButton ID="btnRejectService" runat="server"
                                                                CssClass="btn-outline-red app-retract"
                                                                CommandName="RejectService"
                                                                CommandArgument='<%# Eval("RequestId") %>'
                                                                Visible='<%# Eval("Status").ToString() == "Pending" %>'
                                                                style="padding:8px 17px; font-size:0.75rem; border-radius:20px; min-width:70px; text-align:center;">
                                                                Reject
                                                            </asp:LinkButton>
                                                        </div>
                                                    </div>
                                                    <span class="app-status <%# Eval("Status").ToString().Replace("_Archived","").ToLower() %>" style="white-space:nowrap; flex-shrink:0;">
                                                        <%# Eval("Status").ToString().Replace("_Archived","") %>
                                                    </span>
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </div>
                            </asp:Panel>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>

                <%-- Deleted Service Listings --%>
                <h4 style="font-size:1rem; font-weight:700; color:#94a3b8; margin-bottom:16px;">
                    <i class='bx bx-archive' style="color:#94a3b8;"></i> Na-delete na Service Listings
                </h4>
                <div style="display:grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap:20px;">
                    <asp:Repeater ID="rptServiceListingsDeleted" runat="server">
                        <ItemTemplate>
                            <div class="app-card" data-service-id='<%# Eval("ServiceId") %>'
                                style="display:flex; flex-direction:column; gap:12px; background:#f8fafc; padding:20px; border-radius:12px; border:1px solid #e2e8f0; opacity:0.75;">
                                <div style="display:flex; justify-content:space-between; align-items:flex-start;">
                                    <h4 style="font-size:1rem; font-weight:700; color:#94a3b8; margin:0;"><%# Eval("ServiceTitle") %></h4>
                                    <span class="app-status deleted">Deleted</span>
                                </div>
                                <p class="app-location" style="margin:0; color:#94a3b8;">
                                    <i class='bx bx-map'></i> Brgy. <%# Eval("Barangay") %>, Biñan
                                </p>
                                <div class="app-meta">
                                    <span class="app-pay"><%# GetPayLabel(Eval("RateMin"), Eval("RateMax"), Eval("RateType")) %></span>
                                    <span><%# Eval("PostedAt", "{0:MMM dd, yyyy}") %></span>
                                </div>
                                <p class="app-tags" style="margin:0;"><%# FormatTags(Eval("Tags")) %></p>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>

        
            <%-- TAB 5: My Business Listings --%>
            <div class="profile-tab-content" id="tab-businesslistings">
                <asp:Panel ID="pnlNoBusinessListings" runat="server" CssClass="empty-state" Visible="false"/>

                <%-- Active Business Listings --%>
                <h4 style="font-size:1rem; font-weight:700; color:#1e293b; margin-bottom:16px;">
                    <i class='bx bx-time-five' style="color:#15803d;"></i> Aktibong Negosyo Listings
                </h4>
                <div style="display:grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap:20px; margin-bottom:40px;">
                    <asp:Repeater ID="rptBusinessListings" runat="server" OnItemCommand="RptBusinessListings_ItemCommand">
                        <ItemTemplate>
                            <div class="app-card"
                                style="display:flex; flex-direction:column; gap:12px; background:#fff; padding:20px; border-radius:12px; border:1px solid #e2e8f0; align-self:start;">
                                <div style="display:flex; justify-content:space-between; align-items:flex-start; gap:8px;">
                                    <h4 style="font-size:0.85rem; font-weight:700; color:#1e293b; margin:0;"><%# Eval("BusinessName") %></h4>
                                    <span class="app-status <%# Eval("Status").ToString().ToLower() %>" style="white-space:nowrap; flex-shrink:0; font-size:0.75rem; padding:5px 12px;">
                                        <%# Eval("Status") %>
                                    </span>
                                </div>
                                <p class="app-location" style="margin:0;">
                                    <i class='bx bx-map'></i> <%# GetBusinessLocation(Eval("AddressLine"), Eval("Barangay")) %>
                                </p>
                                <div class="app-meta">
                                    <span class="app-pay"><%# Eval("Category") %></span>
                                    <span><%# Eval("CreatedAt", "{0:MMM dd, yyyy}") %></span>
                                </div>
                                <p class="app-tags" style="margin:0;"><%# FormatTags(Eval("Tags")) %></p>
                                <p style="font-size:0.82rem; color:var(--text-soft); margin-top:6px;">
                                    <i class='bx bx-phone'></i> <%# GetBusinessContact(Eval("ContactNumber")) %>
                                </p>
                                <div class="app-actions">
                                    <div class="app-actions" style="gap:8px;">
                                        <a href='<%# "/Pages/PostNegosyo.aspx?edit=" + Eval("DirectoryId") %>' 
                                           class="btn-outline app-retract" 
                                           style="text-decoration:none; display:inline-block;">
                                            I-edit
                                        </a>
                                        <asp:LinkButton ID="btnDeleteBusinessListing" runat="server"
                                            CssClass="btn-outline app-retract"
                                            CommandName="DeleteBusinessListing"
                                            CommandArgument='<%# Eval("DirectoryId") %>'>
                                            I-delete
                                        </asp:LinkButton>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>

                <%-- Deleted Business Listings --%>
                <h4 style="font-size:1rem; font-weight:700; color:#94a3b8; margin-bottom:16px;">
                    <i class='bx bx-archive' style="color:#94a3b8;"></i> Na-delete na Negosyo Listings
                </h4>
                <div style="display:grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap:20px;">
                    <asp:Repeater ID="rptBusinessListingsDeleted" runat="server">
                        <ItemTemplate>
                            <div class="app-card"
                                style="display:flex; flex-direction:column; gap:12px; background:#f8fafc; padding:20px; border-radius:12px; border:1px solid #e2e8f0; opacity:0.75;">
                                <div style="display:flex; justify-content:space-between; align-items:flex-start;">
                                    <h4 style="font-size:1rem; font-weight:700; color:#94a3b8; margin:0;"><%# Eval("BusinessName") %></h4>
                                    <span class="app-status deleted">Deleted</span>
                                </div>
                                <p class="app-location" style="margin:0; color:#94a3b8;">
                                    <i class='bx bx-map'></i> <%# GetBusinessLocation(Eval("AddressLine"), Eval("Barangay")) %>
                                </p>
                                <div class="app-meta">
                                    <span class="app-pay"><%# Eval("Category") %></span>
                                    <span><%# Eval("CreatedAt", "{0:MMM dd, yyyy}") %></span>
                                </div>
                                <p class="app-tags" style="margin:0;"><%# FormatTags(Eval("Tags")) %></p>
                                <p style="font-size:0.82rem; color:var(--text-soft); margin-top:6px;">
                                    <i class='bx bx-phone'></i> <%# GetBusinessContact(Eval("ContactNumber")) %>
                                </p>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>
        </div>
    </div>
    <%-- end profile-tabs --%>
    <script>
        // shows selected filename for profile image upload
        document.getElementById('<%= fuProfileImage.ClientID %>').addEventListener('change', function () {
            var fileName = this.files[0] ? this.files[0].name : 'Walang napiling file';
            document.getElementById('fileNameDisplay').textContent = fileName;
        });
        // Auto-hide alerts after 3 seconds
        function autoHideAlerts() {
            var alerts = document.querySelectorAll('.form-alert');
            alerts.forEach(function (alert) {
                if (alert.style.display !== 'none' && alert.offsetParent !== null) {
                    setTimeout(function () {
                        alert.style.transition = 'opacity 0.5s ease';
                        alert.style.opacity = '0';
                        setTimeout(function () {
                            alert.style.display = 'none';
                            alert.style.opacity = '1';
                        }, 500);
                    }, 3000);
                }
            });
        }

        document.addEventListener('DOMContentLoaded', function () {
            autoHideAlerts();
        });
        // Tab switching
        var tabBtns    = document.querySelectorAll('.profile-tab-btn');
        var tabContents = document.querySelectorAll('.profile-tab-content');
        //modified for notifs so we can activate the correct tab when user clicks on a notif related to a listing/request/application   
        function activateProfileTab(tabName) {
            tabBtns.forEach(function (b) { b.classList.remove('active'); });
            tabContents.forEach(function (c) { c.classList.remove('active'); });

            var btn = document.querySelector('.profile-tab-btn[data-tab="' + tabName + '"]');
            var panel = document.getElementById('tab-' + tabName);

            if (btn) btn.classList.add('active');
            if (panel) panel.classList.add('active');
        }

        tabBtns.forEach(function(btn) {
            btn.addEventListener('click', function() {
                activateProfileTab(btn.dataset.tab);
            });
        });
        document.addEventListener('DOMContentLoaded', function() {
            var params = new URLSearchParams(window.location.search);
            var tab = params.get('tab');
            var applicationId = params.get('applicationId');
            var requestId = params.get('requestId');
            var jobId = params.get('jobId');
            var serviceId = params.get('serviceId');
            if (tab) {
                activateProfileTab(tab);
            }
            var scope = tab ? document.getElementById('tab-' + tab) : document;
            var selectors = [];

            if (applicationId) selectors.push('[data-application-id="' + applicationId + '"]');
            if(requestId) selectors.push('[data-request-id="' + requestId + '"]');
            if(jobId) selectors.push('[data-job-id="' + jobId + '"]');
            if (serviceId) selectors.push('[data-service-id="' + serviceId + '"]');
            if (!selectors.length) return;
            setTimeout(function () {
                var target = null;
                selectors.some(function (selector) {
                    target = scope ? scope.querySelector(selector) : null;
                    if (!target) target = document.querySelector(selector);
                    return !!target;
                });
                if (target) {
                    var highlightTarget = target.closest('.app-card') || target;
                    highlightTarget.scrollIntoView({ behavior: 'smooth', block: 'center' });
                    highlightTarget.style.outline = '2px solid #1f7a5a';
                    highlightTarget.style.outlineOffset = '4px';
                }

            }, 100);
        });
    </script>
</asp:Content>

