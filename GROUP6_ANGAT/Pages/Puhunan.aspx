<%@ Page Title="Puhunan Tips" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Puhunan.aspx.cs" Inherits="GROUP6_ANGAT.Pages.Puhunan" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    
    <div id="page-hero">
        <div class="hero-circles">
            <div class="c1"></div>
            <div class="c2"></div>
        </div>
        <div class="page-hero-inner">
            <span class="hero-badge"><i class='bx bx-money'></i> Gabay sa Negosyo</span>
            <h2>Puhunan <strong>Tips</strong></h2>
            <p class="hero-desc">
                Naghahanap ng dagdag puhunan para sa sari-sari store o carinderia? Alamin ang mga lehitimo at mababang-interes na pautang mula sa gobyerno at microfinance NGOs.
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
            <div class="quick-icon"><i class='bx bx-wallet'></i></div>
            <div>
                <h5>Low Interest</h5>
                <p>Mga programang may mababang interes.</p>
            </div>
        </div>
        <div class="quick-card">
            <div class="quick-icon"><i class='bx bx-badge-check'></i></div>
            <div>
                <h5>Legit Sources</h5>
                <p>Lehitimong ahensya at microfinance.</p>
            </div>
        </div>
        <div class="quick-card">
            <div class="quick-icon"><i class='bx bx-line-chart'></i></div>
            <div>
                <h5>Grow Your Biz</h5>
                <p>Gabay sa pag-angat ng maliit na negosyo.</p>
            </div>
        </div>
    </div>
    <!-- Searchbar start placeholder wala pang DB (Lean) -->
        <div id="search-bar" style="margin-top: 24px; display: flex; justify-content: center; width: 100%;">
    <div class="search-box" style="display: flex; width: 100%; max-width: 1100px;">
        
        <div class="search-field" style="flex: 2;"> <span class="s-icon"><i class='bx bx-search'></i></span>
            <input type="text" placeholder="Anong Loan ang hanap mo" 
                   style="background: transparent; border: none; outline: none; width: 100%;" />
        </div>

        <div class="search-field" style="flex: 1;">
            <span class="s-icon"><i class='bx bx-calendar'></i></span>
            <select style="background: transparent; border: none; outline: none; width: 100%; cursor: pointer;">
                <option>Micro Loans (0 - 10,000)</option>
                <option>Small Loans (10,001 - 50,000)</option>
                <option>Big Loans (50,001 - 100,000)</option>
                <option>Business Loans (100,001 - 5,000,000)</option>
            </select>
        </div>

        <button type="button" class="search-btn">Maghanap</button>
    </div>
