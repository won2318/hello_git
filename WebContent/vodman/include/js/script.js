function jumin_check(form) {
	if (form.ssn1.value.length != 6) {
		alert("�ֹι�ȣ �չ�ȣ�� ������ ���ڶ��ϴ�. �� �����ּ���."); 
		form.ssn1.focus();
		return false;  
	} else if (form.ssn2.value.length != 7) {
		alert("�ֹι�ȣ �޹�ȣ�� ������ ���ڶ��ϴ�. �� �����ּ���.");
		form.ssn2.focus();
		return false;
	} else {
		var strjumin1 = form.ssn1.value;
		var strjumin2 = form.ssn2.value;
		var digit = 0;

		for (var i=0;i<strjumin1.length;i++) {   //�ֹι�ȣ ���ڸ��� ���̸�ŭ for���� ������.
			var strdigit=strjumin1.substring(i,i+1);  //���ڸ��� i��°�� i+i��° ���ڸ� ������ ��´�.
			if (strdigit<'0' || strdigit>'9') {   //strdigit �� ���� 0���� �۰ų� 9���� ũ��
				digit=digit+1   //digit�� 1�� ���Ѵ�.
			}
		}

		if ( digit != 0 ) {   //digit�� 0�� �ƴ϶��
			alert('�ֹι�ȣ���� 0���� 9������ ���ڸ� ���� �� �ֽ��ϴ�.\n\n�ٽ� Ȯ���ϰ� �Է��� �ּ���.');
            form.ssn1.focus();   
            return false;  
        }

        var digit1=0;
		for (var i=0;i<strjumin2.length;i++) { // �ֹι�ȣ ���ڸ��� ���̸�ŭ for���� ������.
			var strdigit1=strjumin2.substring(i,i+1);
			if (strdigit1<'0' || strdigit1>'9') {
				digit1=digit1+1;
			}
		}

        if ( digit1 != 0 ) {
			alert('�ֹι�ȣ���� 0���� 9������ ���ڸ� ���� �� �ֽ��ϴ�.\n\n�ٽ� Ȯ���ϰ� �Է��� �ּ���.'); 
			form.ssn2.focus();
			return false;   
		}

        if (strjumin1.substring(2,3) > 1) {   //�ֹι�ȣ �� �κ��� ù° ���ڰ� 1���� Ŭ���
            alert('�߸��� \'��\'�� �Է��߽��ϴ�.\n\n�ٽ� Ȯ���ϰ� �Է��� �ּ���.');
            form.ssn1.focus();   
            return false;
        }
        if (strjumin1.substring(4,5) > 3) { //�ֹι�ȣ �� �κ��� ù° ���ڰ� 3���� Ŭ���   
            alert('�߸��� \'��\'�� �Է��߽��ϴ�.\n\n�ٽ� Ȯ���ϰ� �Է��� �ּ���.');
            form.ssn1.focus();   
            return false;   
        } 
		if (strjumin2.substring(0,1) > 4 || strjumin2.substring(0,1) == 0) {  //�ֹι�ȣ ���ڸ��� ù°���ڰ� 4���� Ŭ���
			alert('�ٽ� Ȯ���ϰ� �Է��� �ּ���.');
			form.ssn2.focus();   
            return false;   
        }
        var a1=strjumin1.substring(0,1)   //�ֹι�ȣ ����
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
			alert('�߸��� �ֹε�Ϲ�ȣ�Դϴ�.\n\n�ٽ� Ȯ���ϰ� �Է��� �ּ���.'); 
			form.ssn1.value="";
			form.ssn2.value="";
			form.ssn1.focus();   
			return false;
		} 
	}
	return true;
}
//color ����
function selectColor(formName, id){
		var id = "color_select.jsp?id="+id+"&formName="+formName;
		var colorSelect = window.open(id,"colorSelect","width=451,height=452");
		colorSelect.focus();
	}
	
function check_email(data) {		//�����Ǹ� true, ���� : false

	  
  
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
		alert("���ڸ� �Է��� �� �ֽ��ϴ�.");
	}
}




