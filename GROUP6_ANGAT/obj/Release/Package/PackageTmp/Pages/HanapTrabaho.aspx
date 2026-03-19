<%@ Page Title="Hanap Trabaho" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="HanapTrabaho.aspx.cs" Inherits="GROUP6_ANGAT.Pages.HanapTrabaho" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    
    <div id="page-hero">
        <div class="hero-circles">
            <div class="c1"></div>
            <div class="c2"></div>
        </div>
        <div class="page-hero-inner">
            <span class="hero-badge"><i class='bx bx-briefcase'></i> Job Board</span>
            <h2>Hanap <strong>Trabaho</strong></h2>
            <p class="hero-desc">
                Tingnan ang mga bakanteng posisyon mula sa mga employer at negosyante dito sa Biñan. Mag-apply nang direkta at magsimulang kumita.
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
            <div class="quick-icon"><i class='bx bx-briefcase'></i></div>
            <div>
                <h5>120+ Jobs</h5>
                <p>Pinakabagong opportunities sa bawat barangay.</p>
            </div>
        </div>
        <div class="quick-card">
            <div class="quick-icon"><i class='bx bx-check-circle'></i></div>
            <div>
                <h5>Madaling Apply</h5>
                <p>Diretsong contact at mabilis na process.</p>
            </div>
        </div>
        <div class="quick-card">
            <div class="quick-icon"><i class='bx bx-refresh'></i></div>
            <div>
                <h5>Regular Updates</h5>
                <p>Updated listings linggo-linggo.</p>
            </div>
        </div>
    </div>

    <div id="search-bar" style="margin-top: 24px;">
        <div class="search-box">
            <div class="search-field">
                <span class="s-icon"><i class='bx bx-search'></i></span>
                <input id="htSearch" type="text" placeholder="Anong trabaho ang hanap mo?" />
            </div>
            <div class="search-field">
                <span class="s-icon"><i class='bx bx-map'></i></span>
                <select id="htLocation">
                    <option value="All">Kahit Saan (Biñan)</option>
                    <option value="Dela Paz">Brgy. Dela Paz</option>
                    <option value="Canlalay">Brgy. Canlalay</option>
                    <option value="Platero">Brgy. Platero</option>
                    <option value="San Antonio">Brgy. San Antonio</option>
                </select>
            </div>
            <button id="htFilterBtn" class="search-btn" type="button">Maghanap</button>
        </div>
    </div>

    <div class="section section-light" style="padding-top: 40px;">
        <div class="section-header left" style="display: flex; justify-content: space-between; align-items: flex-end;">
            <div>
                <h3>Mga Bakanteng <span>Trabaho</span></h3>
                <p class="section-sub">Mayroong 120+ na available na trabaho ngayon.</p>
            </div>
            <div style="display:flex; gap: 10px; align-items: center;">
                <a runat="server" href="~/Pages/PostJob.aspx" class="btn-outline" style="padding: 8px 16px;">
                    <i class='bx bx-plus'></i> I-post ang Trabaho
                </a>
                <select id="htSort" style="padding: 8px 16px; border-radius: 8px; border: 1px solid #e2e8f0; outline:none; font-family: inherit;">
                    <option value="newest">Pinakabago</option>
                    <option value="pay">Pinakamataas na Sahod</option>
                </select>
            </div>
        </div>

        <asp:Panel ID="pnlApplyMessage" runat="server" CssClass="form-alert" Visible="false" ClientIDMode="Static">
            <asp:Label ID="lblApplyMessage" runat="server" />
        </asp:Panel>
        
        <div id="htListings" class="listings-grid">
            <asp:Repeater ID="rptJobs" runat="server">
                <ItemTemplate>
                    <button type="button" class="listing-card listing-card-button"
                        data-jobid='<%# Eval("JobId") %>'
                        data-location='<%# Eval("Barangay") %>'
                        data-search='<%# GetSearchText(Eval("JobTitle"), Eval("JobLocation"), Eval("JobTags"), Eval("Barangay"), Eval("Category")) %>'
                        data-title='<%# Eval("JobTitle") %>'
                        data-pay='<%# GetPayDisplay(Eval("JobPay")) %>'
                        data-pay-amount='<%# GetPaySortValue(Eval("JobPay")) %>'
                        data-posted='<%# GetPostedValue(Eval("PostedAt")) %>'
                        data-tags='<%# Eval("JobTags") %>'
                        data-status='<%# Eval("Status") %>'
                        data-date='<%# Eval("DateLabel") %>'
                        data-desc='<%# Eval("JobDescription") %>'>
                        <div class="listing-top">
                            <div class="listing-icon" data-icon-color='<%# Eval("IconColor") %>' data-icon-bg='<%# Eval("IconBg") %>'>
                                <i class='<%# Eval("IconClass") %>'></i>
                            </div>
                            <span class='badge <%# GetStatusClass(Eval("Status")) %>'><%# Eval("Status") %></span>
                        </div>
                        <h4><%# Eval("JobTitle") %></h4>
                        <p class="listing-company"><i class='bx bx-map'></i> <%# Eval("JobLocation") %></p>
                        <div class="listing-tags">
                            <asp:Literal ID="litTags" runat="server" Mode="PassThrough" Text='<%# GetTagsHtml(Eval("JobTags"), Eval("Category")) %>' />
                        </div>
                        <div class="listing-footer">
                            <span class="listing-pay"><%# GetPayDisplay(Eval("JobPay")) %></span>
                            <span class="listing-date"><%# Eval("DateLabel") %></span>
                        </div>
                    </button>
                </ItemTemplate>
            </asp:Repeater>
        </div>
        
        <div style="text-align:center; margin-top: 40px;">
            <button class="btn-outline js-coming-soon" data-msg="Wala pang dagdag na trabaho ngayon.">Mag-load ng iba pang trabaho <i class='bx bx-chevron-down'></i></button>
        </div>
    </div>

    <div id="jobModal" class="job-modal">
        <div class="job-modal-backdrop"></div>
        <div class="job-modal-card">
            <button type="button" class="job-modal-close job-modal-close-icon" aria-label="Isara">✕</button>
            <div class="job-modal-header">
                <span id="jobStatus" class="badge badge-green"></span>
                <span id="jobDate" class="job-meta"></span>
            </div>
            <h4 id="jobTitle"></h4>
            <p id="jobLocation" class="job-location"></p>
            <div id="jobTags" class="job-tags"></div>
            <p id="jobDesc" class="job-desc"></p>
            <div class="job-modal-actions">
                <asp:PlaceHolder ID="phApplyLoggedIn" runat="server">
                    <asp:Button ID="btnApplyJob" runat="server" Text="Mag-apply" CssClass="btn-green" OnClick="BtnApplyJob_Click" />
                </asp:PlaceHolder>
                <asp:PlaceHolder ID="phApplyLoggedOut" runat="server" Visible="false">
                    <a runat="server" href="~/Pages/Login.aspx?returnUrl=/Pages/HanapTrabaho.aspx" class="btn-green">Mag-login para mag-apply</a>
                </asp:PlaceHolder>
                <button type="button" class="btn-outline job-modal-close">Isara</button>
            </div>
        </div>
    </div>

    <asp:HiddenField ID="hfJobId" runat="server" />
    <asp:HiddenField ID="hfJobTitle" runat="server" />
    <asp:HiddenField ID="hfJobLocation" runat="server" />
    <asp:HiddenField ID="hfJobPay" runat="server" />
    <asp:HiddenField ID="hfJobTags" runat="server" />
    <asp:HiddenField ID="hfJobDesc" runat="server" />

    <script>
        (function () {
            const searchInput = document.getElementById('htSearch');
            const locationSelect = document.getElementById('htLocation');
            const filterBtn = document.getElementById('htFilterBtn');
            const sortSelect = document.getElementById('htSort');
            const cards = Array.from(document.querySelectorAll('#htListings .listing-card'));
            const listingWrap = document.getElementById('htListings');
            const icons = Array.from(document.querySelectorAll('#htListings .listing-icon'));

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
                const loc = locationSelect.value;

                cards.forEach(card => {
                    const text = (card.dataset.search || '').toLowerCase();
                    const location = card.dataset.location || '';
                    const matchQ = !q || text.includes(q);
                    const matchLoc = loc === 'All' || location === loc || (loc === 'All' && location === 'Biñan');
                    card.style.display = (matchQ && matchLoc) ? '' : 'none';
                });
            }

            function applySort() {
                const mode = sortSelect.value;
                const sorted = cards.slice().sort((a, b) => {
                    if (mode === 'pay') {
                        const payA = parseFloat(a.dataset.payAmount || '0');
                        const payB = parseFloat(b.dataset.payAmount || '0');
                        return payB - payA;
                    }
                    const postA = parseFloat(a.dataset.posted || '0');
                    const postB = parseFloat(b.dataset.posted || '0');
                    return postB - postA;
                });

                sorted.forEach(card => listingWrap.appendChild(card));
            }

            filterBtn.addEventListener('click', applyFilter);
            searchInput.addEventListener('keyup', applyFilter);
            locationSelect.addEventListener('change', applyFilter);
            sortSelect.addEventListener('change', () => {
                applySort();
                applyFilter();
            });
        })();

        (function () {
            const modal = document.getElementById('jobModal');
            const modalBackdrop = modal.querySelector('.job-modal-backdrop');
            const closeButtons = modal.querySelectorAll('.job-modal-close');
            const jobTitle = document.getElementById('jobTitle');
            const jobLocation = document.getElementById('jobLocation');
            const jobStatus = document.getElementById('jobStatus');
            const jobDate = document.getElementById('jobDate');
            const jobTags = document.getElementById('jobTags');
            const jobDesc = document.getElementById('jobDesc');
            const hfJobId = document.getElementById('<%= hfJobId.ClientID %>');
            const hfJobTitle = document.getElementById('<%= hfJobTitle.ClientID %>');
            const hfJobLocation = document.getElementById('<%= hfJobLocation.ClientID %>');
            const hfJobPay = document.getElementById('<%= hfJobPay.ClientID %>');
            const hfJobTags = document.getElementById('<%= hfJobTags.ClientID %>');
            const hfJobDesc = document.getElementById('<%= hfJobDesc.ClientID %>');

            function openModal(card) {
                jobTitle.textContent = card.dataset.title || '';
                jobLocation.textContent = card.querySelector('.listing-company') ? card.querySelector('.listing-company').innerText : '';
                jobStatus.textContent = card.dataset.status || '';
                jobDate.textContent = card.dataset.date || '';
                jobDesc.textContent = card.dataset.desc || '';

                jobTags.innerHTML = '';
                const tags = (card.dataset.tags || '').split('|').filter(Boolean);
                tags.forEach(tag => {
                    const span = document.createElement('span');
                    span.className = 'badge badge-teal';
                    span.textContent = tag;
                    jobTags.appendChild(span);
                });

                hfJobId.value = card.dataset.jobid || '';
                hfJobTitle.value = card.dataset.title || '';
                hfJobLocation.value = jobLocation.textContent || '';
                hfJobPay.value = card.dataset.pay || '';
                hfJobTags.value = (card.dataset.tags || '').replace(/\|/g, ', ');
                hfJobDesc.value = card.dataset.desc || '';

                modal.classList.add('open');
                document.body.style.overflow = 'hidden';
            }

            function closeModal() {
                modal.classList.remove('open');
                document.body.style.overflow = '';
            }

            document.querySelectorAll('#htListings .listing-card-button').forEach(card => {
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
