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
                <p>Available na ngayon sa Bi&#241;an.</p>
            </div>
        </div>
        <div class="quick-card"><div class="quick-icon"><i class='bx bx-check-circle'></i></div><div><h5>Madaling Apply</h5><p>Isang click lang para mag-apply.</p></div></div>
        <div class="quick-card"><div class="quick-icon"><i class='bx bx-refresh'></i></div><div><h5>Regular Updates</h5><p>Bagong listings araw-araw.</p></div></div>
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
                </select>
            </div>
            <button id="htFilterBtn" class="search-btn" type="button">Maghanap</button>
        </div>
    </div>

    <%-- LISTINGS HEADER --%>
        <div class="section-header left" style="display:flex; justify-content:space-between; align-items:flex-end; flex-wrap:wrap; gap:12px; margin-top:30px;">
            <div>
                <h3>Mga Bakanteng <span>Trabaho</span></h3>
                <p class="section-sub">Pinakabagong mga trabaho mula sa ating lungsod.</p>
            </div>
            <div style="display:flex; gap:10px; align-items:center; flex-wrap:wrap;">
                <asp:PlaceHolder ID="phPostJobBtn" runat="server">
                    <a href="PostJob.aspx" class="btn-outline" style="padding:8px 16px;">
                        <i class='bx bx-plus'></i> I-post ang Trabaho
                    </a>
                </asp:PlaceHolder>
                <select id="htSort" style="padding:12px 16px; border-radius:8px; border:1px solid #ddd; outline:none; font-family:inherit; font-size:0.88rem;">
                    <option value="newest">Pinakabago</option>
                    <option value="pay">Pinakamataas na Sahod</option>
                </select>
            </div>
        </div>

        <%-- ALERT BANNER --%>
        <asp:Panel ID="pnlApplyMessage" runat="server" CssClass="form-alert" Visible="false" ClientIDMode="Static" style="margin-bottom:20px;">
            <asp:Label ID="lblApplyMessage" runat="server" />
        </asp:Panel>

        <%-- REPEATER --%>
        <div id="htListings" class="listings-grid">
            <asp:Repeater ID="rptJobs" runat="server">
                <ItemTemplate>
                    <button type="button" class="listing-card listing-card-button"
                        data-jobid='<%# Eval("JobId") %>'
                        data-location='<%# Eval("Barangay") %>'
                        data-title='<%# Eval("JobTitle") %>'
                        data-pay='<%# GROUP6_ANGAT.DisplayHelper.GetPayDisplay(Eval("PayMin"), Eval("PayMax"), Eval("PayRate")) %>'
                        data-tags='<%# Eval("Tags") %>'
                        data-category='<%# Eval("Category") %>'
                        data-status='<%# Eval("Status") %>'
                        data-date='<%# GetRelativeTime(Eval("PostedAt")) %>'
                        data-desc='<%# Eval("JobDescription") %>'
                        data-poster='<%# Eval("PosterName") %>'
                        data-poster-img='<%# Eval("PosterImage") != DBNull.Value ? Eval("PosterImage") : "" %>'
                        data-slots='<%# Eval("Slots") %>'>
                        
                        <div class="listing-top">
                            <div class="listing-icon" data-category='<%# Eval("Category") %>'><i></i></div>
                            <span class='badge <%# GROUP6_ANGAT.DisplayHelper.GetStatusClass(Eval("Status")) %>'><%# Eval("Status") %></span>
                        </div>
                        
                        <h4><%# Eval("JobTitle") %></h4>
                        <p class="listing-company"><i class='bx bx-map'></i> Brgy. <%# Eval("Barangay") %>, Bi&#241;an</p>
                        
                        <div class="listing-tags">
                            <asp:Literal ID="litTags" runat="server" Mode="PassThrough"
                                Text='<%# GROUP6_ANGAT.DisplayHelper.GetTagsHtml(Eval("Tags"), Eval("Category")) %>' />
                        </div>
                        
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
            <button type="button" class="job-modal-close job-modal-close-icon" aria-label="Isara">✕</button>

            <div class="modal-poster">
                <img id="posterImg" src="/Images/default-icon.jpg" alt="Poster" class="modal-poster-img" style="width:50px; height:50px; border-radius:50%; object-fit:cover;" />
                <div style="display: flex; flex-direction: column; line-height: 1.1; margin-left:10px;">
                    <span class="modal-poster-name" id="posterName" style="font-weight:600; font-size:1rem; color: #1e293b;"></span>
                    <small class="modal-poster-date" id="posterDate" style="color:#64748b; font-size:0.75rem;"></small>
                </div>
            </div>

            <h4 id="jobTitle" style="margin-top:15px; font-weight:700;"></h4>

            <div class="modal-info-grid" style="display: grid; grid-template-columns: 1fr 1fr; gap: 15px; margin-top:15px;">
                <div class="modal-info-item"><span class="modal-info-label">Lokasyon</span><span class="modal-info-value" id="jobLocation"></span></div>
                <div class="modal-info-item"><span class="modal-info-label">Status</span><span id="jobStatus" class="badge"></span></div>
                <div class="modal-info-item"><span class="modal-info-label">Sahod</span><span class="modal-info-value" id="jobPay"></span></div>
                <div class="modal-info-item"><span class="modal-info-label">Slots Natitira</span><span class="modal-info-value" id="jobSlots"></span></div>
                <div class="modal-info-item" style="grid-column: span 2;">
                    <span class="modal-info-label">Uri ng Trabaho / Tags</span>
                    <div id="modalTags" style="display:flex; flex-wrap:wrap; gap:8px; margin-top:8px;"></div>
                </div>
            </div>

            <div class="modal-desc-block" style="margin-top:20px;">
                <span class="modal-info-label">Detalye ng Trabaho</span>
                <p id="jobDesc" class="job-desc" style="font-size:0.9rem; line-height:1.5; color:#475569; margin-top:8px;"></p>
            </div>

            <div class="job-modal-actions" style="margin-top:25px;">
                <asp:UpdatePanel ID="upApply" runat="server">
                    <ContentTemplate>
                        <asp:HiddenField ID="hfJobId" runat="server" ClientIDMode="Static" />
                        <asp:PlaceHolder ID="phApplyLoggedIn" runat="server">
                            <asp:Button ID="btnApplyJob" runat="server" Text="Mag-apply" CssClass="btn-green" OnClick="BtnApplyJob_Click" />
                        </asp:PlaceHolder>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>
    </div>

    <script>
        // ── SYNCED TAG LOGIC (Mirrors DisplayHelper.GetTagCss) ──
        function getTagColorClass(tag, category) {
            const t = (tag || "").toLowerCase().trim();
            const cat = (category || "").toLowerCase().trim();

            if (t.includes("urgent")) return "tag-rose";
            if (t.includes("full-time")) return "tag-fulltime";
            if (t.includes("part-time")) return "tag-parttime";

            if (t.includes("weekday") || t.includes("weekdays") ||
                t.includes("weekend") || t.includes("weekends") ||
                t.includes("flexible")) return "tag-blue";

            if (t.includes("experienced") || t.includes("may karanasan") ||
                t.includes("licensed") || t.includes("pisikal") ||
                t.includes("driver's license") || t.includes("nbi") ||
                t.includes("with tools")) return "tag-amber";

            if (t.includes("repair") || t.includes("install") || t.includes("wiring") ||
                t.includes("cleaning") || t.includes("maintenance")) return "tag-teal";

            if (cat.includes("karpintero")) return "tag-amber";
            if (cat.includes("tubero") || cat.includes("driver")) return "tag-blue";
            if (cat.includes("mananahi")) return "tag-rose";
            if (cat.includes("kasambahay") || cat.includes("labandera")) return "tag-violet";

            return "tag-teal";
        }

        // ── TAG OVERFLOW (Card Level) ──
        function updateTagOverflow() {
            document.querySelectorAll('.listing-tags').forEach(container => {
                const badges = Array.from(container.querySelectorAll('.badge:not(.more-badge)'));
                if (badges.length === 0) return;
                badges.forEach(b => b.style.display = '');
                const oldMore = container.querySelector('.more-badge');
                if (oldMore) oldMore.remove();

                const firstBadgeTop = badges[0].offsetTop;
                let hiddenCount = 0;
                badges.forEach(badge => {
                    if (badge.offsetTop > firstBadgeTop) {
                        badge.style.display = 'none';
                        hiddenCount++;
                    }
                });
                if (hiddenCount > 0) {
                    const more = document.createElement('span');
                    more.className = 'badge more-badge';
                    more.style.background = '#f1f5f9'; more.style.color = '#475569';
                    more.innerText = '+' + hiddenCount;
                    container.appendChild(more);
                }
            });
        }

        // ── SUCCESS NOTIFICATION HANDLER ──
        function checkPostStatus() {
            const urlParams = new URLSearchParams(window.location.search);
            if (urlParams.get('posted') === 'success') {
                const banner = document.getElementById('pnlApplyMessage');
                const lbl = document.getElementById('lblApplyMessage');
                if (banner && lbl) {
                    banner.style.display = 'block';
                    banner.className = 'form-alert success';
                    lbl.innerHTML = "<i class='bx bx-check-circle'></i> Naipost na ang trabaho! Makikita ito sa listahan sa ibaba.";
                }
                window.history.replaceState({}, document.title, window.location.pathname);
            }
        }

        document.addEventListener('DOMContentLoaded', () => {
            updateTagOverflow();
            checkPostStatus();

            document.querySelectorAll('.listing-card-button').forEach(btn => {
                btn.onclick = () => {
                    document.getElementById('jobTitle').innerText = btn.dataset.title;
                    document.getElementById('jobDesc').innerText = btn.dataset.desc;
                    document.getElementById('jobPay').innerText = btn.dataset.pay;
                    document.getElementById('jobLocation').innerText = "Brgy. " + btn.dataset.location;
                    document.getElementById('jobSlots').innerText = btn.dataset.slots + " Slots";
                    document.getElementById('posterName').innerText = btn.dataset.poster;
                    document.getElementById('posterDate').innerText = btn.dataset.date;
                    document.getElementById('hfJobId').value = btn.dataset.jobid;

                    const statusBadge = document.getElementById('jobStatus');
                    statusBadge.innerText = btn.dataset.status;
                    statusBadge.className = 'badge ' + (btn.dataset.status === 'Available' ? 'badge-green' : 'badge-rose');

                    // Populate Modal Tags
                    const tagBox = document.getElementById('modalTags');
                    tagBox.innerHTML = '';
                    const category = btn.dataset.category;
                    if (btn.dataset.tags) {
                        btn.dataset.tags.split(/[|,]/).forEach(t => {
                            if (t.trim()) {
                                const s = document.createElement('span');
                                s.className = 'badge ' + getTagColorClass(t.trim(), category);
                                s.innerText = t.trim();
                                tagBox.appendChild(s);
                            }
                        });
                    }

                    // User Icon Fix
                    const img = document.getElementById('posterImg');
                    const rawPath = btn.dataset.posterImg;
                    if (rawPath && rawPath.trim() !== "") {
                        img.src = rawPath.replace(/^~\//, '/');
                    } else {
                        img.src = '/Images/default-icon.jpg';
                    }
                    img.onerror = function () { this.src = '/Images/default-icon.jpg'; };

                    document.getElementById('jobModal').classList.add('open');
                };
            });

            document.querySelectorAll('.job-modal-close').forEach(b => {
                b.onclick = () => document.getElementById('jobModal').classList.remove('open');
            });
        });

        window.onresize = updateTagOverflow;
    </script>
</asp:Content>