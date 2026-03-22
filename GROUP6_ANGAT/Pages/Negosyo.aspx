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
            <p class="hero-desc">Tuklasin at suportahan ang mga sari-sari store, carinderia, ukay-ukay, at iba pang maliliit na negosyo dito sa ating komunidad sa Biñan.</p>
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
            <div><h5>LGU Supported</h5><p>Verified ng PESO at DTI program partners.</p></div>
        </div>
        <div class="quick-card">
            <div class="quick-icon"><i class='bx bx-time-five'></i></div>
            <div><h5>Open Hours</h5><p>May oras ng operasyon para planado ang pagbisita.</p></div>
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
    </div>
    
    <asp:Panel ID="pnlDirectoryMessage" runat="server" CssClass="form-alert" Visible="false" ClientIDMode="Static">
        <asp:Label ID="lblDirectoryMessage" runat="server" />
    </asp:Panel>

    <div id="dirNoResults" class="empty-state" style="display:none; margin-top:24px; text-align:center; padding: 40px;">
        <i class='bx bx-search' style="font-size: 3rem; color: var(--muted);"></i>
        <h4>Walang Nahanap</h4>
        <p>Walang negosyong tumugma sa iyong filter.</p>
    </div>
    
    <div id="dirListings" class="listings-grid">
        <asp:Repeater ID="rptDirectory" runat="server">
            <ItemTemplate>
                <button type="button" class="listing-card listing-card-button"
                   data-name='<%# EncodeAttr(Eval("BusinessName")) %>'
                   data-category='<%# EncodeAttr(Eval("Category")) %>'
                   data-barangay='<%# EncodeAttr(Eval("Barangay")) %>'
                   data-exact-address='<%# EncodeAttr(Eval("AddressLine")) %>'
                   data-tags='<%# EncodeAttr(Eval("Tags")) %>'
                   data-owner='<%# EncodeAttr(GetOwnerDisplay(Eval("OwnerName"), Eval("OwnerDisplay"))) %>'
                   data-contact='<%# EncodeAttr(Eval("ContactNumber")) %>'
                   data-status='<%# EncodeAttr(Eval("Status")) %>'
                   data-map='<%# EncodeAttr(Eval("MapEmbedUrl")) %>'
                   data-icon-class='<%# EncodeAttr(GetCategoryIconClass(Eval("Category"))) %>'
                   data-icon-style='<%# EncodeAttr(GetCategoryIconStyle(Eval("Category"))) %>'
                   data-badge-class='<%# EncodeAttr(GetCategoryBadgeClass(Eval("Category"))) %>'
                   data-search='<%# BuildSearchText(Eval("BusinessName"), Eval("Tags"), Eval("Barangay"), Eval("Category"), Eval("AddressLine"), Eval("OwnerDisplay")) %>'
                   data-days='<%# EncodeAttr(GetDaysPart(Eval("Hours"))) %>'
                   data-time='<%# EncodeAttr(GetTimePart(Eval("Hours"))) %>'
                   data-address-full='<%# EncodeAttr(GetAddressValue(Eval("AddressLine"), Eval("Barangay"))) %>'>
                    <div class="listing-top">
                        <div class="listing-icon" style='<%# GetCategoryIconStyle(Eval("Category")) %>'>
                            <i class='bx <%# GetCategoryIconClass(Eval("Category")) %>'></i>
                        </div>
                        <span class='badge <%# GetCategoryBadgeClass(Eval("Category")) %>'><%# Eval("Category") %></span>
                    </div>
                    <h4><%# Eval("BusinessName") %></h4>
                    <p class="listing-company"><i class='bx bx-map'></i> <%# GetDisplayLocation(null, Eval("Barangay")) %></p>
                    <div class="listing-tags">
                        <asp:Literal ID="litHours" runat="server" Mode="PassThrough" Text='<%# GetHoursBadge(Eval("Hours")) %>' />
                        <asp:Literal ID="litTags" runat="server" Mode="PassThrough" Text='<%# GROUP6_ANGAT.DisplayHelper.GetTagsHtml(Eval("Tags"), Eval("Category")) %>' />
                    </div>
                    <div class="listing-footer">
                        <span class="listing-pay" style="font-size: 0.85rem; color: #475569;">
                            <i class='bx bx-user'></i> <%# GetOwnerDisplay(Eval("OwnerName"), Eval("OwnerDisplay")) %>
                        </span>
                        <span class="listing-date" style='<%# GetStatusStyle(Eval("Hours")) %>'>
                            <%# GetDynamicStatus(Eval("Hours")) %>
                        </span>
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
                <div class="modal-info-item"><span class="modal-info-label">Address</span><span class="modal-info-value" id="bizAddress"></span></div>
                <div class="modal-info-item"><span class="modal-info-label">Contact</span><span class="modal-info-value" id="bizContact"></span></div>
                <div class="modal-info-item"><span class="modal-info-label">Mga Araw ng Operasyon</span><span class="modal-info-value" id="bizDaysOpen"></span></div>
                <div class="modal-info-item"><span class="modal-info-label">Oras ng Operasyon</span><span class="modal-info-value" id="bizTimeOpen"></span></div>
                <div class="modal-info-item"><span class="modal-info-label">Kategorya</span><span id="bizCategory" class="badge"></span></div>
                <div class="modal-info-item modal-tags-item"><span class="modal-info-label">Tags</span><div id="bizTags" class="job-tags" style="margin:0;"></div></div>
            </div>
            <div class="modal-desc-block">
                <span class="modal-info-label">Lokasyon sa Mapa</span>
                <div id="bizMapWrap" style="margin-top:8px;border-radius:12px;overflow:hidden;border:1px solid var(--border);">
                    <iframe id="bizMap" title="Business location" loading="lazy" style="width:100%;height:220px;border:0;" allowfullscreen></iframe>
                </div>
                <p id="bizMapEmpty" class="job-meta" style="margin-top:8px;display:none;">Walang map link.</p>
            </div>
        </div>
    </div>

    <script>
        // ── FILTER, PAGINATION & TAG OVERFLOW ──
        (function () {
            const searchInput = document.getElementById('dirSearch');
            const categorySelect = document.getElementById('dirCategory');
            const filterBtn = document.getElementById('dirFilterBtn');
            const cards = Array.from(document.querySelectorAll('#dirListings .listing-card-button'));
            const paginationWrap = document.getElementById('dirPagination');
            const noResults = document.getElementById('dirNoResults');
            const heroCount = document.getElementById('lblDirectoryCountHero');

            const pageSize = 8;
            let currentPage = 1;

            function updateTagOverflow() {
                const containers = document.querySelectorAll('.listing-tags');
                containers.forEach(container => {
                    const badges = Array.from(container.querySelectorAll('.badge:not(.more-badge)'));
                    if (badges.length === 0) return;
                    badges.forEach(b => b.style.display = '');
                    const existingMore = container.querySelector('.more-badge');
                    if (existingMore) existingMore.remove();
                    let hiddenCount = 0;
                    const firstBadgeTop = badges[0].offsetTop;
                    badges.forEach(badge => {
                        if (badge.offsetTop > firstBadgeTop) {
                            badge.style.display = 'none';
                            hiddenCount++;
                        }
                    });
                    if (hiddenCount > 0) {
                        const moreLabel = document.createElement('span');
                        moreLabel.className = 'more-badge';
                        moreLabel.innerText = `+${hiddenCount} more`;
                        container.appendChild(moreLabel);
                    }
                });
            }

            function getFiltered() {
                const q = (searchInput.value || '').toLowerCase().trim();
                const cat = categorySelect.value;
                return cards.filter(c => {
                    const mq = !q || (c.dataset.search || '').toLowerCase().includes(q);
                    const mc = cat === 'All' || (c.dataset.category || '') === cat;
                    return mq && mc;
                });
            }

            function renderPagination(totalItems) {
                paginationWrap.innerHTML = '';
                const totalPages = Math.ceil(totalItems / pageSize);
                if (totalPages <= 1) return;
                for (let i = 1; i <= totalPages; i++) {
                    const btn = document.createElement('button');
                    btn.type = 'button'; btn.textContent = i; btn.className = 'btn-outline';
                    btn.style.padding = '8px 14px';
                    if (i === currentPage) { btn.style.background = 'var(--primary)'; btn.style.color = '#fff'; }
                    btn.onclick = () => { currentPage = i; renderPage(); window.scrollTo({ top: 400, behavior: 'smooth' }); };
                    paginationWrap.appendChild(btn);
                }
            }

            function renderPage() {
                const filtered = getFiltered();
                const totalPages = Math.ceil(filtered.length / pageSize);
                if (currentPage > totalPages) currentPage = 1;

                noResults.style.display = filtered.length === 0 ? 'block' : 'none';
                if (heroCount) heroCount.textContent = filtered.length;

                cards.forEach(c => c.style.display = 'none');
                const start = (currentPage - 1) * pageSize;
                filtered.slice(start, start + pageSize).forEach(c => c.style.display = '');

                renderPagination(filtered.length);
                updateTagOverflow();
            }

            filterBtn.onclick = () => { currentPage = 1; renderPage(); };
            searchInput.onkeyup = () => { currentPage = 1; renderPage(); };
            categorySelect.onchange = () => { currentPage = 1; renderPage(); };
            window.onresize = updateTagOverflow;

            renderPage();
        })();

        // ── MODAL LOGIC ──
        (function () {
            const modal = document.getElementById('businessModal');
            const backdrop = modal.querySelector('.job-modal-backdrop');
            const closeBtns = modal.querySelectorAll('.job-modal-close');
            const mapFrame = modal.querySelector('#bizMap');
            const tagsWrap = modal.querySelector('#bizTags');

            function getTagClass(tag, category) {
                var t = (tag || '').toLowerCase(); var cat = (category || '').toLowerCase();
                if (t.includes('gcash')) return 'tag-teal';
                if (t.includes('pick-up') || t.includes('delivery')) return 'tag-blue';
                return 'tag-teal';
            }

            function openModal(card) {
                modal.querySelector('#bizName').textContent = card.dataset.name;
                modal.querySelector('#bizOwner').textContent = card.dataset.owner;

                // Grabs the "Bukas Ngayon" or "Sarado Ngayon" text directly from the card
                const statusText = card.querySelector('.listing-date').textContent.trim();
                const bizStatusEl = modal.querySelector('#bizStatus');
                bizStatusEl.textContent = statusText;

                // Updates the color in the modal to match
                bizStatusEl.style.color = (statusText === "Bukas Ngayon") ? "#0d9e6e" : "#be123c";
                bizStatusEl.style.fontWeight = "bold";

                modal.querySelector('#bizContact').textContent = card.dataset.contact || 'Walang contact number';
                modal.querySelector('#bizAddress').textContent = card.dataset.addressFull;
                modal.querySelector('#bizDaysOpen').textContent = card.dataset.days;
                modal.querySelector('#bizTimeOpen').textContent = card.dataset.time;

                const category = card.dataset.category;
                const badge = modal.querySelector('#bizCategory');
                badge.textContent = category;
                badge.className = 'badge ' + card.dataset.badgeClass;

                const iconWrap = modal.querySelector('#bizIcon');
                iconWrap.style.cssText = 'width:48px;height:48px;border-radius:12px;display:flex;align-items:center;justify-content:center;font-size:1.5rem;flex-shrink:0;' + card.dataset.iconStyle;
                modal.querySelector('#bizIconI').className = 'bx ' + card.dataset.iconClass;

                tagsWrap.innerHTML = '';
                (card.dataset.tags || '').split('|').filter(Boolean).forEach(tag => {
                    const span = document.createElement('span');
                    span.className = 'badge ' + getTagClass(tag.trim(), category);
                    span.textContent = tag.trim();
                    tagsWrap.appendChild(span);
                });

                const rawMap = card.dataset.map;
                if (rawMap) { mapFrame.src = rawMap.includes('embed') ? rawMap : `https://www.google.com/maps?q=${encodeURIComponent(card.dataset.addressFull)}&output=embed`; document.getElementById('bizMapWrap').style.display = ''; document.getElementById('bizMapEmpty').style.display = 'none'; }
                else { mapFrame.src = ''; document.getElementById('bizMapWrap').style.display = 'none'; document.getElementById('bizMapEmpty').style.display = ''; }

                modal.classList.add('open');
                document.body.classList.add('modal-open');
            }

            document.querySelectorAll('.listing-card-button').forEach(c => c.onclick = () => openModal(c));
            [...closeBtns, backdrop].forEach(el => el.onclick = () => { modal.classList.remove('open'); document.body.classList.remove('modal-open'); });
        })();
    </script>
</asp:Content>