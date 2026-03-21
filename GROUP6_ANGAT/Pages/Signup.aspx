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
                    <label>Buong Pangalan <span class="required">*</span></label>
                    <asp:TextBox ID="txtFullName" runat="server" placeholder="Juan Dela Cruz"></asp:TextBox>
                </div>

                <div class="form-group">
                    <label>Mobile Number <span class="required">*</span></label>
                    <asp:TextBox ID="txtPhone" runat="server" placeholder="09123456789"></asp:TextBox>
                    <small class="field-hint">Format: 09123456789" o +639123456789"</small>
                </div>

                <div class="form-group">
                    <label>Email Address <span class="optional">(optional)</span></label>
                    <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" placeholder="juan@email.com"></asp:TextBox>
                </div>

                <div class="form-group">
                    <label>Barangay <span class="required">*</span></label>
                    <asp:DropDownList ID="ddlBarangay" runat="server">
                        <asp:ListItem Value="">-- Piliin ang Barangay --</asp:ListItem>
                        <asp:ListItem Value="Biñan">Biñan (Poblacion)</asp:ListItem>
                        <asp:ListItem Value="Bungahan">Bungahan</asp:ListItem>
                        <asp:ListItem Value="Canlalay">Canlalay</asp:ListItem>
                        <asp:ListItem Value="Casile">Casile</asp:ListItem>
                        <asp:ListItem Value="De La Paz">De La Paz</asp:ListItem>
                        <asp:ListItem Value="Ganado">Ganado</asp:ListItem>
                        <asp:ListItem Value="Irregular Sinaplit">Irregular Sinaplit</asp:ListItem>
                        <asp:ListItem Value="Langkiwa">Langkiwa</asp:ListItem>
                        <asp:ListItem Value="Loma">Loma</asp:ListItem>
                        <asp:ListItem Value="Malaban">Malaban</asp:ListItem>
                        <asp:ListItem Value="Malamig">Malamig</asp:ListItem>
                        <asp:ListItem Value="Mampalasan">Mampalasan</asp:ListItem>
                        <asp:ListItem Value="Mapagong">Mapagong</asp:ListItem>
                        <asp:ListItem Value="Masile">Masile</asp:ListItem>
                        <asp:ListItem Value="Maysilo">Maysilo</asp:ListItem>
                        <asp:ListItem Value="Munting Ilog">Munting Ilog</asp:ListItem>
                        <asp:ListItem Value="New Biñan">New Biñan</asp:ListItem>
                        <asp:ListItem Value="New Market">New Market</asp:ListItem>
                        <asp:ListItem Value="Platero">Platero</asp:ListItem>
                        <asp:ListItem Value="Poblacion">Poblacion</asp:ListItem>
                        <asp:ListItem Value="San Antonio">San Antonio</asp:ListItem>
                        <asp:ListItem Value="San Francisco">San Francisco</asp:ListItem>
                        <asp:ListItem Value="San Jose">San Jose</asp:ListItem>
                        <asp:ListItem Value="San Vicente">San Vicente</asp:ListItem>
                        <asp:ListItem Value="Santa Rosa">Santa Rosa</asp:ListItem>
                        <asp:ListItem Value="Santo Domingo">Santo Domingo</asp:ListItem>
                        <asp:ListItem Value="Santo Tomas">Santo Tomas</asp:ListItem>
                        <asp:ListItem Value="Soro-soro Ibaba">Soro-soro Ibaba</asp:ListItem>
                        <asp:ListItem Value="Soro-soro Ilaya">Soro-soro Ilaya</asp:ListItem>
                        <asp:ListItem Value="Soro-soro Kaylat">Soro-soro Kaylat</asp:ListItem>
                        <asp:ListItem Value="Timbao">Timbao</asp:ListItem>
                        <asp:ListItem Value="Tubigan">Tubigan</asp:ListItem>
                        <asp:ListItem Value="Zapote">Zapote</asp:ListItem>
                    </asp:DropDownList>
                </div>

                <div class="form-group">
                    <label>Address <span class="required">*</span></label>
                    <asp:TextBox ID="txtAddress" runat="server" placeholder="House No., Street, Subdivision"></asp:TextBox>
                    <small class="field-hint">Hindi ito ipapakita sa publiko. Para lamang sa pagpapadala ng impormasyon sa employer.</small>
                </div>

                <div class="form-group">
                    <label>Password <span class="required">*</span></label>
                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" placeholder="Password"></asp:TextBox>
                </div>

                <div class="form-group">
                    <label>Confirm Password <span class="required">*</span></label>
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
