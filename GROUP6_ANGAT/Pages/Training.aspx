<%@ Page Title="Training Calendar" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Training.aspx.cs" Inherits="GROUP6_ANGAT.Pages.Training" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    
    <div id="page-hero">
        <div class="hero-circles">
            <div class="c1"></div>
            <div class="c2"></div>
        </div>
        <div class="page-hero-inner">
            <span class="hero-badge"><i class='bx bx-book-reader'></i> Skills Training</span>
            <h2>Libreng <strong>Training</strong></h2>
            <p class="hero-desc">
                Palawakin ang inyong kaalaman at kasanayan. Sumali sa mga libreng TESDA at LGU training programs upang mas mapalago ang inyong hanapbuhay dito sa Biñan.
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
            <div class="quick-icon"><i class='bx bx-book'></i></div>
            <div>
                <h5>TESDA Courses</h5>
                <p>Libreng training na may certificates.</p>
            </div>
        </div>
        <div class="quick-card">
            <div class="quick-icon"><i class='bx bx-calendar'></i></div>
            <div>
                <h5>Scheduled Batches</h5>
                <p>May iskedyul para makapaghanda.</p>
            </div>
        </div>
        <div class="quick-card">
            <div class="quick-icon"><i class='bx bx-award'></i></div>
            <div>
                <h5>Skill Upgrade</h5>
                <p>Dagdag kaalaman para sa mas mataas na kita.</p>
            </div>
        </div>
    </div>

    <div class="section section-white" style="padding-top: 40px; display: flex; flex-direction: column; align-items: center;">
        <div class="section-header" style="width: 100%; max-width: 800px; text-align: left;">
            <h3>Upcoming <span>Seminars & Courses</span></h3>
            <p class="section-sub" style="margin: 0;">Mag-apply ng maaga dahil limitado lamang ang mga slots para sa bawat batch.</p>
        </div>
        
        <ul class="announcement-list" style="width: 100%; margin-top: 30px;">
            
            <li>
                <div class="ann-date">APR<br />15</div>
                <div class="ann-body" style="flex-grow: 1;">
                    <div style="display: flex; justify-content: space-between; align-items: flex-start; flex-wrap: wrap; gap: 10px;">
                        <div>
                            <h5>Cookery NC II (TESDA)</h5>
                            <p style="margin-bottom: 10px;">Matutong magluto ng mga sikat na putahe para sa carinderia o catering business. May libreng allowance at starter kit pagkatapos ng kurso.</p>
                            <span class="badge badge-teal"><i class='bx bx-map'></i> Biñan Livelihood Center</span>
                            <span class="badge badge-blue"><i class='bx bx-time-five'></i> 20 Araw</span>
                        </div>
                        <a href="/Pages/Contact.aspx" class="btn-outline" style="padding: 6px 16px; font-size: 0.8rem;">Mag-apply</a>
                    </div>
                </div>
            </li>

            <li>
                <div class="ann-date" style="background: #f59e0b;">APR<br />22</div>
                <div class="ann-body" style="flex-grow: 1;">
                    <div style="display: flex; justify-content: space-between; align-items: flex-start; flex-wrap: wrap; gap: 10px;">
                        <div>
                            <h5>Basic Computer & Social Media for Business (DICT)</h5>
                            <p style="margin-bottom: 10px;">Para sa mga may-ari ng sari-sari store at maliliit na negosyo. Matutunan kung paano gumamit ng Facebook at Gcash para makabenta online.</p>
                            <span class="badge badge-teal"><i class='bx bx-map'></i> City Hall IT Room</span>
                            <span class="badge badge-blue"><i class='bx bx-time-five'></i> 3 Araw</span>
                        </div>
                        <a href="/Pages/Contact.aspx" class="btn-outline" style="padding: 6px 16px; font-size: 0.8rem;">Mag-apply</a>
                    </div>
                </div>
            </li>

            <li>
                <div class="ann-date" style="background: #be123c;">MAY<br />05</div>
                <div class="ann-body" style="flex-grow: 1;">
                    <div style="display: flex; justify-content: space-between; align-items: flex-start; flex-wrap: wrap; gap: 10px;">
                        <div>
                            <h5>Electrical Installation & Maintenance NC II</h5>
                            <p style="margin-bottom: 10px;">Libreng kurso para maging isang certified electrician. Pwedeng makapasok sa construction companies o mag-freelance pagkatapos.</p>
                            <span class="badge badge-teal"><i class='bx bx-map'></i> TESDA Provincial Office</span>
                            <span class="badge badge-blue"><i class='bx bx-time-five'></i> 25 Araw</span>
                        </div>
                        <a href="/Pages/Contact.aspx" class="btn-outline" style="padding: 6px 16px; font-size: 0.8rem;">Mag-apply</a>
                    </div>
                </div>
            </li>

            <li>
                <div class="ann-date" style="background: #1d4ed8;">MAY<br />18</div>
                <div class="ann-body" style="flex-grow: 1;">
                    <div style="display: flex; justify-content: space-between; align-items: flex-start; flex-wrap: wrap; gap: 10px;">
                        <div>
                            <h5>Financial Literacy Seminar (DTI)</h5>
                            <p style="margin-bottom: 10px;">Paano mag-budget at magpalago ng puhunan? Alamin kung paano ihiwalay ang personal na pera sa pera ng inyong negosyo.</p>
                            <span class="badge badge-teal"><i class='bx bx-map'></i> Brgy. San Antonio Hall</span>
                            <span class="badge badge-blue"><i class='bx bx-time-five'></i> 1 Araw (8AM - 4PM)</span>
                        </div>
                        <a href="/Pages/Contact.aspx" class="btn-outline" style="padding: 6px 16px; font-size: 0.8rem;">Mag-apply</a>
                    </div>
                </div>
            </li>

        </ul>
    </div>
</asp:Content>
