function sendMail() {

	var f = document.frmMail;

	if(f.from_name.value == '') {
		 alert("보내는 사람명을 입력하세요.");
		 f.from_name.focus();
		  return ;
	 }

		
	if ( f.from_email.value == null || f.from_email.value == ""){
			alert("보내는 사람의 전자우편 주소를 입력하세요!");
			f.from_email.focus();
			return;
	}

	//받는 이메일 주소 체크
	if ( f.recv_email.options[0].value == null || f.recv_email.options[0].value == ""){
			alert("받는 사람의 전자우편 주소를 입력하세요!");
			f.to_email.focus();
			return;
	}

	var request_addr_count = 0;
	for( i = 0; i < f.recv_email.options.length; i++ ) {
			f.recv_email.options[i].selected = true;
			request_addr_count++;
	}

	 if(f.title.value == '') {
		 alert("제목을 입력하세요.");
		 f.title.focus();
		  return ;
	 }

	  if(f.message.value == '') {
		 alert("내용을 입력하세요.");
		 f.message.focus();
		  return ;
	 }

	f.submit();

}


function getAdd(rvalue){
	var i;
	if(rvalue != ""){
		tmp = rvalue.split("/")
		for(i=0; i<tmp.length; i++){
			tmp2 = tmp[i].split(",");
			name = tmp2[0];
			tmp3 = tmp2[1];
			email  = tmp3;
			if ( isValidEMAILADDR( email ) == true )
				add2SelectBox(name, email );
			else
				alert( name + "님의 전자우편 주소가 형식에 맞지 않습니다.");
		}
		return true;
	}
	return false;
}
	

function isValidEMAILADDR( email ){
	alert(email);
	if(email.indexOf('@')==-1 || email.indexOf('.')==-1){		
		return true;	 
	}else{
		return false;
	}
}



function add2SelectBox(name, email ){
	var f = document.frmMail;
    if(name.length > 8)
    	name = name.substr(0,8);
    	
	index=f.recv_email.options.length;
	
	if( index== 0){
		index = index+1;
		f.recv_email.options[0] = document.createElement("OPTION");
	}

	//if( index==1 ){
	if( f.recv_email.options[0].value =="" &&  f.recv_email.options[0].text =="" ){

			f.recv_email.options[0].value = name + "," + email;
			f.recv_email.options[0].text  = name + "," + email;

	}else{
		f.recv_email.options.length       = index +1;
		f.recv_email.options[index].value = name + "," + email;
		f.recv_email.options[index].text  = name + "," + email;
	}
	return

}   


function add_item(){
	var f = document.frmMail;
	
	if( f.to_email.value.indexOf(',') != -1 ){
		var temp = f.to_email.value.split(',');

			add2SelectBox( temp[0], temp[1] );
			f.to_email.value = "";

	}else {
			add2SelectBox( "", f.to_email.value );
			f.to_email.value = "";
	}
		
}



function del_item(){
	var f = document.frmMail;
	var i,j;
	var Cnt;
	var recvVList = new Array();
	var recvTList = new Array();
		
	recvList = f.recv_email ;
	if(recvList.options.length<1){
		recvList.options[0].value	= '';
		recvList.options[0].text	= '';
		recvList.options[0].selected	= false;
	}else{
		for ( i = 0, Cnt = 0; i < recvList.options.length; i++ ) {
			if ( recvList.options[i].selected == false ) {
				recvVList[Cnt]	 = recvList.options[i].value;
				recvTList[Cnt++] = recvList.options[i].text;
			}//if
		}//for

		recvList.options.length		= 0;
		for ( i = 0; i < Cnt; i++ ) {
			index = recvList.options.length;
			recvList.options.length			= index+1;
			recvList.options[index].value	= recvVList[i];
			recvList.options[index].text	= recvTList[i];
		}//for
	}

	index=f.recv_email.options.length;
    if( index==0)
		f.recv_email.options[0] = document.createElement("OPTION")

	delete(recvVList);
	delete(recvTList);
}//function
	



function recv_email_check(e){
	var whichCode = (window.Event) ? e.which : e.keyCode;
	if(whichCode==13){
		emailcheck();
	}
}


function emailcheck(){
	var f = document.frmMail;
	//받는 이메일 주소 체크
	if(f.to_email.value.indexOf('@')==-1 || f.to_email.value.indexOf('.')==-1){		
		alert("잘못된 전자우편 주소입니다.");	
		f.to_email.value="";
		f.to_email.focus();	
		return ;
	}else{
		add_item();	
	}

}


// 주소록 보기 팝업
function searchAddrBook() {
	var url = "/admin/group/addressBook/frm_emailAddressBookList.jsp";
	var name = "pop_emailAddrBook";
	var opts = "width=750,height=500,scrollbars=yes,resizable=yes";
	var win = window.open(url, name, opts);
	if ( win.focus )
		win.focus();
}

function cancel() {
	document.form1.reset();

} 