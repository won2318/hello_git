	// <span class = 'tab1~7 : �������� ����ϴ� Ŭ����
	// <span class = 'tab8 : ������ �ͽ��÷ξ�� ���
	// <span class = 'tab9 : ������ �ͽ��÷ξ �ƴ� ���������� ���
	appname = navigator.appName;
	if(appname == "Microsoft Internet Explorer") appname = "IE";
 
	function change(num) {
 
		for(var i = 1; i <= 7; i++) {
			n = i;
			if(appname != "IE" && i == 7) n = i + 1;
			document.getElementById("mp_body"+i).className = "tab" + i + " tab_ttl_off";
			document.getElementById("mp_div"+i).style.display = "none";
		}
 
		document.getElementById("mp_body"+num).className = "tab" + num + " tab_ttl_on";
		document.getElementById("mp_div"+num).style.display = "";
	}
