<%@ page contentType="text/html; charset=euc-kr"%>

			 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
			 <html>
			 <head>
			<script language="javascript">
			<!--	 
					//var frag = document.createDocumentFragment();
					
					
					if ( window.addEventListener ) { // W3C DOM ���� ������ 
						window.addEventListener("load", start, false); 
					} else if ( window.attachEvent ) { // W3C DO M ���� ������ ��(ex:MSDOM ���� ������ IE) 
						window.attachEvent("onload", start); 
					} else { 
						window.onload = start; 
					} 


					function start() 
					{ 
						var anchor = document.createElement("a");
						if (!anchor.click) { //Providing a logic for Non IE
							location.href = '<%=REF_URL%>';
						 
						}
						anchor.setAttribute("href", '<%=REF_URL%>');
						anchor.style.display = "none";
						var aa = document.getElementById('aa');
						if( aa ){
							aa.appendChild(anchor);
							anchor.click();
						}			
					} 
					//-->
			</script>
			</head>
			<body>
			<div id="aa"></div>
			</body>
			</html>
		