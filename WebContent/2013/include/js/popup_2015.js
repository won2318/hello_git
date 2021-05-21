 
 //a
//<![CDATA[
var current_popup_a = 0;  //변수 current_popup의 값을 초기값 0으로 지정
var popup_play_a = 0; //변수 popup_play의 값을 초기값 0으로 지정 play, stop 에 관여
var pz_a = "";
var pz_p_a = "";
var pz_i_a = "";

function change_popup_a(value) // 팝업존 이미지 변경을 위한 function
{
	pz_a = document.getElementById('popup_zone_a');
	pz_p_a =  pz_a.getElementsByTagName('p');
	pz_i_a = pz_p_a.length;

	if(value > pz_i_a) value = 1;  // 팝업존안의 p태그의 수보다 value의 값이 커질경우 1로, 반복되게하기 위해 정의
	if(value < 1) value = pz_i_a;  // 팝업존안의 p태그의 수보다 value의 값이 작아질경우 마지막 이미지로 돌아가게하기 위해
	
	current_popup_a=value; // value 의 값이 중간값(양끝의 값이 아닐경우)일 때 실행
	
	for(i=1;i<=pz_i_a+1;i++) 
	{ 
		if(obj_a = document.getElementById("popup_a"+i))
		{
			var p = document.getElementById("popup_img_a"+i);
			if(i==value) {
				obj_a.style.display="block"; // i와 value값이 같을 경우 이미지를 블럭처리
				if(imgobj_a = p) imgobj_a.src = imgobj_a.src.replace("off.png","on.png"); //  숫자 이미지 명의 off를 on으로 바꾸어 이미지의 변환
			} else {
				obj_a.style.display="none"; // i와 value값이 다를 경우 이미지 none 처리
				if(imgobj_a = p) imgobj_a.src = imgobj_a.src.replace("on.png","off.png"); //on 이미지를 off 이미지로 변환
			}
		}
	}
}

function select_num_a(value)
{
	change_popup_a(value);
	play_popup_a(0);
}

function play_popup_a(value) 
{
	if(value == 0) 	popup_play_a = 0; //멈춤 play_popup(0)이 되면서 움직임 멈춤
	else if(value == 1) 
	{
		popup_play_a = 1;// 시작  play_popup(1)이 되면서 움직임 시작
	}
	if(popup_play_a==1)
	{ 
		change_popup_a(current_popup_a+1); // change_popup 1씩증가 
		//setTimeout("play_popup_a()", 1000); // 일정시간후 play_popup 한번실행 (setinterval의 경우 반복실행이기에 오류가 남)
	}
}

function play_pop_a()
{
	for (var i=0;i<pz_i_a;i++ ) // 처음 시작할때의 준비
	{
		if ( i == 0) pz_p_a[i].style.display = "block";  
		else pz_p_a[i].style.display = "none"; //첫번째 이미지를 제외한 나머지 이미지는 none.
	}

	document.getElementById('photo_zone_a').className = "photo_banner_a";

	//document.getElementById('popup_num_a').style.display = "block";
	document.getElementById('popup_btn_a1').style.display = "block";
	document.getElementById('popup_btn_a2').style.display = "block";
	
	play_popup_a(1);
}






 //]]>
 
 
  
 //b
//<![CDATA[
var current_popup_b = 0;  //변수 current_popup의 값을 초기값 0으로 지정
var popup_play_b = 0; //변수 popup_play의 값을 초기값 0으로 지정 play, stop 에 관여
var pz_b = "";
var pz_p_b = "";
var pz_i_b = "";

function change_popup_b(value) // 팝업존 이미지 변경을 위한 function
{
	pz_b = document.getElementById('popup_zone_b');
	pz_p_b =  pz_b.getElementsByTagName('p');
	pz_i_b = pz_p_b.length;

	if(value > pz_i_b) value = 1;  // 팝업존안의 p태그의 수보다 value의 값이 커질경우 1로, 반복되게하기 위해 정의
	if(value < 1) value = pz_i_b;  // 팝업존안의 p태그의 수보다 value의 값이 작아질경우 마지막 이미지로 돌아가게하기 위해
	
	current_popup_b=value; // value 의 값이 중간값(양끝의 값이 아닐경우)일 때 실행
	
	for(i=1;i<=pz_i_b+1;i++) 
	{ 
		if(obj_b = document.getElementById("popup_b"+i))
		{
			var p = document.getElementById("popup_img_b"+i);
			if(i==value) {
				obj_b.style.display="block"; // i와 value값이 같을 경우 이미지를 블럭처리
				if(imgobj_b = p) imgobj_b.src = imgobj_b.src.replace("off.png","on.png"); //  숫자 이미지 명의 off를 on으로 바꾸어 이미지의 변환
			} else {
				obj_b.style.display="none"; // i와 value값이 다를 경우 이미지 none 처리
				if(imgobj_b = p) imgobj_b.src = imgobj_b.src.replace("on.png","off.png"); //on 이미지를 off 이미지로 변환
			}
		}
	}
}

