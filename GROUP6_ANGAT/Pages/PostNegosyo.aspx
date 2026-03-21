<%@ Page Title="I-rehistro ang Negosyo" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PostNegosyo.aspx.cs" Inherits="GROUP6_ANGAT.PostNegosyo" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div id="page-hero">
        <div class="hero-circles">
            <div class="c1"></div>
            <div class="c2"></div>
        </div>
        <div class="page-hero-inner">
            <span class="hero-badge"><i class='bx bx-store'></i> Negosyo Registration</span>
            <h2>I-rehistro ang <strong>Negosyo</strong></h2>
            <p class="hero-desc">
                I-post ang inyong tindahan para makita ng mga kababayan at madali kang mahanap.
            </p>
        </div>
        <div class="wave">
            <svg viewBox="0 0 1440 80" xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="none">
                <path d="M0,80 L1440,80 L1440,80 L0,80 Z" fill="#ffffff"/>
            </svg>
        </div>
    </div>

    <div class="section section-white">
        <div class="section-header">
            <h3>Negosyo <span>Details</span></h3>
            <p class="section-sub">Punan ang impormasyon para maipakita ang inyong negosyo sa directory.</p>
        </div>

        <asp:Panel ID="pnlPostMessage" runat="server" CssClass="form-alert" Visible="false">
            <asp:Label ID="lblPostMessage" runat="server" />
        </asp:Panel>

        <div style="max-width: 900px; margin: 0 auto;">
            <div class="form-group">
                <label>Pangalan ng Negosyo</label>
                <asp:TextBox ID="txtBusinessName" runat="server" placeholder="Hal. Aling Nena's Sari-Sari Store"></asp:TextBox>
            </div>

            <div class="form-group">
                <label>Kategorya</label>
                <asp:DropDownList ID="ddlCategory" runat="server">
                    <asp:ListItem Value="Sari-Sari Store">Sari-Sari Store</asp:ListItem>
                    <asp:ListItem Value="Carinderia">Carinderia / Food</asp:ListItem>
                    <asp:ListItem Value="Ukay-Ukay">Ukay-Ukay / Damit</asp:ListItem>
                    <asp:ListItem Value="Agrivet">Palengke / Agrivet</asp:ListItem>
                    <asp:ListItem Value="Iba">Iba pa</asp:ListItem>
                </asp:DropDownList>
            </div>

            <div class="form-group">
                <label>Barangay</label>
                <asp:TextBox ID="txtBarangay" runat="server" placeholder="Hal. Dela Paz"></asp:TextBox>
            </div>

            <div class="form-group">
                <label>Address / Lokasyon</label>
                <asp:TextBox ID="txtAddressLine" runat="server" placeholder="Hal. Brgy. Dela Paz, Biñan"></asp:TextBox>
            </div>

            <div class="form-group">
                <label>Owner / Contact Name <span class="optional">(optional)</span></label>
                <asp:TextBox ID="txtOwnerName" runat="server" placeholder="Hal. Juan Dela Cruz"></asp:TextBox>
                <small class="field-hint">Kung walang ilalagay, gagamitin ang pangalan ng naka-login.</small>
            </div>

            <div class="form-group">
                <label>Contact Number <span class="optional">(optional)</span></label>
                <asp:TextBox ID="txtContactNumber" runat="server" placeholder="09XXXXXXXXX"></asp:TextBox>
            </div>

            <div class="form-group">
                <label>Oras ng Operasyon</label>
                <asp:TextBox ID="txtHours" runat="server" placeholder="Hal. 6AM - 10PM"></asp:TextBox>
            </div>

            <div class="form-group">
                <label>Google Maps Embed Link <span class="optional">(optional)</span></label>
                <asp:TextBox ID="txtMapEmbedUrl" runat="server" placeholder="I-paste ang Google Maps embed link"></asp:TextBox>
                <small class="field-hint">Kung may iframe embed code, ilagay lang ang src link.</small>
            </div>

            <div class="form-group">
                <label>Tags (gamitin ang | para maghiwalay)</label>
                <asp:TextBox ID="txtTags" runat="server" placeholder="Gcash Accepted|Takeout"></asp:TextBox>
            </div>

            <div class="form-group">
                <label>Status</label>
                <asp:DropDownList ID="ddlStatus" runat="server">
                    <asp:ListItem Value="Bukas Ngayon">Bukas Ngayon</asp:ListItem>
                    <asp:ListItem Value="Sarado">Sarado</asp:ListItem>
                </asp:DropDownList>
            </div>

            <asp:Button ID="btnPostNegosyo" runat="server" Text="I-rehistro ang Negosyo" CssClass="btn-green" OnClick="BtnPostNegosyo_Click" />
        </div>
    </div>
</asp:Content>
