<%@ Page Title="Training Calendar" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Training.aspx.cs" Inherits="GROUP6_ANGAT.Pages.Training" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    
    <div id="page-hero">
        <div class="hero-circles">
            <div class="c1"></div>
            <div class="c2"></div>
        </div>
        <div class="page-hero-inner">
            <span class="hero-badge"><i class='bx bx-book-reader'></i> Skills Training</span>
            <h2>Libreng <strong>Training</strong></h2>
            <p class="hero-desc">
                Palawakin ang inyong kaalaman at kasanayan. Sumali sa mga libreng TESDA at LGU training programs upang mas mapalago ang inyong hanapbuhay dito sa Biñan.
            </p>
        </div>
        <div class="wave">
            <svg viewBox="0 0 1440 80" xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="none">
                <path d="M0,80 L1440,80 L1440,80 L0,80 Z" fill="#ffffff"/>
            </svg>
        </div>
    </div>

<ul class="announcement-list">
    <asp:Repeater ID="rptTrainings" runat="server">
        <ItemTemplate>
            </ItemTemplate>
    </asp:Repeater>
</ul>
    <div class="section section-light" style="padding-top: 40px;"> 
        <div class="page-quick">
        <div class="quick-card">
            <div class="quick-icon"><i class='bx bx-book'></i></div>
            <div>
                <h5>TESDA Courses</h5>
                <p>Libreng training na may certificates.</p>
            </div>
        </div>
        <div class="quick-card">
            <div class="quick-icon"><i class='bx bx-calendar'></i></div>
            <div>
                <h5>Scheduled Batches</h5>
                <p>May iskedyul para makapaghanda.</p>
            </div>
        </div>
        <div class="quick-card">
            <div class="quick-icon"><i class='bx bx-award'></i></div>
            <div>
                <h5>Skill Upgrade</h5>
                <p>Dagdag kaalaman para sa mas mataas na kita.</p>
            </div>
        </div>
    </div>
        <!-- Search Bar title and OPEN CLOSED FILTER (updated lean)-->
<div style="max-width: 1280px; margin: 40px auto; padding: 0 20px;">
    
    <div id="search-bar" style="margin-top: 24px;">
        <div class="search-box">
            <div class="search-field">
                <span class="s-icon"><i class='bx bx-search'></i></span>
                <input type="text" id="hgSearch" 
                    placeholder="Anong training ang hanap mo?" 
                    oninput="applyClientFilter()" 
                    style="width: 100%; padding: 10px; border: none; outline: none;" />
            </div>
    
            <div class="search-field">
                <span class="s-icon"><i class='bx bx-filter-alt'></i></span>
                <select id="hgStatus" onchange="applyClientFilter()" style="padding: 10px; border: none; outline: none; background: transparent;">
                    <option value="All">All Status</option>
                    <option value="Open">Open Only</option>
                    <option value="Closed">Closed Only</option>
                </select>
            </div>
            
            <button type="button" class="search-btn" onclick="applyClientFilter()">Maghanap</button>
    </div>
</div>
        <div class="section-header">
        <h3>Mga Libreng Training para sa <span>Masa</span></h3>
        <p class="section-sub">Huwag nang mag-alala kung wala kang budget—narito ang mga ahensya na handang tumulong sa paghasa ng iyong kakayahan at pag-angat ng iyong kinabukasan</p>
    </div>
    <!-- Repeater lists --LEAN -->
            <div id="hgListings" class="listings-grid" style="margin-top: 40px; display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 20px;">
        <asp:Repeater ID="Repeater1" runat="server">
            <ItemTemplate>
                <div class="listing-card" 
                     data-search='<%# Eval("Title").ToString().ToLower() %> <%# Eval("Agency").ToString().ToLower() %>' 
                     data-status='<%# Eval("Status") %>'
                     style="display: flex; flex-direction: column; gap: 15px; background: #fff; padding: 25px; border-radius: 12px; border: 1px solid #e2e8f0; transition: transform 0.2s;">
                    
                    <div style="width: 48px; height: 48px; background: #e8f5e9; border-radius: 12px; display: flex; align-items: center; justify-content: center; margin-bottom: 10px;">
                        <i class='bx bx-book-open' style="color: #2e7d32; font-size: 1.5rem;"></i>
                    </div>

                    <h4 style="font-size: 1.2rem; font-weight: 750; color: #1e293b;"><%# Eval("Title") %></h4>
                    
                    <div>
                        <span style="background: #15803d; color: white; padding: 6px 14px; border-radius: 50px; font-size: 0.75rem; font-weight: 700;">
                            <%# Eval("Agency") %>
                        </span>
                    </div>

                    <p style="color: #64748b; font-size: 1rem; line-height: 1.7; flex-grow: 1;">
                        <%# Eval("Description") %>
                    </p>

                    <div style="border-top: 1px solid #f1f5f9; padding-top: 20px; margin-top: auto;">
                        <button type="button" 
                            <%# Eval("Status").ToString() != "Open" ? "disabled" : "" %>
                            onclick="showTrainingModal('<%# Eval("Title").ToString().Replace("'", "\\'") %>', '<%# Eval("ApplyURL") %>')" 
                            style="background: none; border: none; 
                                   color: <%# Eval("Status").ToString() == "Open" ? "#15803d" : "#94a3b8" %>; 
                                   font-weight: 700; font-size: 1rem; display: flex; align-items: center; gap: 8px; 
                                   cursor: <%# Eval("Status").ToString() == "Open" ? "pointer" : "not-allowed" %>; 
                                   padding: 0;">
                            <%# Eval("Status").ToString() == "Open" ? "Alamin ang requirements" : "Registration Closed" %> 
                            <i class='bx bx-right-arrow-alt'></i>
                        </button>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
</div>

    <script type="text/javascript">
        function applyClientFilter() {
            const query = document.getElementById('hgSearch').value.toLowerCase().trim();
            const status = document.getElementById('hgStatus').value;
            const cards = document.querySelectorAll('.listing-card');
            const noResults = document.getElementById('noResults');
            let visibleCount = 0;

            cards.forEach(card => {
                const content = card.getAttribute('data-search') || '';
                const cardStatus = card.getAttribute('data-status') || '';

                const matchesSearch = !query || content.includes(query);
                const matchesStatus = (status === 'All') || (cardStatus === status);

                if (matchesSearch && matchesStatus) {
                    card.style.display = 'flex';
                    visibleCount++;
                } else {
                    card.style.display = 'none';
                }
            });

            // Show "No Results" message if everything is hidden
            noResults.style.display = (visibleCount === 0) ? 'block' : 'none';
        }

        // Modal Logic
        function showTrainingModal(name, url) {
            document.getElementById('modalTitle').innerText = name;
            document.getElementById('modalLink').href = url;
            document.getElementById('trainingModal').style.display = 'flex';
        }

        function closeTrainingModal() {
            document.getElementById('trainingModal').style.display = 'none';
        }
</script>
</asp:Content>
