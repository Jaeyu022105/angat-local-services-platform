<%@ Page Title="Post Job" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PostJob.aspx.cs" Inherits="GROUP6_ANGAT.PostJob" %>
    
<%-- PAGE HERO --%>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div id="page-hero">
        <div class="hero-circles">
            <div class="c1"></div>
            <div class="c2"></div>
        </div>
        <div class="page-hero-inner">
            <span class="hero-badge"><i class='bx bx-briefcase'></i> Employer Portal</span>
            <h2>I-post ang <strong>Trabaho</strong></h2>
            <p class="hero-desc">
                Magdagdag ng bagong job listing para makita ng mga aplikante sa Bi&#241;an.
            </p>
        </div>
        <div class="wave">
            <svg viewBox="0 0 1440 80" xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="none">
                <path d="M0,80 L1440,80 L1440,80 L0,80 Z" fill="#ffffff"/>
            </svg>
        </div>
    </div>

    <div class="section section-light">
        <div class="section-header">
            <h3>Job <span>Details</span></h3>
            <p class="section-sub">Punan ang impormasyon para sa bagong listing.</p>
        </div>

        <asp:Panel ID="pnlPostMessage" runat="server" CssClass="form-alert" Visible="false">
            <asp:Label ID="lblPostMessage" runat="server" />
        </asp:Panel>

        <div style="max-width: 720px; margin: 0 auto;">

            <%-- Job Title --%>
            <div class="form-group">
                <label>Job Title <span class="required">*</span></label>
                <asp:TextBox ID="txtJobTitle" runat="server" placeholder="Halimbawa: House Helper sa Bi&#241;an, Personal Driver para Pamilya"></asp:TextBox>
                <small class="field-hint">Iwasan ang emoji at espesyal na karakter.</small>
            </div>

            <%-- Category --%>
            <div class="form-group">
                <label>Kategorya <span class="required">*</span></label>
                <asp:DropDownList ID="ddlCategory" runat="server">
                    <asp:ListItem Value="">-- Pumili ng Kategorya --</asp:ListItem>
                    <asp:ListItem Value="Kasambahay">Kasambahay</asp:ListItem>
                    <asp:ListItem Value="Driver">Driver</asp:ListItem>
                    <asp:ListItem Value="Labandera">Labandera</asp:ListItem>
                    <asp:ListItem Value="Karpintero">Karpintero</asp:ListItem>
                    <asp:ListItem Value="Electrician">Electrician</asp:ListItem>
                    <asp:ListItem Value="Tubero">Tubero</asp:ListItem>
                    <asp:ListItem Value="Mananahi">Mananahi</asp:ListItem>
                    <asp:ListItem Value="Carinderia">Carinderia</asp:ListItem>
                    <asp:ListItem Value="Sari-sari Store">Sari-sari Store</asp:ListItem>
                    <asp:ListItem Value="Bodega">Bodega</asp:ListItem>
                    <asp:ListItem Value="Iba Pa">Iba Pa</asp:ListItem>
                </asp:DropDownList>
            </div>

            <%-- Barangay --%>
            <div class="form-group">
                <label>Barangay <span class="required">*</span></label>
                <asp:DropDownList ID="ddlBarangay" runat="server">
                    <asp:ListItem Value="">-- Pumili ng Barangay --</asp:ListItem>
                    <asp:ListItem Value="Bi&#241;an">Bi&#241;an (Poblacion)</asp:ListItem>
                    <asp:ListItem Value="Bungahan">Bungahan</asp:ListItem>
                    <asp:ListItem Value="Canlalay">Canlalay</asp:ListItem>
                    <asp:ListItem Value="Casile">Casile</asp:ListItem>
                    <asp:ListItem Value="De La Paz">De La Paz</asp:ListItem>
                    <asp:ListItem Value="Ganado">Ganado</asp:ListItem>
                    <asp:ListItem Value="Langkiwa">Langkiwa</asp:ListItem>
                    <asp:ListItem Value="Loma">Loma</asp:ListItem>
                    <asp:ListItem Value="Malaban">Malaban</asp:ListItem>
                    <asp:ListItem Value="Malamig">Malamig</asp:ListItem>
                    <asp:ListItem Value="Mampalasan">Mampalasan</asp:ListItem>
                    <asp:ListItem Value="Mapagong">Mapagong</asp:ListItem>
                    <asp:ListItem Value="Masile">Masile</asp:ListItem>
                    <asp:ListItem Value="Maysilo">Maysilo</asp:ListItem>
                    <asp:ListItem Value="Munting Ilog">Munting Ilog</asp:ListItem>
                    <asp:ListItem Value="New Bi&#241;an">New Bi&#241;an</asp:ListItem>
                    <asp:ListItem Value="Platero">Platero</asp:ListItem>
                    <asp:ListItem Value="San Antonio">San Antonio</asp:ListItem>
                    <asp:ListItem Value="San Francisco">San Francisco</asp:ListItem>
                    <asp:ListItem Value="San Jose">San Jose</asp:ListItem>
                    <asp:ListItem Value="San Vicente">San Vicente</asp:ListItem>
                    <asp:ListItem Value="Santo Domingo">Santo Domingo</asp:ListItem>
                    <asp:ListItem Value="Santo Tomas">Santo Tomas</asp:ListItem>
                    <asp:ListItem Value="Soro-soro Ibaba">Soro-soro Ibaba</asp:ListItem>
                    <asp:ListItem Value="Soro-soro Ilaya">Soro-soro Ilaya</asp:ListItem>
                    <asp:ListItem Value="Timbao">Timbao</asp:ListItem>
                    <asp:ListItem Value="Tubigan">Tubigan</asp:ListItem>
                    <asp:ListItem Value="Zapote">Zapote</asp:ListItem>
                </asp:DropDownList>
                <small class="field-hint">Ang exact address ay ipapakita lamang pagkatapos ma-approve ang application.</small>
            </div>

            <%-- Pay --%>
            <div class="form-group">
                <label>Sahod <span class="required">*</span></label>
                <div class="pay-row">
                    <div class="pay-field">
                        <span class="pay-currency">&#8369;</span>
                        <asp:TextBox ID="txtPayMin" runat="server" placeholder="Min"></asp:TextBox>
                    </div>
                    <span class="pay-sep">&ndash;</span>
                    <div class="pay-field">
                        <span class="pay-currency">&#8369;</span>
                        <asp:TextBox ID="txtPayMax" runat="server" placeholder="Max"></asp:TextBox>
                    </div>
                    <asp:DropDownList ID="ddlPayRate" runat="server">
                        <asp:ListItem Value="per hour">/ oras</asp:ListItem>
                        <asp:ListItem Value="per day" Selected="True">/ araw</asp:ListItem>
                        <asp:ListItem Value="per month">/ buwan</asp:ListItem>
                        <asp:ListItem Value="per job">/ bawat trabaho</asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>

            <%-- Tags --%>
            <div class="form-group">
                <label>Tags <span class="required">*</span></label>
                <small class="field-hint" style="margin-bottom: 10px; display:block;">Piliin ang lahat ng angkop.</small>
                <div class="tag-group">
                    <span class="tag-group-label">Uri ng Trabaho</span>
                    <div class="tag-pills">
                        <label class="tag-pill"><input type="radio" value="Full-time" /> Full-time</label>
                        <label class="tag-pill"><input type="radio" value="Part-time" /> Part-time</label>
                    </div>
                </div>
                <div class="tag-group">
                    <span class="tag-group-label">Schedule</span>
                    <div class="tag-pills">
                        <label class="tag-pill"><input type="radio" value="Weekdays Only" /> Weekdays Only</label>
                        <label class="tag-pill"><input type="radio" value="Weekends Only" /> Weekends Only</label>
                        <label class="tag-pill"><input type="radio" value="Flexible Hours" /> Flexible Hours</label>
                    </div>
                </div>
                <div class="tag-group">
                    <span class="tag-group-label">Urgency</span>
                    <div class="tag-pills">
                        <label class="tag-pill"><input type="checkbox" value="Urgent" /> Urgent</label>
                    </div>
                </div>
                <div class="tag-group">
                    <span class="tag-group-label">Kinakailangan</span>
                    <div class="tag-pills">
                        <label class="tag-pill"><input type="checkbox" value="Experienced" /> Experienced</label>
                        <label class="tag-pill"><input type="checkbox" value="Pisikal na Trabaho" /> Pisikal na Trabaho</label>
                        <label class="tag-pill"><input type="checkbox" value="Driver's License" /> Driver's License</label>
                        <label class="tag-pill"><input type="checkbox" value="NBI Clearance" /> NBI Clearance</label>
                        <label class="tag-pill"><input type="checkbox" value="With Tools" /> With Tools</label>
                    </div>
                </div>
                <asp:HiddenField ID="hfTags" runat="server" />
            </div>

            <%-- Slots --%>
            <div class="form-group">
                <label>Bilang ng Kailangan <span class="required">*</span></label>
                <asp:TextBox ID="txtSlots" runat="server" TextMode="Number" Text="1"></asp:TextBox>
                <small class="field-hint">Ilang tao ang kailangan mo? (1-10)</small>
            </div>

            <%-- Description --%>
            <div class="form-group">
                <label>Detalye <span class="required">*</span></label>
                <asp:TextBox ID="txtJobDescription" runat="server" TextMode="MultiLine"
                    placeholder="Halimbawa: Naghahanap kami ng kasambahay para sa pamilya sa Bi&#241;an. Kailangan ng magluto, maglinis, at mag-alaga ng bata. Live-in, may libreng pagkain at tirahan. Kausapin kami para sa interview."
                    MaxLength="500"></asp:TextBox>
                <small class="field-hint"><span id="descCount">0</span> / 500 characters</small>
            </div>

            <asp:Button ID="btnPostJob" runat="server" Text="I-post ang Trabaho"
                CssClass="btn-green" OnClick="BtnPostJob_Click" />

        </div>
    </div>

    <script>
        // 1. Select both checkboxes and radio buttons
        var tagPills = document.querySelectorAll('.tag-pill input');
        var hfTags = document.getElementById('<%= hfTags.ClientID %>');

        var slotsInput = document.getElementById('<%= txtSlots.ClientID %>');
        if (slotsInput) {
            slotsInput.setAttribute('min', '1');
            slotsInput.setAttribute('max', '10');
        }

        function updateTags() {
            var selected = [];
            tagPills.forEach(function (cb) {
                if (cb.checked) selected.push(cb.value);
            });
            hfTags.value = selected.join('|');
        }

        tagPills.forEach(function (cb) {
            cb.addEventListener('change', function () {
                // Fix for Radios: If it's a radio, we need to refresh the 'active' class 
                // for all pills in this specific group first.
                if (cb.type === 'radio') {
                    var group = cb.closest('.tag-pills');
                    group.querySelectorAll('.tag-pill').forEach(function(pill) {
                        pill.classList.remove('active');
                    });
                }
            
                // Toggle active class based on checked status
                cb.closest('.tag-pill').classList.toggle('active', cb.checked);
            
                updateTags();
            });
        });

        // ── DESCRIPTION COUNTER ──
        var descBox   = document.getElementById('<%= txtJobDescription.ClientID %>');
        var descCount = document.getElementById('descCount');
        if (descBox && descCount) {
            descBox.addEventListener('input', function () {
                descCount.textContent = descBox.value.length;
            });
        }
    </script>

</asp:Content>
