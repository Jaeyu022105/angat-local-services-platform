<%@ Page Title="Hanap Trabaho" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="HanapTrabaho.aspx.cs" Inherits="GROUP6_ANGAT.Pages.HanapTrabaho" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <%-- PAGE HERO --%>
    <div id="page-hero">
        <div class="hero-circles">
            <div class="c1"></div>
            <div class="c2"></div>
        </div>
        <div class="page-hero-inner">
            <span class="hero-badge"><i class='bx bx-briefcase'></i> Job Board</span>
            <h2>Hanap <strong>Trabaho</strong></h2>
            <p class="hero-desc">
                Tingnan ang mga bakanteng posisyon mula sa mga employer sa Biñan.
                Mag-apply nang direkta at magsimulang kumita.
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
            <div class="quick-icon"><i class='bx bx-briefcase'></i></div>
            <div>
                <h5><asp:Label ID="lblJobCount" runat="server" Text="0" /> Trabaho</h5>
                <p>Available na ngayon sa Biñan.</p>
            </div>
        </div>
        <div class="quick-card">
            <div class="quick-icon"><i class='bx bx-check-circle'></i></div>
            <div>
                <h5>Madaling Apply</h5>
                <p>Isang click lang para mag-apply.</p>
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
                <input id="htSearch" type="text" placeholder="Anong trabaho ang hanap mo?" />
            </div>
            <div class="search-field">
                <span class="s-icon"><i class='bx bx-map'></i></span>
                <select id="htLocation">
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
            <button id="htFilterBtn" class="search-btn" type="button">Maghanap</button>
        </div>
    </div>

    <%-- LISTINGS SECTION --%>
        <div class="section-header left" style="display:flex; justify-content:space-between; align-items:flex-end; flex-wrap:wrap; gap:12px;">
            <div>
                <h3>Mga Bakanteng <span>Trabaho</span></h3>
                <p class="section-sub">Pinakabagong mga trabaho mula sa ating lungsod.</p>
            </div>
            <div style="display:flex; gap:10px; align-items:center; flex-wrap:wrap;">
                <asp:PlaceHolder ID="phPostJobBtn" runat="server">
                    <a runat="server" href="~/Pages/PostJob.aspx" class="btn-outline" style="padding:8px 16px;">
                        <i class='bx bx-plus'></i> I-post ang Trabaho
                    </a>
                </asp:PlaceHolder>
                <select id="htSort" style="padding:12px 16px; border-radius:8px; border:1px solid var(--border); outline:none; font-family:inherit; font-size:0.88rem;">
                    <option value="newest">Pinakabago</option>
                    <option value="pay">Pinakamataas na Sahod</option>
                </select>
            </div>
        </div>

        <%-- Alert message --%>
        <asp:Panel ID="pnlApplyMessage" runat="server" CssClass="form-alert" Visible="false" ClientIDMode="Static">
            <asp:Label ID="lblApplyMessage" runat="server" />
        </asp:Panel>

        <%-- Job cards --%>
        <div id="htListings" class="listings-grid">
            <asp:Repeater ID="rptJobs" runat="server">
                <ItemTemplate>
                    <button type="button" class="listing-card listing-card-button"
                        data-jobid='<%# Eval("JobId") %>'
                        data-location='<%# Eval("Barangay") %>'
                        data-search='<%# GROUP6_ANGAT.DisplayHelper.GetSearchText(Eval("JobTitle"), Eval("Tags"), Eval("Barangay"), Eval("Category")) %>'
                        data-title='<%# Eval("JobTitle") %>'
                        data-pay='<%# GROUP6_ANGAT.DisplayHelper.GetPayDisplay(Eval("PayMin"), Eval("PayMax"), Eval("PayRate")) %>'
                        data-pay-amount='<%# Eval("PayMax") ?? Eval("PayMin") ?? 0 %>'
                        data-posted='<%# GROUP6_ANGAT.DisplayHelper.GetPostedValue(Eval("PostedAt")) %>'
                        data-tags='<%# Eval("Tags") %>'
                        data-status='<%# Eval("Status") %>'
                        data-date='<%# GetRelativeTime(Eval("PostedAt")) %>'
                        data-desc='<%# Eval("JobDescription") %>'
                        data-poster='<%# Eval("PosterName") %>'
                        data-poster-img='<%# Eval("PosterImage") %>'
                        data-slots='<%# Eval("Slots") %>'
                        data-exact-date='<%# Eval("PostedAt") != DBNull.Value ? Convert.ToDateTime(Eval("PostedAt")).ToString("MMMM dd, yyyy") : "" %>'>
                        <div class="listing-top">
                            <div class="listing-icon" data-category='<%# Eval("Category") %>'>
                                <i></i>
                            </div>
                            <span class='badge <%# GROUP6_ANGAT.DisplayHelper.GetStatusClass(Eval("Status")) %>'><%# Eval("Status") %></span>
                        </div>
                        <h4><%# Eval("JobTitle") %></h4>
                        <p class="listing-company">
                            <i class='bx bx-map'></i> Brgy. <%# Eval("Barangay") %>, Biñan
                        </p>
                        <div class="listing-tags">
                            <asp:Literal ID="litTags" runat="server" Mode="PassThrough"
                                Text='<%# GROUP6_ANGAT.DisplayHelper.GetTagsHtml(Eval("Tags"), Eval("Category")) %>' />
                        </div>
                        <div class="listing-footer">
                            <span class="listing-pay"><%# GROUP6_ANGAT.DisplayHelper.GetPayDisplay(Eval("PayMin"), Eval("PayMax"), Eval("PayRate")) %></span>
                            <span><i class='bx bx-time-five'></i> <%# GetRelativeTime(Eval("PostedAt")) %></span>                    
                        </button>
                </ItemTemplate>
            </asp:Repeater>
        </div>

        <%-- Empty state --%>
        <asp:Panel ID="pnlEmpty" runat="server" Visible="false" CssClass="empty-state">
            <i class='bx bx-briefcase-alt'></i>
            <h4>Walang trabaho sa ngayon</h4>
            <p>Subukan ulit mamaya o mag-post ng trabaho.</p>
        </asp:Panel>

    </div>

    <%-- JOB MODAL --%>
    <div id="jobModal" class="job-modal">
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
            <h4 id="jobTitle"></h4>

            <%-- Info grid --%>
            <div class="modal-info-grid">
                <div class="modal-info-item">
                    <span class="modal-info-label">Lokasyon</span>
                    <span class="modal-info-value" id="jobLocation"></span>
                </div>
                <div class="modal-info-item">
                    <span class="modal-info-label">Uri ng Trabaho</span>
                    <div id="jobTags" class="job-tags" style="margin:0;"></div>
                </div>
                <div class="modal-info-item">
                    <span class="modal-info-label">Sahod</span>
                    <span class="modal-info-value" id="jobPay"></span>
                </div>
                <div class="modal-info-item">
                    <span class="modal-info-label">Status</span>
                    <span id="jobStatus" class="badge badge-green"></span>
                </div>
                <div class="modal-info-item">
                    <span class="modal-info-label">Slots Natitira</span>
                    <span class="modal-info-value" id="jobSlots"></span>
                </div>
            </div>

            <%-- Description --%>
            <div class="modal-desc-block">
                <span class="modal-info-label">Detalye ng Trabaho</span>
                <p id="jobDesc" class="job-desc" style="margin-top:8px;"></p>
            </div>

            <%-- Actions --%>
            <div class="job-modal-actions">
                <asp:PlaceHolder ID="phApplyLoggedIn" runat="server">
                    <asp:Button ID="btnApplyJob" runat="server" Text="Mag-apply" CssClass="btn-green" OnClick="BtnApplyJob_Click" />
                </asp:PlaceHolder>
                <asp:PlaceHolder ID="phApplyLoggedOut" runat="server" Visible="false">
                    <a runat="server" href="~/Pages/Login.aspx?returnUrl=/Pages/HanapTrabaho.aspx" class="btn-green">
                        Mag-login para mag-apply
                    </a>
                </asp:PlaceHolder>
            </div>
        </div>
    </div>

    <%-- Hidden fields for apply --%>
    <asp:HiddenField ID="hfJobId" runat="server" />
    <asp:HiddenField ID="hfJobTitle" runat="server" />
    <asp:HiddenField ID="hfJobTags" runat="server" />
    <asp:HiddenField ID="hfJobDesc" runat="server" />

    <script>
        // ── FILTER & SORT ──
        (function () {
            const searchInput   = document.getElementById('htSearch');
            const locationSelect = document.getElementById('htLocation');
            const filterBtn     = document.getElementById('htFilterBtn');
            const sortSelect    = document.getElementById('htSort');
            const listingWrap   = document.getElementById('htListings');
            const cards         = Array.from(listingWrap.querySelectorAll('.listing-card'));

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
                    if (mode === 'pay') {
                        return parseFloat(b.dataset.payAmount || 0) - parseFloat(a.dataset.payAmount || 0);
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
            const modal       = document.getElementById('jobModal');
            const backdrop    = modal.querySelector('.job-modal-backdrop');
            const closeBtns   = modal.querySelectorAll('.job-modal-close');
            const hfJobId     = document.getElementById('<%= hfJobId.ClientID %>');
            const hfJobTitle  = document.getElementById('<%= hfJobTitle.ClientID %>');
            const hfJobTags   = document.getElementById('<%= hfJobTags.ClientID %>');
            const hfJobDesc   = document.getElementById('<%= hfJobDesc.ClientID %>');

            function openModal(card) {
                modal.querySelector('#jobTitle').textContent  = card.dataset.title  || '';
                modal.querySelector('#jobStatus').textContent = card.dataset.status || '';
                modal.querySelector('#jobDesc').textContent   = card.dataset.desc   || '';
                modal.querySelector('#jobPay').textContent    = card.dataset.pay    || '';
                modal.querySelector('#posterName').textContent = card.dataset.poster || 'Hindi nakita';
                modal.querySelector('#posterDate').textContent = 'Na-post: ' + (card.dataset.exactDate || '');
                modal.querySelector('#jobLocation').textContent = 'Brgy. ' + (card.dataset.location || '') + ', Biñan';
                modal.querySelector('#jobSlots').textContent = (card.dataset.slots || '1') + ' slot/s';

                var img = modal.querySelector('#posterImg');
                var imgPath = card.dataset.posterImg || '';
                img.src = imgPath && imgPath !== '' ? imgPath : '/Images/default-icon.jpg';

                // tags
                var tagsEl = modal.querySelector('#jobTags');
                tagsEl.innerHTML = '';
                (card.dataset.tags || '').split('|').filter(Boolean).forEach(function(tag) {
                    var span = document.createElement('span');
                    span.className = 'badge badge-teal';
                    span.textContent = tag.trim();
                    tagsEl.appendChild(span);
                });

                hfJobId.value    = card.dataset.jobid || '';
                hfJobTitle.value = card.dataset.title || '';
                hfJobTags.value  = (card.dataset.tags || '').replace(/\|/g, ', ');
                hfJobDesc.value  = card.dataset.desc  || '';

                modal.classList.add('open');
                document.body.classList.add('modal-open');
            }

            function closeModal() {
                modal.classList.remove('open');
                document.body.classList.remove('modal-open');
            }

            document.querySelectorAll('#htListings .listing-card-button').forEach(function (card) {
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