function select_num_b(value)
{
	change_popup_b(value);
	play_popup_b(0);
}

function play_popup_b(value) 
{
	if(value == 0) 	popup_play_b = 0; //멈춤 play_popup(0)이 되면서 움직임 멈춤
	else if(value == 1) 
	{
		popup_play_b = 1;// 시작  play_popup(1)이 되면서 움직임 시작
	}
	if(popup_play_b==1)
	{ 
		change_popup_b(current_popup_b+1); // change_popup 1씩증가 
		setTimeout("play_popup_b()", 5000); // 일정시간후 play_popup 한번실행 (setinterval의 경우 반복실행이기에 오류가 남)
	}
}

function play_pop_b()
{
	for (var i=0;i<pz_i_b;i++ ) // 처음 시작할때의 준비
	{
		if ( i == 0) pz_p_b[i].style.display = "block";  
		else pz_p_b[i].style.display = "none"; //첫번째 이미지를 제외한 나머지 이미지는 none.
	}

	document.getElementById('photo_zone_b').className = "photo_banner_b";
	document.getElementById('popup_num_b').style.display = "block";

	play_popup_b(1);
}






 //]]>
 
 //c
//<![CDATA[
var current_popup_c = 0;  //변수 current_popup의 값을 초기값 0으로 지정
var popup_play_c = 0; //변수 popup_play의 값을 초기값 0으로 지정 play, stop 에 관여
var pz_c = "";
var pz_p_c = "";
var pz_i_c = "";

function change_popup_c(value) // 팝업존 이미지 변경을 위한 function
{
	pz_c = document.getElementById('popup_zone_c');
	pz_p_c =  pz_c.getElementsByTagName('p');
	pz_i_c = pz_p_c.length;

	if(value > pz_i_c) value = 1;  // 팝업존안의 p태그의 수보다 value의 값이 커질경우 1로, 반복되게하기 위해 정의
	if(value < 1) value = pz_i_c;  // 팝업존안의 p태그의 수보다 value의 값이 작아질경우 마지막 이미지로 돌아가게하기 위해
	
	current_popup_c=value; // value 의 값이 중간값(양끝의 값이 아닐경우)일 때 실행
	
	for(i=1;i<=pz_i_c+1;i++) 
	{ 
		if(obj_c = document.getElementById("popup_c"+i))
		{
			var p = document.getElementById("popup_img_c"+i);
			if(i==value) {
				obj_c.style.display="block"; // i와 value값이 같을 경우 이미지를 블럭처리
				if(imgobj_c = p) imgobj_c.src = imgobj_c.src.replace("off.png","on.png"); //  숫자 이미지 명의 off를 on으로 바꾸어 이미지의 변환
			} else {
				obj_c.style.display="none"; // i와 value값이 다를 경우 이미지 none 처리
				if(imgobj_c = p) imgobj_c.src = imgobj_c.src.replace("on.png","off.png"); //on 이미지를 off 이미지로 변환
			}
		}
	}
}

function select_num_c(value)
{
	change_popup_c(value);
	play_popup_c(0);
}

function play_popup_c(value) 
{
	if(value == 0) 	popup_play_c = 0; //멈춤 play_popup(0)이 되면서 움직임 멈춤
	else if(value == 1) 
	{
		popup_play_c = 1;// 시작  play_popup(1)이 되면서 움직임 시작
	}
	if(popup_play_c==1)
	{ 
		change_popup_c(current_popup_c+1); // change_popup 1씩증가 
		setTimeout("play_popup_c()", 5000); // 일정시간후 play_popup 한번실행 (setinterval의 경우 반복실행이기에 오류가 남)
	}
}

function play_pop_c()
{
	for (var i=0;i<pz_i_c;i++ ) // 처음 시작할때의 준비
	{
		if ( i == 0) pz_p_c[i].style.display = "block";  
		else pz_p_c[i].style.display = "none"; //첫번째 이미지를 제외한 나머지 이미지는 none.
	}

	document.getElementById('photo_zone_c').className = "photo_banner_c";

	document.getElementById('popup_num_c').style.display = "block";

	play_popup_c(1);
}






 //]]>
 
 //d
