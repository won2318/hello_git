<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*,com.vodcaster.sqlbean.*,com.hrlee.sqlbean.*"%>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ include file = "/vodman/include/auth.jsp"%>
<%
	request.setCharacterEncoding("euc-kr");

if(!chk_auth(vod_id, vod_level, "s_write")) {
    out.println("<script language='javascript'>\n" +
                "alert('접근 제한이 있습니다. 이전페이지로 이동합니다.');\n" +
                "history.go(-1);\n" +
                "</script>");
    return;
}
%>



<%@ include file="/vodman/include/top.jsp"%>



<script type="text/javascript" src="<%=DirectoryNameManager.SILVERLIGHT_SERVERNAME%>/Silverlight.js"></script>
<script type="text/javascript">
	function onSilverlightError(sender, args) {

		var appSource = "";
		if (sender != null && sender != 0) {
			appSource = sender.getHost().Source;
		}
		var errorType = args.ErrorType;
		var iErrorCode = args.ErrorCode;

		var errMsg = "Unhandled Error in Silverlight Application " + appSource + "\n";

		errMsg += "Code: " + iErrorCode + "    \n";
		errMsg += "Category: " + errorType + "       \n";
		errMsg += "Message: " + args.ErrorMessage + "     \n";

		if (errorType == "ParserError") {
			errMsg += "File: " + args.xamlFile + "     \n";
			errMsg += "Line: " + args.lineNumber + "     \n";
			errMsg += "Position: " + args.charPosition + "     \n";
		}
		else if (errorType == "RuntimeError") {
			if (args.lineNumber != 0) {
				errMsg += "Line: " + args.lineNumber + "     \n";
				errMsg += "Position: " + args.charPosition + "     \n";
			}
			errMsg += "MethodName: " + args.methodName + "     \n";
		}

		throw new Error(errMsg);
	}
	
</script>



<%@ include file="/vodman/vod_aod/vod_left.jsp"%>
		<div id="contents">
			<h3>영상 파일관리</h3>
		 
			<div id="content">
				<table cellspacing="0" class="board_view" summary="영상 파일관리">
				<caption>영상 파일관리</caption>
				<colgroup>
					<col />
				</colgroup>
				<tbody>
				<tr>
						
					<td height="600"> 
    <!-- Runtime errors from Silverlight will be displayed here.
	This will contain debugging information and should be removed or hidden when debugging is completed -->
	<div id='errorLocation' style="font-size: small;color: Gray;"></div>

    <div id="silverlightControlHost">
		<object id="SilverPlayer" data="data:application/x-silverlight-2," type="application/x-silverlight-2" width="100%" height="700">
			<param name="source" value="<%=DirectoryNameManager.SILVERLIGHT_SERVERNAME%>/ClientBin/FileManager.xap"/>
			<param name="onerror" value="onSilverlightError" />
			<param name="background" value="white" />
			<param name="minRuntimeVersion" value="3.0.40624.0" />
			<param name="autoUpgrade" value="true" />
			<param name="enablehtmlaccess" value="true"/>
			<a href="http://go.microsoft.com/fwlink/?LinkID=124807" style="text-decoration: none;">
     			<img src="http://go.microsoft.com/fwlink/?LinkId=108181" alt="Get Microsoft Silverlight" style="border-style: none"/>
			</a>
		</object>
		<iframe style='visibility:hidden;height:0;width:0;border:0px'></iframe>
    </div>
						</td>
					</tr>
				</tbody>
				</table>
			
			</div>
		</div>

<%@ include file="/vodman/include/footer.jsp"%>	
