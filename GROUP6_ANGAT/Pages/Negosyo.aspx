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
                    <button type="button" class="listing-card listing-card-button"
                       data-name='<%# EncodeAttr(Eval("BusinessName")) %>'
                       data-category='<%# EncodeAttr(Eval("Category")) %>'
                       data-status='<%# EncodeAttr(Eval("Status")) %>'
                       data-address='<%# EncodeAttr(GetAddressValue(Eval("AddressLine"), Eval("Barangay"))) %>'
                       data-contact='<%# EncodeAttr(Eval("ContactNumber")) %>'
                       data-map='<%# EncodeAttr(Eval("MapEmbedUrl")) %>'
                       data-owner='<%# EncodeAttr(Eval("OwnerDisplay")) %>'
                       data-icon-class='<%# EncodeAttr(GetCategoryIconClass(Eval("Category"))) %>'
                       data-icon-style='<%# EncodeAttr(GetCategoryIconStyle(Eval("Category"))) %>'
                       data-badge-class='<%# EncodeAttr(GetCategoryBadgeClass(Eval("Category"))) %>'
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
                    </button>
                </ItemTemplate>
            </asp:Repeater>
        </div>
        
        <div style="text-align:center; margin-top: 40px;">
            <button class="btn-outline js-coming-soon" data-msg="Wala pang dagdag na negosyo ngayon.">Mag-load ng iba pang negosyo <i class='bx bx-chevron-down'></i></button>
        </div>
    </div>

    <%-- BUSINESS MODAL --%>
    <div id="businessModal" class="job-modal">
        <div class="job-modal-backdrop"></div>
        <div class="job-modal-card">
            <button type="button" class="job-modal-close job-modal-close-icon" aria-label="Isara">✕</button>

            <div class="job-modal-header">
                <div id="bizIcon" class="listing-icon" style="margin-right:6px;">
                    <i id="bizIconI" class='bx'></i>
                </div>
                <div>
                    <h4 id="bizName" style="margin:0;"></h4>
                    <span id="bizCategory" class="badge"></span>
                </div>
            </div>

            <p id="bizOwner" class="job-meta"></p>

            <div class="modal-info-grid">
                <div class="modal-info-item">
                    <span class="modal-info-label">Address</span>
                    <span class="modal-info-value" id="bizAddress"></span>
                </div>
                <div class="modal-info-item">
                    <span class="modal-info-label">Contact</span>
                    <span class="modal-info-value" id="bizContact"></span>
                </div>
            </div>

            <div class="modal-desc-block">
                <span class="modal-info-label">Google Map</span>
                <div id="bizMapWrap" style="margin-top:8px; border-radius:12px; overflow:hidden; border:1px solid var(--border);">
                    <iframe id="bizMap" title="Business location" loading="lazy"
                        style="width:100%; height:220px; border:0;" allowfullscreen
                        referrerpolicy="no-referrer-when-downgrade"></iframe>
                </div>
                <p id="bizMapEmpty" class="job-meta" style="margin-top:8px;">Walang map link.</p>
            </div>

            <div class="job-modal-actions">
                <button type="button" class="btn-outline job-modal-close">Isara</button>
            </div>
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

        (function () {
            const modal = document.getElementById('businessModal');
            const backdrop = modal.querySelector('.job-modal-backdrop');
            const closeBtns = modal.querySelectorAll('.job-modal-close');
            const mapFrame = modal.querySelector('#bizMap');
            const mapWrap = modal.querySelector('#bizMapWrap');
            const mapEmpty = modal.querySelector('#bizMapEmpty');
            const categoryBadge = modal.querySelector('#bizCategory');
            const iconWrap = modal.querySelector('#bizIcon');
            const iconI = modal.querySelector('#bizIconI');

            function buildEmbedUrl(mapUrl, address) {
                const addr = (address || '').trim();
                const fallback = addr
                    ? 'https://www.google.com/maps?q=' + encodeURIComponent(addr) + '&output=embed'
                    : '';

                const raw = (mapUrl || '').trim();
                if (!raw) return fallback;

                let url;
                try {
                    url = new URL(raw, window.location.origin);
                } catch (e) {
                    return fallback;
                }

                const host = url.hostname.toLowerCase();
                const allowed = url.protocol === 'https:' && (
                    host.endsWith('google.com') ||
                    host.endsWith('google.com.ph') ||
                    host === 'maps.google.com' ||
                    host === 'maps.app.goo.gl' ||
                    host === 'goo.gl'
                );

                if (!allowed) return fallback;

                const rawLower = raw.toLowerCase();
                if (rawLower.includes('/maps/embed') || rawLower.includes('output=embed')) {
                    return raw;
                }

                if (addr) return fallback;

                if (rawLower.includes('/maps')) {
                    const joiner = raw.includes('?') ? '&' : '?';
                    return raw + joiner + 'output=embed';
                }

                return raw;
            }

            function openModal(card) {
                modal.querySelector('#bizName').textContent = card.dataset.name || '';
                modal.querySelector('#bizOwner').textContent = card.dataset.owner ? ('Owner: ' + card.dataset.owner) : 'Owner: N/A';
                modal.querySelector('#bizAddress').textContent = card.dataset.address || 'Biñan';
                modal.querySelector('#bizContact').textContent = card.dataset.contact || 'Walang contact number';

                const category = card.dataset.category || '';
                categoryBadge.textContent = category;
                categoryBadge.className = 'badge ' + (card.dataset.badgeClass || 'badge-teal');

                iconWrap.style.cssText = card.dataset.iconStyle || '';
                iconI.className = 'bx ' + (card.dataset.iconClass || 'bx-store');

                const mapUrl = card.dataset.map || '';
                const embedUrl = buildEmbedUrl(mapUrl, card.dataset.address || '');
                if (embedUrl) {
                    mapFrame.src = embedUrl;
                    mapWrap.style.display = '';
                    mapEmpty.style.display = 'none';
                } else {
                    mapFrame.src = '';
                    mapWrap.style.display = 'none';
                    mapEmpty.style.display = '';
                }

                modal.classList.add('open');
                document.body.classList.add('modal-open');
            }

            function closeModal() {
                modal.classList.remove('open');
                document.body.classList.remove('modal-open');
                mapFrame.src = '';
            }

            document.querySelectorAll('#dirListings .listing-card-button').forEach(function (card) {
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
