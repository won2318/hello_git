<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%@ page import="java.util.*"%>
<%@ page import="com.vodcaster.sqlbean.*"%>
<%@page import="com.yundara.util.TextUtil"%>
<%@page import="com.hrlee.sqlbean.MediaManager"%>
<%@page import="com.hrlee.sqlbean.MenuManager2"%>
<%@page import="com.vodcaster.sqlbean.DirectoryNameManager"%>
<jsp:useBean id="chb" class="com.vodcaster.utils.ConvertHtmlBean"/>
<%@ page import="org.apache.commons.lang.StringUtils"%>
<jsp:useBean id="omiBean" class="com.hrlee.silver.OrderMediaInfoBean" scope="page" />
<%

String ocode = TextUtil.nvl(request.getParameter("ocode"));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width"/>
<title>KakaoLink v2 Demo(Scrap) - Kakao JavaScript SDK</title>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>

</head>
<body>
<div class="panel panel-default">
<div class="panel-heading">
<h3 class="panel-title">
[īī����ũ v2] ���� ��ũ (��ũ��)
</h3>
</div>
<div class="panel-body">
<h4>īī���� ���� ��ġ�Ǿ� �ִ� ����� ����� �Ʒ��� ��ũ�� �����մϴ�.</h4>
<a id="kakao-link-btn" href="javascript:sendLink()">
<img src="//dev.kakao.com/assets/img/about/logos/kakaolink/kakaolink_btn_medium.png"/>
</a>
</div>
</div>
<script type='text/javascript'>
  //<![CDATA[
    // // ����� ���� JavaScript Ű�� ������ �ּ���.
    Kakao.init('0bd092c4a3aadf17452f919aee1a6fa7');
    // // īī����ũ ��ư�� �����մϴ�. ó�� �ѹ��� ȣ���ϸ� �˴ϴ�.
 
    function sendLink() {
      Kakao.Link.sendDefault({
        objectType: 'feed',
        content: {
          title: '���� ġ�� ����',
          description: '#���� #���� #���� #ī�� #������ #�Ұ���',
          imageUrl: 'http://mud-kage.kakao.co.kr/dn/Q2iNx/btqgeRgV54P/VLdBs9cvyn8BJXB3o7N8UK/kakaolink40_original.png',
          link: {
            mobileWebUrl: 'https://developers.kakao.com',
            webUrl: 'https://developers.kakao.com'
          }
        },
        
        buttons: [
          {
            title: '������ ����',
            link: {
              mobileWebUrl: 'https://developers.kakao.com',
              webUrl: 'https://developers.kakao.com'
            }
          } 
        ]
      });
    }
    
  //]]>
</script>

</body>
 
</html>
