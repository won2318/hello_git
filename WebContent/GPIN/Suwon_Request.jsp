<%@ page language = "java" contentType = "text/html; charset=UTF-8"%>

<%@ page import="gov.mogaha.gpin.sp.proxy.*" %>

<%
    /**
     * 사용자 본인인증을 요청하는 페이지입니다.
     * 회원가입, 게시판 글쓰기등 본인인증이 필요한 경우에 이 페이지를 호출하시면 됩니다.
     * 인증이 완료되면 session에 사용자정보가 설정됩니다.
     * 설정된 사용자 정보를 참조하는 방법은 Sample-AuthResponse를 참조하시기 바랍니다.
     */
    // 인증완료후 session에 저장된 사용자정보를 참조할 페이지, (이용기관 인증수신페이지와 다릅니다.)
    // TODO 이용기관에서 사용하실 페이지를 지정합니다.
	
	String type  = request.getParameter("type"); //type
    String board_id  = request.getParameter("board_id"); // board_id
    String list_id  = request.getParameter("list_id"); // list_id

    session.setAttribute("gpinAuthRetPage", "Suwon_Response.jsp?board_id="+board_id+"&list_id="+list_id+"&type="+type);
    // 인증 수신시 요청처와 동일한 위치인지를 확인할 요청자IP를 session에 저장합니다.
    session.setAttribute("gpinUserIP", request.getRemoteAddr());

 
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>GPIN 인증 중</title>
<script language="javascript" type="text/javascript">
<!--
function body_onload()
{
    document.reqForm.SAMLRequest.value = "PEF1dGhuUmVxdWVzdCB4bWxucz0idXJuOm9hc2lzOm5hbWVzOnRjOlNBTUw6Mi4wOnByb3RvY29s"
+"IiBBc3NlcnRpb25Db25zdW1lclNlcnZpY2VVUkw9Ik5vVXNlIiBBdHRyaWJ1dGVDb25zdW1pbmdT"
+"ZXJ2aWNlSW5kZXg9IjAiIEZvcmNlQXV0aG49ImZhbHNlIiBJRD0iXzk3YTZlMjEyMmM3OGIyZWM1"
+"NTIwNmQ2YmJjMjllNWM4YjM3ODZiNGQiIElzUGFzc2l2ZT0iZmFsc2UiIElzc3VlSW5zdGFudD0i"
+"MjAxNS0xMS0xOFQxNzo0NToxMi4xNDUrMDk6MDAiIFByb3RvY29sQmluZGluZz0idXJuOm9hc2lz"
+"Om5hbWVzOnRjOlNBTUw6Mi4wOmJpbmRpbmdzOkhUVFAtUE9TVCIgUHJvdmlkZXJOYW1lPSJIQkVG"
+"T1IwMTIwMTAiIFZlcnNpb249IjIuMCI+PG5zMTpJc3N1ZXIgeG1sbnM6bnMxPSJ1cm46b2FzaXM6"
+"bmFtZXM6dGM6U0FNTDoyLjA6YXNzZXJ0aW9uIiBGb3JtYXQ9InVybjpvYXNpczpuYW1lczp0YzpT"
+"QU1MOjIuMDpuYW1laWQtZm9ybWF0OmVudGl0eSI+SEJFRk9SMDEyMDEwPC9uczE6SXNzdWVyPjxk"
+"czpTaWduYXR1cmUgeG1sbnM6ZHM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvMDkveG1sZHNpZyMi"
+"Pgo8ZHM6U2lnbmVkSW5mbz4KPGRzOkNhbm9uaWNhbGl6YXRpb25NZXRob2QgQWxnb3JpdGhtPSJo"
+"dHRwOi8vd3d3LnczLm9yZy8yMDAxLzEwL3htbC1leGMtYzE0biMiPjwvZHM6Q2Fub25pY2FsaXph"
+"dGlvbk1ldGhvZD4KPGRzOlNpZ25hdHVyZU1ldGhvZCBBbGdvcml0aG09Imh0dHA6Ly93d3cudzMu"
+"b3JnLzIwMDAvMDkveG1sZHNpZyNyc2Etc2hhMSI+PC9kczpTaWduYXR1cmVNZXRob2Q+CjxkczpS"
+"ZWZlcmVuY2UgVVJJPSIjXzk3YTZlMjEyMmM3OGIyZWM1NTIwNmQ2YmJjMjllNWM4YjM3ODZiNGQi"
+"Pgo8ZHM6VHJhbnNmb3Jtcz4KPGRzOlRyYW5zZm9ybSBBbGdvcml0aG09Imh0dHA6Ly93d3cudzMu"
+"b3JnLzIwMDAvMDkveG1sZHNpZyNlbnZlbG9wZWQtc2lnbmF0dXJlIj48L2RzOlRyYW5zZm9ybT4K"
+"PGRzOlRyYW5zZm9ybSBBbGdvcml0aG09Imh0dHA6Ly93d3cudzMub3JnLzIwMDEvMTAveG1sLWV4"
+"Yy1jMTRuIyI+PC9kczpUcmFuc2Zvcm0+CjwvZHM6VHJhbnNmb3Jtcz4KPGRzOkRpZ2VzdE1ldGhv"
+"ZCBBbGdvcml0aG09Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvMDkveG1sZHNpZyNzaGExIj48L2Rz"
+"OkRpZ2VzdE1ldGhvZD4KPGRzOkRpZ2VzdFZhbHVlPjdmdmlRM3IwanhrQlA2dVZEZUlXdkxyMGd6"
+"Yz08L2RzOkRpZ2VzdFZhbHVlPgo8L2RzOlJlZmVyZW5jZT4KPC9kczpTaWduZWRJbmZvPgo8ZHM6"
+"U2lnbmF0dXJlVmFsdWU+ClF6QkNHcExYKy9wNTlveWpGeXkzQUs5c0FvdzJOZlYzYlhQeXkraml0"
+"SDIxelVMSVdDbTV0dTNQTGd5RU90V0pJVDNuaklDeGpJMXIKaXlSNENUZERUc0o0azJ5b3lmcEtp"
+"N1BZWXBIL2UyY0czVjJvRzg4aEwzWkRtL245VzUzd2x0bnQyRmRiOXdkS0NIenNCa2UrRXUxMgov"
+"SXpIS1kyalAyWFRJZXVRQ0ZpYWJjM0ZRbzJWMzFva0M1S2hJNjhCeHpkL05SSUJwbHNKZzF3WnFz"
+"Q2dlMFdmZVFqdHJKTzc4WXhOCkdOVUZDMC92Q1dqcU5kVVhUTjhUd2xSY1VTRkRvTmg0WG5yWHkv"
+"QWxuQjY2RUx1SHFkZjd2QVhBQVNJTTZaaWp6aysvVmJ3ejF5OG8KWGtzeFdENitYc2EvSE05SGlT"
+"ZWlRaEdoYTNWajZzTTVDY01zMEE9PQo8L2RzOlNpZ25hdHVyZVZhbHVlPgo8ZHM6S2V5SW5mbz4K"
+"PGRzOlg1MDlEYXRhPgo8ZHM6WDUwOUNlcnRpZmljYXRlPgpNSUlFelRDQ0E3V2dBd0lCQWdJVUVB"
+"aTV5Um1LQzB1bkRWWXRQQlJYSmphZFZkWXdEUVlKS29aSWh2Y05BUUVMQlFBd1VERUxNQWtHCkEx"
+"VUVCaE1DUzFJeEhEQWFCZ05WQkFvTUUwZHZkbVZ5Ym0xbGJuUWdiMllnUzI5eVpXRXhEVEFMQmdO"
+"VkJBc01CRWRRUzBreEZEQVMKQmdOVkJBTU1DME5CTVRNeE1UQXdNREF4TUI0WERURXpNVEl5TnpB"
+"eU1qa3pPVm9YRFRFMk1ETXlOekUwTlRrMU9Wb3dYVEVMTUFrRwpBMVVFQmhNQ1MxSXhIREFhQmdO"
+"VkJBb01FMGR2ZG1WeWJtMWxiblFnYjJZZ1MyOXlaV0V4R0RBV0JnTlZCQXNNRDBkeWIzVndJRzlt"
+"CklGTmxjblpsY2pFV01CUUdBMVVFQXd3TlUxWlNNemMwTURBME9UQXdNakNDQVNJd0RRWUpLb1pJ"
+"aHZjTkFRRUJCUUFEZ2dFUEFEQ0MKQVFvQ2dnRUJBTHhFMXVXblBSdlgxbDNMTUZOaDhpSytIS1cr"
+"MmJ0cENCeFV4eW9KN3lvWFo2Tm9KcXgzRlRyYktUQ0J1QzcrNGdxSAo2M2VEQ2czRXZUT3dlYkNX"
+"d0JvcGJhUGU2WlhxZ1YrR01ya3p1ZkdUaTJZV1g2cFVkQWlvVi9QRnltcmdpcDNzdEJ5WXN5N3Qx"
+"QkRoClN2QnNmMWhEdVEybXgwM1lZNk1tZFFxbmFEakUydEdLbGczRXF4NUFIMjZFakI3MU1sTVll"
+"SzFJMEpGSzYrNEozbStBUmlRcEhEMFkKZ2dHdnY0V3F5Y2ZTQ05vYTduSGs4eUZaVmNIZFNjYjNY"
+"RzVzVzlucGlqSCsxck43TkVmOEp6WjhDaDZSVys2MkphcXhMZmVab3pqVQpvZmJobHAzZVc2bFVl"
+"ZmxvSURxZEoxZ2xCUlZYMFVCN0ZzQTBkdjlZZVVMKzd2MENBd0VBQWFPQ0FaQXdnZ0dNTUhrR0Ex"
+"VWRJd1J5Ck1IQ0FGSktrZUJleHFpOFoyQ3MvdWJNckl4V0QxWmMxb1ZTa1VqQlFNUXN3Q1FZRFZR"
+"UUdFd0pMVWpFY01Cb0dBMVVFQ2d3VFIyOTIKWlhKdWJXVnVkQ0J2WmlCTGIzSmxZVEVOTUFzR0Ex"
+"VUVDd3dFUjFCTFNURVVNQklHQTFVRUF3d0xSMUJMU1ZKdmIzUkRRVEdDQWljUwpNQjBHQTFVZERn"
+"UVdCQlRJYUdycm5reEZzV3dWZWYzTmNzaS9BSmVjcHpBT0JnTlZIUThCQWY4RUJBTUNCREF3RmdZ"
+"RFZSMGdCQTh3CkRUQUxCZ2txZ3hxR2pTRUNBUUl3Z1k4R0ExVWRId1NCaHpDQmhEQ0JnYUIvb0gy"
+"R2UyeGtZWEE2THk5alpXNHVaR2x5TG1kdkxtdHkKT2pNNE9TOWpiajFqY213eGNERmtjREV3TlRF"
+"c1kyNDlRMEV4TXpFeE1EQXdNREVzYjNVOVIxQkxTU3h2UFVkdmRtVnlibTFsYm5RZwpiMllnUzI5"
+"eVpXRXNZejFMVWo5alpYSjBhV1pwWTJGMFpWSmxkbTlqWVhScGIyNU1hWE4wTzJKcGJtRnllVEEy"
+"QmdnckJnRUZCUWNCCkFRUXFNQ2d3SmdZSUt3WUJCUVVITUFHR0dtaDBkSEE2THk5bmRtRXVaM0Jy"
+"YVM1bmJ5NXJjam80TURBd01BMEdDU3FHU0liM0RRRUIKQ3dVQUE0SUJBUUNXL0hnajY5dzI0MnhY"
+"dlBFRE5RRDR5NlZvUldKUmd4ZnN5c2dBSlJzWi80TUVPYUpuNXVONWE2NFZ2MEhwSVBPWQpyTnJi"
+"VkR1dlNRR3pYUlE5Q2VGQmRmZ0JlQ2hkYUI0Zm5DVk9GOHJqSmh5OCtYd29pbzZtZDdxdXdtbEtp"
+"b0pJSktuOFhHUkJRMk9BCjFrMVRIWGNPd2RHbXdRcGtKSFlSQ3BHWGp0TytWZlg1Mm0wV0ZpdmJS"
+"bXNITUVwS1lLNW9zZ0N5d3RNK2VUTDNqbktoakZRM0FRRDMKZGNMdGQxbE05Q056MTVBMlUrdWx3"
+"Y2U3ZmtySGthZmFvNWtweDVTU1Vjb2ZXSTNEcFNmenF0dkdKd3Uya2F2emhDOVlheFRSNzBDdgpk"
+"S0ExVmpqTzBaQmRxM1JKejJyQnBDaDNCM1lSRFVlcUNCOEVJZkg4V0N0Z2M5WG4KPC9kczpYNTA5"
+"Q2VydGlmaWNhdGU+CjwvZHM6WDUwOURhdGE+CjwvZHM6S2V5SW5mbz4KPC9kczpTaWduYXR1cmU+"
+"PE5hbWVJRFBvbGljeSBBbGxvd0NyZWF0ZT0idHJ1ZSIgRm9ybWF0PSJ1cm46b2FzaXM6bmFtZXM6"
+"dGM6U0FNTDoyLjA6bmFtZWlkLWZvcm1hdDpwZXJzaXN0ZW50Ij48L05hbWVJRFBvbGljeT48UmVx"
+"dWVzdGVkQXV0aG5Db250ZXh0IENvbXBhcmlzb249ImV4YWN0Ij48bnMyOkF1dGhuQ29udGV4dENs"
+"YXNzUmVmIHhtbG5zOm5zMj0idXJuOm9hc2lzOm5hbWVzOnRjOlNBTUw6Mi4wOmFzc2VydGlvbiI+"
+"dXJuOm9hc2lzOm5hbWVzOnRjOlNBTUw6Mi4wOmFjOmNsYXNzZXM6UGFzc3dvcmQ8L25zMjpBdXRo"
+"bkNvbnRleHRDbGFzc1JlZj48L1JlcXVlc3RlZEF1dGhuQ29udGV4dD48L0F1dGhuUmVxdWVzdD4=";
    document.reqForm.submit();
}
// -->
</script>
</head>
<body onload="body_onload()" style="font-family: 굴림">
    <form name="reqForm" id="reqForm" method="post" action="https://www.g-pin.go.kr/VerifyRequestService/Post">
        <input type="hidden" name="SAMLRequest" />
     <input type="submit" name="input1" style="display:none" />
    </form>
<div id="divLogging" style="width: 400; left: 0%; position: absolute; top: 0px; font-size: 10pt; font-family: Arial; text-align: center; vertical-align: middle; z-index: 2; visibility: visible;">
<table border="0" cellspacing="1" cellpadding="10" align="center" bgcolor="#dbdee8">
<tr>
<td width="378" height="93" align="center" valign="top" background="http://www.g-pin.go.kr/common/images/connect/ad_mainbar_back02.gif">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
<td width="25%" height="30">&nbsp;</td>
<td width="75%">&nbsp;</td>
</tr>
<tr>
<td height="30">&nbsp;</td>
<td><img src='http://www.g-pin.go.kr/common/images/connect/progress.gif' alt='진행중' width="210" height="11" alt=""/></td>
</tr>
<tr>
<td>&nbsp;</td>
<td>&nbsp;</td>
</tr>
</table>
</td>
</tr>
</table>
</div>
</body>
</html>