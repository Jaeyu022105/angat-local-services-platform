<%@ Page Title="I-rehistro ang Negosyo" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PostNegosyo.aspx.cs" Inherits="GROUP6_ANGAT.PostNegosyo" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div id="page-hero">
        <div class="hero-circles">
            <div class="c1"></div>
            <div class="c2"></div>
        </div>
        <div class="page-hero-inner">
            <span class="hero-badge"><i class='bx bx-store'></i> Negosyo Registration</span>
            <h2>I-rehistro ang <strong>Negosyo</strong></h2>
            <p class="hero-desc">
                I-post ang inyong tindahan para makita ng mga kababayan at madali kang mahanap.
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
            <h3>Negosyo <span>Details</span></h3>
            <p class="section-sub">Punan ang impormasyon para maipakita ang inyong negosyo sa directory.</p>
        </div>

        <asp:Panel ID="pnlPostMessage" runat="server" CssClass="form-alert" Visible="false">
            <asp:Label ID="lblPostMessage" runat="server" />
        </asp:Panel>

        <div style="max-width: 720px; margin: 0 auto;">

            <%-- Business Name --%>
            <div class="form-group">
                <label>Pangalan ng Negosyo <span class="required">*</span></label>
                <asp:TextBox ID="txtBusinessName" runat="server"
                    placeholder="Halimbawa: Aling Nena Sari-Sari Store, Karinderia ni Mang Jose"></asp:TextBox>
            
            </div>

            <%-- Category --%>
            <div class="form-group">
                <label>Kategorya <span class="required">*</span></label>
                <asp:DropDownList ID="ddlCategory" runat="server">
                    <asp:ListItem Value="">-- Pumili ng Kategorya --</asp:ListItem>
                    <%-- Food & Retail --%>
                    <asp:ListItem Value="Kainan at Panaderya">Kainan at Panaderya</asp:ListItem>
                    <asp:ListItem Value="Sari-Sari Store">Sari-Sari Store</asp:ListItem>
                    <asp:ListItem Value="Tindahan ng Damit o Ukay-Ukay">Tindahan ng Damit at Ukay-Ukay</asp:ListItem>
                    <asp:ListItem Value="Tindahan ng Gamit o Regalo">Tindahan ng Gamit at Regalo</asp:ListItem>
                    <%-- Tech & Services --%>
                    <asp:ListItem Value="Computer at Printing Shop">Computer at Printing Shop</asp:ListItem>
                    <asp:ListItem Value="Electronics at Repair Shop">Electronics at Repair Shop</asp:ListItem>
                    <asp:ListItem Value="Laundry Shop">Laundry Shop</asp:ListItem>
                    <asp:ListItem Value="Salon at Barbershop">Salon at Barbershop</asp:ListItem>
                    <%-- Specialized --%>
                    <asp:ListItem Value="Hardware at Construction">Hardware at Construction</asp:ListItem>
                    <asp:ListItem Value="Tindahan ng Gamot o Halaman">Tindahan ng Gamot o Halaman</asp:ListItem>
                    <asp:ListItem Value="Veterinary at Pet Supplies">Veterinary at Pet Supplies</asp:ListItem>
                    <%-- Others --%>
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
            </div>

            <%-- Eksaktong Address --%>
            <div class="form-group">
                <label>Eksaktong Address <span class="required">*</span></label>
                <asp:TextBox ID="txtAddressLine" runat="server"
                    placeholder="Halimbawa: Tapat ng Simbahan, Brgy. De La Paz, Bi&#241;an"></asp:TextBox>
                <small class="field-hint">Para mas madaling mahanap ng mga kustomer.</small>
            </div>

            <%-- Owner --%>
            <div class="form-group">
                <label>Owner / Contact Name <span class="optional">(optional)</span></label>
                <asp:TextBox ID="txtOwnerName" runat="server" placeholder="Halimbawa: Juan Dela Cruz"></asp:TextBox>
                <small class="field-hint">Kung walang ilalagay, gagamitin ang pangalan ng naka-login.</small>
            </div>

            <%-- Contact Number --%>
            <div class="form-group">
                <label>Contact Number <span class="required">*</span></label>
                <asp:TextBox ID="txtContactNumber" runat="server" placeholder="09XXXXXXXXX"></asp:TextBox>
                <small class="field-hint">
                    <asp:Label ID="lblPhoneHint" runat="server"
                        Text="Awtomatikong gagamitin ang inyong registered na number kung walang ilalagay." />
                </small>
            </div>

            <%-- Oras ng Operasyon — dropdowns populated server-side --%>
            <div class="form-group">
                <label>Oras ng Operasyon <span class="required">*</span></label>
                <div class="pay-row" style="margin-bottom: 12px;">
                    <asp:DropDownList ID="ddlOpenHour"  runat="server" CssClass="pay-unit"></asp:DropDownList>
                    <span class="pay-sep">hanggang</span>
                    <asp:DropDownList ID="ddlCloseHour" runat="server" CssClass="pay-unit"></asp:DropDownList>
                </div>

                <small class="field-hint" style="margin-bottom: 8px; display:block;">Mga araw na bukas:</small>
                <div class="tag-pills" style="flex-wrap:wrap;">
                    <label class="tag-pill"><input type="checkbox" name="dayCheck" value="0" class="day-check" /> Lunes</label>
                    <label class="tag-pill"><input type="checkbox" name="dayCheck" value="1" class="day-check" /> Martes</label>
                    <label class="tag-pill"><input type="checkbox" name="dayCheck" value="2" class="day-check" /> Miyerkules</label>
                    <label class="tag-pill"><input type="checkbox" name="dayCheck" value="3" class="day-check" /> Huwebes</label>
                    <label class="tag-pill"><input type="checkbox" name="dayCheck" value="4" class="day-check" /> Biyernes</label>
                    <label class="tag-pill"><input type="checkbox" name="dayCheck" value="5" class="day-check" /> Sabado</label>
                    <label class="tag-pill"><input type="checkbox" name="dayCheck" value="6" class="day-check" /> Linggo</label>                </div>
                <asp:HiddenField ID="hfHours" runat="server" />
                <small class="field-hint" style="margin-top: 8px;">
                    Preview: <span id="hoursPreview" style="font-weight:600; color:var(--primary);">—</span>
                </small>
            </div>

            <%-- Google Maps --%>
            <div class="form-group">
                <label>Google Maps Link <span class="optional">(optional)</span></label>
                <asp:TextBox ID="txtMapEmbedUrl" runat="server"
                    placeholder="Halimbawa: https://maps.app.goo.gl/..."></asp:TextBox>
                <small class="field-hint">I-paste ang Google Maps link ng inyong tindahan.</small>
            </div>

            <%-- Tags --%>
            <div class="form-group">
                <label>Tags <span class="required">*</span></label>
                <small class="field-hint" style="margin-bottom: 10px; display:block;">Piliin ang lahat ng angkop sa inyong negosyo.</small>
                <div class="tag-group">
                    <span class="tag-group-label">Paraan ng Bayad</span>
                    <div class="tag-pills">
                        <label class="tag-pill"><input type="checkbox" value="GCash Accepted" /> GCash Accepted</label>
                        <label class="tag-pill"><input type="checkbox" value="Cash Only" /> Cash Only</label>
                    </div>
                </div>
                <div class="tag-group">
                    <span class="tag-group-label">Paraan ng Order</span>
                    <div class="tag-pills">
                        <label class="tag-pill"><input type="checkbox" value="Pick-up" /> Pick-up</label>
                        <label class="tag-pill"><input type="checkbox" value="Delivery" /> Delivery</label>
                        <label class="tag-pill"><input type="checkbox" value="Dine-in" /> Dine-in</label>
                    </div>
                </div>
                <asp:HiddenField ID="hfTags" runat="server" />
            </div>

            <asp:Button ID="btnPostNegosyo" runat="server" Text="I-rehistro ang Negosyo"
                CssClass="btn-green" OnClick="BtnPostNegosyo_Click" />

        </div>
    </div>

    <script>
        var DAY_NAMES = ['Lunes', 'Martes', 'Miyerkules', 'Huwebes', 'Biyernes', 'Sabado', 'Linggo'];

        var openHour = document.getElementById('<%= ddlOpenHour.ClientID %>');
        var closeHour = document.getElementById('<%= ddlCloseHour.ClientID %>');
        var dayChecks  = document.querySelectorAll('.day-check');
        var hfHours    = document.getElementById('<%= hfHours.ClientID %>');
        var hfTags     = document.getElementById('<%= hfTags.ClientID %>');
        var preview = document.getElementById('hoursPreview');

        // ── HOURS PREVIEW ──
        function buildDayString(selected) {
            if (selected.length === 0) return '';
            if (selected.length === 7) return 'Araw-araw';

            var weekdays = [0, 1, 2, 3, 4];
            var weekends = [5, 6];
            var isWeekdays = selected.length === 5 && weekdays.every(function (d) { return selected.indexOf(d) !== -1; });
            var isWeekends = selected.length === 2 && weekends.every(function (d) { return selected.indexOf(d) !== -1; });
            if (isWeekdays) return 'Weekdays';
            if (isWeekends) return 'Weekends';

            var parts = [];
            var i = 0;
            while (i < selected.length) {
                var start = selected[i];
                var end = selected[i];
                while (i + 1 < selected.length && selected[i + 1] === selected[i] + 1) {
                    i++; end = selected[i];
                }
                if (end - start >= 2) parts.push(DAY_NAMES[start] + ' - ' + DAY_NAMES[end]);
                else if (end - start === 1) parts.push(DAY_NAMES[start] + ', ' + DAY_NAMES[end]);
                else parts.push(DAY_NAMES[start]);
                i++;
            }
            return parts.join(', ');
        }

        function updateHours() {
            var sameTime = openHour.value && closeHour.value && openHour.value === closeHour.value;

            // Get selected days
            var selected = [];
            dayChecks.forEach(function (cb) {
                cb.closest('.tag-pill').classList.toggle('active', cb.checked);
                if (cb.checked) selected.push(parseInt(cb.value));
            });
            selected.sort(function (a, b) { return a - b; });

            // Build days string for preview only
            var dayStr = '';
            if (selected.length === 0) {
                dayStr = 'Hindi tinukoy';
            } else if (selected.length === 7) {
                dayStr = 'Araw-araw';
            } else {
                var weekdays = [0, 1, 2, 3, 4];
                var weekends = [5, 6];
                var isWeekdays = selected.length === 5 && weekdays.every(function (d) { return selected.indexOf(d) !== -1; });
                var isWeekends = selected.length === 2 && weekends.every(function (d) { return selected.indexOf(d) !== -1; });

                if (isWeekdays) {
                    dayStr = 'Weekdays (Lunes - Biyernes)';
                } else if (isWeekends) {
                    dayStr = 'Weekends (Sabado - Linggo)';
                } else {
                    var dayNames = ['Lunes', 'Martes', 'Miyerkules', 'Huwebes', 'Biyernes', 'Sabado', 'Linggo'];
                    var parts = [];
                    var i = 0;
                    while (i < selected.length) {
                        var start = selected[i];
                        var end = selected[i];
                        while (i + 1 < selected.length && selected[i + 1] === selected[i] + 1) {
                            i++;
                            end = selected[i];
                        }
                        if (end - start >= 2) {
                            parts.push(dayNames[start] + ' - ' + dayNames[end]);
                        } else if (end - start === 1) {
                            parts.push(dayNames[start] + ', ' + dayNames[end]);
                        } else {
                            parts.push(dayNames[start]);
                        }
                        i++;
                    }
                    dayStr = parts.join(', ');
                }
            }

            if (sameTime) {
                preview.textContent = dayStr + ' | Pumili ng iba\'t ibang oras';
                preview.style.color = '#dc2626';
                return;
            }

            var timeStr = openHour.value + ' - ' + closeHour.value;
            var result = (dayStr && dayStr !== 'Hindi tinukoy') ? dayStr + ' | ' + timeStr : timeStr;

            preview.textContent = result;
            preview.style.color = 'var(--primary)';
        }

        openHour.addEventListener('change', updateHours);
        closeHour.addEventListener('change', updateHours);
        dayChecks.forEach(function (cb) { cb.addEventListener('change', updateHours); });

        updateHours();

        // ── TAG PILLS ──
        var tagPills = document.querySelectorAll('.tag-pill input:not(.day-check)');

        function updateTags() {
            var selected = [];
            tagPills.forEach(function (cb) { if (cb.checked) selected.push(cb.value); });
            hfTags.value = selected.join('|');
        }

        tagPills.forEach(function (cb) {
            cb.addEventListener('change', function () {
                cb.closest('.tag-pill').classList.toggle('active', cb.checked);
                updateTags();
            });
        });
    </script>
</asp:Content>
