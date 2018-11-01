using System;
using System.Configuration;

namespace Com.PerkinElmer.Service.WuhanSSO
{
    public class Global : System.Web.HttpApplication
    {
        public const string USER_SESSION = "SSO_USER_INFO";
        public const string AUTH_CODE = "AUTH_CODE";

        public static string SSO_SERVER_URL = ConfigurationManager.AppSettings["SSO_SERVER_URL"];
        public static string OAUTH_SERVER_ROOT = ConfigurationManager.AppSettings["OAUTH_SERVER_ROOT"];
        public static string CLIENT_ID => ConfigurationManager.AppSettings["CLIENT_ID"];
        public static string CLIENT_SECRET = ConfigurationManager.AppSettings["CLIENT_SECRET"];

        public static readonly string LOGIN_URL = $"{OAUTH_SERVER_ROOT}authorize?";
        public static readonly string TOKEN_URL = $"{OAUTH_SERVER_ROOT}accessToken?";
        public static readonly string USER_INFO_URL = $"{OAUTH_SERVER_ROOT}userInfo?";

        protected void Application_Start(object sender, EventArgs e)
        {

        }

        protected void Session_Start(object sender, EventArgs e)
        {
            Session.Add(AUTH_CODE, null);
        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {

        }

        protected void Application_AuthenticateRequest(object sender, EventArgs e)
        {

        }

        protected void Application_Error(object sender, EventArgs e)
        {

        }

        protected void Session_End(object sender, EventArgs e)
        {

        }

        protected void Application_End(object sender, EventArgs e)
        {

        }
    }
}