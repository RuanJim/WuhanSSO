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
            if (args.Length == 0)
            {

                return ;
            }

            string sessionId = args[0];
            string fileName = args[1];
            string extName = args[2];

            string userId = SaveLogToDb(sessionId, fileName, extName);
            SaveFileToFtp(sessionId, userId, fileName, extName);
        }

        static void TestClient()
        {
            string host = ConfigurationManager.AppSettings["FTP_HOST"];
            int port = int.Parse(ConfigurationManager.AppSettings["FTP_PORT"]);
            string username = ConfigurationManager.AppSettings["FTP_USERNAME"];
            string password = ConfigurationManager.AppSettings["FTP_PASSWORD"];

            using (FileStream stream = File.Open("C:\\ftp.txt", FileMode.Open))
            {
                FluentFTP.FtpClient client = new FluentFTP.FtpClient(host, port, username, password);

                client.Connect();
                client.Upload(stream, $"/ftp.txt", FluentFTP.FtpExists.Overwrite, true);
                client.Disconnect();

                stream.Close();
            }
        }

        static string SaveLogToDb(string sessionId, string toSave, string extName)
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

                string filename = $"{userId}_{toSave}_{DateTime.Now.ToString("yyyyMMddHHmmss")}.{extName}";

                string sql = $"INSERT INTO SSO.SSO_DOWNLOAD (SESSION_ID, USER_ID, DOWNLOAD_TIME, FILENAME) VALUES('{sessionId}','{userId}','{DateTime.Now.ToString()}', '{filename}')";

                OracleCommand command = new OracleCommand(sql, connection);

                command.ExecuteNonQuery();

                connection.Close();
            }

            return userId;
        }

        static void SaveFileToFtp(string sessionId, string userId, string toSave, string extName)
        {
            string filename = ConfigurationManager.AppSettings["SSO_ROOT"] + sessionId;

            string host = ConfigurationManager.AppSettings["FTP_HOST"];
            int port = int.Parse(ConfigurationManager.AppSettings["FTP_PORT"]);
            string username = ConfigurationManager.AppSettings["FTP_USERNAME"];
            string password = ConfigurationManager.AppSettings["FTP_PASSWORD"];
            string remoteRoot = ConfigurationManager.AppSettings["REMOTE_ROOT"];

            using (FileStream stream = File.Open(filename, FileMode.Open))
            {
                FluentFTP.FtpClient client = new FluentFTP.FtpClient(host, port, username, password);

                client.Connect();
                client.Upload(stream, $"{remoteRoot}{userId}/{userId}_{toSave}_{DateTime.Now.ToString("yyyyMMddHHmmss")}.{extName}", FluentFTP.FtpExists.Overwrite, true);
                client.Disconnect();

                stream.Close();
            }

            File.Delete(filename);
        }
    }
}
