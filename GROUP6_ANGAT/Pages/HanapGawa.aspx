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
                Dito direktang nag-uugnay ang mga manggagawa at kustomer sa Biñan.
            </p>
        </div>
        <div class="wave">
            <svg viewBox="0 0 1440 80" xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="none">
                <path d="M0,80 L1440,80 L1440,80 L0,80 Z" fill="#ffffff"/>
            </svg>
        </div>
    </div>

    <%-- QUICK STATS --%>
    <div class="section section-light" style="padding-top: 40px;">
    <div class="page-quick">
        <div class="quick-card">
            <div class="quick-icon"><i class='bx bx-wrench'></i></div>
            <div>
                <h5><asp:Label ID="lblServiceCount" runat="server" Text="0" /> Serbisyo</h5>
                <p>Available na ngayon sa Biñan.</p>
            </div>
        </div>
        <div class="quick-card">
            <div class="quick-icon"><i class='bx bx-check-circle'></i></div>
            <div>
                <h5>Madaling Mag-request</h5>
                <p>Isang click lang para mag-request.</p>
            </div>
        </div>
        <div class="quick-card">
            <div class="quick-icon"><i class='bx bx-refresh'></i></div>
            <div>
                <h5>Regular Updates</h5>
                <p>Bagong listings araw-araw.</p>
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
                <span class="s-icon"><i class='bx bx-map'></i></span>
                <select id="hgLocation">
                    <option value="All">Kahit Saan (Biñan)</option>
                    <option value="Biñan">Biñan (Poblacion)</option>
                    <option value="Bungahan">Bungahan</option>
                    <option value="Canlalay">Canlalay</option>
                    <option value="Casile">Casile</option>
                    <option value="De La Paz">De La Paz</option>
                    <option value="Ganado">Ganado</option>
                    <option value="Langkiwa">Langkiwa</option>
                    <option value="Loma">Loma</option>
                    <option value="Malaban">Malaban</option>
                    <option value="Malamig">Malamig</option>
                    <option value="Mampalasan">Mampalasan</option>
                    <option value="Mapagong">Mapagong</option>
                    <option value="Masile">Masile</option>
                    <option value="Maysilo">Maysilo</option>
                    <option value="Munting Ilog">Munting Ilog</option>
                    <option value="New Biñan">New Biñan</option>
                    <option value="Platero">Platero</option>
                    <option value="San Antonio">San Antonio</option>
                    <option value="San Francisco">San Francisco</option>
                    <option value="San Jose">San Jose</option>
                    <option value="San Vicente">San Vicente</option>
                    <option value="Santo Domingo">Santo Domingo</option>
                    <option value="Santo Tomas">Santo Tomas</option>
                    <option value="Soro-soro Ibaba">Soro-soro Ibaba</option>
                    <option value="Soro-soro Ilaya">Soro-soro Ilaya</option>
                    <option value="Timbao">Timbao</option>
                    <option value="Tubigan">Tubigan</option>
                    <option value="Zapote">Zapote</option>
                </select>
            </div>
            <button id="hgFilterBtn" class="search-btn" type="button">Maghanap</button>
        </div>
    </div>

    <%-- LISTINGS SECTION --%>
        <div class="section-header left" style="display:flex; justify-content:space-between; align-items:flex-end; flex-wrap:wrap; gap:12px;">
            <div>
                <h3>Mga Magagaling na <span>Manggagawa</span></h3>
                <p class="section-sub">Direktang makipag-ugnayan sa mga skilled workers ng Biñan.</p>
            </div>
            <div style="display:flex; gap:10px; align-items:center; flex-wrap:wrap;">
                <asp:PlaceHolder ID="phPostServiceBtn" runat="server">
                    <a runat="server" href="~/Pages/PostService.aspx" class="btn-outline" style="padding:8px 16px;">
                        <i class='bx bx-plus'></i> I-post ang Serbisyo
                    </a>
                </asp:PlaceHolder>
                <select id="hgSort" style="padding:12px 16px; border-radius:8px; border:1px solid var(--border); outline:none; font-family:inherit; font-size:0.88rem;">
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
                        data-location='<%# Eval("Barangay") %>'
                        data-search='<%# GROUP6_ANGAT.DisplayHelper.GetSearchText(Eval("ServiceTitle"), Eval("Tags"), Eval("Barangay"), Eval("Category")) %>'
                        data-title='<%# Eval("ServiceTitle") %>'
                        data-rate='<%# GROUP6_ANGAT.DisplayHelper.GetPayDisplay(Eval("RateMin"), Eval("RateMax"), Eval("RateType")) %>'
                        data-rate-amount='<%# Eval("RateMax") ?? Eval("RateMin") ?? 0 %>'
                        data-posted='<%# GROUP6_ANGAT.DisplayHelper.GetPostedValue(Eval("PostedAt")) %>'
                        data-tags='<%# Eval("Tags") %>'
                        data-status='<%# Eval("Status") %>'
                        data-date='<%# GetRelativeTime(Eval("PostedAt")) %>'
                        data-desc='<%# Eval("ServiceDescription") %>'
                        data-poster='<%# Eval("PosterName") %>'
                        data-poster-img='<%# Eval("PosterImage") %>'
                        data-exact-date='<%# Eval("PostedAt") != DBNull.Value ? Convert.ToDateTime(Eval("PostedAt")).ToString("MMMM dd, yyyy") : "" %>'>
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
                            <span><i class='bx bx-time-five'></i> <%# GetRelativeTime(Eval("PostedAt")) %></span>
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

            <%-- Poster --%>
            <div class="modal-poster">
                <img id="posterImg" src="/Images/default-icon.jpg" alt="Poster" class="modal-poster-img" />
                <div>
                    <span class="modal-poster-name" id="posterName"></span>
                    <span class="modal-poster-date" id="posterDate"></span>
                </div>
            </div>

            <%-- Title --%>
            <h4 id="serviceTitle"></h4>

            <%-- Info grid --%>
            <div class="modal-info-grid">
                <div class="modal-info-item">
                    <span class="modal-info-label">Lokasyon</span>
                    <span class="modal-info-value" id="serviceLocation"></span>
                </div>
                <div class="modal-info-item">
                    <span class="modal-info-label">Uri ng Serbisyo</span>
                    <div id="serviceTags" class="job-tags" style="margin:0;"></div>
                </div>
                <div class="modal-info-item">
                    <span class="modal-info-label">Rate</span>
                    <span class="modal-info-value" id="serviceRate"></span>
                </div>
                <div class="modal-info-item">
                    <span class="modal-info-label">Status</span>
                    <span id="serviceStatus" class="badge badge-green"></span>
                </div>
            </div>

            <%-- Description --%>
            <div class="modal-desc-block">
                <span class="modal-info-label">Detalye ng Serbisyo</span>
                <p id="serviceDesc" class="job-desc" style="margin-top:8px;"></p>
            </div>

            <%-- Actions --%>
            <div class="job-modal-actions">
                <asp:PlaceHolder ID="phServiceLoggedIn" runat="server">
                    <asp:Button ID="btnRequestService" runat="server" Text="Mag-request" CssClass="btn-green" OnClick="BtnRequestService_Click" />
                </asp:PlaceHolder>
                <asp:PlaceHolder ID="phServiceLoggedOut" runat="server" Visible="false">
                    <a runat="server" href="~/Pages/Login.aspx?returnUrl=/Pages/HanapGawa.aspx" class="btn-green">
                        Mag-login para mag-request
                    </a>
                </asp:PlaceHolder>
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
            const searchInput    = document.getElementById('hgSearch');
            const locationSelect = document.getElementById('hgLocation');
            const filterBtn      = document.getElementById('hgFilterBtn');
            const sortSelect     = document.getElementById('hgSort');
            const listingWrap    = document.getElementById('hgListings');
            const cards          = Array.from(listingWrap.querySelectorAll('.listing-card'));

            function applyFilter() {
                const q   = searchInput.value.toLowerCase().trim();
                const loc = locationSelect.value;

                cards.forEach(function (card) {
                    const text     = (card.dataset.search || '').toLowerCase();
                    const barangay = card.dataset.location || '';
                    const matchQ   = !q || text.includes(q);
                    const matchLoc = loc === 'All' || barangay === loc;
                    card.style.display = (matchQ && matchLoc) ? '' : 'none';
                });
            }

            function applySort() {
                const mode   = sortSelect.value;
                const sorted = cards.slice().sort(function (a, b) {
                    if (mode === 'rate') {
                        return parseFloat(b.dataset.rateAmount || 0) - parseFloat(a.dataset.rateAmount || 0);
                    }
                    return parseFloat(b.dataset.posted || 0) - parseFloat(a.dataset.posted || 0);
                });
                sorted.forEach(function (card) { listingWrap.appendChild(card); });
            }

            filterBtn.addEventListener('click', applyFilter);
            searchInput.addEventListener('keyup', applyFilter);
            locationSelect.addEventListener('change', applyFilter);
            sortSelect.addEventListener('change', function () { applySort(); applyFilter(); });
        })();

        // ── MODAL ──
        (function () {
            const modal          = document.getElementById('serviceModal');
            const backdrop       = modal.querySelector('.job-modal-backdrop');
            const closeBtns      = modal.querySelectorAll('.job-modal-close');
            const hfServiceId    = document.getElementById('<%= hfServiceId.ClientID %>');
            const hfServiceTitle = document.getElementById('<%= hfServiceTitle.ClientID %>');
            const hfServiceDesc  = document.getElementById('<%= hfServiceDesc.ClientID %>');

            function openModal(card) {
                modal.querySelector('#serviceTitle').textContent = card.dataset.title || '';
                modal.querySelector('#serviceStatus').textContent = card.dataset.status || '';
                modal.querySelector('#serviceDesc').textContent = card.dataset.desc || '';
                modal.querySelector('#serviceRate').textContent = card.dataset.rate || '';
                modal.querySelector('#posterName').textContent = card.dataset.poster || 'Hindi nakita';
                modal.querySelector('#posterDate').textContent = 'Na-post: ' + (card.dataset.exactDate || '');
                modal.querySelector('#serviceLocation').textContent = 'Brgy. ' + (card.dataset.location || '') + ', Biñan';

                var img = modal.querySelector('#posterImg');
                var imgPath = card.dataset.posterImg || '';
                img.src = imgPath && imgPath !== '' ? imgPath : '/Images/default-icon.jpg';

                // tags
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
                document.body.classList.add('modal-open');
            }

            function closeModal() {
                modal.classList.remove('open');
                document.body.classList.remove('modal-open');
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
