<%@ Page Title="Livelihood Directory" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Negosyo.aspx.cs" Inherits="GROUP6_ANGAT.Pages.Directory" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    
    <div id="page-hero">
        <div class="hero-circles">
            <div class="c1"></div>
            <div class="c2"></div>
        </div>
        <div class="page-hero-inner">
            <span class="hero-badge"><i class='bx bx-store-alt'></i> Livelihood Directory</span>
            <h2>Lokal na <strong>Negosyo</strong></h2>
            <p class="hero-desc">
                Tuklasin at suportahan ang mga sari-sari store, carinderia, ukay-ukay, at iba pang maliliit na negosyo dito sa ating komunidad sa Biñan.
            </p>
        </div>
        <div class="wave">
            <svg viewBox="0 0 1440 80" xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="none">
                <path d="M0,80 L1440,80 L1440,80 L0,80 Z" fill="#ffffff"/>
            </svg>
        </div>
    </div>
<div class="section section-light" style="padding-top: 40px;">
    <div class="page-quick">
        <div class="quick-card">
            <div class="quick-icon"><i class='bx bx-store'></i></div>
            <div>
                <h5>60+ Negosyo</h5>
                <p>Mga lokal na tindahan at serbisyo sa Biñan.</p>
            </div>
        </div>
        <div class="quick-card">
            <div class="quick-icon"><i class='bx bx-badge-check'></i></div>
            <div>
                <h5>LGU Supported</h5>
                <p>Verified ng PESO at DTI program partners.</p>
            </div>
        </div>
        <div class="quick-card">
            <div class="quick-icon"><i class='bx bx-time-five'></i></div>
            <div>
                <h5>Open Hours</h5>
                <p>May oras ng operasyon para planado ang pagbisita.</p>
            </div>
        </div>
    </div>

    <div id="search-bar" style="margin-top: 24px;">
        <div class="search-box">
            <div class="search-field">
                <span class="s-icon"><i class='bx bx-search'></i></span>
                <input id="dirSearch" type="text" placeholder="Pangalan ng negosyo..." />
            </div>
            <div class="search-field">
                <span class="s-icon"><i class='bx bx-category'></i></span>
                <select id="dirCategory">
                    <option value="All">Lahat ng Kategorya</option>
                    <option value="Sari-Sari Store">Sari-Sari Store</option>
                    <option value="Carinderia">Carinderia / Food</option>
                    <option value="Ukay-Ukay">Ukay-Ukay / Damit</option>
                    <option value="Agrivet">Palengke / Agrivet</option>
                    <option value="Iba">Iba pa</option>
                </select>
            </div>
            <button id="dirFilterBtn" class="search-btn" type="button">Hanapin</button>
        </div>
    </div>


        <div class="section-header left" style="display: flex; justify-content: space-between; align-items: flex-end;">
            <div>
                <h3>Ating Mga <span>Tindahan</span></h3>
                <p class="section-sub">Mayroong 60+ na lokal na negosyo ang nakarehistro ngayon.</p>
            </div>
            <div style="display:flex; gap: 10px;">
                <a href="/Pages/PostNegosyo.aspx" class="btn-outline" style="padding: 8px 16px;"><i class='bx bx-plus'></i> I-rehistro ang Negosyo</a>
            </div>
        </div>
        
        <div id="dirListings" class="listings-grid">
            <asp:Repeater ID="rptDirectory" runat="server">
                <ItemTemplate>
                    <a href="#" class="listing-card"
                       data-category='<%# Eval("Category") %>'
                       data-search='<%# BuildSearchText(Eval("BusinessName"), Eval("Tags"), Eval("Barangay"), Eval("Category"), Eval("AddressLine"), Eval("OwnerDisplay")) %>'>
                        <div class="listing-top">
                            <div class="listing-icon" style='<%# GetCategoryIconStyle(Eval("Category")) %>'>
                                <i class='bx <%# GetCategoryIconClass(Eval("Category")) %>'></i>
                            </div>
                            <span class='badge <%# GetCategoryBadgeClass(Eval("Category")) %>'><%# Eval("Category") %></span>
                        </div>
                        <h4><%# Eval("BusinessName") %></h4>
                        <p class="listing-company"><i class='bx bx-map'></i> <%# GetDisplayLocation(Eval("AddressLine"), Eval("Barangay")) %></p>
                        <div class="listing-tags">
                            <asp:Literal ID="litHours" runat="server" Mode="PassThrough" Text='<%# GetHoursBadge(Eval("Hours")) %>' />
                            <asp:Literal ID="litTags" runat="server" Mode="PassThrough" Text='<%# GROUP6_ANGAT.DisplayHelper.GetTagsHtml(Eval("Tags"), Eval("Category")) %>' />
                        </div>
                        <div class="listing-footer">
                            <span class="listing-pay" style="font-size: 0.85rem; color: #475569;"><i class='bx bx-user'></i> <%# GetOwnerDisplay(Eval("OwnerDisplay")) %></span>
                            <span class="listing-date" style='<%# GetStatusStyle(Eval("Status")) %>'><%# Eval("Status") %></span>
                        </div>
                    </a>
                </ItemTemplate>
            </asp:Repeater>
        </div>
        
        <div style="text-align:center; margin-top: 40px;">
            <button class="btn-outline js-coming-soon" data-msg="Wala pang dagdag na negosyo ngayon.">Mag-load ng iba pang negosyo <i class='bx bx-chevron-down'></i></button>
        </div>
    </div>

    <script>
        (function () {
            const searchInput = document.getElementById('dirSearch');
            const categorySelect = document.getElementById('dirCategory');
            const filterBtn = document.getElementById('dirFilterBtn');
            const cards = Array.from(document.querySelectorAll('#dirListings .listing-card'));

            function applyFilter() {
                const q = (searchInput.value || '').toLowerCase();
                const cat = categorySelect.value;

                cards.forEach(card => {
                    const text = (card.dataset.search || '').toLowerCase();
                    const category = card.dataset.category || '';
                    const matchQ = !q || text.includes(q);
                    const matchCat = cat === 'All' || category === cat;
                    card.style.display = (matchQ && matchCat) ? '' : 'none';
                });
            }

            filterBtn.addEventListener('click', applyFilter);
            searchInput.addEventListener('keyup', applyFilter);
            categorySelect.addEventListener('change', applyFilter);
        })();
    </script>
</asp:Content>
