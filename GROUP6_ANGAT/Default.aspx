<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="GROUP6_ANGAT._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div id="hero">
        <div class="hero-circles">
            <div class="c1"></div>
            <div class="c2"></div>
            <div class="c3"></div>
        </div>
        <div class="hero-inner">
            <span class="hero-badge">📍 Biñan, Laguna — Para sa Komunidad</span>
            <h2>Hanapin ang Inyong<br /><strong>Trabaho o Kabuhayan</strong></h2>
            <p class="hero-desc">
                Ang <strong>ANGAT</strong> — Ating Negosyo, Galing, at Trabaho — ay isang libreng
                plataporma para sa mga kasambahay, karpintero, labandera, at maliliit na
                negosyante ng ating lungsod. Walang pinipili, lahat tutulungan.
            </p>
            <div class="hero-btns">
                <a href="/Pages/HanapTrabaho.aspx" class="btn-primary">🔍 Maghanap ng Trabaho</a>
                <a href="/Pages/HanapGawa.aspx" class="btn-secondary">🛠️ Mag-alok ng Serbisyo</a>
            </div>
        </div>
        <div class="wave">
            <svg viewBox="0 0 1440 80" xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="none">
                <path d="M0,80 L1440,80 L1440,80 L0,80 Z" fill="#ffffff"/>
            </svg>
        </div>
    </div>

    <div class="stats-bar">
        <div class="stat-item">
            <span class="stat-num">120+</span>
            <span class="stat-label">Mga Trabaho</span>
        </div>
        <div class="stat-item">
            <span class="stat-num">85+</span>
            <span class="stat-label">Mga Serbisyo</span>
        </div>
        <div class="stat-item">
            <span class="stat-num">60+</span>
            <span class="stat-label">Lokal na Negosyo</span>
        </div>
        <div class="stat-item">
            <span class="stat-num">5</span>
            <span class="stat-label">Mga Barangay</span>
        </div>
    </div>

        <div class="section section-white">
        <div class="section-header">
            <h3>Paano <span>Gamitin</span>?</h3>
            <p class="section-sub">Simple at libre. Dinisenyo para sa lahat ng Biñanense.</p>
        </div>
        <ol class="steps-grid" style="list-style:none;">
            <li class="step-card">
                <div class="step-num">1</div>
                <h5>Piliin ang Seksyon</h5>
                <p>Pumili kung naghahanap ka ng trabaho, serbisyo, o lokal na negosyo.</p>
            </li>
            <li class="step-card">
                <div class="step-num">2</div>
                <h5>I-browse ang Listings</h5>
                <p>Tingnan ang mga available na trabaho at serbisyo sa inyong lugar.</p>
            </li>
            <li class="step-card">
                <div class="step-num">3</div>
                <h5>Makipag-ugnayan</h5>
                <p>Direktang makipag-usap sa employer o trabahador gamit ang contact info.</p>
            </li>
            <li class="step-card">
                <div class="step-num">4</div>
                <h5>Magsimulang Kumita</h5>
                <p>Simulan ang trabaho o negosyo at tulungan ang ating komunidad.</p>
            </li>
        </ol>
    </div>

    <div class="section section-white">
        <div class="section-header">
            <h3>Simulan ang Inyong <span>Paghahanap</span></h3>
            <p class="section-sub">
                Pumili ng seksyon para makapagsimula. Mula sa paghahanap ng trabaho hanggang sa pagpapaunlad ng negosyo — nandito ang lahat.
            </p>
        </div>
        <div class="category-grid">
            <a href="/Pages/HanapTrabaho.aspx" class="cat-card">
                <div class="cat-icon-wrap cat-icon-green">💼</div>
                <span>Hanap Trabaho</span>
            </a>
            <a href="/Pages/HanapGawa.aspx" class="cat-card">
                <div class="cat-icon-wrap cat-icon-teal">🛠️</div>
                <span>Hanap Gawa</span>
            </a>
            <a href="/Pages/Directory.aspx" class="cat-card">
                <div class="cat-icon-wrap cat-icon-amber">🏪</div>
                <span>Lokal na Negosyo</span>
            </a>
            <a href="/Pages/Puhunan.aspx" class="cat-card">
                <div class="cat-icon-wrap cat-icon-blue">💰</div>
                <span>Puhunan Tips</span>
            </a>
            <a href="/Pages/Training.aspx" class="cat-card">
                <div class="cat-icon-wrap cat-icon-rose">📚</div>
                <span>Training Calendar</span>
            </a>
        </div>
    </div>

    <div class="section section-light">
        <div class="section-header left">
            <h3>Mga Bagong <span>Trabaho</span></h3>
            <p class="section-sub">Pinakabagong mga listing mula sa ating lungsod.</p>
        </div>
        <div class="listings-grid">
            <asp:Repeater ID="rptFeaturedJobs" runat="server">
                <ItemTemplate>
                    <a href="/Pages/HanapTrabaho.aspx" class="listing-card">
                        <div class="listing-top">
                            <div class="listing-icon" style="background: <%# Eval("IconBg") %>; color: <%# Eval("IconColor") %>">
                                <i class='<%# Eval("IconClass") %>'></i>
                            </div>
                            <span class="badge badge-green"><%# Eval("Status") %></span>
                        </div>
                        <h4><%# Eval("JobTitle") %></h4>
                        <p class="listing-company"><i class='bx bx-map'></i> <%# Eval("JobLocation") %></p>
                        <div class="listing-tags">
                            <asp:Literal runat="server" Mode="PassThrough" Text='<%# GetTagsHtml(Eval("JobTags"), Eval("Category")) %>' />
                        </div>
                        <div class="listing-footer">
                            <span class="listing-pay"><%# Eval("JobPay") %></span>
                            <span class="listing-date"><%# Eval("DateLabel") %></span>
                        </div>
                    </a>
                </ItemTemplate>
            </asp:Repeater>
        </div>
        <br />
        <div style="text-align:center;">
            <a href="/Pages/HanapTrabaho.aspx" class="btn-green">Tingnan Lahat ng Trabaho →</a>
        </div>
    </div>

    <div class="section section-light">
        <div class="section-header left">
            <h3>Mga <span>Anunsyo</span></h3>
            <p class="section-sub">
                Pinakabagong balita mula sa PESO Office at LGU Biñan.<br />
                Ang seksyong ito ay maglalaman ng mga opisyal na anunsyo sa hinaharap.
            </p>
        </div>
        <ul class="announcement-list">
            <li>
                <div class="ann-date">JUN<br />3</div>
                <div class="ann-body">
                    <h5>Bagong TESDA Free Training — Cookery NC II</h5>
                    <p>Magbubukas ang bagong batch ng libreng cookery training sa Biñan City Livelihood Center. Limitado lamang ang slot.</p>
                </div>
            </li>
            <li>
                <div class="ann-date">MAY<br />28</div>
                <div class="ann-body">
                    <h5>DTI Negosyo Center — Micro-Loan Applications Open</h5>
                    <p>Tumatanggap na ng applications ang DTI para sa P3 program. Hanggang Php 200,000 ang maaaring hiramin.</p>
                </div>
            </li>
            <li>
                <div class="ann-date">MAY<br />20</div>
                <div class="ann-body">
                    <h5>Job Fair — Biñan City Hall, Hunyo 15</h5>
                    <p>Magsasagawa ng job fair ang PESO Office. Mahigit 30 employer ang lalahok. Magdala ng resume at valid ID.</p>
                </div>
            </li>
        </ul>
    </div>
</asp:Content>
