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

        <div style="max-width: 900px; margin: 0 auto;">
            <div class="form-group">
                <label>Job Title</label>
                <asp:TextBox ID="txtJobTitle" runat="server" placeholder="Hal. House Helper / Kasambahay"></asp:TextBox>
            </div>

            <div class="form-group">
                <label>Category</label>
                <asp:DropDownList ID="ddlCategory" runat="server">
                    <asp:ListItem Value="Household">Household</asp:ListItem>
                    <asp:ListItem Value="Driver">Driver</asp:ListItem>
                    <asp:ListItem Value="Laundry">Laundry</asp:ListItem>
                    <asp:ListItem Value="Retail">Retail</asp:ListItem>
                    <asp:ListItem Value="Food">Food</asp:ListItem>
                    <asp:ListItem Value="Warehouse">Warehouse</asp:ListItem>
                    <asp:ListItem Value="General">General</asp:ListItem>
                </asp:DropDownList>
            </div>

            <div class="form-group">
                <label>Location (Full)</label>
                <asp:TextBox ID="txtJobLocation" runat="server" placeholder="Brgy. Dela Paz, Biñan"></asp:TextBox>
            </div>

            <div class="form-group">
                <label>Barangay</label>
                <asp:TextBox ID="txtBarangay" runat="server" placeholder="Dela Paz"></asp:TextBox>
            </div>

            <div class="form-group">
                <label>Pay</label>
                <div class="pay-inputs">
                    <div class="pay-field">
                        <span class="pay-currency">₱</span>
                        <asp:TextBox ID="txtPayMin" runat="server" placeholder="5,000"></asp:TextBox>
                    </div>
                    <span class="pay-sep">-</span>
                    <div class="pay-field">
                        <span class="pay-currency">₱</span>
                        <asp:TextBox ID="txtPayMax" runat="server" placeholder="6,500"></asp:TextBox>
                    </div>
                    <asp:DropDownList ID="ddlPayUnit" runat="server" CssClass="pay-unit">
                        <asp:ListItem Value="/ araw">/ araw</asp:ListItem>
                        <asp:ListItem Value="/ buwan">/ buwan</asp:ListItem>
                        <asp:ListItem Value="/ unit">/ unit</asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>

            <div class="form-group">
                <label>Tags (gamitin ang | para maghiwalay)</label>
                <asp:TextBox ID="txtJobTags" runat="server" placeholder="Full-time|May Tirahan"></asp:TextBox>
            </div>

            <div class="form-group">
                <label>Status</label>
                <asp:DropDownList ID="ddlStatus" runat="server">
                    <asp:ListItem Value="Bukas">Bukas</asp:ListItem>
                    <asp:ListItem Value="Busy Ngayon">Busy Ngayon</asp:ListItem>
                </asp:DropDownList>
            </div>

            <div class="form-group">
                <label>Date Label</label>
                <asp:TextBox ID="txtDateLabel" runat="server" placeholder="Ngayon"></asp:TextBox>
            </div>

            <div class="form-group">
                <label>Description</label>
                <asp:TextBox ID="txtJobDescription" runat="server" TextMode="MultiLine" placeholder="Maikling detalye tungkol sa trabaho."></asp:TextBox>
            </div>

            <asp:Button ID="btnPostJob" runat="server" Text="I-post ang Trabaho" CssClass="btn-green" OnClick="BtnPostJob_Click" />
        </div>
    </div>
</asp:Content>
