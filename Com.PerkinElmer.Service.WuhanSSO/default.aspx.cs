using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Com.PerkinElmer.Service.WuhanSSO
{
    public partial class _default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(Request["code"]) && Session[Global.AUTH_CODE] == null)
            {
                Session[Global.AUTH_CODE] = Request["code"];

                string tokenUrl = $"{Global.TOKEN_URL}client_id={Global.CLIENT_ID}&client_secret={Global.CLIENT_SECRET}&code={Session[Global.AUTH_CODE]}&grant_type=authorization_code&redirect_uri={Global.SSO_SERVER_URL}";

                HttpWebRequest tokenReq = (HttpWebRequest) HttpWebRequest.Create(tokenUrl);
                tokenReq.Method = "POST";
                tokenReq.ContentType = "application/x-www-form-urlencoded";

                var tokenResponse = tokenReq.GetResponse();

                StreamReader tokenReader = new StreamReader(tokenResponse.GetResponseStream());
                string responseContent = tokenReader.ReadToEnd();
                tokenReader.Close();

                dynamic token = Newtonsoft.Json.JsonConvert.DeserializeObject(responseContent);
                string accessToken = token.access_token.ToString();

                string userInfoUrl = $"{Global.USER_INFO_URL}access_token={accessToken}";

                HttpWebRequest userInfoReq = (HttpWebRequest)HttpWebRequest.Create(userInfoUrl);
                userInfoReq.Method = "POST";
                userInfoReq.ContentType = "application/x-www-form-urlencoded";

                var userInfoResponse = userInfoReq.GetResponse();

                StreamReader userInfoReader = new StreamReader(userInfoResponse.GetResponseStream());
                string userInfo = userInfoReader.ReadToEnd();
                userInfoReader.Close();

                Session.Add(Global.USER_SESSION, userInfo);
            }

            if (Session[Global.AUTH_CODE] == null)
            {
                Response.Redirect($"{Global.LOGIN_URL}client_id={Global.CLIENT_ID}&response_type=code&redirect_uri={Global.SSO_SERVER_URL}");
            }
        }
    }
}