//key event ���ڸ� �Է�Ȯ��
//���ڸ� �Է� ('.'����)
function onlyNumber2()
{
	if(((event.keyCode<48)||(event.keyCode>57)) && 
		event.keyCode !=46 && event.keyCode !=13)
	{
		event.returnValue=false;
		alert("���ڿ� �Ҽ����� �Է��� �� �ֽ��ϴ�.");
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
		alert("url�� �Է��Ͻʽÿ�.");
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
		var special = /[\{\}\[\]\/?.,;:|\)*~`!^\-_+��<>@\#$%&\'\"\\\(\=]/gi;
		obj.value = obj.value.replace(special,'');
	}
}

/* ��й�ȣ ���� üũ 8~12*/
function pwCheck(p) {
	chk1 = /^[a-z\d\{\}\[\]\/?.,;:|\)*~`!^\-_+&lt;&gt;@\#$%&amp;\\\=\(\'\"]{4,12}$/i; //������ ���� Ư���� �̿��� ���ڰ� �ִ��� Ȯ��
	chk2 = /[a-z]/i; //��� �Ѱ��� ������ Ȯ��
	chk3 = /\d/; //��� �Ѱ��� ���� Ȯ��
	//chk4 = /[\{\}\[\]\/?.,;:|\)*~`!^\-_+&lt;&gt;@\#$%&amp;\\\=\(\'\"]/i; //��� �Ѱ��� Ư���� Ȯ��
	return chk1.test(p) && chk2.test(p) && chk3.test(p);

}

/* ��й�ȣ ���� üũ 8~12*/
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

/* ���ڸ� �Է� */
function onlyNumber(obj){
		 obj.style.imeMode = "disabled";
		 if((event.keyCode != 9 && event.keyCode != 8 && event.keyCode != 46) && (event.keyCode < 48 || event.keyCode > 57) && (event.keyCode < 96 || event.keyCode > 105))
		 {
		     alert("���ڸ� �Է��Ҽ� �ֽ��ϴ�.");  
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

	var re=true; //�⺻�� true

	for(i=0;i<ojbstrlen;i++){
	//�������� �� �ʿ��� ����������

	//�ѱ�&�Ϻ���� +2   
	onechar=objstr.charAt(i);
	if(escape(onechar).length>4){
		bytesize+=2;//�ѱ� �Ϻ��� 2����Ʈ
	}else{
		bytesize++;
	}
	if(bytesize<=maxlen){
		strlen=i+1; 
	}
	//Ư����������

	// var keyCode; 
	//keyCode = objstr.charCodeAt(i);
	//if((keyCode>=32 && keyCode<48) || (keyCode>57 && keyCode <65) || (keyCode>90 &&   keyCode<96) ||keyCode == 124 ||keyCode == 96 ||keyCode==123 || keyCode==125)
	// {
	//alert("??");   
	//re=false;
	//objname.value=''; //�ʱ�ȭ

	 //break; // break�� ���ϸ� Ư�����ڰ� 3�������� alertâ�� 3���� ��

	//   }


	}//for����

	if(bytesize>=maxlen){
		alert("�ؽ�Ʈ �Է� ���� �ʰ� �ѱ�"+maxlength/2+"��, ����"+maxlength+"�� ���Ϸ� �����ּ���.");
		objstr2=objstr.substr(0,strlen);
		objname.value=objstr2;   
		re = false;
	}
	objname.focus();
	return re;
}

function fc_chk_byte(memo,leng) 
{ 

	var ls_str = memo.value; // �̺�Ʈ�� �Ͼ ��Ʈ���� value �� 
	var li_str_len = ls_str.length; // ��ü���� 

	// �����ʱ�ȭ 
	var li_max = leng; // ������ ���ڼ� ũ�� 
	var i = 0; // for���� ��� 
	var li_byte = 0; // �ѱ��ϰ��� 2 �׹ܿ��� 1�� ���� 
	var li_len = 0; // substring�ϱ� ���ؼ� ��� 
	var ls_one_char = ""; // �ѱ��ھ� �˻��Ѵ� 
	var ls_str2 = ""; // ���ڼ��� �ʰ��ϸ� �����Ҽ� ������������ �����ش�. 

	for(i=0; i< li_str_len; i++) 
	{ 
	// �ѱ������� 
	ls_one_char = ls_str.charAt(i); 

	// �ѱ��̸� 2�� ���Ѵ�. 
	if (escape(ls_one_char).length > 4) 
	{ 
	li_byte += 2; 
	} 
	// �׹��� ���� 1�� ���Ѵ�. 
	else 
	{ 
	li_byte++; 
	} 

	// ��ü ũ�Ⱑ li_max�� ���������� 
	if(li_byte <= li_max) 
	{ 
	li_len = i + 1; 
	} 
	} 

	// ��ü���̸� �ʰ��ϸ� 
	if(li_byte >= li_max) 
	{ 
		alert( li_max + " ���ڸ� �ʰ� �Է��Ҽ� �����ϴ�. \n �ʰ��� ������ �ڵ����� ���� �˴ϴ�. "); 
		ls_str2 = ls_str.substr(0, li_len); 
		memo.value = ls_str2; 

	} 
	memo.focus(); 
} 
//html���� �̹��� ������ ��� �̸����� ��� ����
// �̹���, div id,
function previewImage(targetObj, previewId) {

        var preview = document.getElementById(previewId); //div id   
        var ua = window.navigator.userAgent;

        if (ua.indexOf("MSIE") > -1) {//ie�϶�

            targetObj.select();

            try {
                var src = document.selection.createRange().text; // get file full path 
                var ie_preview_error = document
                        .getElementById("ie_preview_error_" + previewId);

                if (ie_preview_error) {
                    preview.removeChild(ie_preview_error); //error�� ������ delete
                }

                var img = document.getElementById(previewId); //�̹����� �ѷ��� �� 

                img.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(src='"
                        + src + "', sizingMethod='scale')"; //�̹��� �ε�, sizingMethod�� div�� ���缭 ����� �ڵ����� �ϴ� ����
            } catch (e) {
                if (!document.getElementById("ie_preview_error_" + previewId)) {
                    var info = document.createElement("<p>");
                    info.id = "ie_preview_error_" + previewId;
                    info.innerHTML = "a";
                    preview.insertBefore(info, null);
                }
            }
        } else { //ie�� �ƴҶ�
            var files = targetObj.files;
            for ( var i = 0; i < files.length; i++) {

                var file = files[i];

                var imageType = /image.*/; //�̹��� �����ϰ�츸.. �ѷ��ش�.
                if (!file.type.match(imageType))
                    continue;

                var prevImg = document.getElementById("prev_" + previewId); //������ �̸����Ⱑ �ִٸ� ����
                if (prevImg) {
                    preview.removeChild(prevImg);
                }

                var img = document.createElement("img"); //ũ���� div�� �̹����� �ѷ����� �ʴ´�. �׷��� �ڽ�Element�� �����.
                img.id = "prev_" + previewId;
                img.classList.add("obj");
                img.file = file;
                img.style.width = '50px'; //�⺻������ div�� �ȿ� �ѷ����� ȿ���� �ֱ� ���ؼ� divũ��� ���� ũ�⸦ �������ش�.
                img.style.height = '50px';
                
                preview.appendChild(img);

                if (window.FileReader) { // FireFox, Chrome, Opera Ȯ��.
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