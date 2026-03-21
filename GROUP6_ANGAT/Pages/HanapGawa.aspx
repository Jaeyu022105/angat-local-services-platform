<%@ Page Title="Hanap Gawa" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="HanapGawa.aspx.cs" Inherits="GROUP6_ANGAT.Pages.HanapGawa" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <%-- PAGE HERO --%>
    <div id="page-hero">
        <div class="hero-circles">
            <div class="c1"></div>
            <div class="c2"></div>
        </div>
        <div class="page-hero-inner">
            <span class="hero-badge"><i class='bx bx-wrench'></i> Services Board</span>
            <h2>Hanap <strong>Gawa</strong></h2>
            <p class="hero-desc">
                Kailangan mo ba ng tubero, karpintero, o electrician? 
                Dito direktang nag-uugnay ang mga manggagawa at kustomer sa Biñan.Q
            </p>
        </div>
        <div class="wave">
            <svg viewBox="0 0 1440 80" xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="none">
                <path d="M0,80 L1440,80 L1440,80 L0,80 Z" fill="#ffffff"/>
            </svg>
        </div>
    </div>

    <%-- QUICK STATS --%>
    <div class="page-quick">
        <div class="quick-card">
            <div class="quick-icon"><i class='bx bx-check-shield'></i></div>
            <div>
                <h5>Skilled Workers</h5>
                <p>Mga manggagawa na may karanasan.</p>
            </div>
        </div>
        <div class="quick-card">
            <div class="quick-icon"><i class='bx bx-timer'></i></div>
            <div>
                <h5>Mabilis Makahanap</h5>
                <p>Direktang contact para sa agarang serbisyo.</p>
            </div>
        </div>
        <div class="quick-card">
            <div class="quick-icon"><i class='bx bx-money'></i></div>
            <div>
                <h5>Presyong Klaro</h5>
                <p>Transparent na rate at kondisyon ng trabaho.</p>
            </div>
        </div>
    </div>

    <%-- SEARCH BAR --%>
    <div id="search-bar" style="margin-top: 24px;">
        <div class="search-box">
            <div class="search-field">
                <span class="s-icon"><i class='bx bx-search'></i></span>
                <input id="hgSearch" type="text" placeholder="Anong serbisyo ang kailangan mo?" />
            </div>
            <div class="search-field">
                <span class="s-icon"><i class='bx bx-wrench'></i></span>
                <select id="hgCategory">
                    <option value="All">Lahat ng Kasanayan</option>
                    <option value="Karpintero">Karpintero</option>
                    <option value="Tubero">Tubero</option>
                    <option value="Electrician">Electrician</option>
                    <option value="Aircon Repair">Aircon Repair</option>
                    <option value="Mananahi">Mananahi</option>
                    <option value="Iba Pa">Iba Pa</option>
                </select>
            </div>
            <button id="hgFilterBtn" class="search-btn" type="button">Hanapin</button>
        </div>
    </div>

    <%-- LISTINGS SECTION --%>
    <div class="section section-white" style="padding-top: 40px;">

        <div class="section-header left" style="display:flex; justify-content:space-between; align-items:flex-end; flex-wrap:wrap; gap:12px;">
            <div>
                <h3>Mga Magagaling na <span>Manggagawa</span></h3>
                <p class="section-sub">Direktang makipag-ugnayan sa mga skilled workers ng Biñan.</p>
            </div>
            <div style="display:flex; gap:10px; align-items:center; flex-wrap:wrap;">
                <a runat="server" href="~/Pages/PostService.aspx" class="btn-outline" style="padding:8px 16px;">
                    <i class='bx bx-plus'></i> I-post ang Serbisyo
                </a>
                <select id="hgSort" style="padding:8px 16px; border-radius:8px; border:1px solid var(--border); outline:none; font-family:inherit; font-size:0.88rem;">
                    <option value="newest">Pinakabago</option>
                    <option value="rate">Pinakamataas na Rate</option>
                </select>
            </div>
        </div>

        <%-- Alert message --%>
        <asp:Panel ID="pnlServiceApplyMessage" runat="server" CssClass="form-alert" Visible="false" ClientIDMode="Static">
            <asp:Label ID="lblServiceApplyMessage" runat="server" />
        </asp:Panel>

        <%-- Service cards --%>
        <div id="hgListings" class="listings-grid">
            <asp:Repeater ID="rptServices" runat="server">
                <ItemTemplate>
                    <button type="button" class="listing-card listing-card-button"
                        data-serviceid='<%# Eval("ServiceId") %>'
                        data-category='<%# Eval("Category") %>'
                        data-search='<%# GROUP6_ANGAT.DisplayHelper.GetSearchText(Eval("ServiceTitle"), Eval("Tags"), Eval("Barangay"), Eval("Category")) %>'
                        data-title='<%# Eval("ServiceTitle") %>'
                        data-rate='<%# GROUP6_ANGAT.DisplayHelper.GetPayDisplay(Eval("RateMin"), Eval("RateMax"), Eval("RateType")) %>'
                        data-rate-amount='<%# Eval("RateMax") ?? Eval("RateMin") ?? 0 %>'
                        data-posted='<%# GROUP6_ANGAT.DisplayHelper.GetPostedValue(Eval("PostedAt")) %>'
                        data-tags='<%# Eval("Tags") %>'
                        data-status='<%# Eval("Status") %>'
                        data-date='<%# GROUP6_ANGAT.DisplayHelper.GetDateLabel(Eval("PostedAt")) %>'
                        data-desc='<%# Eval("ServiceDescription") %>'>
                        <div class="listing-top">
                            <div class="listing-icon" data-category='<%# Eval("Category") %>'>
                                <i></i>
                            </div>
                            <span class='badge <%# GROUP6_ANGAT.DisplayHelper.GetStatusClass(Eval("Status")) %>'><%# Eval("Status") %></span>
                        </div>
                        <h4><%# Eval("ServiceTitle") %></h4>
                        <p class="listing-company">
                            <i class='bx bx-map'></i> Brgy. <%# Eval("Barangay") %>, Biñan
                        </p>
                        <div class="listing-tags">
                            <asp:Literal ID="litServiceTags" runat="server" Mode="PassThrough"
                                Text='<%# GROUP6_ANGAT.DisplayHelper.GetTagsHtml(Eval("Tags"), Eval("Category")) %>' />
                        </div>
                        <div class="listing-footer">
                            <span class="listing-pay"><%# GROUP6_ANGAT.DisplayHelper.GetPayDisplay(Eval("RateMin"), Eval("RateMax"), Eval("RateType")) %></span>
                            <span class="listing-date"><%# GROUP6_ANGAT.DisplayHelper.GetDateLabel(Eval("PostedAt")) %></span>
                        </div>
                    </button>
                </ItemTemplate>
            </asp:Repeater>
        </div>

        <%-- Empty state --%>
        <asp:Panel ID="pnlEmpty" runat="server" Visible="false" CssClass="empty-state">
            <i class='bx bx-wrench'></i>
            <h4>Walang serbisyo sa ngayon</h4>
            <p>Subukan ulit mamaya o mag-post ng iyong serbisyo.</p>
        </asp:Panel>

    </div>

    <%-- SERVICE MODAL --%>
    <div id="serviceModal" class="job-modal">
        <div class="job-modal-backdrop"></div>
        <div class="job-modal-card">
            <button type="button" class="job-modal-close job-modal-close-icon" aria-label="Isara">✕</button>
            <div class="job-modal-header">
                <span id="serviceStatus" class="badge badge-green"></span>
                <span id="serviceDate" class="job-meta"></span>
            </div>
            <h4 id="serviceTitle"></h4>
            <p id="serviceLocation" class="job-location"></p>
            <div id="serviceRate" class="job-pay"></div>
            <div id="serviceTags" class="job-tags"></div>
            <p id="serviceDesc" class="job-desc"></p>
            <div class="job-modal-actions">
                <asp:PlaceHolder ID="phServiceLoggedIn" runat="server">
                    <asp:Button ID="btnRequestService" runat="server" Text="Mag-request" CssClass="btn-green" OnClick="BtnRequestService_Click" />
                </asp:PlaceHolder>
                <asp:PlaceHolder ID="phServiceLoggedOut" runat="server" Visible="false">
                    <a runat="server" href="~/Pages/Login.aspx?returnUrl=/Pages/HanapGawa.aspx" class="btn-green">
                        Mag-login para mag-request
                    </a>
                </asp:PlaceHolder>
                <button type="button" class="btn-outline job-modal-close">Isara</button>
            </div>
        </div>
    </div>

    <%-- Hidden fields --%>
    <asp:HiddenField ID="hfServiceId" runat="server" />
    <asp:HiddenField ID="hfServiceTitle" runat="server" />
    <asp:HiddenField ID="hfServiceDesc" runat="server" />

    <script>
        // ── FILTER & SORT ──
        (function () {
            var searchInput    = document.getElementById('hgSearch');
            var categorySelect = document.getElementById('hgCategory');
            var filterBtn      = document.getElementById('hgFilterBtn');
            var sortSelect     = document.getElementById('hgSort');
            var listingWrap    = document.getElementById('hgListings');
            var cards          = Array.from(listingWrap.querySelectorAll('.listing-card'));

            function applyFilter() {
                var q   = searchInput.value.toLowerCase().trim();
                var cat = categorySelect.value;

                cards.forEach(function (card) {
                    var text     = (card.dataset.search || '').toLowerCase();
                    var category = card.dataset.category || '';
                    var matchQ   = !q || text.includes(q);
                    var matchCat = cat === 'All' || category === cat;
                    card.style.display = (matchQ && matchCat) ? '' : 'none';
                });
            }

            function applySort() {
                var mode   = sortSelect.value;
                var sorted = cards.slice().sort(function (a, b) {
                    if (mode === 'rate') {
                        return parseFloat(b.dataset.rateAmount || 0) - parseFloat(a.dataset.rateAmount || 0);
                    }
                    return parseFloat(b.dataset.posted || 0) - parseFloat(a.dataset.posted || 0);
                });
                sorted.forEach(function (card) { listingWrap.appendChild(card); });
            }

            filterBtn.addEventListener('click', applyFilter);
            searchInput.addEventListener('keyup', applyFilter);
            categorySelect.addEventListener('change', applyFilter);
            sortSelect.addEventListener('change', function () { applySort(); applyFilter(); });
        })();

        // ── MODAL ──
        (function () {
            var modal         = document.getElementById('serviceModal');
            var backdrop      = modal.querySelector('.job-modal-backdrop');
            var closeBtns     = modal.querySelectorAll('.job-modal-close');
            var hfServiceId   = document.getElementById('<%= hfServiceId.ClientID %>');
            var hfServiceTitle = document.getElementById('<%= hfServiceTitle.ClientID %>');
            var hfServiceDesc = document.getElementById('<%= hfServiceDesc.ClientID %>');

            function openModal(card) {
                modal.querySelector('#serviceTitle').textContent = card.dataset.title || '';
                modal.querySelector('#serviceStatus').textContent = card.dataset.status || '';
                modal.querySelector('#serviceDate').textContent = card.dataset.date || '';
                modal.querySelector('#serviceDesc').textContent = card.dataset.desc || '';
                modal.querySelector('#serviceLocation').textContent = 'Brgy. ' + (card.dataset.location || '') + ', Biñan';
                modal.querySelector('#serviceRate').textContent = card.dataset.rate || '';

                var tagsEl = modal.querySelector('#serviceTags');
                tagsEl.innerHTML = '';
                (card.dataset.tags || '').split('|').filter(Boolean).forEach(function (tag) {
                    var span = document.createElement('span');
                    span.className = 'badge badge-teal';
                    span.textContent = tag.trim();
                    tagsEl.appendChild(span);
                });

                hfServiceId.value = card.dataset.serviceid || '';
                hfServiceTitle.value = card.dataset.title || '';
                hfServiceDesc.value = card.dataset.desc || '';

                modal.classList.add('open');
                document.body.style.overflow = 'hidden';
            }

            function closeModal() {
                modal.classList.remove('open');
                document.body.style.overflow = '';
            }

            document.querySelectorAll('#hgListings .listing-card-button').forEach(function (card) {
                card.addEventListener('click', function () { openModal(card); });
            });

            closeBtns.forEach(function (btn) { btn.addEventListener('click', closeModal); });
            backdrop.addEventListener('click', closeModal);
            document.addEventListener('keydown', function (e) {
                if (e.key === 'Escape' && modal.classList.contains('open')) closeModal();
            });
        })();
    </script>

</asp:Content>
