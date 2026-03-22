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
                Dito direktang nag-uugnay ang mga manggagawa at kustomer sa Bi&#241;an.
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
                <p>Available na ngayon sa Bi&#241;an.</p>
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
                    <option value="All">Kahit Saan (Bi&#241;an)</option>
                    <option value="Bi&#241;an">Bi&#241;an (Poblacion)</option>
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
                    <option value="New Bi&#241;an">New Bi&#241;an</option>
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
                <p class="section-sub">Direktang makipag-ugnayan sa mga skilled workers ng Bi&#241;an.</p>
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

        <%-- Alert message — also used for ?posted=success banner --%>
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
                        data-category='<%# Eval("Category") %>'
                        data-search='<%# GROUP6_ANGAT.DisplayHelper.GetSearchText(Eval("ServiceTitle"), Eval("Tags"), Eval("Barangay"), Eval("Category")) %>'
                        data-title='<%# Eval("ServiceTitle") %>'
                        data-rate='<%# GROUP6_ANGAT.DisplayHelper.GetPayDisplay(Eval("RateMin"), Eval("RateMax"), Eval("RateType")) %>'
                        data-rate-amount='<%# Eval("RateMax") ?? Eval("RateMin") ?? 0 %>'
                        data-posted='<%# GROUP6_ANGAT.DisplayHelper.GetPostedValue(Eval("PostedAt")) %>'
                        data-posted-ticks='<%# Convert.ToDateTime(Eval("PostedAt")).Ticks %>'
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
                        <h4 style="flex:0 0 auto; min-height:0; margin-bottom:5px;"><%# Eval("ServiceTitle") %></h4>
                        <p class="listing-company">
                            <i class='bx bx-map'></i> Brgy. <%# Eval("Barangay") %>, Bi&#241;an
                        </p>
                        <div class="listing-tags">
                            <asp:Literal ID="litServiceTags" runat="server" Mode="PassThrough"
                                Text='<%# GROUP6_ANGAT.DisplayHelper.GetTagsHtml(Eval("Tags"), Eval("Category")) %>' />
                        </div>
                        <div class="listing-footer">
                            <span class="listing-pay">
                                <%# GROUP6_ANGAT.DisplayHelper.GetPayDisplay(Eval("RateMin"), Eval("RateMax"), Eval("RateType")) %>
                            </span>
                            <span class="listing-time">
                                <i class='bx bx-time-five'></i> <%# GetRelativeTime(Eval("PostedAt")) %>
                            </span>
                        </div>
                    </button>
                </ItemTemplate>
            </asp:Repeater>
        </div>

        <%-- PAGINATION= --%>
        <div id="hgPagination" style="display:flex; justify-content:center; align-items:center; gap:8px; margin-top:40px; flex-wrap:wrap;"></div>

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
            <button type="button" class="job-modal-close job-modal-close-icon" aria-label="Isara">&#x2715;</button>

            <%-- Poster --%>
            <div class="modal-poster">
                <img id="posterImg" src="/Images/default-icon.jpg" alt="Poster" class="modal-poster-img" style="width:50px; height:50px; border-radius:50%; object-fit:cover;" />
                <div style="display:flex; flex-direction:column; line-height:1.1; margin-left:10px;">
                    <span class="modal-poster-name" id="posterName" style="font-weight:600; font-size:1rem;"></span>
                    <small class="modal-poster-date" id="posterDate" style="color:#64748b; font-size:0.75rem;"></small>
                </div>
            </div>

            <%-- Title --%>
            <h4 id="serviceTitle" style="margin-top:15px; font-weight:700;"></h4>

            <%-- Info grid (same layout as Hanap Trabaho) --%>
            <div class="modal-info-grid" style="display: grid; grid-template-columns: 1fr 1fr; gap: 15px; margin-top:15px;">
                <div class="modal-info-item"><span class="modal-info-label">Lokasyon</span><span class="modal-info-value" id="serviceLocation"></span></div>
                <div class="modal-info-item"><span class="modal-info-label">Status</span><span id="serviceStatus" class="badge"></span></div>
                <div class="modal-info-item"><span class="modal-info-label">Rate</span><span class="modal-info-value" id="serviceRate"></span></div>
                <div class="modal-info-item" style="grid-column: span 2;"><span class="modal-info-label">Uri ng Serbisyo / Tags</span><div id="serviceTags" class="job-tags" style="display:flex; flex-wrap:wrap; gap:8px; margin-top:8px;"></div></div>
            </div>
            <div class="modal-desc-block"><span class="modal-info-label">Detalye</span><p id="serviceDesc" class="job-desc" style="margin-top:8px;"></p></div>


            <%-- Description --%>
            <div class="modal-desc-block">
                <span class="modal-info-label">Detalye ng Serbisyo</span>
                <p id="serviceDesc" class="job-desc" style="margin-top:8px;"></p>
            </div>

            <%-- Actions --%>
            <div class="job-modal-actions">
                <asp:UpdatePanel ID="UpdatePanelService" runat="server">
                    <ContentTemplate>
                        <asp:Panel ID="pnlModalServiceMessage" runat="server" CssClass="form-alert" 
                            EnableViewState="false"
                            style="display:none; margin-bottom:15px;" ClientIDMode="Static">
                            <asp:Label ID="lblModalServiceMessage" runat="server" EnableViewState="false" />
                        </asp:Panel>
                        <asp:PlaceHolder ID="phServiceLoggedIn" runat="server">
                            <asp:Button ID="btnRequestService" runat="server"
                                Text="Mag-request"
                                CssClass="btn-green"
                                OnClick="BtnRequestService_Click" />
                        </asp:PlaceHolder>
                        <asp:PlaceHolder ID="phServiceLoggedOut" runat="server" Visible="false">
                            <a runat="server" href="~/Pages/Login.aspx?returnUrl=/Pages/HanapGawa.aspx" class="btn-green">
                                Mag-login para mag-request
                            </a>
                        </asp:PlaceHolder>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>
    </div>

    <%-- Hidden fields --%>
    <asp:HiddenField ID="hfServiceId"    runat="server" />
    <asp:HiddenField ID="hfServiceTitle" runat="server" />
    <asp:HiddenField ID="hfServiceDesc"  runat="server" />

    <script>
        // ── TAG COLOR MAP — mirrors DisplayHelper.GetTagCss ──
        function getTagClass(tag, category) {
            var t   = (tag      || '').toLowerCase();
            var cat = (category || '').toLowerCase();

            if (t.includes('urgent'))                                       return 'tag-rose';
            if (t.includes('full-time'))                                    return 'tag-fulltime';
            if (t.includes('part-time'))                                    return 'tag-parttime';
            if (t.includes('weekday') || t.includes('weekdays'))            return 'tag-blue';
            if (t.includes('weekend') || t.includes('weekends'))            return 'tag-violet';
            if (t.includes('flexible'))                                     return 'tag-teal';
            if (t.includes('anytime') || t.includes('available'))           return 'tag-mint';
            if (t.includes('experienced') || t.includes('may karanasan'))   return 'tag-experience';
            if (t.includes('licensed'))                                     return 'tag-experience';
            if (t.includes('pisikal'))                                      return 'tag-physical';
            if (t.includes("driver's license"))                             return 'tag-blue';
            if (t.includes('nbi'))                                          return 'tag-amber';
            if (t.includes('with tools'))                                   return 'tag-amber';
            if (t.includes('repair'))                                       return 'tag-blue';
            if (t.includes('install') || t.includes('wiring'))              return 'tag-teal';
            if (t.includes('cleaning'))                                     return 'tag-mint';
            if (t.includes('maintenance'))                                  return 'tag-teal';
            if (t.includes('gawa sa order') || t.includes('custom'))       return 'tag-amber';
            if (t.includes('emergency'))                                    return 'tag-rose';
            if (t.includes('gcash'))                                        return 'tag-teal';
            if (t.includes('pautang') || t.includes('utang'))              return 'tag-amber';
            if (t.includes('takeout'))                                      return 'tag-blue';
            if (t.includes('delivery'))                                     return 'tag-violet';
            if (t.includes('dine-in'))                                      return 'tag-mint';
            if (t.includes('online selling'))                               return 'tag-teal';
            if (t.includes('lutong bahay'))                                 return 'tag-amber';
            if (t.includes('halamang gamot'))                               return 'tag-mint';

            if (cat.includes('karpintero'))                                 return 'tag-amber';
            if (cat.includes('tubero'))                                     return 'tag-blue';
            if (cat.includes('electric'))                                   return 'tag-teal';
            if (cat.includes('aircon') || cat.includes('appliance'))       return 'tag-mint';
            if (cat.includes('mananahi'))                                   return 'tag-rose';
            if (cat.includes('kasambahay') || cat.includes('labandera'))   return 'tag-violet';
            if (cat.includes('driver'))                                     return 'tag-blue';
            if (cat.includes('carinderia') || cat.includes('sari-sari'))   return 'tag-amber';

            return 'tag-teal';
        }

        // ── FILTER & SORT ──
        (function () {
            const searchInput = document.getElementById('hgSearch');
            const locationSelect = document.getElementById('hgLocation');
            const filterBtn = document.getElementById('hgFilterBtn');
            const sortSelect = document.getElementById('hgSort');
            const listingWrap = document.getElementById('hgListings');
            const paginationWrap = document.getElementById('hgPagination');
            const cards = Array.from(listingWrap.querySelectorAll('.listing-card'));
            const pageSize = 10;
            let currentPage = 1;
            function getFilteredAndSorted() {
                const q = searchInput.value.toLowerCase().trim();
                const loc = locationSelect.value;
                const sort = sortSelect.value;
                const filtered = cards.filter(function (card) {
                    const text = (card.dataset.search || '').toLowerCase();
                    const barangay = card.dataset.location || '';
                    const matchQ = !q || text.includes(q);
                    const matchLoc = loc === 'All' || barangay === loc;
                    return matchQ && matchLoc;
                });
                filtered.sort(function (a, b) {
                    if (sort === 'rate')
                        return parseFloat(b.dataset.rateAmount || 0) - parseFloat(a.dataset.rateAmount || 0);
                    return parseFloat(b.dataset.postedTicks || b.dataset.posted || 0) - parseFloat(a.dataset.postedTicks || a.dataset.posted || 0);
                });
                return filtered;
            }
            function renderPagination(totalItems) {
                paginationWrap.innerHTML = '';
                const totalPages = Math.ceil(totalItems / pageSize);
                if (totalPages <= 1) return;
                for (var i = 1; i <= totalPages; i++) {
                    var btn = document.createElement('button');
                    btn.type = 'button';
                    btn.textContent = i;
                    btn.className = 'btn-outline';
                    btn.style.padding = '8px 14px';
                    if (i === currentPage) {
                        btn.style.background = 'var(--primary)';
                        btn.style.color = '#fff';
                    }
                    btn.onclick = (function (page) {
                        return function () {
                            currentPage = page;
                            renderPage();
                            window.scrollTo({ top: 400, behavior: 'smooth' });
                        };
                    })(i);
                    paginationWrap.appendChild(btn);
                }
            }
            function renderPage() {
                var filtered = getFilteredAndSorted();
                var totalPages = Math.ceil(filtered.length / pageSize);
                if (currentPage > totalPages) currentPage = 1;
                cards.forEach(function (c) { c.style.display = 'none'; });
                var start = (currentPage - 1) * pageSize;
                filtered.slice(start, start + pageSize).forEach(function (c) { c.style.display = ''; });
                filtered.forEach(function (card) { listingWrap.appendChild(card); });
                renderPagination(filtered.length);
                updateTagOverflow();
            }
            filterBtn.addEventListener('click', function () { currentPage = 1; renderPage(); });
            searchInput.addEventListener('keyup', function () { currentPage = 1; renderPage(); });
            locationSelect.addEventListener('change', function () { currentPage = 1; renderPage(); });
            sortSelect.addEventListener('change', function () { currentPage = 1; renderPage(); });
            window.addEventListener('resize', updateTagOverflow);
            renderPage();
        })();

        function updateTagOverflow() {
            document.querySelectorAll('.listing-tags').forEach(container => {
                const badges = Array.from(container.querySelectorAll('.badge:not(.more-badge)'));
                const old = container.querySelector('.more-badge'); if (old) old.remove();
                const maxTags = 2;

                if (badges.length > maxTags) {
                    badges.forEach((b, index) => {
                        if (index >= maxTags) {
                            b.style.display = 'none';
                        }
                    });

                    const m = document.createElement('span');
                    m.className = 'badge more-badge';
                    m.innerText = '+' + (badges.length - maxTags);
                    container.appendChild(m);
                }
            });
        }

        document.addEventListener('DOMContentLoaded', function () {
            updateTagOverflow();
        });
        window.addEventListener('resize', updateTagOverflow);

        // ── MODAL ──
        (function () {
            const modal          = document.getElementById('serviceModal');
            const backdrop       = modal.querySelector('.job-modal-backdrop');
            const closeBtns      = modal.querySelectorAll('.job-modal-close');
            const hfServiceId    = document.getElementById('<%= hfServiceId.ClientID %>');
            const hfServiceTitle = document.getElementById('<%= hfServiceTitle.ClientID %>');
            const hfServiceDesc  = document.getElementById('<%= hfServiceDesc.ClientID %>');

            function openModal(card) {
                var modalAlert = document.getElementById('pnlModalServiceMessage');
                if (modalAlert) {
                    modalAlert.style.display = 'none';
                    modalAlert.className = 'form-alert';
                    var lbl = modalAlert.querySelector('span');
                    if (lbl) lbl.innerHTML = '';
                }
                modal.querySelector('#serviceTitle').textContent = card.dataset.title || '';
                var st = modal.querySelector('#serviceStatus');
                st.textContent = card.dataset.status || '';
                st.className = 'badge ' + (String(card.dataset.status || '').toLowerCase().includes('available') ? 'badge-green' : 'badge-rose');
                modal.querySelector('#serviceDesc').textContent = card.dataset.desc || '';
                modal.querySelector('#serviceRate').textContent = card.dataset.rate || '';
                modal.querySelector('#posterName').textContent = card.dataset.poster || 'Hindi nakita';
                modal.querySelector('#posterDate').textContent = 'Na-post: ' + (card.dataset.exactDate || '');
                modal.querySelector('#serviceLocation').textContent = 'Brgy. ' + (card.dataset.location || '') + ', Bi\u00F1an';

                // ── Poster image ──
                var img = modal.querySelector('#posterImg');
                var imgPath = (card.dataset.posterImg || '').replace('~/', '/');
                img.src = imgPath && imgPath !== '' ? imgPath : '/Images/default-icon.jpg';
                img.onerror = function () { img.src = '/Images/default-icon.jpg'; };

                // ── Tags with correct colors matching card display ──
                var tagsEl = modal.querySelector('#serviceTags');
                var category = card.dataset.category || '';
                tagsEl.innerHTML = '';
                (card.dataset.tags || '').split('|').filter(Boolean).forEach(function (tag) {
                    var span = document.createElement('span');
                    span.className = 'badge ' + getTagClass(tag.trim(), category);
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

        (function () {
            var params = new URLSearchParams(window.location.search);
            if (params.get('posted') === 'success') {
                var banner = document.getElementById('pnlServiceApplyMessage');
                if (banner) {
                    banner.style.display = 'block';
                    banner.className = 'form-alert success';
                    var lbl = banner.querySelector('span');
                    if (lbl) lbl.textContent = 'Naipost na ang serbisyo! Makikita ito sa listahan.';
                    else banner.textContent = 'Naipost na ang serbisyo! Makikita ito sa listahan.';
                }
                window.history.replaceState({}, '', window.location.pathname);
            }
        })();
        if (typeof Sys !== 'undefined') {
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
                var modalAlert = document.getElementById('pnlModalServiceMessage');
                if (!modalAlert) return;
                var lbl = modalAlert.querySelector('span');
                var hasContent = lbl && lbl.innerHTML.trim() !== '';
                modalAlert.style.display = hasContent ? 'block' : 'none';
            });
        }
    </script>

</asp:Content>