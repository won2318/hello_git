<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
 
<%@ page import="com.hrlee.sqlbean.*"%>
<%@ page import="com.vodcaster.sqlbean.*"%>
<%@ page import="com.yundara.util.*"%>
<%@ page import="org.apache.commons.lang.StringUtils"%>
<%@ page import="org.apache.commons.lang.math.NumberUtils" %>
<%@ page import="com.hrlee.sqlbean.MediaManager"%>
<%@ page import="com.security.*" %>

<jsp:useBean id="omiBean" class="com.hrlee.silver.OrderMediaInfoBean" scope="page" />
<jsp:useBean id="chb" class="com.vodcaster.utils.ConvertHtmlBean"/>
 <%@ include file = "/include/chkLogin.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="ko" xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko"> 
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR"/>
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	<title>수원 iTV</title>
	<link href="../include/css/default.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="../include/js/close.js"></script>
	<link rel="stylesheet" type="text/css" href="../include/css/content.css" />
	<link rel="stylesheet" type="text/css" href="../include/css/colorbox.css" />
	<script type="text/javascript" charset="utf-8" src="../include/js/jquery.min.js"></script>
	<script type="text/javascript" src="../include/js/jquery.colorbox.js"></script>
	<script type="text/javascript" charset="utf-8" src="../include/js/script.js"></script> <!-- 서브탭버튼 -->

</head>
<body>

