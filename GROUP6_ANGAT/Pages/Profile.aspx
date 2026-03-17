<%@ Page Title="Profile" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="GROUP6_ANGAT.Profile" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div id="page-hero">
        <div class="hero-circles">
            <div class="c1"></div>
            <div class="c2"></div>
        </div>
        <div class="page-hero-inner">
            <span class="hero-badge"><i class='bx bx-user'></i> My Account</span>
            <h2>Profile ng <strong>ANGAT</strong></h2>
            <p class="hero-desc">
                Tingnan ang inyong impormasyon at status ng account.
            </p>
        </div>
        <div class="wave">
            <svg viewBox="0 0 1440 80" xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="none">
                <path d="M0,80 L1440,80 L1440,80 L0,80 Z" fill="#ffffff"/>
            </svg>
        </div>
    </div>

    <div class="section section-white">
        <div class="profile-grid">
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

                <asp:Button ID="btnUploadPhoto" runat="server" Text="I-save ang Photo" CssClass="btn-outline" OnClick="BtnSaveProfile_Click" />
                <asp:Label ID="lblProfileMessage" runat="server" CssClass="login-helper" />
            </div>

            <div class="profile-card">
                <h3>I-edit ang Profile</h3>
                <p class="section-sub" style="text-align:left; margin: 0 0 18px;">Ayusin ang inyong impormasyon para mas maayos ang matching.</p>

                <div class="form-group">
                    <label>Buong Pangalan</label>
                    <asp:TextBox ID="txtFullName" runat="server"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label>Email Address</label>
                    <asp:TextBox ID="txtEmail" runat="server" TextMode="Email"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label>Phone Number</label>
                    <asp:TextBox ID="txtPhone" runat="server" placeholder="09xx-xxx-xxxx"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label>Address</label>
                    <asp:TextBox ID="txtAddress" runat="server" placeholder="Street / Barangay"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label>Barangay</label>
                    <asp:TextBox ID="txtBarangay" runat="server" placeholder="Brgy. Canlalay"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label>Bio</label>
                    <asp:TextBox ID="txtBio" runat="server" TextMode="MultiLine" placeholder="Maikling paglalarawan tungkol sa inyong kasanayan."></asp:TextBox>
                </div>

                <asp:Button ID="btnSaveProfile" runat="server" Text="I-save ang Profile" CssClass="btn-green" OnClick="BtnSaveProfile_Click" />
            </div>
        </div>

        <div class="profile-grid" style="margin-top: 28px;">
            <div class="profile-card">
                <h3>Palitan ang Password</h3>
                <p class="section-sub" style="text-align:left; margin: 0 0 18px;">Para sa seguridad, palitan ang password kapag kinakailangan.</p>

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

                <asp:Button ID="btnChangePassword" runat="server" Text="Palitan ang Password" CssClass="btn-outline" OnClick="BtnChangePassword_Click" />
                <asp:Label ID="lblPasswordMessage" runat="server" CssClass="login-helper" />
            </div>
        </div>

        <div class="profile-applications">
            <h3>My Applications</h3>
            <p class="section-sub" style="text-align:left; margin: 0 0 18px;">Mga trabahong na-apply-an mo at kanilang status.</p>

            <asp:Panel ID="pnlApplicationsMessage" runat="server" CssClass="form-alert" Visible="false">
                <asp:Label ID="lblApplicationsMessage" runat="server" />
            </asp:Panel>

            <asp:Panel ID="pnlNoApplications" runat="server" CssClass="form-alert" Visible="false">
                Wala ka pang applications sa ngayon.
            </asp:Panel>

            <asp:Repeater ID="rptApplications" runat="server" OnItemCommand="RptApplications_ItemCommand">
                <ItemTemplate>
                    <div class="app-card">
                        <div class="app-card-top">
                            <div>
                                <h4><%# Eval("JobTitle") %></h4>
                                <p class="app-location"><%# Eval("JobLocation") %></p>
                            </div>
                            <span class="app-status <%# Eval("Status").ToString().ToLower() %>"><%# Eval("Status") %></span>
                        </div>
                        <div class="app-meta">
                            <span class="app-pay"><%# Eval("JobPay") %></span>
                            <span class="app-date"><%# Eval("AppliedAt", "{0:MMM dd, yyyy}") %></span>
                        </div>
                        <p class="app-tags"><%# FormatTags(Eval("JobTags")) %></p>
                        <div class="app-actions">
                            <asp:LinkButton ID="btnRetract" runat="server" CssClass="btn-outline app-retract"
                                CommandName="Retract" CommandArgument='<%# Eval("ApplicationId") %>'
                                Visible='<%# Eval("Status").ToString() == "Pending" %>'>
                                I-retract
                            </asp:LinkButton>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>

        <div class="profile-applications">
            <h3>My Service Requests</h3>
            <p class="section-sub" style="text-align:left; margin: 0 0 18px;">Mga serbisyong na-request mo at kanilang status.</p>

            <asp:Panel ID="pnlServiceMessage" runat="server" CssClass="form-alert" Visible="false">
                <asp:Label ID="lblServiceMessage" runat="server" />
            </asp:Panel>

            <asp:Panel ID="pnlNoServiceRequests" runat="server" CssClass="form-alert" Visible="false">
                Wala ka pang service requests sa ngayon.
            </asp:Panel>

            <asp:Repeater ID="rptServiceRequests" runat="server" OnItemCommand="RptServiceRequests_ItemCommand">
                <ItemTemplate>
                    <div class="app-card">
                        <div class="app-card-top">
                            <div>
                                <h4><%# Eval("ServiceTitle") %></h4>
                                <p class="app-location"><%# Eval("ServiceLocation") %></p>
                            </div>
                            <span class="app-status <%# Eval("Status").ToString().ToLower() %>"><%# Eval("Status") %></span>
                        </div>
                        <div class="app-meta">
                            <span class="app-pay"><%# Eval("ServiceRate") %></span>
                            <span class="app-date"><%# Eval("RequestedAt", "{0:MMM dd, yyyy}") %></span>
                        </div>
                        <p class="app-tags"><%# FormatTags(Eval("ServiceTags")) %></p>
                        <div class="app-actions">
                            <asp:LinkButton ID="btnRetractService" runat="server" CssClass="btn-outline app-retract"
                                CommandName="RetractService" CommandArgument='<%# Eval("RequestId") %>'
                                Visible='<%# Eval("Status").ToString() == "Pending" %>'>
                                I-retract
                            </asp:LinkButton>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>

        <div class="profile-applications">
            <h3>My Listings</h3>
            <p class="section-sub" style="text-align:left; margin: 0 0 18px;">Mga trabahong ikaw ang nag-post at ang kanilang applicants.</p>

            <asp:Panel ID="pnlNoListings" runat="server" CssClass="form-alert" Visible="false">
                Wala ka pang job listings.
            </asp:Panel>

            <asp:Repeater ID="rptMyListings" runat="server" OnItemDataBound="RptMyListings_ItemDataBound" OnItemCommand="RptMyListings_ItemCommand">
                <ItemTemplate>
                    <div class="app-card">
                        <div class="app-card-top">
                            <div>
                                <h4><%# Eval("JobTitle") %></h4>
                                <p class="app-location"><%# Eval("JobLocation") %></p>
                            </div>
                            <span class="app-status <%# Eval("Status").ToString().ToLower() %>"><%# Eval("Status") %></span>
                        </div>
                        <div class="app-meta">
                            <span class="app-pay"><%# Eval("JobPay") %></span>
                            <span class="app-date"><%# Eval("PostedAt", "{0:MMM dd, yyyy}") %></span>
                        </div>
                        <p class="app-tags"><%# FormatTags(Eval("JobTags")) %></p>
                        <div class="app-actions">
                            <asp:LinkButton ID="btnDeleteListing" runat="server" CssClass="btn-outline app-retract"
                                CommandName="DeleteListing" CommandArgument='<%# Eval("JobId") %>'>
                                Delete Listing
                            </asp:LinkButton>
                        </div>

                        <asp:HiddenField ID="hfListingJobId" runat="server" Value='<%# Eval("JobId") %>' />

                        <div class="applicants-block">
                            <h5>Applicants</h5>
                            <asp:Panel ID="pnlNoApplicants" runat="server" CssClass="form-alert" Visible="false">
                                Wala pang applicants.
                            </asp:Panel>

                            <asp:Repeater ID="rptApplicants" runat="server" OnItemCommand="RptApplicants_ItemCommand">
                                <ItemTemplate>
                                    <div class="applicant-row">
                                        <div>
                                            <strong><%# Eval("FullName") %></strong>
                                            <div class="applicant-meta"><%# Eval("Email") %> &bull; <%# Eval("Phone") %></div>
                                            <div class="applicant-meta"><%# Eval("AppliedAt", "{0:MMM dd, yyyy}") %></div>
                                        </div>
                                        <div class="applicant-actions">
                                            <span class="app-status <%# Eval("Status").ToString().ToLower() %>"><%# Eval("Status") %></span>
                                            <asp:LinkButton ID="btnApprove" runat="server" CssClass="btn-outline app-retract"
                                                CommandName="Approve" CommandArgument='<%# Eval("ApplicationId") %>'
                                                Visible='<%# Eval("Status").ToString() == "Pending" %>'>
                                                Approve
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="btnReject" runat="server" CssClass="btn-outline app-retract"
                                                CommandName="Reject" CommandArgument='<%# Eval("ApplicationId") %>'
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

        <div class="profile-applications">
            <h3>My Service Listings</h3>
            <p class="section-sub" style="text-align:left; margin: 0 0 18px;">Mga serbisyong ikaw ang nag-post at ang kanilang requests.</p>

            <asp:Panel ID="pnlNoServiceListings" runat="server" CssClass="form-alert" Visible="false">
                Wala ka pang service listings.
            </asp:Panel>

            <asp:Repeater ID="rptServiceListings" runat="server" OnItemDataBound="RptServiceListings_ItemDataBound" OnItemCommand="RptServiceListings_ItemCommand">
                <ItemTemplate>
                    <div class="app-card">
                        <div class="app-card-top">
                            <div>
                                <h4><%# Eval("ServiceTitle") %></h4>
                                <p class="app-location"><%# Eval("ServiceLocation") %></p>
                            </div>
                            <span class="app-status <%# Eval("Status").ToString().ToLower() %>"><%# Eval("Status") %></span>
                        </div>
                        <div class="app-meta">
                            <span class="app-pay"><%# Eval("ServiceRate") %></span>
                            <span class="app-date"><%# Eval("PostedAt", "{0:MMM dd, yyyy}") %></span>
                        </div>
                        <p class="app-tags"><%# FormatTags(Eval("ServiceTags")) %></p>
                        <div class="app-actions">
                            <asp:LinkButton ID="btnDeleteServiceListing" runat="server" CssClass="btn-outline app-retract"
                                CommandName="DeleteServiceListing" CommandArgument='<%# Eval("ServiceId") %>'>
                                Delete Listing
                            </asp:LinkButton>
                        </div>

                        <asp:HiddenField ID="hfListingServiceId" runat="server" Value='<%# Eval("ServiceId") %>' />

                        <div class="applicants-block">
                            <h5>Requests</h5>
                            <asp:Panel ID="pnlNoServiceApplicants" runat="server" CssClass="form-alert" Visible="false">
                                Wala pang requests.
                            </asp:Panel>

                            <asp:Repeater ID="rptServiceApplicants" runat="server" OnItemCommand="RptServiceApplicants_ItemCommand">
                                <ItemTemplate>
                                    <div class="applicant-row">
                                        <div>
                                            <strong><%# Eval("FullName") %></strong>
                                            <div class="applicant-meta"><%# Eval("Email") %> &bull; <%# Eval("Phone") %></div>
                                            <div class="applicant-meta"><%# Eval("RequestedAt", "{0:MMM dd, yyyy}") %></div>
                                        </div>
                                        <div class="applicant-actions">
                                            <span class="app-status <%# Eval("Status").ToString().ToLower() %>"><%# Eval("Status") %></span>
                                            <asp:LinkButton ID="btnApproveService" runat="server" CssClass="btn-outline app-retract"
                                                CommandName="ApproveService" CommandArgument='<%# Eval("RequestId") %>'
                                                Visible='<%# Eval("Status").ToString() == "Pending" %>'>
                                                Approve
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="btnRejectService" runat="server" CssClass="btn-outline app-retract"
                                                CommandName="RejectService" CommandArgument='<%# Eval("RequestId") %>'
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
    </div>
</asp:Content>
