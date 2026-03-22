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
                <a href="/Pages/About.aspx" class="btn-primary">Tungkol Sa Amin → </a>
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
                <span class="stat-num"><%=GetCount("Jobs")%></span>
                <span class="stat-label">Mga Trabaho</span>
            </div>
            <div class="stat-item">
                <span class="stat-num"><%=GetCount("Services")%></span>
                <span class="stat-label">Mga Serbisyo</span>
            </div>
            <div class="stat-item">
                <span class="stat-num"><%=GetCount("Negosyo")%></span>
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
                    <div class="listing-card">
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
                            <span class="listing-date"><%# GetRelativeTime(Eval("PostedAt")) %></span>
                        </div>
                    </div>
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
                    <div class="listing-card">
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
                            <span class="listing-date"><%# GetRelativeTime(Eval("PostedAt")) %></span>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
        <br />
        <div style="text-align:center;">
            <a href="/Pages/HanapGawa.aspx" class="btn-green">Tingnan Lahat ng Serbisyo →</a>
        </div>
    </div>

    <%-- RESOURCES AT HOTLINES --%>
    <div class="section section-light">
        <div class="section-header left">
            <h3>Mga <span>Resources</span> at <span>Hotline</span></h3>
            <p class="section-sub">Opisyal na mga website at contact numbers para sa mga manggagawa at negosyante ng Biñan.</p>
        </div>
        <div class="resource-links-grid">

            <%-- LGU / GOVERNMENT --%>
            <div class="resource-group">
                <h5 class="resource-group-title"><i class='bx bx-buildings'></i> LGU / Gobyerno</h5>
                <a href="https://www.binan.gov.ph" target="_blank" class="resource-link">
                    <div class="resource-link-icon"><i class='bx bx-home-alt'></i></div>
                    <div>
                        <strong>Biñan City Official Website</strong>
                        <span>binan.gov.ph</span>
                    </div>
                    <i class='bx bx-link-external resource-link-arrow'></i>
                </a>
                <a href="https://www.binan.gov.ph/departments-and-offices/" target="_blank" class="resource-link">
                    <div class="resource-link-icon"><i class='bx bx-building'></i></div>
                    <div>
                        <strong>Mga Tanggapan ng LGU</strong>
                        <span>Departments & Offices</span>
                    </div>
                    <i class='bx bx-link-external resource-link-arrow'></i>
                </a>
                <a href="https://experiencebinan.com" target="_blank" class="resource-link">
                    <div class="resource-link-icon"><i class='bx bx-map-alt'></i></div>
                    <div>
                        <strong>Experience Biñan</strong>
                        <span>experiencebinan.com</span>
                    </div>
                    <i class='bx bx-link-external resource-link-arrow'></i>
                </a>
            </div>

            <%-- PESO / JOBS --%>
            <div class="resource-group">
                <h5 class="resource-group-title"><i class='bx bx-briefcase'></i> PESO / Trabaho</h5>
                <a href="https://www.facebook.com/pesobinan/" target="_blank" class="resource-link">
                    <div class="resource-link-icon"><i class='bx bxl-facebook'></i></div>
                    <div>
                        <strong>PESO Biñan Facebook</strong>
                        <span>Pinakabagong job fair at anunsyo</span>
                    </div>
                    <i class='bx bx-link-external resource-link-arrow'></i>
                </a>
                <a href="https://www.philjobnet.gov.ph" target="_blank" class="resource-link">
                    <div class="resource-link-icon"><i class='bx bx-search-alt'></i></div>
                    <div>
                        <strong>PhilJobNet</strong>
                        <span>DOLE job matching portal</span>
                    </div>
                    <i class='bx bx-link-external resource-link-arrow'></i>
                </a>
                <a href="https://www.dole.gov.ph" target="_blank" class="resource-link">
                    <div class="resource-link-icon"><i class='bx bx-badge-check'></i></div>
                    <div>
                        <strong>DOLE Official Website</strong>
                        <span>dole.gov.ph</span>
                    </div>
                    <i class='bx bx-link-external resource-link-arrow'></i>
                </a>
            </div>

            <%-- HOTLINES --%>
            <div class="resource-group">
                <h5 class="resource-group-title"><i class='bx bx-phone-call'></i> Mga Hotline</h5>
                <div class="resource-link">
                    <div class="resource-link-icon"><i class='bx bx-store'></i></div>
                    <div>
                        <strong>Negosyo Center</strong>
                        <span>513-5104 / 523-5104</span>
                        <span class="resource-link-desc">MSMEs, business registration, payo</span>
                    </div>
                </div>
                <div class="resource-link">
                    <div class="resource-link-icon"><i class='bx bx-file'></i></div>
                    <div>
                        <strong>BPLO</strong>
                        <span>513-5084 / 523-5481</span>
                        <span class="resource-link-desc">Business permits at licensing</span>
                    </div>
                </div>
                <div class="resource-link">
                    <div class="resource-link-icon"><i class='bx bx-pen'></i></div>
                    <div>
                        <strong>City Information Office</strong>
                        <span>513-5028 / 523-5400</span>
                        <span class="resource-link-desc">Job fairs at city announcements</span>
                    </div>
                </div>
                <div class="resource-link">
                    <div class="resource-link-icon"><i class='bx bx-heart'></i></div>
                    <div>
                        <strong>DSWD</strong>
                        <span>513-5041 / 523-5415</span>
                        <span class="resource-link-desc">Livelihood programs, cash-for-work</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
<script>
    // ── LIMIT TAGS ON CARDS (max 3) ──
    document.querySelectorAll('.listings-grid .listing-card').forEach(function (card) {
        var tagWrap = card.querySelector('.listing-tags');
        if (!tagWrap) return;
        var tags = Array.from(tagWrap.querySelectorAll('.badge'));
        if (tags.length <= 3) return;
        for (var i = 3; i < tags.length; i++) {
            tags[i].style.display = 'none';
        }
        var more = document.createElement('span');
        more.className = 'tag-overflow';
        more.textContent = '+' + (tags.length - 3);
        tagWrap.appendChild(more);
    });
</script>
</asp:Content>