<div id="pWrap">
	<!-- container::메인컨텐츠 -->
	<div id="pLogo">
		<span class="close"><a href="javascript:parent.$.colorbox.close();"><img src="../include/images/btn_view_close.gif" alt="닫기"/></a></span>
	
 	</div>
	<div id="pContainer">
		<div id="pContent">
			<h3 id="pTitle">개인정보보호정책</h3>
			<div class="pSubject">
				<p class="skip"> 
					<a href="#presonal1">홈페이지 이용자의 개인정보 보호</a>
					<a href="#presonal2">컴퓨터에 의하여 처리되는 개인정보보호</a>
				</p>
				<ul class="presonal">
				<li>
					<h4 class="tit"><span id="presonal1"></span>[홈페이지 이용자의 개인정보보호 ]</h4>
					<p>
						수원시 홈페이지 이용에 대해 감사드리며, 홈페이지에서의 개인정보보호방침에 대하여 설명을 드리겠습니다. 이는 현행『공공기관의 개인정보보호에 관한 법률』 및 『공공기관의 개인정보보호를 위한 기본지침』에 근거를 두고 있습니다. 우리시에서 운영하고 있는 웹사이트는 다음과 같으며, 이 방침은 별도의 설명이 없는 한 우리시에서 운용하는 모든 웹사이트에 적용됨을 알려드립니다.<br/> ※ <a href="http://www.suwon.go.kr" title="수원시" target="_blank"> www.suwon.go.kr</a>등 
					</p>
					<ul class="law">
						<li>
						<b>자동으로 수집ㆍ저장되는 개인정보</b><br/>
						여러분이 우리 시 홈페이지를 이용할 경우 다음의 정보는 자동적으로 수집ㆍ저장됩니다.
						<ol>
							<li>이용자의 접속 ip </li>
							<li>이용자의 방문일시 등 </li>
						</ol>
						위와 같이 자동 수집ㆍ저장되는 정보는 이용자 여러분에게 보다 나은 서비스를 제공하기 위해 
						홈페이지의 개선과 보완을 위한 통계분석, 이용자와 웹사이트간의 원활한 의사소통 등을 위해 
						이용되어질 것입니다.<br/>
						다만, 법령의 규정에 따라 이러한 정보를 제출하게 되어 있을 경우도 있다는 것을 유념하시기 바랍니다.
						</li>
						
						<li>
						<b>이메일 및 웹 서식 등을 통한 수집정보 </b><br/>
						이용자 여러분은 우편, 전화 또는 온라인 전자서식 등을 통해 의사를 표시할 수 있습니다. 이러한 방법에 있어 몇 가지 유의사항을 알려 드립니다. 
						<ol>
							<li>여러분이 홈페이지의 공개게시판에 게재한 사항은 다른 사람들이 조회 또는 열람할 수 있습니다.</li>
							<li>여러분이 기재한 사항은 관련 법규에 근거하여 필요한 다른 사람과 공유될 수 있으며, 관련법령의 시행과 정책개발의 자료로도 사용될 수 있습니다. </li>
							<li>또한, 이러한 정보는 타 부처와 공유되거나 필요에 의하여 제공될 수도 있습니다.</li>
						</ol>
						위와 같이 자동 수집ㆍ저장되는 정보는 이용자 여러분에게 보다 나은 서비스를 제공하기 위해 
						홈페이지의 개선과 보완을 위한 통계분석, 이용자와 웹사이트간의 원활한 의사소통 등을 위해 
						이용되어질 것입니다.<br/>
						다만, 법령의 규정에 따라 이러한 정보를 제출하게 되어 있을 경우도 있다는 것을 유념하시기 바랍니다.
						</li>
						
						<li>
						<b>웹사이트에서 운영하는 보안조치</b><br/>
						홈페이지의 보안 또는 지속적인 서비스를 위해 우리시는 네트워크 트래픽의 통제(Monitor)는 물론 불법적으로 정보를 변경하는 등의 시도를 탐지하기 위해 여러 가지 프로그램을 운영하고 있습니다. 
						</li>
						
						<li>
						<b>링크 사이트ㆍ웹 페이지의 개인정보보호</b><br/>
						수원시가 운영하는 여러 웹페이지에 포함된 링크 또는 배너를 클릭하여 다른 사이트 또는 웹페이지로 이동할 경우 개인정보보호방침은 그 사이트 운영기관이 게시한 방침이 적용됨으로 새로 방문한 사이트의 방침을 확인하시기 바랍니다. 
						</li>
						
						<li>
						<b>웹사이트 이용 중 타인의 개인정보 취득</b><br/>
						수원시가 운영하는 웹사이트에서 이메일 주소 등 식별할 수 있는 다른 사람의 개인정보를 취득하여서는 아니 되며, 기타 부정한 방법으로 이러한 개인정보를 열람 또는 제공받은 자는 「공공기관의 개인정보 보호에 관한법률」 제23조의 규정에 의하여 처벌을 받을 수 있습니다. 
						</li>		
						
						<li>
						<b>개인정보 침해사항의 신고</b><br/>
						우리시의 웹사이트 이용 중 개인정보의 유출 가능성 등 정보주체의 권익이 침해될 우려가 있는 사실을 발견하였을 경우는 다음의 연락처로 알려주시기 바랍니다. 
						</li>
							
						<li>
						<b>홈페이지 개인정보보호 담당자 : 정보통신과(지역정보팀) </b>
						<ol>
							<li>전화번호 : 031) 228-2305 ~ 6</li>
							<li>팩스번호 : 031) 228-3399 </li>
							<li>주 소 : 수원시 팔달구 효원로 241 (인계동) 수원시청 정보통신과 </li>
						</ol>
						</li>
				
					</ul>
					<h4 class="tit"><span id="presonal2"></span>[컴퓨터에 의해 처리되는 개인정보의 취급 및 보호방침 ]</h4>
					<ul class="law">
						<li>
						<b>개인정보의 수집 및 보유 </b><br/>
						수원시는 법령의 규정과 정보주체의 동의에 의해서만 개인정보를 수집· 보유하며 우리시가 보유하고 있는 여러분의 개인정보를 관계법령에 따라 적법하고 적정하게 처리하여, 여러분의 권익이 침해받지 않도록 노력할 것이며, 수원시가 법령의 규정에 근거하여 수집·보유하고 있는 개인정보파일은 다음과 같습니다.<br/>
						※ 아래의 개인정보파일대장은 시청·구청·민원실 및 개인정보 사용부서에 비치되어 있습니다 
							<div class="tabox7">
							<b>수원시 보유 개인정보 목록 리스트</b><br/>
							<!-- //개인정보 목록리스트 -->
							<div class="table_btn_cen">	
								<p><a href="http://www.suwon.ne.kr/helper/content/data/2009_private_info_list.xls" title=" 새창으로보기" target="_blank"><img src="http://img.suwon.ne.kr/guide/private_info1.gif" alt="2009 개인정보파일대장 목록집" width="187" height="25" border="0" /></a>   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="http://www.suwon.ne.kr/helper/content/data/2009_private_info.hwp" title=" 새창으로보기" target="_blank"><img src="http://img.suwon.ne.kr/guide/private_info2.gif" alt="2009 수원시 개인정보파일대장" width="187" height="25" border="0"/></a></p>
							</div>
							</div><!-- //tabox7 -->
						</li>

						<li>
						<b>개인정보의 이용 및 제공의 제한</b><br/>
						수원시가 수집·보유하고 있는 개인정보는 일반 행정정보와는 달리 이용 및 제공에 엄격한 제한이 있는 정보이며, 『공공기관의 개인정보보호에 관한 법률』 제10조(이용 및 제공의 제한)는 이에 관하여 다음과 같이 규정하고 있습니다. 
						<ol>
							<li>보유기관의 장은 다른 법률에 의하여 보유기관의 내부에서 이용하거나 보유기관외의 자에게 제공하는 경우를 제외하고는 당해 개인정보 파일의 보유목적외의 목적으로 처리정보를 이용하거나 다른 기관에 제공하여서는 아니 된다. </li>
							<li>보유기관의 장은 제1항의 규정에 불구하고 다음 각호의 1에 해당하는 경우에는 당해 개인정보파일의 보유목적외의 목적으로 처리정보를 이용하거나 다른 기관에 제공할 수 있다. 다만, 다음 각호의 1에 해당하는 경우에도 정보주체 또는 제3자의 권리와 이익을 부당하게 침해할 우려가 있다고 인정되는 때에는 그러하지 아니하다. 
								<ul>
								<li>1) 정보주체의 동의가 있거나 정보주체에게 제공하는 경우</li>
								<li>2) 다른 법률에서 정하는 소관업무를 수행하기 위하여 당해 처리 정보를 이용할 상당한 이유가 있는 경우</li>
								<li>3) 조약 기타 국제협정의 이행을 위하여 외국정부 또는 국제기구에 제공하는 경우</li>
								<li>4) 통계작성 및 학술연구 등의 목적을 위한 경우로서 특정개인을 식별할 수 없는 형태로 제공하는 경우</li>
								<li>5) 정보주체 또는 그 법정대리인이 의사표시를 할 수 없는 상태에 있거나 주소불명 등으로 동의를 할 수 없는 경우로서 정보주체 외의 자에게 제공하는 것이 명백히 정보주체에게 이익이 된다고 인정되는 경우</li>
								<li>6) 범죄의 수사와 공소의 제기 및 유지에 필요한 경우</li>
								<li>7) 법원의 재판업무수행을 위하여 필요한 경우</li>
								<li>8) 기타 대통령령이 정하는 특별한 사유가 있는 경우</li>
								</ul>
							</li>
							<li>보유기관의 장은 제2항제2호 내지 제8호의 규정에 의하여 처리정보를 정보주체외의 자에게 제공하는 때에는 처리정보를 수령한 자에 대하여 사용목적·사용방법 기타 필요한 사항에 대하여 제한을 하거나 처리정보의 안전성확보를 위하여 필요한 조치를 강구하도록 요청하여야 한다. </li>
							<li>보유기관의 장은 정보주체의 권리와 이익을 보호하기 위하여 필요하다고 인정하는 때에는 처리정보의 이용을 당해 기관내의 특정부서로 제한할 수 있다. </li>
							<li>보유기관으로부터 제공받은 처리정보를 이용하는 기관은 제공기관의 동의 없이 당해 처리정보를 다른 기관에 제공하여서는 아니된다.<br/>
								그러나, 개인정보일지라도 공공기관의 정보공개에 관한 법률 제9조 제1항제6호에 의하여 다음의 경우에는 공개가 가능합니다.
								<ul>
								<li>1) 법령이 정하는 바에 따라 열람할 수 있는 정보</li>
								<li>2) 공공기관이 공표를 목적으로 작성하거나 취득한 정보로서 개인의 사생활의 비밀과 자유를 부당하게 침해하지 않는 정보</li>
								<li>3) 공공기관이 작성하거나 취득한 정보로서 공개하는 것이 공익 또는 개인의 권리구제를 위하여 필요하다고 인정되는 정보</li>
								<li>4) 직무를 수행한 공무원의 성명·직위</li>
								<li>5) 공개하는 것이 공익을 위하여 필요한 경우로써 법령에 의하여 국가 또는 지방자치단체가 업무의 일부를 위탁 또는 위촉한 개인의 성명·직업 </li>
								</ul>
							</li>
						</ol>
						<div class="tabox7">
						<b>수원시가 위 법령 및 기타 개별법에 근거하여 통상적으로 다른 기관에 제공하는 개인정보파일은 다음과 같습니다.</b><br/>
						<!-- //개인정보 목록리스트 -->
						<div class="table_btn_cen">	
							<table class="plist" summary="다른 기관에 제공하는 개인정보파일">
							<colgroup>
								<col width="21%"/>
								<col width="25%"/>
								<col width="*"/>
								<col width="10%"/>
								<col width="14%"/>
							</colgroup>
							<thead>
								<tr>
									<th><strong>개인정보파일명</strong></th>
									<th><strong>제공대상기관</strong></th>
									<th><strong>제공근거</strong></th>
									<th><strong>제공<br/>주기</strong></th>
									<th><strong>제공형태</strong></th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>호적인구동태</td>
									<td>도 통계담당</td>
									<td>통계법제8조</td>
									<td>매월</td>
									<td>주민전산망</td>
								</tr>
								<tr>
									<td>재산세<br/>(종합부동산세 과세관련) </td>
									<td>행정자치부</td>
									<td>지방세볍 제 195조3 </td>
									<td>연6회</td>
									<td>파일</td>
								</tr>
								<tr>
									<td>의무취학아동명부</td>
									<td>관내초교</td>
									<td>교육법시행령제92조</td>
									<td>연1회</td>
									<td>전산출력물</td>
								</tr>
								<tr>
									<td>지방세<br/>(자동차세, 등록세) </td>
									<td>국세청</td>
									<td>국세기본법 제84조, 85조 </td>
									<td>자료<br/>요청시</td>
									<td>전산출력물 <br/>또는 파일 </td>
								</tr>
								<tr>
									<td>재산세</td>
									<td>국민건강보험수원서부,동부지사건설교통부</td>
									<td>국민건강법 83조정보통신망이용촉진에관한법률</td>
									<td>자료<br/>요청시</td>
									<td>파일</td>
								</tr>
								<tr>
									<td>주민세</td>
									<td>대한적십자사</td>
									<td>적십자회비모금에관한지침<br/>제8조</td>
									<td>자료<br/>요청시</td>
									<td>파일</td>
								</tr>
								<tr>
									<td>자동차세 </td>
									<td>동수원세무서</td>
									<td>국세기본법 제84조</td>
									<td>자료<br/>요청시</td>
									<td>전산출력물</td>
								</tr>
								<tr>
									<td>토지거래현황</td>
									<td>한국토지공사</td>
									<td>건설교통부공문</td>
									<td>월1회</td>
									<td>파일</td>
								</tr>
								</tbody>
							</table>

						</div>
						</div><!-- //tabox7 -->
						</li>
				 
						<li>
						<b>개인정보파일의 열람 및 정정 청구 </b><br/>
						우리시가 보유하고 있는 개인정보파일은 『공공기관의 개인정보보호에 관한 법률』(다른 법률에 규정이 있는 경우는 해당 법률)의 규정이 정하는 바에 따라 열람을 청구할 수 있습니다. 
						<ol>
							<li>열람청구 절차(『공공기관의 개인정보보호에 관한 법률』의 경우) <br/>
								<img src="http://img.suwon.ne.kr/guide/rodls_19.jpg" alt="청구인은 서식에따라 청구하여 5일이내 보유기관으로부터 결정통지서를 송부받으며 10일이내 열람을 할수 있습니다."/>
							</li>
							<li>다음사항은 법 제13조 규정에 의하여 열람을 제한할 수 있습니다.
								<ul>
								<li>1) 다음 사항에 해당하는 업무로서 당해업무의 수행에 중대한 지장을 초래하는 경우
									<ul>
									<li>- 조세의 부과·징수 또는 환급에 관한 업무</li>
									<li>- 교육법에 의한 각종 학교에서의 성적의 평가 또는 입학자의 선발에 관한 업무</li>
									<li>- 학력·기능 및 채용에 관한 시험, 자격의 심사, 보상금·급부금의 산정 등 평가 또는 판단에 관한 업무</li>
									<li>- 다른 법률에 의한 감사 및 조사에 관한 업무</li>
									<li>- 토지 및 주택 등에 관한 부동산 투기를 방지하기 위한 업무</li>
									<li>- 증권거래법에 의한 불공정거래를 방지하기 위한 업무</li>
									</ul>
								</li>
								<li>2) 개인의 생명·신체를 해할 우려가 있거나 개인의 재산과 기타 이익을 부당하게 침해할 우려가 있는 경우 
									<ul>
									<li>- 본인의 개인정보를 열람한 정보주체는 다음의 경우 정정을 청구할 수 있습니다. </li>
									</ul>
								</li>
								</ul>
							</li>
							<li>정정 청구의 범위<br/>
								<ul>
								<li>- 사실과 다르게 기록된 정보의 정정</li>
								<li>- 특정항목에 해당사실이 없는 내용에 대한 삭제 </li>
								</ul>
							</li>
							<li>정정 청구의 절차(『공공기관의 개인정보보호에 관한 법률』의 경우) <br/>
								<img src="http://img.suwon.ne.kr/guide/rodls_19.jpg" alt="청구인은 서식에따라 청구하여 5일이내 보유기관으로부터 결정통지서를 송부받으며 10일이내 열람을 할수 있습니다."/>
							</li>
						</ol>
						</li>
				 
						<li>
						<b>권익침해 구제방법 </b><br/>
						『공공기관의 개인정보보호에 관한 법률』 제12조(처리정보의 열람) 제1항 및 제14조제1항(처리정보의 정정)의 규정에 의한 청구에 대하여 공공기관의 장이 행한 처분 또는 부작위로 인하여 권리 또는 이익이 침해를 받은 자는 행정심판법이 정하는 바에 따라 행정심판을 청구할 수 있습니다. 
						</li>
						
						<li>
						<b>※ 행정심판에 대한 자세한 사항은 법제처(http://www.moleg.go.kr) 사이트를 참고하시기 바랍니다. </b>
						<ol>
							<li>법제처 <a href="http://www.moleg.go.kr/" target="_blank" title="법제처 새창이동">http://www.moleg.go.kr/</a>
							<table class="plist" summary="행정심판위원회 전화번호와 팩스번호 정보목록">
							<caption>※ 행정심판위원회 전화번호 안내(법제처 홈페이지 참조)   </caption>
								<thead>
									<tr>
										<th><strong>행정심판위원회 명칭</strong></th>
										<th><strong>전화번호</strong></th>
										<th><strong>fax</strong></th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>국무총리행정심판위원회</td>
										<td>(02)    2100 - 2660-4</td>
										<td>(02)    2100 - 2778</td>
									</tr>
									<tr>
										<td>서울특별시행정심판위원회</td>
										<td>(02)    731 - 6157, 6557</td>
										<td>(02)    731 - 6562</td>
									</tr>
									<tr>
										<td>부산광역시행정심판위원회</td>
										<td>(051)    888 - 2212</td>
										<td>(051)    888 - 2209</td>
									</tr>
									<tr>
										<td>대구광역시행정심판위원회</td>
										<td>(053)    803 - 2581</td>
										<td>(053) 803-2569</td>
									</tr>
									<tr>
										<td>인천광역시행정심판위원회</td>
										<td>(032)    440 - 2292,4,6</td>
										<td>(032)    427 - 8312</td>
									</tr>
									<tr>
										<td>광주광역시행정심판위원회</td>
										<td>(062)    613 - 2771</td>
										<td>(062)    613 - 2769</td>
									</tr>
									<tr>
										<td>대전광역시행정심판위원회</td>
										<td>(042)    600 - 5572</td>
										<td>(042)    600 - 2159</td>
									</tr>
									<tr>
										<td>울산광역시행정심판위원회</td>
										<td>(052)    229 - 2294</td>
										<td>(052)    229 - 2279</td>
									</tr>
									<tr>
										<td>경기도행정심판위원회</td>
										<td>(031)    249-2837</td>
										<td>(031)    249-2139</td>
									</tr>
									<tr>
										<td>강원도행정심판위원회</td>
										<td>(033)    249 - 2476 ~ 8</td>
										<td>(033)    249 - 4015</td>
									</tr>
									<tr>
										<td>충청북도행정심판위원회</td>
										<td>(043)    220 - 2323</td>
										<td>(043)    220 - 2319</td>
									</tr>
									<tr>
										<td>충청남도행정심판위원회</td>
										<td>(042)    251 - 2133</td>
										<td>(042)    251 - 2139</td>
									</tr>
									<tr>
										<td>전라북도행정심판위원회</td>
										<td>(063)    280 - 2137</td>
										<td>(063)    280 - 2139</td>
									</tr>
									<tr>
										<td>전라남도행정심판위원회</td>
										<td>(061)    286 - 2631</td>
										<td>(061)    286 -4740</td>
									</tr>
									<tr>
										<td>경상북도행정심판위원회</td>
										<td>053)    950 - 2133</td>
										<td>(053)    950 - 2139</td>
									</tr>
									<tr>
										<td>경상남도행정심판위원회</td>
										<td>(055)    211 - 2435</td>
										<td>(055)    211 - 2419</td>
									</tr>
									<tr>
										<td>제주도행정심판위원회</td>
										<td>(064)    710 - 2271 ~ 3</td>
										<td>(064)    710 - 2279</td>
									</tr>
								</tbody>
							</table>
							</li>
						</ol>
						</li>
						<li>
						<b>개인정보 파일 문의처 </b>
						<ol>
							<li>주민등록 : 각 구청 종합민원실 및 각 동주민센터<br/>( 장안구 031-228-5243, 권선구 6246, 팔달구 7244, 영통구 8382 ) </li>
							<li>취득세, 등록세, 면허세, 레저세, 주민세, 재산세, 자동차세, 사업소세 등 지방세 관련 : 각 구청 세무과 <br/>( 장안구 031-228-5295, 권선구 6296, 팔달구 7296, 영통구 8575 ) </li>
							<li>환경개선부담금 : 각 구청 환경위생과 <br/>( 장안구 031-228-5348, 권선구 6331, 팔달구 7346, 영통구 8452 )</li>						</ol>
						</li>
					</ul>
				</li>
				</ul>
			</div>

		</div>
	</div>
	
	
</div>



</body>
</html>