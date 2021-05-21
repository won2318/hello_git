
    function tellerror(msg, url, linenumber) {
        if (msg.toString().indexOf("Image") >= 0 && msg.toString().indexOf("4001") >= 0) {
		alert('Error message= ' + msg + '\nURL= ' + url + '\nLine Number= ' + linenumber)
            return true;
        }
        else {
            alert('Error message= ' + msg + '\nURL= ' + url + '\nLine Number= ' + linenumber)
            return true;
        }
    }

    
function mplayer(text){
	document.write(document.getElementById(text).value);
}



function check_email(data) {		//성공되면 true, 실패 : false
	var str = data;
	var supported = 0; 
	if (window.RegExp) {
		var tempStr = "a"; 
		var tempReg = new RegExp(tempStr); 
		if (tempReg.test(tempStr)) supported = 1; 
	} 
	if (!supported) return (str.indexOf(".") > 2) && (str.indexOf("@") > 0); 
	var r = new RegExp("(^[_0-9a-zA-Z-]+(\.[_0-9a-zA-Z-]+)*@[0-9a-zA-Z-]+(\.[0-9a-zA-Z-]+)*$)");
	return r.test(str);       	
} 


// auto Tab
var isNN = (navigator.appName.indexOf("Netscape")!=-1);

function autoTab(input,len, e) {
var keyCode = (isNN) ? e.which : e.keyCode; 
var filter = (isNN) ? [0,8,9] : [0,8,9,16,17,18,37,38,39,40,46];

	if(input.value.length >= len && !containsElement(filter,keyCode)) {
		input.value = input.value.slice(0, len);
		input.form[(getIndex(input)+1) % input.form.length].focus();

	}

	function containsElement(arr, ele) {
	var found = false, index = 0;
	while(!found && index < arr.length)
	if(arr[index] == ele)
	found = true;
	else
	index++;
	return found;
	}
	function getIndex(input) {
	var index = -1, i = 0, found = false;
	while (i < input.form.length && index == -1)
	if (input.form[i] == input)index = i;
	else i++;
	return index;
	}
	return true;
}


function onlyNumber(obj)
{
	obj.style.imeMode = "disabled";
		 if((event.keyCode != 9 && event.keyCode != 8 && event.keyCode != 46) && (event.keyCode < 48 || event.keyCode > 57) && (event.keyCode < 96 || event.keyCode > 105))
		 {
		     alert("숫자만 입력할수 있습니다.");  
		     event.returnValue=false;
		 }
}




//key event 숫자만 입력확인
//숫자만 입력 ('.'포함)
function onlyNumber2()
{
	if(((event.keyCode<48)||(event.keyCode>57)) && 
		event.keyCode !=46 && event.keyCode !=13)
	{
		event.returnValue=false;
		alert("숫자와 소수점만 입력할 수 있습니다.");
	}
}

function ReadCookie(name) { 
var label = name + "="; 
var labelLen = label.length; 
var cLen = document.cookie.length; 
var i = 0; 

while (i < cLen) { 
        var j = i + labelLen; 

        if (document.cookie.substring(i, j) == label) { 
                var cEnd = document.cookie.indexOf(";", j); 
                if (cEnd == -1) cEnd = document.cookie.length; 
                return unescape(document.cookie.substring(j, cEnd)); 
        } 
                i++; 
    } 
  return ""; 
} 

function SaveCookie(name, value, expire) { 
var eDate = new Date(); 
eDate.setDate(eDate.getDate() + expire); 
document.cookie = name + "=" + value + "; expires=" +  eDate.toGMTString()+ "; path=/"; 
} 


//----------------------------------------
// window popup center align
//----------------------------------------
function ComPopWin(mypage,myname,w,h)
{
	var win = null;
	var scroll = 'yes';
	
	if(mypage == "")
	{
		alert("url을 입력하십시오.");
		return;
	}
	
	if(myname == "")
	{
		myname = "popwin";
	}

	if(w == "")
	{
		w = "400";
	}

	if(h == "")
	{
		h = "300";
	}
		
	LeftPosition = (screen.width) ? (screen.width-w)/2 : 0;

	TopPosition = (screen.height) ? (screen.height-h)/2 : 0;

	settings = 'height='+h+',width='+w+',top='+TopPosition+',left='+LeftPosition+',scrollbars='+scroll+',resizable';

	win = window.open(mypage,myname,settings)
	win.focus();

	return win;
}