//<![CDATA[
var current_popup_d = 0;  //변수 current_popup의 값을 초기값 0으로 지정
var popup_play_d = 0; //변수 popup_play의 값을 초기값 0으로 지정 play, stop 에 관여
var pz_d = "";
var pz_p_d = "";
var pz_i_d = "";

function change_popup_d(value) // 팝업존 이미지 변경을 위한 function
{
	pz_d = document.getElementById('popup_zone_d');
	pz_p_d =  pz_d.getElementsByTagName('p');
	pz_i_d = pz_p_d.length;

	if(value > pz_i_d) value = 1;  // 팝업존안의 p태그의 수보다 value의 값이 커질경우 1로, 반복되게하기 위해 정의
	if(value < 1) value = pz_i_d;  // 팝업존안의 p태그의 수보다 value의 값이 작아질경우 마지막 이미지로 돌아가게하기 위해
	
	current_popup_d=value; // value 의 값이 중간값(양끝의 값이 아닐경우)일 때 실행
	
	for(i=1;i<=pz_i_d+1;i++) 
	{ 
		if(obj_d = document.getElementById("popup_d"+i))
		{
			var p = document.getElementById("popup_img_d"+i);
			if(i==value) {
				obj_d.style.display="block"; // i와 value값이 같을 경우 이미지를 블럭처리
				if(imgobj_d = p) imgobj_d.src = imgobj_d.src.replace("off.png","on.png"); //  숫자 이미지 명의 off를 on으로 바꾸어 이미지의 변환
			} else {
				obj_d.style.display="none"; // i와 value값이 다를 경우 이미지 none 처리
				if(imgobj_d = p) imgobj_d.src = imgobj_d.src.replace("on.png","off.png"); //on 이미지를 off 이미지로 변환
			}
		}
	}
}

function select_num_d(value)
{
	change_popup_d(value);
	play_popup_d(0);
}

function play_popup_d(value) 
{
	if(value == 0) 	popup_play_d = 0; //멈춤 play_popup(0)이 되면서 움직임 멈춤
	else if(value == 1) 
	{
		popup_play_d = 1;// 시작  play_popup(1)이 되면서 움직임 시작
	}
	if(popup_play_d==1)
	{ 
		change_popup_d(current_popup_d+1); // change_popup 1씩증가 
		setTimeout("play_popup_d()", 5000); // 일정시간후 play_popup 한번실행 (setinterval의 경우 반복실행이기에 오류가 남)
	}
}

function play_pop_d()
{
	for (var i=0;i<pz_i_d;i++ ) // 처음 시작할때의 준비
	{
		if ( i == 0) pz_p_d[i].style.display = "block";  
		else pz_p_d[i].style.display = "none"; //첫번째 이미지를 제외한 나머지 이미지는 none.
	}

	document.getElementById('photo_zone_d').className = "photo_banner_d";

	document.getElementById('popup_num_d').style.display = "block";

	play_popup_d(1);
}



//e
//<![CDATA[
var current_popup_e = 0;  //변수 current_popup의 값을 초기값 0으로 지정
var popup_play_e = 0; //변수 popup_play의 값을 초기값 0으로 지정 play, stop 에 관여
var pz_e = "";
var pz_p_e = "";
var pz_i_e = "";

function change_popup_e(value) // 팝업존 이미지 변경을 위한 function
{
	pz_e = document.getElementById('popup_zone_e');
	pz_p_e =  pz_e.getElementsByTagName('p');
	pz_i_e = pz_p_e.length;

	if(value > pz_i_e) value = 1;  // 팝업존안의 p태그의 수보다 value의 값이 커질경우 1로, 반복되게하기 위해 정의
	if(value < 1) value = pz_i_e;  // 팝업존안의 p태그의 수보다 value의 값이 작아질경우 마지막 이미지로 돌아가게하기 위해
	
	current_popup_e=value; // value 의 값이 중간값(양끝의 값이 아닐경우)일 때 실행
	
	for(i=1;i<=pz_i_e+1;i++) 
	{ 
		if(obj_e = document.getElementById("popup_e"+i))
		{
			var p = document.getElementById("popup_img_e"+i);
			if(i==value) {
				obj_e.style.display="block"; // i와 value값이 같을 경우 이미지를 블럭처리
				if(imgobj_e = p) imgobj_e.src = imgobj_e.src.replace("off.png","on.png"); //  숫자 이미지 명의 off를 on으로 바꾸어 이미지의 변환
			} else {
				obj_e.style.display="none"; // i와 value값이 다를 경우 이미지 none 처리
				if(imgobj_e = p) imgobj_e.src = imgobj_e.src.replace("on.png","off.png"); //on 이미지를 off 이미지로 변환
			}
		}
	}
}

