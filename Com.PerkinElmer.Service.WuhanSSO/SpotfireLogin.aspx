<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SpotfireLogin.aspx.cs" Inherits="Com.PerkinElmer.Service.WuhanSSO.SpotfireLogin" %>

<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Configuration" %>
<%@ Import Namespace="System.IO" %>

<%@ Import Namespace="Newtonsoft.Json" %>
<%@ Import Namespace="Oracle.ManagedDataAccess.Client" %>

<%@ Import Namespace="Com.PerkinElmer.Service.WuhanSSO" %>
<%
    dynamic userInfo = JsonConvert.DeserializeObject(Session[Global.USER_SESSION].ToString());

    Dictionary<string, string> userList = new Dictionary<string, string>();

    userList.Add("30000000", "123456");

    string sessionId = Guid.NewGuid().ToString();
    Session.Add("SPOTFIRE_SESSION_ID", sessionId);

    string sql = $@"
INSERT INTO SSO.SSO_LOG
(
  SESSION_ID
 ,LOGIN_TIME
 ,LOGIN_IP
 ,ADMINTITLECODE
 ,MODIFIEDUSER
 ,DEPARTMENTCODE
 ,PASSWORDID
 ,WARDCODE
 ,BTRTLCODE
 ,DEPARTMENTNAME
 ,REGISTERIP
 ,TECHTITLE2
 ,ADMINTITLE
 ,GMTREGISTE
 ,CURRENTADDRES
 ,SALARYCODE
 ,WARDNAME
 ,GMTVALID
 ,GMTAPPROVE
 ,NATIONALITY
 ,TECHLEVEL
 ,TECHTITLECODE
 ,USEREXTEND02
 ,TECHTITLE1
 ,USEREXTEND01
 ,NATIVEPLACE
 ,USEREXTEND03
 ,POSITION
 ,STATUS
 ,BIRTHDAY
 ,GMTMODIFIED
 ,JOBSTATUS
 ,TELEPHONENUMBER
 ,TECHTITLE2CODE
 ,BTRTLNAME
 ,ORDERNUMPOSITIONCODE
 ,TECHTITLE
 ,IDNUMBER
 ,USERCODE
 ,TECHTITLE1CODE
 ,PHOTOURL
 ,APPROVERESULT
 ,APPROVECOMMENT
 ,APPROVEUSER
 ,EMAIL
 ,ISDELETE
 ,SEX
 ,GMTCREATE
 ,USERNAME
 ,USERID
 ,EMPLOYEENATURECODE
 ,EMPLOYEENATURE
 ,CREATEUSER
 ,JOBSTATUSCODE
 ,ID
 ,POSITIONCODE
)
VALUES
(
  '{sessionId}' -- SESSION_ID - NVARCHAR2(200) NOT NULL
 ,'{DateTime.Now.ToString()}' -- LOGIN_TIME - NVARCHAR2(200) NOT NULL
 ,'{Request.UserHostAddress}' -- LOGIN_IP - NVARCHAR2(200) NOT NULL
 ,'{userInfo.adminTitleCode}' -- ADMINTITLECODE - NVARCHAR2(200)
 ,'{userInfo.modifiedUser}' -- MODIFIEDUSER - NVARCHAR2(200)
 ,'{userInfo.departmentCode}' -- DEPARTMENTCODE - NVARCHAR2(200)
 ,'{userInfo.password}' -- PASSWORDID - NVARCHAR2(200)
 ,'{userInfo.wardCode}' -- WARDCODE - NVARCHAR2(200)
 ,'{userInfo.btrtlCode}' -- BTRTLCODE - NVARCHAR2(200)
 ,'{userInfo.departmentName}' -- DEPARTMENTNAME - NVARCHAR2(200)
 ,'{userInfo.registerIp}' -- REGISTERIP - NVARCHAR2(200)
 ,'{userInfo.techTitle2}' -- TECHTITLE2 - NVARCHAR2(200)
 ,'{userInfo.adminTitle}' -- ADMINTITLE - NVARCHAR2(200)
 ,'{userInfo.gmtRegiste}' -- GMTREGISTE - NVARCHAR2(200)
 ,'{userInfo.currentAddres}' -- CURRENTADDRES - NVARCHAR2(200)
 ,'{userInfo.salaryCode}' -- SALARYCODE - NVARCHAR2(200)
 ,'{userInfo.wardName}' -- WARDNAME - NVARCHAR2(200)
 ,'{userInfo.gmtValid}' -- GMTVALID - NVARCHAR2(200)
 ,'{userInfo.gmtApprove}' -- GMTAPPROVE - NVARCHAR2(200)
 ,'{userInfo.nationality}' -- NATIONALITY - NVARCHAR2(200)
 ,'{userInfo.techLevel}' -- TECHLEVEL - NVARCHAR2(200)
 ,'{userInfo.techTitleCode}' -- TECHTITLECODE - NVARCHAR2(200)
 ,'{userInfo.userExtend02}' -- USEREXTEND02 - NVARCHAR2(200)
 ,'{userInfo.techTitle1}' -- TECHTITLE1 - NVARCHAR2(200)
 ,'{userInfo.userExtend01}' -- USEREXTEND01 - NVARCHAR2(200)
 ,'{userInfo.nativePlace}' -- NATIVEPLACE - NVARCHAR2(200)
 ,'{userInfo.userExtend03}' -- USEREXTEND03 - NVARCHAR2(200)
 ,'{userInfo.position}' -- POSITION - NVARCHAR2(200)
 ,'{userInfo.status}' -- STATUS - NVARCHAR2(200)
 ,'{userInfo.birthday}' -- BIRTHDAY - NVARCHAR2(200)
 ,'{userInfo.gmtModified}' -- GMTMODIFIED - NVARCHAR2(200)
 ,'{userInfo.jobStatus}' -- JOBSTATUS - NVARCHAR2(200)
 ,'{userInfo.telephoneNumber}' -- TELEPHONENUMBER - NVARCHAR2(200)
 ,'{userInfo.techTitle2Code}' -- TECHTITLE2CODE - NVARCHAR2(200)
 ,'{userInfo.btrtlName}' -- BTRTLNAME - NVARCHAR2(200)
 ,'{userInfo.orderNum}' -- ORDERNUMPOSITIONCODE - NVARCHAR2(200)
 ,'{userInfo.techTitle}' -- TECHTITLE - NVARCHAR2(200)
 ,'{userInfo.idNumber}' -- IDNUMBER - NVARCHAR2(200)
 ,'{userInfo.userCode}' -- USERCODE - NVARCHAR2(200)
 ,'{userInfo.techTitle1Code}' -- TECHTITLE1CODE - NVARCHAR2(200)
 ,'{userInfo.photoUrl}' -- PHOTOURL - NVARCHAR2(200)
 ,'{userInfo.approveResult}' -- APPROVERESULT - NVARCHAR2(200)
 ,'{userInfo.approveComment}' -- APPROVECOMMENT - NVARCHAR2(200)
 ,'{userInfo.approveUser}' -- APPROVEUSER - NVARCHAR2(200)
 ,'{userInfo.email}' -- EMAIL - NVARCHAR2(200)
 ,'{userInfo.isDelete}' -- ISDELETE - NVARCHAR2(200)
 ,'{userInfo.sex}' -- SEX - NVARCHAR2(200)
 ,'{userInfo.gmtCreate}' -- GMTCREATE - NVARCHAR2(200)
 ,'{userInfo.userName}' -- USERNAME - NVARCHAR2(200)
 ,'{userInfo.userId}' -- USERID - NVARCHAR2(200)
 ,'{userInfo.employeeNatureCode}' -- EMPLOYEENATURECODE - NVARCHAR2(200)
 ,'{userInfo.employeeNature}' -- EMPLOYEENATURE - NVARCHAR2(200)
 ,'{userInfo.createUser}' -- CREATEUSER - NVARCHAR2(200)
 ,'{userInfo.jobStatusCode}' -- JOBSTATUSCODE - NVARCHAR2(200)
 ,'{userInfo.id}' -- ID - NVARCHAR2(200)
 ,'{userInfo.positionCode}' -- POSITIONCODE - NVARCHAR2(200)
)";

    string[] departments = userInfo.departmentName.ToString().Split(new char[] { '|' });

    using (OracleConnection connection = new OracleConnection(ConfigurationManager.AppSettings["CONNECTION_STRING"]))
    {
        connection.Open();

        OracleCommand command = new OracleCommand(sql, connection);

        command.ExecuteNonQuery();

        foreach (string department in departments)
        {
            string departmentSql = $"INSERT INTO SSO_DEPARTMENT(SESSION_ID, DEPARTMNET), VALUES('{sessionId}', '{department}')";

            OracleCommand departmentCommand = new OracleCommand(departmentSql, connection);

            departmentCommand.ExecuteNonQuery();
        }

        connection.Close();
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title></title>
    <script>
        window.onload = function () {
            location = "http://192.168.62.175:790/spotfire/resources/custom-login/custom-login-app-example.html?sessionid=<%=sessionId%>&username=<%=userInfo.departmentCode%>&password=<%=userList[userInfo.departmentCode.ToString()]%>";
		}
    </script>
</head>
<body>
</body>
</html>