</div>
    <!-- SearchBar done -->
    <div class="section section-white" style="padding-top: 40px;">
        <div class="section-header">
            <h3>Mga Programa para sa <span>Micro-Entrepreneurs</span></h3>
            <p class="section-sub">Huwag nang kumagat sa "5-6". Narito ang mga ligtas na ahensya na handang tumulong sa pag-asenso ng iyong kabuhayan.</p>
        </div>
        
        <div class="listings-grid" style="margin-top: 40px;">
            
            <div class="listing-card" style="display: flex; flex-direction: column; gap: 15px;">
                <div class="listing-icon" style="color: #0d9e6e; background: #e6f7f1; width: 60px; height: 60px; font-size: 1.8rem;">
                    <i class='bx bxs-bank'></i>
                </div>
                <h4 style="font-size: 1.2rem;">DTI - P3 Program</h4>
                <div class="listing-tags">
                    <span class="badge badge-green">Pondo sa Pagbabago at Pag-asenso</span>
                </div>
                <p style="color: #475569; font-size: 0.9rem; line-height: 1.6; flex-grow: 1;">
                    Isang programa ng Department of Trade and Industry na nagbibigay ng pautang na walang collateral. Mayroon lamang itong 2.5% na interes kada buwan, mas mababa kaysa sa mga loan sharks.
                </p>
                <div style="border-top: 1px solid var(--border); padding-top: 15px; margin-top: auto;">
                    <a href="/Pages/Contact.aspx" style="color: var(--primary); text-decoration: none; font-weight: bold; font-size: 0.9rem; display: flex; align-items: center; gap: 5px;">
                        Alamin ang requirements <i class='bx bx-right-arrow-alt'></i>
                    </a>
                </div>
            </div>

            <div class="listing-card" style="display: flex; flex-direction: column; gap: 15px;">
                <div class="listing-icon" style="color: #1d4ed8; background: #dbeafe; width: 60px; height: 60px; font-size: 1.8rem;">
                    <i class='bx bx-group'></i>
                </div>
                <h4 style="font-size: 1.2rem;">CARD MRI Microfinance</h4>
                <div class="listing-tags">
                    <span class="badge badge-blue">Para sa mga Nanay</span>
                </div>
                <p style="color: #475569; font-size: 0.9rem; line-height: 1.6; flex-grow: 1;">
                    Nagbibigay ng maliliit na pautang na nagsisimula sa ₱3,000 para sa mga kababaihan na gustong magnegosyo. Mayroon din itong kasamang micro-insurance at savings program.
                </p>
                <div style="border-top: 1px solid var(--border); padding-top: 15px; margin-top: auto;">
                    <a href="/Pages/Contact.aspx" style="color: #1d4ed8; text-decoration: none; font-weight: bold; font-size: 0.9rem; display: flex; align-items: center; gap: 5px;">
                        Alamin ang requirements <i class='bx bx-right-arrow-alt'></i>
                    </a>
                </div>
            </div>

            <div class="listing-card" style="display: flex; flex-direction: column; gap: 15px;">
                <div class="listing-icon" style="color: #b45309; background: #fef3c7; width: 60px; height: 60px; font-size: 1.8rem;">
                    <i class='bx bx-briefcase-alt-2'></i>
                </div>
                <h4 style="font-size: 1.2rem;">DOLE Kabuhayan Program</h4>
                <div class="listing-tags">
                    <span class="badge badge-amber">Livelihood Grant</span>
                </div>
                <p style="color: #475569; font-size: 0.9rem; line-height: 1.6; flex-grow: 1;">
                    Ang DOLE Integrated Livelihood Program (DILP) ay nagbibigay ng grant (hindi inuutang, kundi tulong) para sa mga materyales at equipment na kailangan para makapagsimula ng negosyo.
                </p>
                <div style="border-top: 1px solid var(--border); padding-top: 15px; margin-top: auto;">
                    <a href="/Pages/Contact.aspx" style="color: #b45309; text-decoration: none; font-weight: bold; font-size: 0.9rem; display: flex; align-items: center; gap: 5px;">
                        Alamin ang requirements <i class='bx bx-right-arrow-alt'></i>
                    </a>
                </div>
            </div>

            <div class="listing-card" style="display: flex; flex-direction: column; gap: 15px;">
                <div class="listing-icon" style="color: #be123c; background: #ffe4e6; width: 60px; height: 60px; font-size: 1.8rem;">
                    <i class='bx bxs-id-card'></i>
                </div>
                <h4 style="font-size: 1.2rem;">SSS Salary Loan</h4>
                <div class="listing-tags">
                    <span class="badge badge-rose">Para sa SSS Members</span>
                </div>
                <p style="color: #475569; font-size: 0.9rem; line-height: 1.6; flex-grow: 1;">
                    Kung ikaw ay may hulog sa SSS kahit self-employed, maaari kang umutang ng katumbas ng isang buwang sahod para pandagdag sa imbentaryo ng iyong tindahan.
                </p>
                <div style="border-top: 1px solid var(--border); padding-top: 15px; margin-top: auto;">
                    <a href="/Pages/Contact.aspx" style="color: #be123c; text-decoration: none; font-weight: bold; font-size: 0.9rem; display: flex; align-items: center; gap: 5px;">
                        Alamin ang requirements <i class='bx bx-right-arrow-alt'></i>
                    </a>
                </div>
            </div>

        </div>
    </div>
</asp:Content>