function select_num_e(value)
{
	change_popup_e(value);
	play_popup_e(0);
}

function play_popup_e(value) 
{
	if(value == 0) 	popup_play_e = 0; //멈춤 play_popup(0)이 되면서 움직임 멈춤
	else if(value == 1) 
	{
		popup_play_e = 1;// 시작  play_popup(1)이 되면서 움직임 시작
	}
	if(popup_play_e==1)
	{ 
		change_popup_e(current_popup_e+1); // change_popup 1씩증가 
		setTimeout("play_popup_e()", 5000); // 일정시간후 play_popup 한번실행 (setinterval의 경우 반복실행이기에 오류가 남)
	}
}

function play_pop_e()
{
	for (var i=0;i<pz_i_e;i++ ) // 처음 시작할때의 준비
	{
		if ( i == 0) pz_p_e[i].style.display = "block";  
		else pz_p_e[i].style.display = "none"; //첫번째 이미지를 제외한 나머지 이미지는 none.
	}

	document.getElementById('photo_zone_e').className = "photo_banner_e";

	document.getElementById('popup_num_e').style.display = "block";

	play_popup_e(1);
}



 //]]>
 
 //e
//<![CDATA[
var current_popup_f = 0;  //변수 current_popup의 값을 초기값 0으로 지정
var popup_play_f = 0; //변수 popup_play의 값을 초기값 0으로 지정 play, stop 에 관여
var pz_f = "";
var pz_p_f = "";
var pz_i_f = "";

function change_popup_f(value) // 팝업존 이미지 변경을 위한 function
{
	pz_f = document.getElementById('popup_zone_f');
	pz_p_f =  pz_f.getElementsByTagName('p');
	pz_i_f = pz_p_f.length;

	if(value > pz_i_f) value = 1;  // 팝업존안의 p태그의 수보다 value의 값이 커질경우 1로, 반복되게하기 위해 정의
	if(value < 1) value = pz_i_f;  // 팝업존안의 p태그의 수보다 value의 값이 작아질경우 마지막 이미지로 돌아가게하기 위해
	
	current_popup_f=value; // value 의 값이 중간값(양끝의 값이 아닐경우)일 때 실행
	
	for(i=1;i<=pz_i_f+1;i++) 
	{ 
		if(obj_f = document.getElementById("popup_f"+i))
		{
			var p = document.getElementById("popup_img_f"+i);
			if(i==value) {
				obj_f.style.display="block"; // i와 value값이 같을 경우 이미지를 블럭처리
				if(imgobj_f = p) imgobj_f.src = imgobj_f.src.replace("off.png","on.png"); //  숫자 이미지 명의 off를 on으로 바꾸어 이미지의 변환
			} else {
				obj_f.style.display="none"; // i와 value값이 다를 경우 이미지 none 처리
				if(imgobj_f = p) imgobj_f.src = imgobj_f.src.replace("on.png","off.png"); //on 이미지를 off 이미지로 변환
			}
		}
	}
}

function select_num_f(value)
{
	change_popup_f(value);
	play_popup_f(0);
}

function play_popup_f(value) 
{
	if(value == 0) 	popup_play_f = 0; //멈춤 play_popup(0)이 되면서 움직임 멈춤
	else if(value == 1) 
	{
		popup_play_f = 1;// 시작  play_popup(1)이 되면서 움직임 시작
	}
	if(popup_play_f==1)
	{ 
		change_popup_f(current_popup_f+1); // change_popup 1씩증가 
		setTimeout("play_popup_f()", 5000); // 일정시간후 play_popup 한번실행 (setinterval의 경우 반복실행이기에 오류가 남)
	}
}

function play_pop_f()
{
	for (var i=0;i<pz_i_f;i++ ) // 처음 시작할때의 준비
	{
		if ( i == 0) pz_p_f[i].style.display = "block";  
		else pz_p_f[i].style.display = "none"; //첫번째 이미지를 제외한 나머지 이미지는 none.
	}

	document.getElementById('photo_zone_f').className = "photo_banner_f";

	document.getElementById('popup_num_f').style.display = "block";

	play_popup_f(1);
}



 //]]>