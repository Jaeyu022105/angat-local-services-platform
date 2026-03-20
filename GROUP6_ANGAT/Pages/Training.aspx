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

<ul class="announcement-list" style="margin-top: 30px;">
    <asp:Repeater ID="rptTrainings" runat="server">
        <ItemTemplate>
            </ItemTemplate>
    </asp:Repeater>
</ul>
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
        <asp:UpdatePanel ID="updPuhunan" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
                <div id="search-bar" style="margin-top: 24px; display: flex; justify-content: center; width: 100%;">
                    <div class="search-wrapper" style="display: flex; align-items: center; background: white; border: 1px solid #e2e8f0; border-radius: 15px; padding: 8px 15px; width: 100%; max-width: 1100px; box-shadow: 0 4px 6px -1px rgba(0,0,0,0.1);">
                        <div style="display: flex; align-items: center; flex: 2; border-right: 1px solid #e2e8f0; padding-right: 15px;">
                            <i class='bx bx-search' style="color: #64748b; margin-right: 10px; font-size: 1.2rem;"></i>
                            <asp:TextBox ID="txtSearch" runat="server" Placeholder="Anong training ang hanap mo?" CssClass="search-input" style="background: transparent; border: none; outline: none; width: 100%; font-size: 0.95rem; color: #1e293b;"></asp:TextBox>
                        </div>
                        <div style="flex: 1; display: flex; align-items: center; padding: 0 15px;">
                            <i class='bx bx-filter-alt' style="color: #64748b; margin-right: 8px; font-size: 1.2rem;"></i>
                            <asp:DropDownList ID="ddlStatus" runat="server" style="border: none; outline: none; background: transparent; width: 100%; cursor: pointer; font-size: 0.9rem; color: #475569;">
                                <asp:ListItem Value="All">All Status</asp:ListItem>
                                <asp:ListItem Value="Open">Open Only</asp:ListItem>
                                <asp:ListItem Value="Closed">Closed Only</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <asp:Button ID="btnSearch" runat="server" Text="Maghanap" OnClick="btnSearch_Click" style="background: #10b981; color: white; border: none; border-radius: 10px; padding: 10px 25px; font-weight: bold; cursor: pointer;" />
                    </div>
                </div>
    <!-- Repeater lists --LEAN -->
            <div style="max-width: 1280px; margin: 40px auto; padding: 0 20px;">
                    <div class="listings-grid" style="display: grid; grid-template-columns: repeat(auto-fit, minmax(350px, 1fr)); gap: 30px;">
                        <asp:Repeater ID="Repeater1" runat="server">
                            <ItemTemplate>
                                <div class="listing-card" style="display: flex; flex-direction: column; background: #fff; padding: 40px; border-radius: 20px; border: 1px solid #eef2f6; box-shadow: 0 10px 15px -3px rgba(0,0,0,0.05); height: 100%; min-height: 400px;">
                                    <div style="width: 48px; height: 48px; background: #e8f5e9; border-radius: 12px; display: flex; align-items: center; justify-content: center; margin-bottom: 24px;">
                                        <i class='bx bx-book-open' style="color: #2e7d32; font-size: 1.5rem;"></i>
                                    </div>
                                    <h4 style="font-size: 1.2rem; font-weight: 750; color: #1e293b; margin-bottom: 12px;"><%# Eval("Title") %></h4>
                                    <div style="margin-bottom: 20px;">
                                        <span style="background: #15803d; color: white; padding: 6px 14px; border-radius: 50px; font-size: 0.75rem; font-weight: 700;"><%# Eval("Agency") %></span>
                                    </div>
                                    <p style="color: #64748b; font-size: 1rem; line-height: 1.7; flex-grow: 1; margin-bottom: 24px;"><%# Eval("Description") %></p>
                                    <div style="border-top: 1px solid #f1f5f9; padding-top: 20px; margin-top: auto;">
                                        <button type="button" onclick="showTrainingModal('<%# Eval("Title") %>', '<%# Eval("ApplyURL") %>')" style="background: none; border: none; color: <%# Eval("Status").ToString() == "Open" ? "#15803d" : "#94a3b8" %>; font-weight: 700; font-size: 1rem; display: flex; align-items: center; gap: 8px; cursor: pointer; padding: 0;">
                                            <%# Eval("Status").ToString() == "Open" ? "Alamin ang requirements" : "Closed" %> <i class='bx bx-right-arrow-alt'></i>
                                        </button>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div> 
                </div>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
            </Triggers>
        </asp:UpdatePanel>

    <div id="trainingModal" style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.6); z-index: 9999; justify-content: center; align-items: center;">
    <div style="background: white; padding: 30px; border-radius: 15px; max-width: 500px; width: 90%; box-shadow: 0 10px 25px rgba(0,0,0,0.2); position: relative;">
        
        <h2 id="modalTitle" style="margin-bottom: 15px; color: #1e293b; font-size: 1.5rem; font-weight: bold;">Training Name</h2>
        <p style="color: #64748b; margin-bottom: 25px; line-height: 1.6;">Ihanda ang inyong impormasyon. Sa pag-click ng button sa ibaba, kayo ay mapupunta sa opisyal na portal ng ahensya.</p>
        
        <div style="display: flex; gap: 12px; justify-content: flex-end;">
            <button type="button" 
                id="btnCancelModal"
                onclick="document.getElementById('trainingModal').style.display='none';" 
                style="padding: 12px 24px; border-radius: 8px; border: 1px solid #e2e8f0; background-color: #f8fafc; color: #475569; cursor: pointer; font-weight: bold; font-size: 1rem;">
                Cancel
            </button>

            <a id="modalLink" href="#" target="_blank" 
                style="padding: 12px 24px; border-radius: 8px; background: #15803d; color: white; text-decoration: none; font-weight: bold; font-size: 1rem; display: inline-block;">
                Ipatuloy ang Pag-apply
            </a>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        function showTrainingModal(name, url) {
            document.getElementById('modalTitle').innerText = name;
            document.getElementById('modalLink').href = url;
            document.getElementById('trainingModal').style.display = 'flex';
        }

        function closeTrainingModal() {
            var modal = document.getElementById('trainingModal');
            if (modal) {
                modal.style.display = 'none';
            }
        }
    </script>
</asp:Content>
