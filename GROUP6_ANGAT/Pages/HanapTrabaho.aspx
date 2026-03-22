<%@ Page Title="Hanap Trabaho" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="HanapTrabaho.aspx.cs" Inherits="GROUP6_ANGAT.Pages.HanapTrabaho" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">


    <%-- PAGE HERO --%>
    <div id="page-hero">
        <div class="hero-circles"><div class="c1"></div><div class="c2"></div></div>
        <div class="page-hero-inner">
            <span class="hero-badge"><i class='bx bx-briefcase'></i> Job Board</span>
            <h2>Hanap <strong>Trabaho</strong></h2>
            <p class="hero-desc">Tingnan ang mga bakanteng posisyon mula sa mga employer sa Bi&#241;an.</p>
        </div>
        <div class="wave"><svg viewBox="0 0 1440 80" preserveAspectRatio="none"><path d="M0,80 L1440,80 L1440,80 L0,80 Z" fill="#ffffff"/></svg></div>
    </div>

    <div class="section section-light" style="padding-top: 40px;">
        
        <%-- QUICK STATS --%>
        <div class="page-quick">
            <div class="quick-card"><div class="quick-icon"><i class='bx bx-briefcase'></i></div><div><h5><asp:Label ID="lblJobCount" runat="server" Text="0" /> Trabaho</h5><p>Available sa Bi&#241;an.</p></div></div>
            <div class="quick-card"><div class="quick-icon"><i class='bx bx-check-circle'></i></div><div><h5>Madaling Apply</h5><p>Isang click lang.</p></div></div>
            <div class="quick-card"><div class="quick-icon"><i class='bx bx-refresh'></i></div><div><h5>Regular Updates</h5><p>Bagong listings.</p></div></div>
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
                <button id="htFilterBtn" class="search-btn" type="button">Maghanap</button>
            </div>
        </div>

        <%-- HEADER --%>
        <div class="section-header left" style="display:flex; justify-content:space-between; align-items:flex-end; flex-wrap:wrap; gap:12px; margin-top:30px;">
            <div>
                <h3>Mga Bakanteng <span>Trabaho</span></h3>
                <p class="section-sub">Pinakabagong mga trabaho mula sa ating lungsod.</p>
            </div>
            <div style="display:flex; gap:10px; align-items:center;">
                <asp:PlaceHolder ID="phPostJobBtn" runat="server">
                    <a href="PostJob.aspx" class="btn-outline" style="padding:8px 16px;"><i class='bx bx-plus'></i> I-post ang Trabaho</a>
                </asp:PlaceHolder>
                <select id="htSort" style="padding:12px 16px; border-radius:8px; border:1px solid #ddd; font-size:0.88rem;">
                    <option value="newest">Pinakabago</option>
                    <option value="pay">Pinakamataas na Sahod</option>
                </select>
            </div>
        </div>

        <%-- PAGE LEVEL ALERT --%>
        <asp:Panel ID="pnlApplyMessage" runat="server" CssClass="form-alert" Visible="false" ClientIDMode="Static" style="margin-bottom:20px;">
            <asp:Label ID="lblApplyMessage" runat="server" />
        </asp:Panel>

        <%-- EMPTY STATE --%>
        <div id="htNoResults" class="empty-state" style="display:none; text-align:center; padding:40px;">
            <i class='bx bx-search' style="font-size:3rem; color:#cbd5e1;"></i>
            <h4>Walang Nahanap</h4>
            <p>Subukan ang ibang keyword o barangay.</p>
        </div>

        <%-- LISTINGS --%>
        <div id="htListings" class="listings-grid">
            <asp:Repeater ID="rptJobs" runat="server">
                <ItemTemplate>
                    <button type="button" class="listing-card listing-card-button"
                        data-jobid='<%# Eval("JobId") %>'
                        data-location='<%# Eval("Barangay") %>'
                        data-title='<%# Eval("JobTitle") %>'
                        data-pay='<%# GROUP6_ANGAT.DisplayHelper.GetPayDisplay(Eval("PayMin"), Eval("PayMax"), Eval("PayRate")) %>'
                        data-pay-amount='<%# Eval("PayMax") ?? Eval("PayMin") ?? 0 %>'
                        data-posted-ticks='<%# Convert.ToDateTime(Eval("PostedAt")).Ticks %>'
                        data-tags='<%# Eval("Tags") %>'
                        data-category='<%# Eval("Category") %>'
                        data-status='<%# Eval("Status") %>'
                        data-date='<%# GetRelativeTime(Eval("PostedAt")) %>'
                        data-desc='<%# Eval("JobDescription") %>'
                        data-poster='<%# Eval("PosterName") %>'
                        data-poster-img='<%# Eval("PosterImage") != DBNull.Value ? Eval("PosterImage") : "" %>'
                        data-slots='<%# Eval("Slots") %>'
                        data-search='<%# GROUP6_ANGAT.DisplayHelper.GetSearchText(Eval("JobTitle"), Eval("Tags"), Eval("Barangay"), Eval("Category")) %>'>
                        
                        <div class="listing-top">
                            <div class="listing-icon" data-category='<%# Eval("Category") %>'><i></i></div>
                            <span class='badge <%# GROUP6_ANGAT.DisplayHelper.GetStatusClass(Eval("Status")) %>'><%# Eval("Status") %></span>
                        </div>
                        <h4><%# Eval("JobTitle") %></h4>
                        <p class="listing-company"><i class='bx bx-map'></i> Brgy. <%# Eval("Barangay") %>, Bi&#241;an</p>
                        <div class="listing-tags"><asp:Literal ID="litTags" runat="server" Text='<%# GROUP6_ANGAT.DisplayHelper.GetTagsHtml(Eval("Tags"), Eval("Category")) %>' /></div>
                        <div class="listing-footer">
                            <span class="listing-pay"><%# GROUP6_ANGAT.DisplayHelper.GetPayDisplay(Eval("PayMin"), Eval("PayMax"), Eval("PayRate")) %></span>
                            <span><i class='bx bx-time-five'></i> <%# GetRelativeTime(Eval("PostedAt")) %></span>
                        </div>
                    </button>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>

    <%-- JOB MODAL --%>
    <div id="jobModal" class="job-modal">
        <div class="job-modal-backdrop"></div>
        <div class="job-modal-card">
            <button type="button" class="job-modal-close job-modal-close-icon">✕</button>
            <div class="modal-poster">
                <img id="posterImg" src="/Images/default-icon.jpg" class="modal-poster-img" style="width:50px; height:50px; border-radius:50%; object-fit:cover;" />
                <div style="display:flex; flex-direction:column; line-height:1.1; margin-left:10px;">
                    <span id="posterName" class="modal-poster-name" style="font-weight:600; font-size:1rem;"></span>
                    <small id="posterDate" class="modal-poster-date" style="color:#64748b; font-size:0.75rem;"></small>
                </div>
            </div>
            <h4 id="jobTitle" style="margin-top:15px; font-weight:700;"></h4>
            <div class="modal-info-grid" style="display: grid; grid-template-columns: 1fr 1fr; gap: 15px; margin-top:15px;">
                <div class="modal-info-item"><span class="modal-info-label">Lokasyon</span><span id="jobLocation" class="modal-info-value"></span></div>
                <div class="modal-info-item"><span class="modal-info-label">Status</span><span id="jobStatus" class="badge"></span></div>
                <div class="modal-info-item"><span class="modal-info-label">Sahod</span><span id="jobPay" class="modal-info-value"></span></div>
                <div class="modal-info-item"><span class="modal-info-label">Slots</span><span id="jobSlots" class="modal-info-value"></span></div>
                <div class="modal-info-item" style="grid-column: span 2;"><span class="modal-info-label">Uri ng Trabaho / Tags</span><div id="modalTags" style="display:flex; flex-wrap:wrap; gap:8px; margin-top:8px;"></div></div>
            </div>
            <div class="modal-desc-block"><span class="modal-info-label">Detalye</span><p id="jobDesc" class="job-desc"></p></div>
            
            <div class="job-modal-actions" style="margin-top:25px;">
                <asp:UpdatePanel ID="upApply" runat="server">
                    <ContentTemplate>
                        <%-- MODAL LEVEL ALERT (NEGOSYO STYLE) --%>
                        <asp:Panel ID="pnlModalAlert" runat="server" CssClass="form-alert" 
                            EnableViewState="false"
                            style="display:none; margin-bottom:15px;" ClientIDMode="Static">
                            <asp:Label ID="lblModalAlert" runat="server" EnableViewState="false" />
                        </asp:Panel>

                        <asp:HiddenField ID="hfJobId" runat="server" ClientIDMode="Static" />
                        
                        <asp:PlaceHolder ID="phApplyLoggedIn" runat="server">
                            <asp:Button ID="btnApplyJob" runat="server" Text="Mag-apply" CssClass="btn-green" OnClick="BtnApplyJob_Click" />
                        </asp:PlaceHolder>
                        
                        <asp:PlaceHolder ID="phApplyLoggedOut" runat="server" Visible="false">
                            <a href="Login.aspx?returnUrl=/Pages/HanapTrabaho.aspx" class="btn-green" style="display:inline-block; text-decoration:none;">Mag-login para mag-apply</a>
                        </asp:PlaceHolder>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>
    </div>

    <script>
        // ── FILTER ENGINE ──
        (function () {
            const searchInput = document.getElementById('htSearch');
            const locationSelect = document.getElementById('htLocation');
            const sortSelect = document.getElementById('htSort');
            const filterBtn = document.getElementById('htFilterBtn');
            const listWrap = document.getElementById('htListings');
            const noResults = document.getElementById('htNoResults');
            const cards = Array.from(document.querySelectorAll('.listing-card-button'));

            function applyFilters() {
                const query = searchInput.value.toLowerCase().trim();
                const location = locationSelect.value;
                const sort = sortSelect.value;

                let visibleCards = cards.filter(card => {
                    const matchSearch = !query || card.dataset.search.toLowerCase().includes(query);
                    const matchLocation = location === 'All' || card.dataset.location === location;
                    const isVisible = matchSearch && matchLocation;
                    card.style.display = isVisible ? '' : 'none';
                    return isVisible;
                });

                visibleCards.sort((a, b) => {
                    if (sort === 'pay') return parseFloat(b.dataset.payAmount) - parseFloat(a.dataset.payAmount);
                    return parseFloat(b.dataset.postedTicks) - parseFloat(a.dataset.postedTicks);
                });

                visibleCards.forEach(card => listWrap.appendChild(card));
                noResults.style.display = visibleCards.length === 0 ? 'block' : 'none';
                updateTagOverflow();
            }

            filterBtn.onclick = applyFilters;
            searchInput.onkeyup = (e) => { if (e.key === 'Enter') applyFilters(); };
            locationSelect.onchange = applyFilters;
            sortSelect.onchange = applyFilters;
        })();

        // ── SYNCED TAG LOGIC (Mirrors DisplayHelper.cs) ──
        function getTagColorClass(tag, category) {
            const t = (tag || "").toLowerCase().trim();
            const cat = (category || "").toLowerCase().trim();
            if (t.includes("urgent")) return "tag-rose";
            if (t.includes("full-time")) return "tag-fulltime";
            if (t.includes("part-time")) return "tag-parttime";
            if (t.includes("weekday") || t.includes("weekend") || t.includes("flexible")) return "tag-blue";
            if (t.includes("experienced") || t.includes("may karanasan") || t.includes("licensed") || t.includes("pisikal") || t.includes("nbi") || t.includes("tools")) return "tag-amber";
            if (cat.includes("kasambahay") || cat.includes("labandera")) return "tag-violet";
            return "tag-teal";
        }

        function updateTagOverflow() {
            document.querySelectorAll('.listing-tags').forEach(container => {
                if (container.closest('.listing-card-button').style.display === 'none') return;
                const badges = Array.from(container.querySelectorAll('.badge:not(.more-badge)'));
                badges.forEach(b => b.style.display = '');
                const old = container.querySelector('.more-badge'); if (old) old.remove();
                if (badges.length === 0) return;
                const top = badges[0].offsetTop; let count = 0;
                badges.forEach(b => { if (b.offsetTop > top) { b.style.display = 'none'; count++; } });
                if (count > 0) {
                    const m = document.createElement('span'); m.className = 'badge more-badge'; m.style.background = '#f1f5f9'; m.innerText = '+' + count; container.appendChild(m);
                }
            });
        }

        // ── CHANGE 1: Helper to clear the modal alert ──
        function clearModalAlert() {
            const modalAlert = document.getElementById('pnlModalAlert');
            if (!modalAlert) return;
            modalAlert.style.display = 'none';
            modalAlert.className = 'form-alert';
            const lbl = modalAlert.querySelector('span');
            if (lbl) lbl.innerHTML = '';
        }

        document.addEventListener('DOMContentLoaded', () => {
            updateTagOverflow();

            // Success banner after posting a job
            const urlParams = new URLSearchParams(window.location.search);
            if (urlParams.get('posted') === 'success') {
                const b = document.getElementById('pnlApplyMessage');
                const lbl = document.getElementById('lblApplyMessage');
                b.style.display = 'block'; b.className = 'form-alert success';
                lbl.innerHTML = "<i class='bx bx-check-circle'></i> Naipost na ang trabaho! Makikita ito sa listahan sa ibaba.";
                window.history.replaceState({}, document.title, window.location.pathname);
            }

            document.querySelectorAll('.listing-card-button').forEach(btn => {
                btn.onclick = () => {
                    // CHANGE 1 CONT: Clear alert when opening any card
                    clearModalAlert();

                    document.getElementById('jobTitle').innerText = btn.dataset.title;
                    document.getElementById('jobDesc').innerText = btn.dataset.desc;
                    document.getElementById('jobPay').innerText = btn.dataset.pay;
                    document.getElementById('jobLocation').innerText = "Brgy. " + btn.dataset.location;
                    document.getElementById('jobSlots').innerText = btn.dataset.slots + " Slots";
                    document.getElementById('posterName').innerText = btn.dataset.poster;
                    document.getElementById('posterDate').innerText = "Na-post: " + btn.dataset.date;
                    document.getElementById('hfJobId').value = btn.dataset.jobid;
                    const tb = document.getElementById('modalTags'); tb.innerHTML = '';
                    if (btn.dataset.tags) {
                        btn.dataset.tags.split(/[|,]/).forEach(t => {
                            if (t.trim()) {
                                const s = document.createElement('span'); s.className = 'badge ' + getTagColorClass(t.trim(), btn.dataset.category);
                                s.innerText = t.trim(); tb.appendChild(s);
                            }
                        });
                    }
                    const st = document.getElementById('jobStatus'); st.innerText = btn.dataset.status;
                    st.className = 'badge ' + (btn.dataset.status.toLowerCase().includes('available') ? 'badge-green' : 'badge-rose');
                    const img = document.getElementById('posterImg'); const path = btn.dataset.posterImg;
                    img.src = path ? path.replace(/^~\//, '/') : '/Images/default-icon.jpg';
                    document.getElementById('jobModal').classList.add('open');
                };
            });
            document.querySelectorAll('.job-modal-close').forEach(b => b.onclick = () => document.getElementById('jobModal').classList.remove('open'));

            // ── CHANGE 2: Fix UpdatePanel overwriting the JS reset ──
            // After every async postback, check if the server actually put content
            // in the alert. If not (e.g. modal just opened, no apply yet), keep it hidden.
            if (typeof Sys !== 'undefined') {
                Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
                    const modalAlert = document.getElementById('pnlModalAlert');
                    if (!modalAlert) return;
                    const lbl = modalAlert.querySelector('span');
                    const hasContent = lbl && lbl.innerHTML.trim() !== '';
                    if (hasContent) {
                        modalAlert.style.display = 'block';
                    } else {
                        modalAlert.style.display = 'none';
                    }
                });
            }
        });
        window.onresize = updateTagOverflow;
    </script>

</asp:Content>