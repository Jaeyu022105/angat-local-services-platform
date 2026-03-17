<%@ Page Title="Contact Us" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="GROUP6_ANGAT.Contact" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    
    <div id="page-hero">
        <div class="hero-circles">
            <div class="c1"></div>
            <div class="c2"></div>
        </div>
        <div class="page-hero-inner">
            <span class="hero-badge"><i class='bx bxs-envelope'></i> Makipag-ugnayan</span>
            <h2>Contact <strong>ANGAT</strong></h2>
            <p class="hero-desc">
                May katanungan, mungkahi, o nais makipag-partner sa aming plataporma? Narito ang IT114L Group 6 upang tumulong sa ating komunidad.
            </p>
        </div>
        <div class="wave">
            <svg viewBox="0 0 1440 80" xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="none">
                <path d="M0,80 L1440,80 L1440,80 L0,80 Z" fill="#ffffff"/>
            </svg>
        </div>
    </div>

    <div class="page-quick">
        <div class="quick-card">
            <div class="quick-icon"><i class='bx bx-envelope'></i></div>
            <div>
                <h5>Direct Message</h5>
                <p>Makipag-ugnayan sa aming team agad.</p>
            </div>
        </div>
        <div class="quick-card">
            <div class="quick-icon"><i class='bx bx-phone'></i></div>
            <div>
                <h5>Hotline Support</h5>
                <p>Available para sa mga tanong sa serbisyo.</p>
            </div>
        </div>
        <div class="quick-card">
            <div class="quick-icon"><i class='bx bx-map'></i></div>
            <div>
                <h5>PESO Office</h5>
                <p>Biñan City Hall, Laguna.</p>
            </div>
        </div>
    </div>

    <div class="section section-white">
        <div class="section-header">
            <h3>Ipadala ang Iyong <span>Mensahe</span></h3>
            <p class="section-sub">Maaari kayong magpadala ng direktang mensahe sa aming team gamit ang form sa ibaba.</p>
        </div>

        <asp:Panel ID="pnlContactMessage" runat="server" CssClass="form-alert" Visible="false">
            <asp:Label ID="lblContactMessage" runat="server" />
        </asp:Panel>
        
        <div style="display: flex; flex-wrap: wrap; gap: 40px; max-width: 1000px; margin: 0 auto;">
            
            <div style="flex: 1; min-width: 300px;">
                <div style="margin-bottom: 24px; display: flex; gap: 16px; align-items: center;">
                    <div style="width: 50px; height: 50px; background: #e6f7f1; color: #0d9e6e; border-radius: 50%; display: flex; justify-content: center; align-items: center; font-size: 1.5rem;">
                        <i class='bx bx-map'></i>
                    </div>
                    <div>
                        <h5 style="color: #0f172a; margin-bottom: 4px;">Lokasyon</h5>
                        <p style="color: #475569; font-size: 0.9rem;">Biñan City Hall, Laguna</p>
                    </div>
                </div>
                <div style="margin-bottom: 24px; display: flex; gap: 16px; align-items: center;">
                    <div style="width: 50px; height: 50px; background: #e6f7f1; color: #0d9e6e; border-radius: 50%; display: flex; justify-content: center; align-items: center; font-size: 1.5rem;">
                        <i class='bx bx-envelope'></i>
                    </div>
                    <div>
                        <h5 style="color: #0f172a; margin-bottom: 4px;">Email</h5>
                        <p style="color: #475569; font-size: 0.9rem;">angat.group6@example.com</p>
                    </div>
                </div>
                <div style="margin-bottom: 24px; display: flex; gap: 16px; align-items: center;">
                    <div style="width: 50px; height: 50px; background: #e6f7f1; color: #0d9e6e; border-radius: 50%; display: flex; justify-content: center; align-items: center; font-size: 1.5rem;">
                        <i class='bx bx-phone'></i>
                    </div>
                    <div>
                        <h5 style="color: #0f172a; margin-bottom: 4px;">Telepono</h5>
                        <p style="color: #475569; font-size: 0.9rem;">(049) 123-4567</p>
                    </div>
                </div>
            </div>

            <div style="flex: 2; min-width: 300px; background: #f8fffe; padding: 30px; border-radius: 16px; border: 1px solid #e2e8f0;">
                <div class="form-group">
                    <label>Pangalan</label>
                    <asp:TextBox ID="txtName" runat="server" placeholder="Juan Dela Cruz"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label>Email Address</label>
                    <asp:TextBox ID="txtEmail" runat="server" placeholder="juan@example.com"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label>Mensahe</label>
                    <asp:TextBox ID="txtMessage" runat="server" TextMode="MultiLine" placeholder="Paano kami makakatulong?"></asp:TextBox>
                </div>
                <asp:Button ID="btnSubmit" runat="server" Text="Ipadala ang Mensahe" CssClass="btn-primary" OnClick="btnSubmit_Click" style="width: 100%; border: none; padding: 14px; font-size: 1rem;" />
            </div>

        </div> </div>

    <div class="section section-light">
        <div class="section-header">
            <h3>Ang Aming <span>Grupo</span></h3>
            <p class="section-sub">Kilalanin ang mga estudyante ng IT114L Group 6 na nasa likod ng ANGAT.</p>
        </div>
        
        <div class="team-grid">
            <div class="team-card">
                <img src="../Images/image1.jpg" alt="Team Member 1" class="team-img" onerror="this.src='https://ui-avatars.com/api/?name=Member+1&background=0d9e6e&color=fff&size=150'" />
                <h5 style="color: #0f172a; font-size: 1.1rem; margin-bottom: 5px;">Member 1</h5>
                <p style="color: #0d9e6e; font-size: 0.85rem; font-weight: 700; margin-bottom: 10px;">Project Manager</p>
                <p style="color: #475569; font-size: 0.85rem;">Nangunguna sa pagpaplano at pagbuo ng ANGAT system.</p>
            </div>
            
            <div class="team-card">
                <img src="../Images/image2.jpg" alt="Team Member 2" class="team-img" onerror="this.src='https://ui-avatars.com/api/?name=Member+2&background=0d9e6e&color=fff&size=150'" />
                <h5 style="color: #0f172a; font-size: 1.1rem; margin-bottom: 5px;">Member 2</h5>
                <p style="color: #0d9e6e; font-size: 0.85rem; font-weight: 700; margin-bottom: 10px;">Lead Developer</p>
                <p style="color: #475569; font-size: 0.85rem;">Nakapokus sa backend logic at database management.</p>
            </div>

            <div class="team-card">
                <img src="../Images/image3.jpg" alt="Team Member 3" class="team-img" onerror="this.src='https://ui-avatars.com/api/?name=Member+3&background=0d9e6e&color=fff&size=150'" />
                <h5 style="color: #0f172a; font-size: 1.1rem; margin-bottom: 5px;">Member 3</h5>
                <p style="color: #0d9e6e; font-size: 0.85rem; font-weight: 700; margin-bottom: 10px;">Frontend Designer</p>
                <p style="color: #475569; font-size: 0.85rem;">Nag-disenyo ng user interface at site layout gamit ang CSS.</p>
            </div>

            <div class="team-card">
                <img src="../Images/image4.jpg" alt="Team Member 4" class="team-img" onerror="this.src='https://ui-avatars.com/api/?name=Member+4&background=0d9e6e&color=fff&size=150'" />
                <h5 style="color: #0f172a; font-size: 1.1rem; margin-bottom: 5px;">Member 4</h5>
                <p style="color: #0d9e6e; font-size: 0.85rem; font-weight: 700; margin-bottom: 10px;">QA Tester</p>
                <p style="color: #475569; font-size: 0.85rem;">Sinusuri ang system para sa mga bugs at errors.</p>
            </div>

            <div class="team-card">
                <img src="../Images/image5.jpg" alt="Team Member 5" class="team-img" onerror="this.src='https://ui-avatars.com/api/?name=Member+5&background=0d9e6e&color=fff&size=150'" />
                <h5 style="color: #0f172a; font-size: 1.1rem; margin-bottom: 5px;">Member 5</h5>
                <p style="color: #0d9e6e; font-size: 0.85rem; font-weight: 700; margin-bottom: 10px;">System Analyst</p>
                <p style="color: #475569; font-size: 0.85rem;">Gumagawa ng documentation at system requirements.</p>
            </div>
        </div>
    </div>
</asp:Content> 
