<%@ Page Title="Post Service" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PostService.aspx.cs" Inherits="GROUP6_ANGAT.PostService" %>

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

    <div class="section section-white">
        <div class="section-header">
            <h3>Service <span>Details</span></h3>
            <p class="section-sub">Punan ang impormasyon para sa bagong listing.</p>
        </div>

        <asp:Panel ID="pnlPostMessage" runat="server" CssClass="form-alert" Visible="false">
            <asp:Label ID="lblPostMessage" runat="server" />
        </asp:Panel>

        <div style="max-width: 900px; margin: 0 auto;">
            <div class="form-group">
                <label>Service Title</label>
                <asp:TextBox ID="txtServiceTitle" runat="server" placeholder="Hal. Aircon Cleaning &amp; Repair"></asp:TextBox>
            </div>

            <div class="form-group">
                <label>Category</label>
                <asp:DropDownList ID="ddlCategory" runat="server">
                    <asp:ListItem Value="Karpintero">Karpintero (Carpentry)</asp:ListItem>
                    <asp:ListItem Value="Tubero">Tubero (Plumbing)</asp:ListItem>
                    <asp:ListItem Value="Electrician">Electrician</asp:ListItem>
                    <asp:ListItem Value="Aircon">Appliance Repair</asp:ListItem>
                    <asp:ListItem Value="Mananahi">Pananahi / Tailoring</asp:ListItem>
                    <asp:ListItem Value="General">General</asp:ListItem>
                </asp:DropDownList>
            </div>

            <div class="form-group">
                <label>Location (Full)</label>
                <asp:TextBox ID="txtServiceLocation" runat="server" placeholder="Brgy. Dela Paz, Bi&#241;an"></asp:TextBox>
            </div>

            <div class="form-group">
                <label>Barangay</label>
                <asp:TextBox ID="txtBarangay" runat="server" placeholder="Dela Paz"></asp:TextBox>
            </div>

            <div class="form-group">
                <label>Rate</label>
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
                    <asp:DropDownList ID="ddlRateUnit" runat="server" CssClass="pay-unit">
                        <asp:ListItem Value="/ araw">/ araw</asp:ListItem>
                        <asp:ListItem Value="/ serbisyo">/ serbisyo</asp:ListItem>
                        <asp:ListItem Value="/ unit">/ unit</asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>

            <div class="form-group">
                <label>Tags (gamitin ang | para maghiwalay)</label>
                <asp:TextBox ID="txtServiceTags" runat="server" placeholder="Home Repair|Cabinet Making"></asp:TextBox>
            </div>

            <div class="form-group">
                <label>Status</label>
                <asp:DropDownList ID="ddlStatus" runat="server">
                    <asp:ListItem Value="Available">Available</asp:ListItem>
                    <asp:ListItem Value="Busy Ngayon">Busy Ngayon</asp:ListItem>
                </asp:DropDownList>
            </div>

            <div class="form-group">
                <label>Date Label</label>
                <asp:TextBox ID="txtDateLabel" runat="server" placeholder="Ngayon"></asp:TextBox>
            </div>

            <div class="form-group">
                <label>Description</label>
                <asp:TextBox ID="txtServiceDescription" runat="server" TextMode="MultiLine" placeholder="Maikling detalye tungkol sa serbisyo."></asp:TextBox>
            </div>

            <asp:Button ID="btnPostService" runat="server" Text="I-post ang Serbisyo" CssClass="btn-green" OnClick="BtnPostService_Click" />
        </div>
    </div>
</asp:Content>
