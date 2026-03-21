<%@ Page Title="Post Job" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PostJob.aspx.cs" Inherits="GROUP6_ANGAT.PostJob" %>

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
                Magdagdag ng bagong job listing para makita ng mga aplikante sa Biñan.
            </p>
        </div>
        <div class="wave">
            <svg viewBox="0 0 1440 80" xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="none">
                <path d="M0,80 L1440,80 L1440,80 L0,80 Z" fill="#ffffff"/>
            </svg>
        </div>
    </div>

    <div class="section section-white">
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
                <asp:TextBox ID="txtJobTitle" runat="server" placeholder="Hal. House Helper, Personal Driver"></asp:TextBox>
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
                    <asp:ListItem Value="Biñan">Biñan (Poblacion)</asp:ListItem>
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
                    <asp:ListItem Value="New Biñan">New Biñan</asp:ListItem>
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
                <div class="pay-row"> <div class="pay-field">
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
                <label>Tags</label>
                <small class="field-hint" style="margin-bottom: 10px; display:block;">Piliin ang lahat ng angkop.</small>
                <div class="tag-pills">
                    <label class="tag-pill"><input type="checkbox" value="Full-time" /> Full-time</label>
                    <label class="tag-pill"><input type="checkbox" value="Part-time" /> Part-time</label>
                    <label class="tag-pill"><input type="checkbox" value="Urgent" /> Urgent</label>
                    <label class="tag-pill"><input type="checkbox" value="Live-in" /> Live-in</label>
                    <label class="tag-pill"><input type="checkbox" value="May Karanasan" /> May Karanasan</label>
                    <label class="tag-pill"><input type="checkbox" value="Pisikal na Trabaho" /> Pisikal na Trabaho</label>
                    <label class="tag-pill"><input type="checkbox" value="Flexible Hours" /> Flexible Hours</label>
                    <label class="tag-pill"><input type="checkbox" value="Weekdays Only" /> Weekdays Only</label>
                    <label class="tag-pill"><input type="checkbox" value="Weekends Only" /> Weekends Only</label>
                </div>
                <asp:HiddenField ID="hfTags" runat="server" />
            </div>

            <%-- Status --%>
            <div class="form-group">
                <label>Status</label>
                <asp:DropDownList ID="ddlStatus" runat="server">
                    <asp:ListItem Value="Available">Available</asp:ListItem>
                    <asp:ListItem Value="Filled">Filled</asp:ListItem>
                    <asp:ListItem Value="Paused">Paused</asp:ListItem>
                </asp:DropDownList>
            </div>

            <%-- Description --%>
            <div class="form-group">
                <label>Detalye <span class="required">*</span></label>
                <asp:TextBox ID="txtJobDescription" runat="server" TextMode="MultiLine"
                    placeholder="Maikling detalye tungkol sa trabaho. Max 500 characters."
                    MaxLength="500"></asp:TextBox>
                <small class="field-hint"><span id="descCount">0</span> / 500 characters</small>
            </div>

            <asp:Button ID="btnPostJob" runat="server" Text="I-post ang Trabaho"
                CssClass="btn-green" OnClick="BtnPostJob_Click" />

        </div>
    </div>

    <script>
        // Tag pills
        var tagPills = document.querySelectorAll('.tag-pill input');
        var hfTags = document.getElementById('<%= hfTags.ClientID %>');

        function updateTags() {
            var selected = [];
            tagPills.forEach(function(cb) {
                if (cb.checked) selected.push(cb.value);
            });
            hfTags.value = selected.join('|');
        }

        tagPills.forEach(function(cb) {
            cb.addEventListener('change', function() {
                cb.closest('.tag-pill').classList.toggle('active', cb.checked);

                updateTags();
            });
        });

        // Description counter
        var descBox = document.getElementById('<%= txtJobDescription.ClientID %>');
        var descCount = document.getElementById('descCount');
        if (descBox && descCount) {
            descBox.addEventListener('input', function() {
                descCount.textContent = descBox.value.length;
            });
        }
    </script>
</asp:Content>