/* 화면 확대 축소 시작 IE 전용 */
 var nowZoom = 100; // 현재비율
 var maxZoom = 200; // 최대비율(500으로하면 5배 커진다)
 var minZoom = 80; // 최소비율



 //화면 키운다.
 function zoomIn() {
  if (nowZoom < maxZoom) {
   nowZoom += 10; //25%씩 커진다.
  } else {
   return;
  }

  document.body.style.zoom = nowZoom + "%";
 }


 //화면 줄인다.
 function zoomOut() {
  if (nowZoom > minZoom) {
   nowZoom -= 10; //25%씩 작아진다.
  } else {
   return;
  }

  document.body.style.zoom = nowZoom + "%";
 }

/* 화면 확대 축소 끝 */

function BrowserCHK() // IE, FF(Mozilla) 
{
	var retval;
	var apn = navigator.appName;

	if(apn.indexOf("Microsoft Internet Explorer")!=-1) {
		retval = "ie";
	} else if(apn.indexOf("Netscape")!=-1) {
		retval = "moz";
	} else if (apn.indexOf("Opera")!=-1){
		retval = "ope";
	}
	return retval;
}

/* 비밀번호 조합 체크 8~12*/
function pwCheck(p) {
	chk1 = /^[a-z\d\{\}\[\]\/?.,;:|\)*~`!^\-_+&lt;&gt;@\#$%&amp;\\\=\(\'\"]{4,12}$/i; //영문자 숫자 특문자 이외의 문자가 있는지 확인
	chk2 = /[a-z]/i; //적어도 한개의 영문자 확인
	chk3 = /\d/; //적어도 한개의 숫자 확인
	//chk4 = /[\{\}\[\]\/?.,;:|\)*~`!^\-_+&lt;&gt;@\#$%&amp;\\\=\(\'\"]/i; //적어도 한개의 특문자 확인
	return chk1.test(p) && chk2.test(p) && chk3.test(p);
/*
    var flag1=flag2=flag3=flag4=false;
    var alpha = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
    var num = "1234567890";
    var spe = "~!@#$%^&*()-_+|";
    var len = str.length;
    var ch,flag1,flag2,flag3, flag4;
    for(i = 0 ; i < len ; i++ ){
        
        ch=str.charAt(i);
        
        if(alpha.match(ch)){
            flag1 = true;
            break;
        }
    }
    for(i = 0 ; i < len ; i++ ){
        
        ch=str.charAt(i);
        
        if(num.match(ch)){
            flag2 = true;
            break;
        }
    }
    for(i = 0 ; i < len ; i++ ){
        
        ch=str.charAt(i);
        
        if(spe.match(ch)){
            flag3 = true;
            break;
        }
    }
	
	if(8 <= len){
		flag4 = true;
	}
    
    return ( flag1 && flag2 && flag3 && flag4) ? true : false;
*/	
	
}

