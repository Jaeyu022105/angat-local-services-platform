<%@ Page Title="Puhunan Tips" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Puhunan.aspx.cs" Inherits="GROUP6_ANGAT.Pages.Puhunan" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    
    <div id="page-hero">
        <div class="hero-circles">
            <div class="c1"></div>
            <div class="c2"></div>
        </div>
        <div class="page-hero-inner">
            <span class="hero-badge"><i class='bx bx-money'></i> Gabay sa Negosyo</span>
            <h2>Puhunan <strong>Tips</strong></h2>
            <p class="hero-desc">
                Naghahanap ng dagdag puhunan para sa sari-sari store o carinderia? Alamin ang mga lehitimo at mababang-interes na pautang mula sa gobyerno at microfinance NGOs.
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
            <div class="quick-icon"><i class='bx bx-wallet'></i></div>
            <div>
                <h5>Low Interest</h5>
                <p>Mga programang may mababang interes.</p>
            </div>
        </div>
        <div class="quick-card">
            <div class="quick-icon"><i class='bx bx-badge-check'></i></div>
            <div>
                <h5>Legit Sources</h5>
                <p>Lehitimong ahensya at microfinance.</p>
            </div>
        </div>
        <div class="quick-card">
            <div class="quick-icon"><i class='bx bx-line-chart'></i></div>
            <div>
                <h5>Grow Your Biz</h5>
                <p>Gabay sa pag-angat ng maliit na negosyo.</p>
            </div>
        </div>
    </div>
    <!-- Searchbar start (Lean) -->
    <ContentTemplate>
        <div id="search-bar" style="margin-top: 24px;">
            <div class="search-box">
                <div class="search-field">
                    <span class="s-icon"><i class='bx bx-search'></i></span>
                    <input type="text" id="loanSearch" placeholder="Anong Loan ang hanap mo?" oninput="filterLoans()" />
                </div>

                <div class="search-field">
                    <span class="s-icon"><i class='bx bx-calendar'></i></span>
                    <select id="loanTypeFilter" onchange="filterLoans()">
                        <option value="all">Lahat ng Loans</option>
                        <option value="Micro">Micro Loans</option>
                        <option value="Small">Small Loans</option>
                        <option value="Big">Big Loans</option>
                        <option value="Business">Business Loans</option>
                    </select>
                </div>

                <button type="button" class="search-btn" onclick="filterLoans()">Maghanap</button>
            </div>
        </div>
        <!-- SearchBar done -->
            <div class="section-header">
                <br>
                    <h3>Mga Programa para sa <span>Micro-Entrepreneurs</span></h3>
                    <p class="section-sub">Huwag nang kumagat sa "5-6". Narito ang mga ligtas na ahensya na handang tumulong sa pag-asenso ng iyong kabuhayan.</p>
                </div>

                <div class="listings-grid" id="loanGrid" style="margin-top: 40px; display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 20px;">
                    <asp:Repeater ID="rptPuhunan" runat="server">
                        <ItemTemplate>
                            <div class="listing-card program-card" 
                                 data-search='<%# Eval("ProgramName").ToString().ToLower() %> <%# Eval("Description").ToString().ToLower() %>' 
                                 data-category='<%# Eval("LoanType") %>'
                                 style="display: flex; flex-direction: column; gap: 15px; background: #fff; padding: 25px; border-radius: 12px; border: 1px solid #e2e8f0;">
                
                                <div class="listing-icon" style='<%# GetIconStyle(Eval("CategorySlug").ToString()) %>'>
                                    <i class='bx <%# GetIconClass(Eval("CategorySlug").ToString()) %>'></i>
                                </div>
                
                                <h4 style="font-size: 1.2rem; font-weight: 750;"><%# Eval("ProgramName") %></h4>
                
                                <div class="listing-tags">
                                    <span class='badge <%# GetBadgeClass(Eval("CategorySlug").ToString()) %>'>
                                        <%# Eval("TagText") %>
                                    </span>
                                </div>
                
                                <p style="color: #475569; font-size: 0.9rem; line-height: 1.6; flex-grow: 1;"><%# Eval("Description") %></p>
                
                                <div style="border-top: 1px solid #e2e8f0; padding-top: 15px; margin-top: auto;">
                                    <button type="button" 
                                            style='background:none; border:none; cursor:pointer; color: <%# GetPrimaryColor(Eval("CategorySlug").ToString()) %>; font-weight: bold; font-size: 0.9rem; display: flex; align-items: center; gap: 5px; padding: 0;'
                                            onclick="showRequirements('<%# Eval("ProgramName").ToString().Replace("'", "\\'") %>', '<%# Eval("TargetURL") %>')">
                                        Alamin ang requirements <i class='bx bx-right-arrow-alt'></i>
                                    </button>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>

            <div id="requirementsModal" style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.5); z-index: 1000; justify-content: center; align-items: center;">
        <div style="background: white; padding: 30px; border-radius: 15px; max-width: 500px; width: 90%; box-shadow: 0 10px 25px rgba(0,0,0,0.2);">
            <h2 id="modalTitle" style="margin-bottom: 15px; color: #1e293b; font-weight: bold;">Program Name</h2>
            <p style="color: #64748b; margin-bottom: 25px; line-height: 1.6;">Siguraduhing handa ang iyong mga dokumento bago mag-apply sa website ng ahensya.</p>
            <div style="display: flex; gap: 10px; justify-content: flex-end;">
                <button type="button" onclick="closeModal()" style="padding: 12px 24px; border-radius: 8px; border: 1px solid #e2e8f0; cursor: pointer; font-weight: bold; font-size: 1rem; background: #f8fafc;">Cancel</button>
                <a id="modalLink" href="#" target="_blank" style="padding: 12px 24px; border-radius: 8px; background: #15803d; color: white; text-decoration: none; font-weight: bold; font-size: 1rem; display: inline-block;">Bisitahin ang Website</a>
            </div>
        </div>
    </div>
</div>
    <script type="text/javascript">
        function filterLoans() {
            const query = document.getElementById('loanSearch').value.toLowerCase().trim();
            const categoryFilter = document.getElementById('loanTypeFilter').value.toLowerCase().trim(); // Convert dropdown value to lowercase
            const cards = document.querySelectorAll('.listing-card');

            cards.forEach(card => {
                const searchText = (card.getAttribute('data-search') || '').toLowerCase();
                const cardCategory = (card.getAttribute('data-category') || '').trim();
                const matchesSearch = !query || searchText.includes(query);
                const matchesCategory = (categoryFilter === 'all') ||
                    (cardCategory.toLowerCase() === categoryFilter.toLowerCase());

                if (matchesSearch && matchesCategory) {
                    card.style.display = 'flex';
                } else {
                    card.style.display = 'none';
                }
            });
        }

        // Modal Functions
        function showRequirements(name, url) {
            document.getElementById('modalTitle').innerText = name;
            document.getElementById('modalLink').href = url;
            document.getElementById('requirementsModal').style.display = 'flex';
        }

        function closeModal() {
            document.getElementById('requirementsModal').style.display = 'none';
        }
    </script>
        <!-- Listings end-->
</asp:Content>
