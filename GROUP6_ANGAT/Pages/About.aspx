<%@ Page Title="Tungkol Sa Amin" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="GROUP6_ANGAT.About" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    
    <div id="page-hero">
        <div class="hero-circles">
            <div class="c1"></div>
            <div class="c2"></div>
        </div>
        <div class="page-hero-inner">
            <span class="hero-badge"><i class='bx bxs-map'></i> IT114L GROUP-6 Project</span>
            <h2>Tungkol sa <strong>ANGAT</strong></h2>
            <p class="hero-desc">
                Isang komunidad na nagtutulungan para sa pag-asenso ng bawat manggagawang lokal at maliliit na negosyante sa Biñan, Laguna.
            </p>
        </div>
        <div class="wave">
            <svg viewBox="0 0 1440 80" xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="none">
                <path d="M0,80 L1440,80 L1440,80 L0,80 Z" fill="#ffffff"/>
            </svg>
        </div>
    </div>
    <div class="section section-light">
        <div class="page-quick">
            <div class="quick-card">
                <div class="quick-icon"><i class='bx bx-heart'></i></div>
                <div>
                    <h5>Community First</h5>
                    <p>Serbisyong walang bayad para sa lahat.</p>
                </div>
            </div>
            <div class="quick-card">
                <div class="quick-icon"><i class='bx bx-mobile-alt'></i></div>
                <div>
                    <h5>Mobile Ready</h5>
                    <p>Madaling gamitin kahit sa cellphone.</p>
                </div>
            </div>
            <div class="quick-card">
                <div class="quick-icon"><i class='bx bx-trending-up'></i></div>
                <div>
                    <h5>Growth Support</h5>
                    <p>Training at micro-loan info mula sa LGU.</p>
                </div>
            </div>
        </div>

            <div class="section-header">
                <h3>Ano ang <span>Layunin Namin?</span></h3>
                <p class="section-sub">
                    Hindi lahat ay gumagamit ng LinkedIn. Ang ANGAT ay ginawa para sa masa — madaling gamitin at walang bayad.
                </p>
            </div>
        
            <div class="steps-grid" style="margin-top: 40px;">
                <div class="step-card">
                    <div class="step-num" style="background-color: #14b8a6;"><i class='bx bx-group'></i></div>
                    <h5>Para Kanino Ito?</h5>
                    <p>Target namin ang mga kasambahay, laundry workers, tsuper, at sari-sari store owners na nangangailangan ng direktang koneksyon sa kabuhayan.</p>
                </div>
            
                <div class="step-card">
                    <div class="step-num" style="background-color: #f59e0b;"><i class='bx bx-mobile-alt'></i></div>
                    <h5>Libre at Madali</h5>
                    <p>Dinisenyo ang platapormang ito upang maging mabilis gamitin sa cellphone, na walang hidden fees para sa ating mga kababayan.</p>
                </div>
            
                <div class="step-card">
                    <div class="step-num" style="background-color: #0d9e6e;"><i class='bx bx-trending-up'></i></div>
                    <h5>Suporta sa Negosyo</h5>
                    <p>Nagbibigay kami ng impormasyon ukol sa micro-loans (DTI) at libreng TESDA training schedules para sa pag-unlad ng inyong galing.</p>
                </div>
        </div>
    </div>
</asp:Content>
