<%@ Page Title="Sign Up" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Signup.aspx.cs" Inherits="GROUP6_ANGAT.Signup" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div id="page-hero">
        <div class="hero-circles">
            <div class="c1"></div>
            <div class="c2"></div>
        </div>
        <div class="page-hero-inner">
            <span class="hero-badge"><i class='bx bx-user-plus'></i> Create Account</span>
            <h2>Mag-sign up sa <strong>ANGAT</strong></h2>
            <p class="hero-desc">
                Simulan ang inyong account para makatanggap ng updates at personalized na listings.
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
                <h3>Gumawa ng Account</h3>
                <p>Ilagay ang inyong detalye para makapagparehistro.</p>

                <div class="form-group">
                    <label for="signup-name">Buong Pangalan</label>
                    <asp:TextBox ID="txtFullName" runat="server" placeholder="Juan Dela Cruz"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label for="signup-email">Email Address</label>
                    <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" placeholder="juan@email.com"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label for="signup-password">Password</label>
                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" placeholder="Password"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label for="signup-confirm">Confirm Password</label>
                    <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" placeholder="Password"></asp:TextBox>
                </div>
                <div class="login-actions">
                    <asp:Button ID="btnSignup" runat="server" Text="Mag-sign up" CssClass="btn-green" OnClick="btnSignup_Click" />
                    <a href="~/Pages/Login.aspx" runat="server" class="btn-outline">May account na</a>
                </div>
                <asp:Label ID="lblSignupMessage" runat="server" CssClass="login-helper" />
            </div>

            <div class="login-spotlight">
                <span class="spotlight-badge"><i class='bx bx-badge-check'></i> Free Registration</span>
                <h4>Mas marami, mas mabilis</h4>
                <p>
                    Kapag rehistrado, mas mabilis kang makakahanap ng trabaho o serbisyo
                    at makakatanggap ng official updates mula sa PESO Office.
                </p>
                <ul>
                    <li><i class='bx bx-check-circle'></i> I-save ang inyong listings</li>
                    <li><i class='bx bx-check-circle'></i> Mabilis na notifications</li>
                    <li><i class='bx bx-check-circle'></i> Updates sa training programs</li>
                </ul>
            </div>
        </div>
    </div>
</asp:Content>
