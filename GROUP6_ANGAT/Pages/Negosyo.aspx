<%@ Page Title="Negosyo" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Negosyo.aspx.cs" Inherits="GROUP6_ANGAT.Pages.Directory" %>

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
                <h5><asp:Label ID="lblDirectoryCountHero" runat="server" ClientIDMode="Static" Text="0" /> Negosyo</h5>
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
                    <option value="Kainan at Panaderya">Kainan at Panaderya</option>
                    <option value="Sari-Sari Store">Sari-Sari Store</option>
                    <option value="Tindahan ng Damit o Ukay-Ukay">Tindahan ng Damit at Ukay-Ukay</option>
                    <option value="Tindahan ng Gamit o Regalo">Tindahan ng Gamit at Regalo</option>
                    <option value="Computer at Printing Shop">Computer at Printing Shop</option>
                    <option value="Electronics at Repair Shop">Electronics at Repair Shop</option>
                    <option value="Laundry Shop">Laundry Shop</option>
                    <option value="Salon at Barbershop">Salon at Barbershop</option>
                    <option value="Hardware at Construction">Hardware at Construction</option>
                    <option value="Tindahan ng Gamot o Halaman">Tindahan ng Gamot o Halaman</option>
                    <option value="Veterinary at Pet Supplies">Veterinary at Pet Supplies</option>
                    <option value="Iba Pa">Iba Pa</option>
                </select>
            </div>
            <button id="dirFilterBtn" class="search-btn" type="button">Hanapin</button>
        </div>
    </div>

    <div class="section-header left" style="display: flex; justify-content: space-between; align-items: flex-end;">
        <div>
            <h3>Ating Mga <span>Tindahan</span></h3>
            <p id="dirDirectorySubtext" class="section-sub">Tuklasin ang mga lokal na negosyong bukas at aktibo sa Biñan.</p>
        </div>
        <div style="display:flex; gap: 10px;">
            <a href="/Pages/PostNegosyo.aspx" class="btn-outline" style="padding: 8px 16px;"><i class='bx bx-plus'></i> I-rehistro ang Negosyo</a>
        </div>
<<<<<<< Updated upstream
    <%-- filter part --%>
        <div id="dirNoResults" class="empty-state" style="display:none; margin-top:24px;">
            Walang negosyong tumugma sa iyong filter.
        </div>
        

        <div id="dirPagination" style="display:flex; justify-content:center; align-items:center; gap:8px; margin-top:40px; flex-wrap:wrap;"></div>

