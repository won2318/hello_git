function jumin_check(form) {
	if (form.ssn1.value.length != 6) {
		alert("주민번호 앞번호의 개수가 모자랍니다. 더 적어주세요."); 
		form.ssn1.focus();
		return false;  
	} else if (form.ssn2.value.length != 7) {
		alert("주민번호 뒷번호의 개수가 모자랍니다. 더 적어주세요.");
		form.ssn2.focus();
		return false;
	} else {
		var strjumin1 = form.ssn1.value;
		var strjumin2 = form.ssn2.value;
		var digit = 0;

		for (var i=0;i<strjumin1.length;i++) {   //주민번호 앞자리의 길이만큼 for문을 돌린다.
			var strdigit=strjumin1.substring(i,i+1);  //앞자리중 i번째와 i+i번째 문자를 변수에 담는다.
			if (strdigit<'0' || strdigit>'9') {   //strdigit 의 값이 0보다 작거나 9보다 크면
				digit=digit+1   //digit에 1을 더한다.
			}
		}

		if ( digit != 0 ) {   //digit가 0이 아니라면
			alert('주민번호에는 0에서 9까지의 숫자만 적을 수 있습니다.\n\n다시 확인하고 입력해 주세요.');
            form.ssn1.focus();   
            return false;  
        }

        var digit1=0;
		for (var i=0;i<strjumin2.length;i++) { // 주민번호 뒷자리의 길이만큼 for문을 돌린다.
			var strdigit1=strjumin2.substring(i,i+1);
			if (strdigit1<'0' || strdigit1>'9') {
				digit1=digit1+1;
			}
		}

        if ( digit1 != 0 ) {
			alert('주민번호에는 0에서 9까지의 숫자만 적을 수 있습니다.\n\n다시 확인하고 입력해 주세요.'); 
			form.ssn2.focus();
			return false;   
		}

        if (strjumin1.substring(2,3) > 1) {   //주민번호 월 부분의 첫째 숫자가 1보다 클경우
            alert('잘못될 \'월\'을 입력했습니다.\n\n다시 확인하고 입력해 주세요.');
            form.ssn1.focus();   
            return false;
        }
        if (strjumin1.substring(4,5) > 3) { //주민번호 일 부분의 첫째 숫자가 3보다 클경우   
            alert('잘못된 \'일\'을 입력했습니다.\n\n다시 확인하고 입력해 주세요.');
            form.ssn1.focus();   
            return false;   
        } 
		if (strjumin2.substring(0,1) > 4 || strjumin2.substring(0,1) == 0) {  //주민번호 뒷자리의 첫째숫자가 4보다 클경우
			alert('다시 확인하고 입력해 주세요.');
			form.ssn2.focus();   
            return false;   
        }
        var a1=strjumin1.substring(0,1)   //주민번호 계산법
        var a2=strjumin1.substring(1,2)          
        var a3=strjumin1.substring(2,3)
        var a4=strjumin1.substring(3,4)
        var a5=strjumin1.substring(4,5)
        var a6=strjumin1.substring(5,6)
        var checkdigit=a1*2+a2*3+a3*4+a4*5+a5*6+a6*7
        var b1=strjumin2.substring(0,1)
        var b2=strjumin2.substring(1,2)
        var b3=strjumin2.substring(2,3)
        var b4=strjumin2.substring(3,4)
        var b5=strjumin2.substring(4,5)
        var b6=strjumin2.substring(5,6)
        var b7=strjumin2.substring(6,7)
        var checkdigit=checkdigit+b1*8+b2*9+b3*2+b4*3+b5*4+b6*5 
        checkdigit = checkdigit%11
        checkdigit = 11 - checkdigit
        checkdigit = checkdigit%10
        if (checkdigit != b7) {
			alert('잘못된 주민등록번호입니다.\n\n다시 확인하고 입력해 주세요.'); 
			form.ssn1.value="";
			form.ssn2.value="";
			form.ssn1.focus();   
			return false;
		} 
	}
	return true;
}
//color 선택
function selectColor(formName, id){
		var id = "color_select.jsp?id="+id+"&formName="+formName;
		var colorSelect = window.open(id,"colorSelect","width=451,height=452");
		colorSelect.focus();
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
	
 	return /^[\w]+[\w.\-]*@[\w.\-]+\.\w+/.test(str); 
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


function onlyNumber()
{
	if(((event.keyCode<48)||(event.keyCode>57)) && event.keyCode !=13)
	{
		event.returnValue=false;
		alert("숫자만 입력할 수 있습니다.");
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

function mplayer(text){
document.write(document.getElementById(text).value);
}

function silverPlayer(xap_name,s_width, s_height, ocode)
{
	document.write("<div id='errorLocation' style='font-size: small;color: Gray;'></div>");
	document.write("<div id='silverlightControlHost'>");
	document.write("<object data='data:application/x-silverlight-2,' type='application/x-silverlight-2' width='"+s_width+"' height='"+s_height+"'>");
	document.write("<param name='source' value='"+xap_name+"'/>");
	document.write("<param name='onerror' value='onSilverlightError' />");
	document.write("<param name='background' value='white' />");
	document.write("<param name='minRuntimeVersion' value='3.0.40307.0' />");
	document.write("<param name='autoUpgrade' value='true' />");
	document.write("<a href='http://go.microsoft.com/fwlink/?LinkID=124807' style='text-decoration: none;'>");
	document.write("	<img src='http://go.microsoft.com/fwlink/?LinkId=108181' alt='Get Microsoft Silverlight' style='border-style: none'/>");
    document.write("</a>");
    if(ocode != ""){
    	document.write("<param name='initParams' value='"+ocode+"' />");
    }
	document.write("</object>");
	document.write("<iframe style='visibility:hidden;height:0;width:0;border:0px'></iframe>");
	document.write("</div>   ");
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

function fncInit()
{
	var allInput = document.all.tags('INPUT');
	for( var i=0 ; i<allInput.length; i++ ) {
		var input = allInput[i];
		if( input.type=='text' && input.tp=='num' ) {
			input.style.imeMode = 'disabled';
			input.onkeyup = fncDigitCheck;

		} else if ( input.type=='text' && input.tp=='eng' ) {
			input.style.imeMode = 'disabled';
			input.onkeyup = fncDigitCheck;
		}
	}
}

function fncDigitCheck()
{
    var obj  = event.srcElement;
	if(obj.tp == 'num') {
		obj.value= obj.value.replace(/[^\d]/g,'');
	} else if(obj.tp == 'eng') {
		var special = /[\{\}\[\]\/?.,;:|\)*~`!^\-_+┼<>@\#$%&\'\"\\\(\=]/gi;
		obj.value = obj.value.replace(special,'');
	}
}

/* 비밀번호 조합 체크 8~12*/
function pwCheck(p) {
	chk1 = /^[a-z\d\{\}\[\]\/?.,;:|\)*~`!^\-_+&lt;&gt;@\#$%&amp;\\\=\(\'\"]{4,12}$/i; //영문자 숫자 특문자 이외의 문자가 있는지 확인
	chk2 = /[a-z]/i; //적어도 한개의 영문자 확인
	chk3 = /\d/; //적어도 한개의 숫자 확인
	//chk4 = /[\{\}\[\]\/?.,;:|\)*~`!^\-_+&lt;&gt;@\#$%&amp;\\\=\(\'\"]/i; //적어도 한개의 특문자 확인
	return chk1.test(p) && chk2.test(p) && chk3.test(p);

}

/* 비밀번호 조합 체크 8~12*/
function pwCheck1(str) {
	

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
	
}

/* 숫자만 입력 */
function onlyNumber(obj){
		 obj.style.imeMode = "disabled";
		 if((event.keyCode != 9 && event.keyCode != 8 && event.keyCode != 46) && (event.keyCode < 48 || event.keyCode > 57) && (event.keyCode < 96 || event.keyCode > 105))
		 {
		     alert("숫자만 입력할수 있습니다.");  
		     event.returnValue=false;
		 }
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

	if(bytesize>=maxlen){
		alert("텍스트 입력 범위 초과 한글"+maxlength/2+"자, 영문"+maxlength+"자 이하로 적어주세요.");
		objstr2=objstr.substr(0,strlen);
		objname.value=objstr2;   
		re = false;
	}
	objname.focus();
	return re;
}

function fc_chk_byte(memo,leng) 
{ 

	var ls_str = memo.value; // 이벤트가 일어난 컨트롤의 value 값 
	var li_str_len = ls_str.length; // 전체길이 

	// 변수초기화 
	var li_max = leng; // 제한할 글자수 크기 
	var i = 0; // for문에 사용 
	var li_byte = 0; // 한글일경우는 2 그밗에는 1을 더함 
	var li_len = 0; // substring하기 위해서 사용 
	var ls_one_char = ""; // 한글자씩 검사한다 
	var ls_str2 = ""; // 글자수를 초과하면 제한할수 글자전까지만 보여준다. 

	for(i=0; i< li_str_len; i++) 
	{ 
	// 한글자추출 
	ls_one_char = ls_str.charAt(i); 

	// 한글이면 2를 더한다. 
	if (escape(ls_one_char).length > 4) 
	{ 
	li_byte += 2; 
	} 
	// 그밗의 경우는 1을 더한다. 
	else 
	{ 
	li_byte++; 
	} 

	// 전체 크기가 li_max를 넘지않으면 
	if(li_byte <= li_max) 
	{ 
	li_len = i + 1; 
	} 
	} 

	// 전체길이를 초과하면 
	if(li_byte >= li_max) 
	{ 
		alert( li_max + " 글자를 초과 입력할수 없습니다. \n 초과된 내용은 자동으로 삭제 됩니다. "); 
		ls_str2 = ls_str.substr(0, li_len); 
		memo.value = ls_str2; 

	} 
	memo.focus(); 
} 
//html에서 이미지 선택한 경우 미리보기 기능 제공
// 이미지, div id,
function previewImage(targetObj, previewId) {

        var preview = document.getElementById(previewId); //div id   
        var ua = window.navigator.userAgent;

        if (ua.indexOf("MSIE") > -1) {//ie일때

            targetObj.select();

            try {
                var src = document.selection.createRange().text; // get file full path 
                var ie_preview_error = document
                        .getElementById("ie_preview_error_" + previewId);

                if (ie_preview_error) {
                    preview.removeChild(ie_preview_error); //error가 있으면 delete
                }

                var img = document.getElementById(previewId); //이미지가 뿌려질 곳 

                img.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(src='"
                        + src + "', sizingMethod='scale')"; //이미지 로딩, sizingMethod는 div에 맞춰서 사이즈를 자동조절 하는 역할
            } catch (e) {
                if (!document.getElementById("ie_preview_error_" + previewId)) {
                    var info = document.createElement("<p>");
                    info.id = "ie_preview_error_" + previewId;
                    info.innerHTML = "a";
                    preview.insertBefore(info, null);
                }
            }
        } else { //ie가 아닐때
            var files = targetObj.files;
            for ( var i = 0; i < files.length; i++) {

                var file = files[i];

                var imageType = /image.*/; //이미지 파일일경우만.. 뿌려준다.
                if (!file.type.match(imageType))
                    continue;

                var prevImg = document.getElementById("prev_" + previewId); //이전에 미리보기가 있다면 삭제
                if (prevImg) {
                    preview.removeChild(prevImg);
                }

                var img = document.createElement("img"); //크롬은 div에 이미지가 뿌려지지 않는다. 그래서 자식Element를 만든다.
                img.id = "prev_" + previewId;
                img.classList.add("obj");
                img.file = file;
                img.style.width = '50px'; //기본설정된 div의 안에 뿌려지는 효과를 주기 위해서 div크기와 같은 크기를 지정해준다.
                img.style.height = '50px';
                
                preview.appendChild(img);

                if (window.FileReader) { // FireFox, Chrome, Opera 확인.
                    var reader = new FileReader();
                    reader.onloadend = (function(aImg) {
                        return function(e) {
                            aImg.src = e.target.result;
                        };
                    })(img);
                    reader.readAsDataURL(file);
                } else { // safari is not supported FileReader
                    //alert('not supported FileReader');
                    if (!document.getElementById("sfr_preview_error_"
                            + previewId)) {
                        var info = document.createElement("p");
                        info.id = "sfr_preview_error_" + previewId;
                        info.innerHTML = "not supported FileReader";
                        preview.insertBefore(info, null);
                    }
                }
            }
        }
    }