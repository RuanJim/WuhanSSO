using Oracle.ManagedDataAccess.Client;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Net;
using System.Text;
using System.Threading.Tasks;

namespace Com.PerkinElmer.Service.WuhanSSO.FtpTool
{
    class Program
    {
        static void Main(string[] args)
        {
            string sessionId = args[0];

            string userId = SaveLogToDb(sessionId);
            SaveFileToFtp(sessionId, userId);
        }

        static string SaveLogToDb(string sessionId)
        {
            string userId = string.Empty;

            using (OracleConnection connection = new OracleConnection(ConfigurationManager.AppSettings["CONNECTION_STRING"]))
            {
                connection.Open();

                string userIdQuery = $"SELECT USERID FROM SSO_LOG WHERE SESSION_ID = '{sessionId}'";

                OracleCommand userIdCommand = new OracleCommand(userIdQuery, connection);

                OracleDataReader reader = userIdCommand.ExecuteReader();

                reader.Read();

                userId = reader.GetString(0);

                string sql = $"INSERT INTO SSO.SSO_DOWNLOAD (SESSION_ID, USER_ID, DOWNLOAD_TIME) VALUES('{sessionId}','{userId}','{DateTime.Now.ToString()}')";

                OracleCommand command = new OracleCommand(sql, connection);

                command.ExecuteNonQuery();

                connection.Close();
            }

            return userId;
        }

        static void SaveFileToFtp(string sessionId, string userId)
        {
            string filename = ConfigurationManager.AppSettings["SSO_ROOT"] + sessionId;

            string host = ConfigurationManager.AppSettings["FTP_HOST"];
            int port = int.Parse(ConfigurationManager.AppSettings["FTP_PORT"]);
            string username = ConfigurationManager.AppSettings["FTP_USERNAME"];
            string password = ConfigurationManager.AppSettings["FTP_PASSWORD"];

            using (FileStream stream = File.Open(filename, FileMode.Open))
            {
                FluentFTP.FtpClient client = new FluentFTP.FtpClient(host, port, username, password);

                client.Connect();
                client.Upload(stream, "/" + userId + "/" + sessionId + ".xlsx", FluentFTP.FtpExists.Overwrite, true);
                client.Disconnect();

                stream.Close();
            }

            File.Delete(filename);
        }
    }
}
