<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="GROUP6_ANGAT._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div id="hero">
        <div class="hero-circles">
            <div class="c1"></div>
            <div class="c2"></div>
            <div class="c3"></div>
        </div>
        <div class="hero-inner">
            <h2>Hanapin ang inyong Trabaho o Kabuhayan!</h2>
            <p class="hero-desc">
                Ang <strong>ANGAT</strong> (Ating Negosyo, Galing, at Trabaho) ay isang libreng
                plataporma para sa mga kasambahay, karpintero, labandera, at maliliit na
                negosyante ng ating lungsod. Walang pinipili, lahat tutulungan.
            </p>
            <div class="hero-btns">
                <a href="/Pages/HanapTrabaho.aspx" class="btn-primary">Maghanap ng Trabaho</a>
                <a href="/Pages/HanapGawa.aspx" class="btn-secondary">Mag-alok ng Serbisyo</a>
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
            <span class="stat-num">24</span>
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

    <div class="section section-light">
        <div class="section-header left">
            <h3>Mga Bagong <span>Trabaho</span></h3>
            <p class="section-sub">Tingnan ang pinakabagong mga trabaho dito sa ating lungsod.</p>
        </div>
        <div class="listings-grid">
            <asp:Repeater ID="rptFeaturedJobs" runat="server">
                <ItemTemplate>
                    <a href="/Pages/HanapTrabaho.aspx" class="listing-card">
                        <div class="listing-top">
                            <div class="listing-icon" data-category='<%# Eval("Category") %>'>
                                <i></i>
                            </div>
                            <span class="badge badge-green"><%# Eval("Status") %></span>
                        </div>
                        <h4><%# Eval("JobTitle") %></h4>
                        <p class="listing-company"><i class='bx bx-map'></i> Brgy. <%# Eval("Barangay") %>, Biñan</p>
                        <div class="listing-tags">
                            <asp:Literal runat="server" Mode="PassThrough" Text='<%# GROUP6_ANGAT.DisplayHelper.GetTagsHtml(Eval("Tags"), Eval("Category")) %>' />
                        </div>
                        <div class="listing-footer">
                            <span class="listing-pay"><%# GROUP6_ANGAT.DisplayHelper.GetPayDisplay(Eval("PayMin"), Eval("PayMax"), Eval("PayRate")) %></span>
                            <span class="listing-date"><%# GROUP6_ANGAT.DisplayHelper.GetDateLabel(Eval("PostedAt")) %></span>
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

    <div class="section section-white">
        <div class="section-header left">
            <h3>Mga Bagong <span>Serbisyo</span></h3>
            <p class="section-sub">Tuklasin ang mga maaasahang serbisyo mula sa ating lokal na manggagawa.</p>
        </div>
        <div class="listings-grid">
            <asp:Repeater ID="rptFeaturedServices" runat="server">
                <ItemTemplate>
                    <a href="/Pages/HanapGawa.aspx" class="listing-card">
                        <div class="listing-top">
                            <div class="listing-icon" data-category='<%# Eval("Category") %>'>
                                <i></i>
                            </div>
                            <span class='badge <%# GROUP6_ANGAT.DisplayHelper.GetStatusClass(Eval("Status")) %>'><%# Eval("Status") %></span>
                        </div>
                        <h4><%# Eval("ServiceTitle") %></h4>
                        <p class="listing-company"><i class='bx bx-map'></i> Brgy. <%# Eval("Barangay") %>, Biñan</p>
                        <div class="listing-tags">
                            <asp:Literal runat="server" Mode="PassThrough" Text='<%# GROUP6_ANGAT.DisplayHelper.GetTagsHtml(Eval("Tags"), Eval("Category")) %>' />
                        </div>
                        <div class="listing-footer">
                            <span class="listing-pay"><%# GROUP6_ANGAT.DisplayHelper.GetPayDisplay(Eval("RateMin"), Eval("RateMax"), Eval("RateType")) %></span>
                            <span class="listing-date"><%# GROUP6_ANGAT.DisplayHelper.GetDateLabel(Eval("PostedAt")) %></span>
                        </div>
                    </a>
                </ItemTemplate>
            </asp:Repeater>
        </div>
        <br />
        <div style="text-align:center;">
            <a href="/Pages/HanapGawa.aspx" class="btn-green">Tingnan Lahat ng Serbisyo →</a>
        </div>
    </div>

    <div class="section section-light">
        <div class="section-header left">
            <h3>Mga <span>Anunsyo</span></h3>
            <p class="section-sub">
                Pinakabagong balita mula sa PESO Office at LGU Biñan.
            </p>
        </div>
        <ul class="announcement-list">
            <asp:Repeater ID="rptAnnouncements" runat="server">
                <ItemTemplate>
                    <li>
                        <div class="ann-date"><%# Eval("MonthLabel") %><br /><%# Eval("DayLabel") %></div>
                        <div class="ann-body">
                            <h5><%# Eval("Title") %></h5>
                            <p><%# Eval("Body") %></p>
                        </div>
                    </li>
                </ItemTemplate>
            </asp:Repeater>
        </ul>
    </div>
</asp:Content>
