 
 //a
//<![CDATA[

 
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