=======
>>>>>>> Stashed changes
    </div>
    
    <%-- Alert message for success --%>
    <asp:Panel ID="pnlDirectoryMessage" runat="server" CssClass="form-alert" Visible="false" ClientIDMode="Static">
        <asp:Label ID="lblDirectoryMessage" runat="server" />
    </asp:Panel>
    
    <div id="dirListings" class="listings-grid">
        <asp:Repeater ID="rptDirectory" runat="server">
            <ItemTemplate>
                <button type="button" class="listing-card listing-card-button"
                   data-name='<%# EncodeAttr(Eval("BusinessName")) %>'
                   data-category='<%# EncodeAttr(Eval("Category")) %>'
                   data-barangay='<%# EncodeAttr(Eval("Barangay")) %>'
                   data-exact-address='<%# EncodeAttr(Eval("AddressLine")) %>'
                   data-hours='<%# EncodeAttr(Eval("Hours")) %>'
                   data-tags='<%# EncodeAttr(Eval("Tags")) %>'
                   data-address='<%# EncodeAttr(GetAddressValue(Eval("AddressLine"), Eval("Barangay"))) %>'
                   data-owner='<%# EncodeAttr(GetOwnerDisplay(Eval("OwnerName"), Eval("OwnerDisplay"))) %>'
                   data-contact='<%# EncodeAttr(Eval("ContactNumber")) %>'
                   data-status='<%# EncodeAttr(Eval("Status")) %>'
                   data-tags='<%# EncodeAttr(Eval("Tags")) %>'
                   data-map='<%# EncodeAttr(Eval("MapEmbedUrl")) %>'
                   data-icon-class='<%# EncodeAttr(GetCategoryIconClass(Eval("Category"))) %>'
                   data-icon-style='<%# EncodeAttr(GetCategoryIconStyle(Eval("Category"))) %>'
                   data-badge-class='<%# EncodeAttr(GetCategoryBadgeClass(Eval("Category"))) %>'
                   data-search='<%# BuildSearchText(Eval("BusinessName"), Eval("Tags"), Eval("Barangay"), Eval("Category"), Eval("AddressLine"), Eval("OwnerDisplay")) %>'
                   <%-- NEW: Add data attributes for separate days and time --%>
                   data-days='<%# EncodeAttr(GetDaysPart(Eval("Hours"))) %>'
                   data-time='<%# EncodeAttr(GetTimePart(Eval("Hours"))) %>'
                   >
                    <div class="listing-top">
                        <div class="listing-icon" style='<%# GetCategoryIconStyle(Eval("Category")) %>'>
                            <i class='bx <%# GetCategoryIconClass(Eval("Category")) %>'></i>
                        </div>
                        <span class='badge <%# GetCategoryBadgeClass(Eval("Category")) %>'><%# Eval("Category") %></span>
                    </div>
                    <h4><%# Eval("BusinessName") %></h4>
                    <%-- MODIFIED: Pass null for AddressLine to GetDisplayLocation to show only Barangay --%>
                    <p class="listing-company"><i class='bx bx-map'></i> <%# GetDisplayLocation(null, Eval("Barangay")) %></p>
                    <div class="listing-tags">
                        <asp:Literal ID="litHours" runat="server" Mode="PassThrough" Text='<%# GetHoursBadge(Eval("Hours")) %>' />
                        <asp:Literal ID="litTags" runat="server" Mode="PassThrough" Text='<%# GROUP6_ANGAT.DisplayHelper.GetTagsHtml(Eval("Tags"), Eval("Category")) %>' />
                    </div>
                    <div class="listing-footer">
                        <span class="listing-pay" style="font-size: 0.85rem; color: #475569;"><i class='bx bx-user'></i> <%# GetOwnerDisplay(Eval("OwnerName"), Eval("OwnerDisplay")) %></span>
                        <span class="listing-date" style='<%# GetStatusStyle(Eval("Status")) %>'><%# Eval("Status") %></span>
                    </div>
                </button>
            </ItemTemplate>
        </asp:Repeater>
    </div>
    
    <div id="dirPagination" style="display:flex; justify-content:center; align-items:center; gap:8px; margin-top:40px; flex-wrap:wrap;"></div>
</div>

