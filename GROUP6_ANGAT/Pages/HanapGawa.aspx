<%@ Page Title="Hanap Gawa" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="HanapGawa.aspx.cs" Inherits="GROUP6_ANGAT.Pages.HanapGawa" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    
    <div id="page-hero">
        <div class="hero-circles">
            <div class="c1"></div>
            <div class="c2"></div>
        </div>
        <div class="page-hero-inner">
            <span class="hero-badge"><i class='bx bx-wrench'></i> Services Board</span>
            <h2>Hanap <strong>Gawa</strong></h2>
            <p class="hero-desc">
                Kailangan mo ba ng tubero, karpintero, o electrician? O gusto mong mag-alok ng iyong kasanayan? Dito direktang nag-uugnay ang mga manggagawa at kustomer.
            </p>
        </div>
        <div class="wave">
            <svg viewBox="0 0 1440 80" xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="none">
                <path d="M0,80 L1440,80 L1440,80 L0,80 Z" fill="#ffffff"/>
            </svg>
        </div>
    </div>

    <div class="page-quick">
        <div class="quick-card">
            <div class="quick-icon"><i class='bx bx-check-shield'></i></div>
            <div>
                <h5>Verified Skills</h5>
                <p>Mga manggagawa na may malinaw na kasanayan at karanasan.</p>
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
                    <option value="Karpintero">Karpintero (Carpentry)</option>
                    <option value="Tubero">Tubero (Plumbing)</option>
                    <option value="Electrician">Electrician</option>
                    <option value="Aircon">Appliance Repair</option>
                    <option value="Mananahi">Pananahi / Tailoring</option>
                    <option value="General">General</option>
                </select>
            </div>
            <button id="hgFilterBtn" class="search-btn" type="button">Hanapin</button>
        </div>
    </div>

    <div class="section section-white" style="padding-top: 40px;">
        <div class="section-header left" style="display: flex; justify-content: space-between; align-items: flex-end;">
            <div>
                <h3>Mga Magagaling na <span>Manggagawa</span></h3>
                <p class="section-sub">Direktang makipag-ugnayan sa mga skilled workers ng Biñan.</p>
            </div>
            <div style="display:flex; gap: 10px; align-items: center;">
                <a runat="server" href="~/Pages/PostService.aspx" class="btn-outline" style="padding: 8px 16px;">
                    <i class='bx bx-plus'></i> I-post ang Iyong Serbisyo
                </a>
                <select id="hgSort" style="padding: 8px 16px; border-radius: 8px; border: 1px solid #e2e8f0; outline:none; font-family: inherit;">
                    <option value="newest">Pinakabago</option>
                    <option value="rate">Pinakamataas na Rate</option>
                </select>
            </div>
        </div>
        
        <asp:Panel ID="pnlServiceApplyMessage" runat="server" CssClass="form-alert" Visible="false" ClientIDMode="Static">
            <asp:Label ID="lblServiceApplyMessage" runat="server" />
        </asp:Panel>

        <div id="hgListings" class="listings-grid">
            <asp:Repeater ID="rptServices" runat="server">
                <ItemTemplate>
                    <button type="button" class="listing-card listing-card-button"
                        data-serviceid='<%# Eval("ServiceId") %>'
                        data-category='<%# Eval("Category") %>'
                        data-search='<%# GetSearchText(Eval("ServiceTitle"), Eval("ServiceLocation"), Eval("ServiceTags"), Eval("Barangay"), Eval("Category")) %>'
                        data-title='<%# Eval("ServiceTitle") %>'
                        data-rate='<%# GetRateDisplay(Eval("ServiceRate")) %>'
                        data-rate-amount='<%# GetRateSortValue(Eval("ServiceRate")) %>'
                        data-posted='<%# GetPostedValue(Eval("PostedAt")) %>'
                        data-tags='<%# Eval("ServiceTags") %>'
                        data-status='<%# Eval("Status") %>'
                        data-date='<%# Eval("DateLabel") %>'
                        data-desc='<%# Eval("ServiceDescription") %>'>
                        <div class="listing-top">
                            <div class="listing-icon" data-icon-color='<%# Eval("IconColor") %>' data-icon-bg='<%# Eval("IconBg") %>'>
                                <i class='<%# Eval("IconClass") %>'></i>
                            </div>
                            <span class='badge <%# GetStatusClass(Eval("Status")) %>'><%# Eval("Status") %></span>
                        </div>
                        <h4><%# Eval("ServiceTitle") %></h4>
                        <p class="listing-company"><i class='bx bx-map'></i> <%# Eval("ServiceLocation") %></p>
                        <div class="listing-tags">
                            <asp:Literal ID="litServiceTags" runat="server" Mode="PassThrough" Text='<%# GetTagsHtml(Eval("ServiceTags"), Eval("Category")) %>' />
                        </div>
                        <div class="listing-footer">
                            <span class="listing-pay" style="font-size: 0.9rem;"><i class='bx bx-money'></i> <%# GetRateDisplay(Eval("ServiceRate")) %></span>
                            <span class="listing-date" style="color: #475569;"><%# Eval("DateLabel") %></span>
                        </div>
                    </button>
                </ItemTemplate>
            </asp:Repeater>
        </div>
        
        <div style="text-align:center; margin-top: 40px;">
            <button class="btn-outline js-coming-soon" data-msg="Wala pang dagdag na manggagawa ngayon.">Mag-load ng iba pang manggagawa <i class='bx bx-chevron-down'></i></button>
        </div>
    </div>

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
            <div id="serviceTags" class="job-tags"></div>
            <p id="serviceDesc" class="job-desc"></p>
            <div class="job-modal-actions">
                <asp:PlaceHolder ID="phServiceLoggedIn" runat="server">
                    <asp:Button ID="btnRequestService" runat="server" Text="Mag-request" CssClass="btn-green" OnClick="BtnRequestService_Click" />
                </asp:PlaceHolder>
                <asp:PlaceHolder ID="phServiceLoggedOut" runat="server" Visible="false">
                    <a runat="server" href="~/Pages/Login.aspx?returnUrl=/Pages/HanapGawa.aspx" class="btn-green">Mag-login para mag-request</a>
                </asp:PlaceHolder>
                <button type="button" class="btn-outline job-modal-close">Isara</button>
            </div>
        </div>
    </div>

    <asp:HiddenField ID="hfServiceId" runat="server" />
    <asp:HiddenField ID="hfServiceTitle" runat="server" />
    <asp:HiddenField ID="hfServiceLocation" runat="server" />
    <asp:HiddenField ID="hfServiceRate" runat="server" />
    <asp:HiddenField ID="hfServiceTags" runat="server" />
    <asp:HiddenField ID="hfServiceDesc" runat="server" />

    <script>
        (function () {
            const searchInput = document.getElementById('hgSearch');
            const categorySelect = document.getElementById('hgCategory');
            const filterBtn = document.getElementById('hgFilterBtn');
            const sortSelect = document.getElementById('hgSort');
            const cards = Array.from(document.querySelectorAll('#hgListings .listing-card'));
            const listingWrap = document.getElementById('hgListings');
            const icons = Array.from(document.querySelectorAll('#hgListings .listing-icon'));

            icons.forEach(icon => {
                const color = icon.dataset.iconColor;
                const bg = icon.dataset.iconBg;
                if (color) {
                    icon.style.color = color;
                }
                if (bg) {
                    icon.style.background = bg;
                }
            });

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

            function applySort() {
                const mode = sortSelect.value;
                const sorted = cards.slice().sort((a, b) => {
                    if (mode === 'rate') {
                        const aVal = parseFloat(a.dataset.rateAmount || '0');
                        const bVal = parseFloat(b.dataset.rateAmount || '0');
                        return bVal - aVal;
                    }
                    const postA = parseFloat(a.dataset.posted || '0');
                    const postB = parseFloat(b.dataset.posted || '0');
                    return postB - postA;
                });
                sorted.forEach(card => listingWrap.appendChild(card));
            }

            filterBtn.addEventListener('click', applyFilter);
            searchInput.addEventListener('keyup', applyFilter);
            categorySelect.addEventListener('change', applyFilter);
            sortSelect.addEventListener('change', () => {
                applySort();
                applyFilter();
            });
        })();

        (function () {
            const modal = document.getElementById('serviceModal');
            const modalBackdrop = modal.querySelector('.job-modal-backdrop');
            const closeButtons = modal.querySelectorAll('.job-modal-close');
            const serviceTitle = document.getElementById('serviceTitle');
            const serviceLocation = document.getElementById('serviceLocation');
            const serviceStatus = document.getElementById('serviceStatus');
            const serviceDate = document.getElementById('serviceDate');
            const serviceTags = document.getElementById('serviceTags');
            const serviceDesc = document.getElementById('serviceDesc');
            const hfServiceId = document.getElementById('<%= hfServiceId.ClientID %>');
            const hfServiceTitle = document.getElementById('<%= hfServiceTitle.ClientID %>');
            const hfServiceLocation = document.getElementById('<%= hfServiceLocation.ClientID %>');
            const hfServiceRate = document.getElementById('<%= hfServiceRate.ClientID %>');
            const hfServiceTags = document.getElementById('<%= hfServiceTags.ClientID %>');
            const hfServiceDesc = document.getElementById('<%= hfServiceDesc.ClientID %>');

            function openModal(card) {
                serviceTitle.textContent = card.dataset.title || '';
                serviceLocation.textContent = card.querySelector('.listing-company') ? card.querySelector('.listing-company').innerText : '';
                serviceStatus.textContent = card.dataset.status || '';
                serviceDate.textContent = card.dataset.date || '';
                serviceDesc.textContent = card.dataset.desc || '';

                serviceTags.innerHTML = '';
                const tags = (card.dataset.tags || '').split('|').filter(Boolean);
                tags.forEach(tag => {
                    const span = document.createElement('span');
                    span.className = 'badge badge-teal';
                    span.textContent = tag;
                    serviceTags.appendChild(span);
                });

                hfServiceId.value = card.dataset.serviceid || '';
                hfServiceTitle.value = card.dataset.title || '';
                hfServiceLocation.value = serviceLocation.textContent || '';
                hfServiceRate.value = card.dataset.rate || '';
                hfServiceTags.value = (card.dataset.tags || '').replace(/\|/g, ', ');
                hfServiceDesc.value = card.dataset.desc || '';

                modal.classList.add('open');
                document.body.style.overflow = 'hidden';
            }

            function closeModal() {
                modal.classList.remove('open');
                document.body.style.overflow = '';
            }

            document.querySelectorAll('#hgListings .listing-card-button').forEach(card => {
                card.addEventListener('click', () => openModal(card));
            });

            closeButtons.forEach(btn => btn.addEventListener('click', closeModal));
            modalBackdrop.addEventListener('click', closeModal);
            document.addEventListener('keydown', (e) => {
                if (e.key === 'Escape' && modal.classList.contains('open')) {
                    closeModal();
                }
            });
        })();
    </script>
</asp:Content>
