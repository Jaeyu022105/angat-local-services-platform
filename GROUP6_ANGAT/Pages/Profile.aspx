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

    <div class="section section-white">

        <%-- ===== PROFILE INFO ===== --%>
        <div class="profile-grid">

            <%-- Left: avatar + quick info --%>
            <div class="profile-card">
                <div class="profile-avatar-wrap">
                    <asp:Image ID="imgProfile" runat="server" CssClass="profile-avatar" />
                </div>
                <div class="profile-meta">
                    <h3><asp:Label ID="lblProfileName" runat="server" /></h3>
                    <span class="profile-badge"><asp:Label ID="lblProfileRole" runat="server" /></span>
                    <p class="profile-email"><asp:Label ID="lblProfileEmail" runat="server" /></p>
                </div>
                <div class="form-group">
                    <label>Palitan ang Profile Picture</label>
                    <asp:FileUpload ID="fuProfileImage" runat="server" />
                </div>
                <asp:Button ID="btnUploadPhoto" runat="server" Text="I-save ang Photo"
                    CssClass="btn-outline" OnClick="BtnSaveProfile_Click" />
                <asp:Label ID="lblProfileMessage" runat="server" CssClass="login-helper" />
            </div>

            <%-- Right: edit form --%>
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
        </div>

        <%-- Change password --%>
        <div class="profile-grid" style="margin-top:24px;">
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
                    <i class='bx bx-briefcase'></i> Aking Job Listings
                </button>
                <button type="button" class="profile-tab-btn" data-tab="servicelistings">
                    <i class='bx bx-store-alt'></i> Aking Service Listings
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
                <asp:Panel ID="pnlNoApplications" runat="server" CssClass="empty-state" Visible="false">
                    <i class='bx bx-file'></i>
                    <h4>Wala ka pang applications</h4>
                    <p>Mag-apply sa isang trabaho para makita dito.</p>
                </asp:Panel>

                <asp:Repeater ID="rptApplications" runat="server" OnItemCommand="RptApplications_ItemCommand">
                    <ItemTemplate>
                        <div class="app-card" data-application-id='<%# Eval("ApplicationId") %>'> <%-- changed so js can find the card for notifs --%>

                            <div class="app-card-top">
                                <div>
                                    <h4><%# Eval("JobTitle") %></h4>
                                    <p class="app-location">
                                        <i class='bx bx-map'></i> Brgy. <%# Eval("Barangay") %>, Biñan
                                    </p>
                                </div>
                                <span class="app-status <%# Eval("Status").ToString().ToLower() %>">
                                    <%# Eval("Status") %>
                                </span>
                            </div>
                            <div class="app-meta">
                                <span class="app-pay"><%# GetPayLabel(Eval("PayMin"), Eval("PayMax"), Eval("PayRate")) %></span>
                                <span><%# Eval("AppliedAt", "{0:MMM dd, yyyy}") %></span>
                            </div>
                            <p class="app-tags"><%# FormatTags(Eval("Tags")) %></p>
                            <div class="app-actions">
                                <asp:LinkButton ID="btnRetract" runat="server"
                                    CssClass="btn-outline app-retract"
                                    CommandName="Retract"
                                    CommandArgument='<%# Eval("ApplicationId") %>'
                                    Visible='<%# Eval("Status").ToString() == "Pending" %>'>
                                    I-retract
                                </asp:LinkButton>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>

            <%-- TAB 2: My Service Requests --%>
            <div class="profile-tab-content" id="tab-requests">
                <asp:Panel ID="pnlNoServiceRequests" runat="server" CssClass="empty-state" Visible="false">
                    <i class='bx bx-wrench'></i>
                    <h4>Wala ka pang service requests</h4>
                    <p>Mag-request ng serbisyo para makita dito.</p>
                </asp:Panel>

                <asp:Repeater ID="rptServiceRequests" runat="server" OnItemCommand="RptServiceRequests_ItemCommand">
                    <ItemTemplate>
                        <div class="app-card" data-request-id='<%# Eval("RequestId") %>'><%--changed for notifs again --%>
                            <div class="app-card-top">
                                <div>
                                    <h4><%# Eval("ServiceTitle") %></h4>
                                    <p class="app-location">
                                        <i class='bx bx-map'></i> Brgy. <%# Eval("Barangay") %>, Biñan
                                    </p>
                                </div>
                                <span class="app-status <%# Eval("Status").ToString().ToLower() %>">
                                    <%# Eval("Status") %>
                                </span>
                            </div>
                            <div class="app-meta">
                                <span class="app-pay"><%# GetPayLabel(Eval("RateMin"), Eval("RateMax"), Eval("RateType")) %></span>
                                <span><%# Eval("RequestedAt", "{0:MMM dd, yyyy}") %></span>
                            </div>
                            <p class="app-tags"><%# FormatTags(Eval("Tags")) %></p>
                            <div class="app-actions">
                                <asp:LinkButton ID="btnRetractService" runat="server"
                                    CssClass="btn-outline app-retract"
                                    CommandName="RetractService"
                                    CommandArgument='<%# Eval("RequestId") %>'
                                    Visible='<%# Eval("Status").ToString() == "Pending" %>'>
                                    I-retract
                                </asp:LinkButton>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>

            <%-- TAB 3: My Job Listings --%>
            <div class="profile-tab-content" id="tab-listings">
                <asp:Panel ID="pnlNoListings" runat="server" CssClass="empty-state" Visible="false">
                    <i class='bx bx-briefcase'></i>
                    <h4>Wala ka pang job listings</h4>
                    <p><a href="/Pages/PostJob.aspx">Mag-post ng trabaho</a> para magsimula.</p>
                </asp:Panel>

                <asp:Repeater ID="rptMyListings" runat="server"
                    OnItemDataBound="RptMyListings_ItemDataBound"
                    OnItemCommand="RptMyListings_ItemCommand">
                    <ItemTemplate>
                        <div class="app-card" data-job-id='<%# Eval("JobId") %>'>
                            <div class="app-card-top">
                                <div>
                                    <h4><%# Eval("JobTitle") %></h4>
                                    <p class="app-location">
                                        <i class='bx bx-map'></i> Brgy. <%# Eval("Barangay") %>, Biñan
                                    </p>
                                </div>
                                <span class="app-status <%# Eval("Status").ToString().ToLower() %>">
                                    <%# Eval("Status") %>
                                </span>
                            </div>
                            <div class="app-meta">
                                <span class="app-pay"><%# GetPayLabel(Eval("PayMin"), Eval("PayMax"), Eval("PayRate")) %></span>
                                <span><%# Eval("PostedAt", "{0:MMM dd, yyyy}") %></span>
                            </div>
                            <p class="app-tags"><%# FormatTags(Eval("Tags")) %></p>
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
                                            <div>
                                                <strong><%# Eval("FullName") %></strong>
                                                <div class="applicant-meta">
                                                    <%# Eval("Phone") %>
                                                    <%# !string.IsNullOrEmpty(Eval("Email").ToString()) ? " &bull; " + Eval("Email") : "" %>
                                                </div>
                                                <div class="applicant-meta"><%# Eval("AppliedAt", "{0:MMM dd, yyyy}") %></div>
                                            </div>
                                            <div class="applicant-actions">
                                                <span class="app-status <%# Eval("Status").ToString().ToLower() %>">
                                                    <%# Eval("Status") %>
                                                </span>
                                                <asp:LinkButton ID="btnApprove" runat="server"
                                                    CssClass="btn-green app-retract"
                                                    CommandName="Approve"
                                                    CommandArgument='<%# Eval("ApplicationId") %>'
                                                    Visible='<%# Eval("Status").ToString() == "Pending" %>'>
                                                    Approve
                                                </asp:LinkButton>
                                                <asp:LinkButton ID="btnReject" runat="server"
                                                    CssClass="btn-outline app-retract"
                                                    CommandName="Reject"
                                                    CommandArgument='<%# Eval("ApplicationId") %>'
                                                    Visible='<%# Eval("Status").ToString() == "Pending" %>'>
                                                    Reject
                                                </asp:LinkButton>
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>

            <%-- TAB 4: My Service Listings --%>
            <div class="profile-tab-content" id="tab-servicelistings">
                <asp:Panel ID="pnlNoServiceListings" runat="server" CssClass="empty-state" Visible="false">
                    <i class='bx bx-store-alt'></i>
                    <h4>Wala ka pang service listings</h4>
                    <p><a href="/Pages/PostService.aspx">Mag-post ng serbisyo</a> para magsimula.</p>
                </asp:Panel>

                <asp:Repeater ID="rptServiceListings" runat="server"
                    OnItemDataBound="RptServiceListings_ItemDataBound"
                    OnItemCommand="RptServiceListings_ItemCommand">
                    <ItemTemplate>
                        <div class="app-card" data-service-id='<%# Eval("ServiceId") %>'>
                            <div class="app-card-top">
                                <div>
                                    <h4><%# Eval("ServiceTitle") %></h4>
                                    <p class="app-location">
                                        <i class='bx bx-map'></i> Brgy. <%# Eval("Barangay") %>, Biñan
                                    </p>
                                </div>
                                <span class="app-status <%# Eval("Status").ToString().ToLower() %>">
                                    <%# Eval("Status") %>
                                </span>
                            </div>
                            <div class="app-meta">
                                <span class="app-pay"><%# GetPayLabel(Eval("RateMin"), Eval("RateMax"), Eval("RateType")) %></span>
                                <span><%# Eval("PostedAt", "{0:MMM dd, yyyy}") %></span>
                            </div>
                            <p class="app-tags"><%# FormatTags(Eval("Tags")) %></p>
                            <div class="app-actions">
                                <asp:LinkButton ID="btnDeleteServiceListing" runat="server"
                                    CssClass="btn-outline app-retract"
                                    CommandName="DeleteServiceListing"
                                    CommandArgument='<%# Eval("ServiceId") %>'>
                                    I-delete
                                </asp:LinkButton>
                            </div>

                            <asp:HiddenField ID="hfListingServiceId" runat="server" Value='<%# Eval("ServiceId") %>' />

                            <div class="applicants-block">
                                <h5>Mga Requests</h5>
                                <asp:Panel ID="pnlNoServiceApplicants" runat="server" CssClass="empty-state" Visible="false">
                                    <p>Wala pang requests.</p>
                                </asp:Panel>
                                <asp:Repeater ID="rptServiceApplicants" runat="server" OnItemCommand="RptServiceApplicants_ItemCommand">
                                    <ItemTemplate>
                                        <div class="applicant-row" data-request-id='<%# Eval("RequestId") %>'>
                                            <div>
                                                <strong><%# Eval("FullName") %></strong>
                                                <div class="applicant-meta">
                                                    <%# Eval("Phone") %>
                                                    <%# !string.IsNullOrEmpty(Eval("Email").ToString()) ? " &bull; " + Eval("Email") : "" %>
                                                </div>
                                                <div class="applicant-meta"><%# Eval("RequestedAt", "{0:MMM dd, yyyy}") %></div>
                                            </div>
                                            <div class="applicant-actions">
                                                <span class="app-status <%# Eval("Status").ToString().ToLower() %>">
                                                    <%# Eval("Status") %>
                                                </span>
                                                <asp:LinkButton ID="btnApproveService" runat="server"
                                                    CssClass="btn-green app-retract"
                                                    CommandName="ApproveService"
                                                    CommandArgument='<%# Eval("RequestId") %>'
                                                    Visible='<%# Eval("Status").ToString() == "Pending" %>'>
                                                    Approve
                                                </asp:LinkButton>
                                                <asp:LinkButton ID="btnRejectService" runat="server"
                                                    CssClass="btn-outline app-retract"
                                                    CommandName="RejectService"
                                                    CommandArgument='<%# Eval("RequestId") %>'
                                                    Visible='<%# Eval("Status").ToString() == "Pending" %>'>
                                                    Reject
                                                </asp:LinkButton>
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>

        
            <%-- TAB 5: My Business Listings --%>
            <div class="profile-tab-content" id="tab-businesslistings">
                <asp:Panel ID="pnlNoBusinessListings" runat="server" CssClass="empty-state" Visible="false">
                    <i class='bx bx-store'></i>
                    <h4>Wala ka pang negosyo listings</h4>
                    <p><a href="/Pages/PostNegosyo.aspx">Mag-rehistro ng negosyo</a> para magsimula.</p>
                </asp:Panel>

                <asp:Repeater ID="rptBusinessListings" runat="server" OnItemCommand="RptBusinessListings_ItemCommand">
                    <ItemTemplate>
                        <div class="app-card">
                            <div class="app-card-top">
                                <div>
                                    <h4><%# Eval("BusinessName") %></h4>
                                    <p class="app-location">
                                        <i class='bx bx-map'></i> <%# GetBusinessLocation(Eval("AddressLine"), Eval("Barangay")) %>
                                    </p>
                                </div>
                                <span class="app-status <%# Eval("Status").ToString().ToLower() %>">
                                    <%# Eval("Status") %>
                                </span>
                            </div>
                            <div class="app-meta">
                                <span class="app-pay"><%# Eval("Category") %></span>
                                <span><%# Eval("CreatedAt", "{0:MMM dd, yyyy}") %></span>
                            </div>
                            <p class="app-tags"><%# FormatTags(Eval("Tags")) %></p>
                            <p style="font-size:0.82rem; color:var(--text-soft); margin-top:6px;">
                                <i class='bx bx-phone'></i> <%# GetBusinessContact(Eval("ContactNumber")) %>
                            </p>
                            <div class="app-actions">
                                <asp:LinkButton ID="btnDeleteBusinessListing" runat="server"
                                    CssClass="btn-outline app-retract"
                                    CommandName="DeleteBusinessListing"
                                    CommandArgument='<%# Eval("DirectoryId") %>'>
                                    I-delete
                                </asp:LinkButton>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
</div><%-- end profile-tabs --%>
    </div>

    <script>
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