<%-- BUSINESS MODAL --%>
    <div id="businessModal" class="job-modal">
        <div class="job-modal-backdrop"></div>
        <div class="job-modal-card">
            <button type="button" class="job-modal-close job-modal-close-icon" aria-label="Isara">&#x2715;</button>

            <div class="modal-poster">
                <div id="bizIcon" class="listing-icon" style="width:48px;height:48px;border-radius:12px;display:flex;align-items:center;justify-content:center;font-size:1.5rem;flex-shrink:0;">
                    <i id="bizIconI" class="bx bx-store"></i>
                </div>
                <div>
                    <span class="modal-poster-name" id="bizOwner"></span>
                    <span class="modal-poster-date" id="bizStatus"></span>
                </div>
            </div>

            <h4 id="bizName"></h4>

            <div class="modal-info-grid">
                <div class="modal-info-item">
                    <span class="modal-info-label">Address</span>
                    <span class="modal-info-value" id="bizAddress"></span>
                </div>
                <div class="modal-info-item">
                    <span class="modal-info-label">Contact</span>
                    <span class="modal-info-value" id="bizContact"></span>
                </div>
                <%-- NEW: Separate field for Days Open --%>
                <div class="modal-info-item">
                    <span class="modal-info-label">Mga Araw ng Operasyon</span>
                    <span class="modal-info-value" id="bizDaysOpen"></span>
                </div>
                <%-- MODIFIED: This will now display only the Time --%>
                <div class="modal-info-item">
                    <span class="modal-info-label">Oras ng Operasyon</span>
                    <span class="modal-info-value" id="bizTimeOpen"></span>
                </div>
                <div class="modal-info-item">
                    <span class="modal-info-label">Kategorya</span>
                    <span id="bizCategory" class="badge"></span>
                </div>
                <div class="modal-info-item modal-tags-item">
                    <span class="modal-info-label">Tags</span>
                    <div id="bizTags" class="job-tags" style="margin:0;"></div>
                </div>
            </div>

            <div class="modal-desc-block">
                <span class="modal-info-label">Lokasyon sa Mapa</span>
                <div id="bizMapWrap" style="margin-top:8px;border-radius:12px;overflow:hidden;border:1px solid var(--border);">
                    <iframe id="bizMap" title="Business location" loading="lazy"
                        style="width:100%;height:220px;border:0;" allowfullscreen
                        referrerpolicy="no-referrer-when-downgrade"></iframe>
                </div>
                <p id="bizMapEmpty" class="job-meta" style="margin-top:8px;display:none;">Walang map link.</p>
            </div>

            <div class="job-modal-actions"></div>
        </div>
    </div>

    <script>
        // FILTER & PAGINATION
        (function () {
<<<<<<< Updated upstream
            const searchInput = document.getElementById('dirSearch');
            const categorySelect = document.getElementById('dirCategory');
            const filterBtn = document.getElementById('dirFilterBtn');

            const cards = Array.from(document.querySelectorAll('#dirListings .listing-card-button'));
            const heroCount = document.getElementById('lblDirectoryCountHero');
            const directorySubtext = document.getElementById('dirDirectorySubtext');
            const paginationWrap = document.getElementById('dirPagination');
            const noResults = document.getElementById('dirNoResults');

=======
            var searchInput = document.getElementById('dirSearch');
            var categorySelect = document.getElementById('dirCategory');
            var filterBtn = document.getElementById('dirFilterBtn');
            var cards = Array.from(document.querySelectorAll('#dirListings .listing-card-button'));
            var heroCount = document.getElementById('lblDirectoryCountHero');
            var paginationWrap = document.getElementById('dirPagination');
            var pageSize = 8;
            var currentPage = 1;
>>>>>>> Stashed changes

            if (heroCount) heroCount.textContent = cards.length;

            function getFiltered() {
                var q = (searchInput.value || '').toLowerCase().trim();
                var cat = categorySelect.value;
                return cards.filter(function (c) {
                    var mq = !q || (c.dataset.search || '').toLowerCase().includes(q);
                    var mc = cat === 'All' || (c.dataset.category || '') === cat;
                    return mq && mc;
                });
            }

            function renderPagination(total) {
                if (!paginationWrap) return;
                paginationWrap.innerHTML = '';
                if (total <= 1) return;
                for (var i = 1; i <= total; i++) {
                    (function (p) {
                        var btn = document.createElement('button');
                        btn.type = 'button'; btn.textContent = p; btn.className = 'btn-outline';
                        btn.style.padding = '8px 14px';
                        if (p === currentPage) { btn.style.background = 'var(--primary)'; btn.style.color = '#fff'; btn.style.borderColor = 'var(--primary)'; }
                        btn.addEventListener('click', function () { currentPage = p; renderPage(); });
                        paginationWrap.appendChild(btn);
                    })(i);
                }
            }
            //
            function renderPage() {
<<<<<<< Updated upstream
                const filteredCards = getFilteredCards();
                const totalPages = Math.max(1, Math.ceil(filteredCards.length / pageSize));

                if (noResults) {
                    noResults.style.display = filteredCards.length === 0 ? 'block' : 'none';
                }
                const start = (currentPage - 1) * pageSize; //bago mag compute, tignan muna kung ala results
                const end = start + pageSize;

                if (noResults) {
                    noResults.style.display = filteredCards.length === 0 ? 'block' : 'none';
                }


                if (currentPage > totalPages) {
                    currentPage = 1;
                }

                cards.forEach(function (card) {
                    card.style.display = 'none';
                });

                filteredCards.slice(start, end).forEach(function (card) {
                    card.style.display = '';
                });

                renderPagination(filteredCards.length === 0 ? 0 : totalPages);
=======
                var filtered = getFiltered();
                var total = Math.max(1, Math.ceil(filtered.length / pageSize));
                if (currentPage > total) currentPage = 1;
                var start = (currentPage - 1) * pageSize;
                cards.forEach(function (c) { c.style.display = 'none'; });
                filtered.slice(start, start + pageSize).forEach(function (c) { c.style.display = ''; });
                renderPagination(total);
>>>>>>> Stashed changes
            }

            renderPage();
            filterBtn.addEventListener('click', function () { currentPage = 1; renderPage(); });
            searchInput.addEventListener('keyup', function () { currentPage = 1; renderPage(); });
            categorySelect.addEventListener('change', function () { currentPage = 1; renderPage(); });
        })();

        // TAG COLOR MAP
        function getTagClass(tag, category) {
            var t = (tag || '').toLowerCase(); var cat = (category || '').toLowerCase();
            if (t.includes('urgent')) return 'tag-rose';
            if (t.includes('full-time')) return 'tag-fulltime';
            if (t.includes('part-time')) return 'tag-parttime';
            if (t.includes('weekday') || t.includes('weekdays') || t.includes('weekend') || t.includes('weekends') || t.includes('flexible')) return 'tag-blue';
            if (t.includes('experienced') || t.includes('may karanasan') || t.includes('licensed') || t.includes('pisikal') || t.includes("driver's license") || t.includes('nbi') || t.includes('with tools')) return 'tag-amber';
            if (t.includes('repair') || t.includes('install') || t.includes('wiring') || t.includes('cleaning') || t.includes('maintenance') || t.includes('gawa sa order') || t.includes('custom')) return 'tag-teal';
            if (t.includes('emergency')) return 'tag-rose';
            if (t.includes('gcash')) return 'tag-teal';
            if (t.includes('pick-up') || t.includes('takeout') || t.includes('delivery') || t.includes('dine-in')) return 'tag-blue';
            if (cat.includes('karpintero')) return 'tag-amber';
            if (cat.includes('tubero')) return 'tag-blue';
            if (cat.includes('electric')) return 'tag-teal';
            if (cat.includes('aircon') || cat.includes('appliance')) return 'tag-mint';
            if (cat.includes('mananahi')) return 'tag-rose';
            if (cat.includes('kasambahay') || cat.includes('labandera')) return 'tag-violet';
            if (cat.includes('driver')) return 'tag-blue';
            if (cat.includes('carinderia') || cat.includes('sari-sari')) return 'tag-amber';
            return 'tag-teal';
        }

        // MODAL
        (function () {
            var modal = document.getElementById('businessModal');
            var backdrop = modal.querySelector('.job-modal-backdrop');
            var closeBtns = modal.querySelectorAll('.job-modal-close');
            var mapFrame = modal.querySelector('#bizMap');
            var mapWrap = modal.querySelector('#bizMapWrap');
            var mapEmpty = modal.querySelector('#bizMapEmpty');
            var iconWrap = modal.querySelector('#bizIcon');
            var iconI = modal.querySelector('#bizIconI');
            var categoryBadge = modal.querySelector('#bizCategory');
            var tagsWrap = modal.querySelector('#bizTags');

            function buildEmbedUrl(mapUrl, address) {
                var addr = (address || '').trim();
                var fallback = addr ? 'https://www.google.com/maps?q=' + encodeURIComponent(addr) + '&output=embed' : '';
                var raw = (mapUrl || '').trim();
                if (!raw) return fallback;
                var url; try { url = new URL(raw, window.location.origin); } catch (e) { return fallback; }
                var host = url.hostname.toLowerCase();
                var ok = url.protocol === 'https:' && (host.endsWith('google.com') || host.endsWith('google.com.ph') || host === 'maps.google.com' || host === 'maps.app.goo.gl' || host === 'goo.gl');
                if (!ok) return fallback;
                var rl = raw.toLowerCase();
                if (rl.includes('/maps/embed') || rl.includes('output=embed')) return raw;
                if (addr) return fallback;
                if (rl.includes('/maps')) return raw + (raw.includes('?') ? '&' : '?') + 'output=embed';
                return raw;
            }

            function openModal(card) {
                modal.querySelector('#bizName').textContent = card.dataset.name || '';
                modal.querySelector('#bizOwner').textContent = card.dataset.owner || 'N/A';
                modal.querySelector('#bizStatus').textContent = card.dataset.status || '';
                modal.querySelector('#bizContact').textContent = card.dataset.contact || 'Walang contact number';

                // Address: barangay on card, exact + brgy in modal
                var brgy = card.dataset.barangay ? 'Brgy. ' + card.dataset.barangay + ', Biñan' : 'Biñan';
                var exact = card.dataset.exactAddress || '';
                modal.querySelector('#bizAddress').textContent = exact ? exact + ' — ' + brgy : brgy;

                // NEW: Populate Days and Time separately using the new data attributes
                modal.querySelector('#bizDaysOpen').textContent = card.dataset.days || 'Hindi tinukoy';
                modal.querySelector('#bizTimeOpen').textContent = card.dataset.time || 'Hindi tinukoy';

                var category = card.dataset.category || '';
                categoryBadge.textContent = category;
                categoryBadge.className = 'badge ' + (card.dataset.badgeClass || 'badge-teal');
                iconWrap.style.cssText = 'width:48px;height:48px;border-radius:12px;display:flex;align-items:center;justify-content:center;font-size:1.5rem;flex-shrink:0;' + (card.dataset.iconStyle || '');
                iconI.className = 'bx ' + (card.dataset.iconClass || 'bx-store');

                tagsWrap.innerHTML = '';
                (card.dataset.tags || '').split('|').filter(Boolean).forEach(function (tag) {
                    var span = document.createElement('span');
                    span.className = 'badge ' + getTagClass(tag.trim(), category);
                    span.textContent = tag.trim();
                    tagsWrap.appendChild(span);
                });

                var embedUrl = buildEmbedUrl(card.dataset.map || '', card.dataset.address || '');
                if (embedUrl) { mapFrame.src = embedUrl; mapWrap.style.display = ''; mapEmpty.style.display = 'none'; }
                else { mapFrame.src = ''; mapWrap.style.display = 'none'; mapEmpty.style.display = ''; }

                modal.classList.add('open');
                document.body.classList.add('modal-open');
            }

            function closeModal() {
                modal.classList.remove('open');
                document.body.classList.remove('modal-open');
                mapFrame.src = ''; tagsWrap.innerHTML = '';
            }

            document.querySelectorAll('#dirListings .listing-card-button').forEach(function (c) {
                c.addEventListener('click', function () { openModal(c); });
            });
            closeBtns.forEach(function (b) { b.addEventListener('click', closeModal); });
            backdrop.addEventListener('click', closeModal);
            document.addEventListener('keydown', function (e) { if (e.key === 'Escape' && modal.classList.contains('open')) closeModal(); });
        })();
    </script>
</asp:Content>