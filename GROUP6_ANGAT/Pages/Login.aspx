<%@ Page Title="Login" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="GROUP6_ANGAT.Login" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div id="page-hero">
        <div class="hero-circles">
            <div class="c1"></div>
            <div class="c2"></div>
        </div>
        <div class="page-hero-inner">
            <h2>Mag-login sa <strong>ANGAT</strong></h2>
            <p class="hero-desc">
                Mabilis at ligtas na pag-access para sa mga naghahanap ng trabaho,
                serbisyo, at lokal na oportunidad.
            </p>
        </div>
        <div class="wave">
            <svg viewBox="0 0 1440 80" xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="none">
                <path d="M0,80 L1440,80 L1440,80 L0,80 Z" fill="#ffffff"/>
            </svg>
        </div>
    </div>

    <div class="login-wrap">
        <div class="login-grid">
            <div class="login-card">
                <h3>Welcome back</h3>
                <p>Ilagay ang inyong email at password para makapasok.</p>

                <div class="form-group">
                    <label>Mobile Number o Email</label>
                    <asp:TextBox ID="txtLoginIdentifier" runat="server" placeholder="09XXXXXXXXX o email@email.com"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label for="login-password">Password</label>
                    <asp:TextBox ID="txtLoginPassword" runat="server" TextMode="Password" placeholder="Password"></asp:TextBox>
                </div>
                <div class="login-actions">
                    <asp:Button ID="btnLogin" runat="server" Text="Mag-login" CssClass="btn-green" OnClick="BtnLogin_Click" />
                </div>
                <asp:Label ID="lblLoginMessage" runat="server" CssClass="login-helper" />
                <p class="login-helper">
                    Wala pang account?
                    <a href="~/Pages/Signup.aspx" runat="server">Mag-sign up</a>
                </p>
            </div>

            <div class="login-spotlight">
                <span class="spotlight-badge"><i class='bx bx-shield-quarter'></i> ANGAT Access</span>
                <h4>Kasama ka sa Komunidad</h4>
                <p>
                    Ang login ay nagbibigay ng mabilis na access sa inyong mga saved listings,
                    updates, at mga libreng training schedule mula sa LGU.
                </p>
                <ul>
                    <li><i class='bx bx-check-circle'></i> Personalized na trabaho at serbisyo</li>
                    <li><i class='bx bx-check-circle'></i> Updates sa TESDA at DTI programs</li>
                    <li><i class='bx bx-check-circle'></i> Direktang abiso mula sa PESO Office</li>
                </ul>
            </div>
        </div>
    </div>
</asp:Content>