function checkLength(objname,maxlength){
		  var objstr=objname.value;
		  var ojbstrlen=objstr.length;

		  var maxlen=maxlength;
		  var i=0;
		  var bytesize=0;
		  var strlen=0;
		  var onechar="";
		  var objstr2="";

		  var re=true; //기본값 true

		  for(i=0;i<ojbstrlen;i++){
		   //길이제한 이 필요한 사이즈저장

		  //한글&일본어시 +2   
		   onechar=objstr.charAt(i);
		   if(escape(onechar).length>4){
		    bytesize+=2;//한글 일본어 2바이트
		   }else{
		    bytesize++;
		   }
		   if(bytesize<=maxlen){

		    strlen=i+1; 
		   }
		   //특수문자제한

		 // var keyCode; 
		   //keyCode = objstr.charCodeAt(i);
		   //if((keyCode>=32 && keyCode<48) || (keyCode>57 && keyCode <65) || (keyCode>90 &&   keyCode<96) ||keyCode == 124 ||keyCode == 96 ||keyCode==123 || keyCode==125)
		  // {
		    //alert("??");   
		    //re=false;
		    //objname.value=''; //초기화

		     //break; // break을 안하면 특수문자가 3개있으면 alert창이 3개가 뜸

		    //   }


		  }//for문끝

		 if(bytesize>maxlen){
		   alert("텍스트 입력 범위 초과 한글"+maxlength/2+"자, 영문"+maxlength+"자 이하로 적어주세요.");
		   objstr2=objstr.substr(0,strlen);
		   objname.value=objstr2;   
		   re = false;
		  }
		  objname.focus();
		  return re;
	}



/***
 * 전화번호 자동 하이픈
 * 숫자여부 체크 하고 031,02 같은 지역번호와 010같은 휴대번호에 자동으로 하이픈을 넣어준다.
***/
function jsPhoneAutoHyphen(obj){
	var n = obj.value.replace(/\-/g, "");
	// 숫자유무 검사 시작
	var comp="0123456789";
	var str = "";
	var err = 0;
	for(i=0; i<n.length; i++) {
	 if(comp.indexOf(n.charAt(i)) >= 0)
	 {
	  str += n.charAt(i);
	 }
	 else
	 {
	  err++;
	 }
	}
	// 자동하이픈 시작
	n = str;
	var len = n.length;
	var phoneNum = n;
	if (n.substring(0, 1) == "0")
	{
	 if (len > 2)
	 {
	  if (n.substring(0, 2) == "02")
	  {
	   phoneNum = n.substring(0, 2) + "-";
	   if (len > 2 && len < 6)
	   {
	    phoneNum += n.substring(2);
	   }
	   else if (len > 5 && len < 10)
	   {
	    phoneNum += n.substring(2, 5) + "-" + n.substring(5);
	   }
	   else if (len == 10)
	   {
	    phoneNum += n.substring(2, 6) + "-" + n.substring(6);
	   }
	   else
	   {
	    phoneNum += n.substring(2, 6) + "-" + n.substring(6, 10);
	   }
	  }
	  else if (len > 3)
	  {
	   if (n.substring(0, 4) == "0505")
	   {
	    if (len > 4)
	    {
	     phoneNum = n.substring(0, 4) + "-";
	     if (len > 4 && len < 8)
	     {
	      phoneNum += n.substring(4);
	     }
	     else if(len > 7 && len < 12)
	     {
	      phoneNum += n.substring(4, 7) + "-" + n.substring(7);
	     }
	     else if (len == 12)
	     {
	      phoneNum += n.substring(4, 8) + "-" + n.substring(8);
	     }
	     else
	     {
	      phoneNum += n.substring(4, 8) + "-" + n.substring(8, 12);
	     }
	    }
	   }
	   else
	   {
	    phoneNum=n.substring(0, 3)+"-";
	    if (len > 3 && len < 7)
	    {
	     phoneNum += n.substring(3);
	    }
	    else if (len > 6 && len < 11)
	    {
	     phoneNum += n.substring(3, 6) + "-" + n.substring(6);
	    }
	    else if (len == 11)
	    {
	     phoneNum += n.substring(3, 7) + "-" + n.substring(7);
	    }
	    else
	    {
	     phoneNum += n.substring(3, 7) + "-" + n.substring(7, 11);
	    }
	   }
	  }
	 }
	}
	else
	{
	 if (len > 3)
	 {
	  phoneNum = n.substring(0, 3)+"-";
	  if (len > 3 && len < 8)
	  {
	   phoneNum += n.substring(3);
	  }
	  else if (len == 8)
	  {
	   phoneNum = n.substring(0, 4) + "-" + n.substring(4);
	  }
	  else
	  {
	   phoneNum = n.substring(0, 4) + "-" + n.substring(4, 8);
	  }
	 }
	}
	obj.value = phoneNum;
}

