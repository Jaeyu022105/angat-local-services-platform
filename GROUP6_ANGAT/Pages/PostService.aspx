<%@ Page Title="Post Service" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PostService.aspx.cs" Inherits="GROUP6_ANGAT.PostService" %>

<%-- PAGE HERO --%>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div id="page-hero">
        <div class="hero-circles">
            <div class="c1"></div>
            <div class="c2"></div>
        </div>
        <div class="page-hero-inner">
            <span class="hero-badge"><i class='bx bx-wrench'></i> Service Provider</span>
            <h2>I-post ang <strong>Serbisyo</strong></h2>
            <p class="hero-desc">
                Magdagdag ng bagong serbisyo para makita ng mga kustomer sa Bi&#241;an.
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
            <h3>Service <span>Details</span></h3>
            <p class="section-sub">Punan ang impormasyon para sa bagong listing.</p>
        </div>

        <asp:Panel ID="pnlPostMessage" runat="server" CssClass="form-alert" Visible="false">
            <asp:Label ID="lblPostMessage" runat="server" />
        </asp:Panel>

        <div style="max-width: 720px; margin: 0 auto;">

            <%-- Service Title --%>
            <div class="form-group">
                <label>Service Title <span class="required">*</span></label>
                <asp:TextBox ID="txtServiceTitle" runat="server"
                    placeholder="Halimbawa: Aircon Cleaning at Repair, Tubero para sa Bi&#241;an Area"></asp:TextBox>
                <small class="field-hint">Iwasan ang emoji at espesyal na karakter. Awtomatikong iko-convert sa Title Case.</small>
            </div>

            <%-- Category — Tagalog only --%>
            <div class="form-group">
                <label>Kategorya <span class="required">*</span></label>
                <asp:DropDownList ID="ddlCategory" runat="server">
                    <asp:ListItem Value="">-- Pumili ng Kategorya --</asp:ListItem>
                    <asp:ListItem Value="Karpintero">Karpintero</asp:ListItem>
                    <asp:ListItem Value="Tubero">Tubero</asp:ListItem>
                    <asp:ListItem Value="Electrician">Electrician</asp:ListItem>
                    <asp:ListItem Value="Aircon">Ayos ng Appliance</asp:ListItem>
                    <asp:ListItem Value="Mananahi">Mananahi</asp:ListItem>
                    <asp:ListItem Value="General">Iba Pa</asp:ListItem>
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
                <small class="field-hint">Ang exact address ay ipapakita lamang sa mga approved na request.</small>
            </div>

            <%-- Rate --%>
            <div class="form-group">
                <label>Rate <span class="required">*</span></label>
                <div class="pay-row">
                    <div class="pay-field">
                        <span class="pay-currency">&#8369;</span>
                        <asp:TextBox ID="txtRateMin" runat="server" placeholder="Min"></asp:TextBox>
                    </div>
                    <span class="pay-sep">&ndash;</span>
                    <div class="pay-field">
                        <span class="pay-currency">&#8369;</span>
                        <asp:TextBox ID="txtRateMax" runat="server" placeholder="Max"></asp:TextBox>
                    </div>
                    <asp:DropDownList ID="ddlRateUnit" runat="server" CssClass="pay-unit">
                        <asp:ListItem Value="per day">/ araw</asp:ListItem>
                        <asp:ListItem Value="per job">/ serbisyo</asp:ListItem>
                        <asp:ListItem Value="per hour">/ oras</asp:ListItem>
                        <asp:ListItem Value="per unit">/ unit</asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>

            <%-- Tags --%>
            <div class="form-group">
                <label>Tags <span class="required">*</span></label>
                <small class="field-hint" style="margin-bottom: 10px; display:block;">Piliin ang lahat ng angkop.</small>
                    <div class="tag-group">
                        <span class="tag-group-label">Uri ng Serbisyo</span>
                        <div class="tag-pills">
                            <label class="tag-pill"><input type="checkbox" value="Repair" /> Repair</label>
                            <label class="tag-pill"><input type="checkbox" value="Installation" /> Installation</label>
                            <label class="tag-pill"><input type="checkbox" value="Cleaning" /> Cleaning</label>
                            <label class="tag-pill"><input type="checkbox" value="Maintenance" /> Maintenance</label>
                            <label class="tag-pill"><input type="checkbox" value="Gawa sa Order" /> Custom / Gawa sa Order</label>
                        </div>
                    </div>
                    <div class="tag-group">
                        <span class="tag-group-label">Iskedyul</span>
                        <div class="tag-pills">
                            <label class="tag-pill"><input type="checkbox" value="Weekdays Only" /> Weekdays Only</label>
                            <label class="tag-pill"><input type="checkbox" value="Weekends Only" /> Weekends Only</label>
                            <label class="tag-pill"><input type="checkbox" value="Flexible Hours" /> Flexible Hours</label>
                            <label class="tag-pill"><input type="checkbox" value="Anytime" /> Anytime</label>
                        </div>
                    </div>
                    <div class="tag-group">
                        <span class="tag-group-label">Urgency</span>
                        <div class="tag-pills">
                            <label class="tag-pill"><input type="checkbox" value="Urgent" /> Urgent</label>
                        </div>
                    </div>
                    <div class="tag-group">
                        <span class="tag-group-label">Kinakailangan / Tiwala</span>
                        <div class="tag-pills">
                            <label class="tag-pill"><input type="checkbox" value="Experienced" /> Experienced</label>
                            <label class="tag-pill"><input type="checkbox" value="Licensed" /> Licensed</label>
                            <label class="tag-pill"><input type="checkbox" value="Pisikal na Trabaho" /> Pisikal na Trabaho</label>
                        </div>
                    </div>
                <asp:HiddenField ID="hfTags" runat="server" />
            </div>

            <%-- Description --%>
            <div class="form-group">
                <label>Detalye <span class="required">*</span></label>
                <asp:TextBox ID="txtServiceDescription" runat="server" TextMode="MultiLine"
                    placeholder="Halimbawa: Nag-aalok ako ng aircon cleaning at repair serbisyo sa Bi&#241;an at mga karatig barangay. May 5 taon na karanasan, may sariling kagamitan. Tumawag o mag-message para sa appointment."
                    MaxLength="500"></asp:TextBox>
                <small class="field-hint"><span id="descCount">0</span> / 500 characters</small>
            </div>

            <asp:Button ID="btnPostService" runat="server" Text="I-post ang Serbisyo"
                CssClass="btn-green" OnClick="BtnPostService_Click" />

        </div>
    </div>

    <script>
        // ── TAG PILLS ──
        var tagPills = document.querySelectorAll('.tag-pill input');
        var hfTags   = document.getElementById('<%= hfTags.ClientID %>');

        function updateTags() {
            var selected = [];
            tagPills.forEach(function (cb) {
                if (cb.checked) selected.push(cb.value);
            });
            hfTags.value = selected.join('|');
        }

        tagPills.forEach(function (cb) {
            cb.addEventListener('change', function () {
                cb.closest('.tag-pill').classList.toggle('active', cb.checked);
                updateTags();
            });
        });

        // ── DESCRIPTION COUNTER ──
        var descBox   = document.getElementById('<%= txtServiceDescription.ClientID %>');
        var descCount = document.getElementById('descCount');
        if (descBox && descCount) {
            descBox.addEventListener('input', function () {
                descCount.textContent = descBox.value.length;
            });
        }
    </script>
</asp:Content>
