using System;
using System.Web.UI;

namespace GROUP6_ANGAT
{
    public partial class SiteMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            bool isLoggedIn = Session["UserId"] != null;
            phLoggedIn.Visible = isLoggedIn;
            phLoggedOut.Visible = !isLoggedIn;
            phSideLoggedIn.Visible = isLoggedIn;
            phSideLoggedOut.Visible = !isLoggedIn;

            if (isLoggedIn)
            {
                lblNavUser.Text = Session["UserName"] != null ? Session["UserName"].ToString() : "User";
            }
        }

        protected void BtnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("~/");
        }
    }
}
