<!--
function onLoadURL(url,contents){ 
	r_GetStatus = SeeVideo2003.GetStatus();
	if(r_GetStatus == 0) SeeVideo2003.ShowURL(url);
}

function MediaEvent(wParam, lParam){//Mozilla Event
	if(wParam == 3 || wParam == 7){ SeeVideo2003.ShowURL('http://seemedia.co.kr/Flash.html?widht=522&height=365');}
}

function MediaEvent_event(wParam, lParam){//Mozilla Event(플래시 사이즈가 틀림)
	if(wParam == 3 || wParam == 7){ SeeVideo2003.ShowURL('http://seemedia.co.kr/Flash.html?widht=450&height=365');}
}

function Play_Flash(widht,height){
	var flash_tag="";
	flash_tag += "<OBJECT classid='clsid:D27CDB6E-AE6D-11cf-96B8-444553540000' codebase='http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0' width='"+widht+"' height='"+height+"'>";
	flash_tag += "<param name='movie' value='./flash/522_2004.swf'>";
	flash_tag += "<param name='quality' value='high'>";
		flash_tag += "<EMBED src='./flash/522_2004.swf' quality='high' pluginspage='http://www.macromedia.com/go/getflashplayer' type='application/x-shockwave-flash' width='"+widht+"' height='"+height+"'></EMBED>";
	flash_tag += "</OBJECT>";
	
	var flayer=document.getElementById("Flash_layer");
	flayer.innerHTML=flash_tag;
}

function put_contents(contents, port){
	if (window.ActiveXObject){
			Object_js(contents, port);
	}else{
			Embed_js(contents, port);
	}

	if(contents=="event"){
		onLoadURL('http://seemedia.co.kr/Flash.html?widht=450&height=365',contents);
	}else if(contents =="bookmark"){
		onLoadURL('http://seemedia.co.kr/Flash.html?widht=522&height=215',contents);
	}else{
		onLoadURL('http://seemedia.co.kr/Flash.html?widht=522&height=365',contents);
	}
}

function Object_js(contents, port){
	var obj_tag="";
		
		switch(contents){
			case "dvd" :
				obj_tag+="<OBJECT id='SeeVideo2003' name='SeeVideo2003' width=100% height=100% classid='CLSID:68253470-5d4f-4cdf-8d9c-353c14a2f013'>";
					obj_tag+="<param name='MediaItem' value='59712137'>";
					obj_tag+="<param name='ShowControl' value='0'>";
					obj_tag+="<param name='RandomEnable' value='1'>"; 
					obj_tag+="<param name='StartMenu' VALUE='2'>";
					obj_tag+="<param name='ScaleMode' value='1'>";
					obj_tag+="<param name='WebScriptURL' VALUE='http://www.seemedia.co.kr/svs/E1_.svs'>";
			break;

			case "dubbing" :
				obj_tag+="<OBJECT id='SeeVideo2003' width=100% height=100% classid='CLSID:68253470-5d4f-4cdf-8d9c-353c14a2f013'>";
					obj_tag+="<param name='RandomEnable' value='1'>";
					obj_tag+="<param name='MediaItem' value='410942172'>";
			break;		
				
			case "message" :
				obj_tag+="<OBJECT id='SeeVideo2003' name='SeeVideo2003' width=100% height=100% classid='CLSID:68253470-5d4f-4cdf-8d9c-353c14a2f013'>";
					obj_tag+="<param name='MediaItem' value='187850670'>";
					obj_tag+="<param name='RandomEnable' value='1'>";
					obj_tag+="<param name='ScaleMode' value='1'>";
					obj_tag+="<param name='EnableMessage' value='1'>";
					obj_tag+="<param name='ShowByRGBVideo' value='1'>";
			break;	

			case "chapter_menu" :
				obj_tag+="<OBJECT id='SeeVideo2003' width=100% height=100% classid='CLSID:68253470-5d4f-4cdf-8d9c-353c14a2f013'>";
					obj_tag+="<param name='MediaItem' value='260780225'>";
					obj_tag+="<param name='RandomEnable' value='1'> ";
					obj_tag+="<param name='EnableMessage' value='0'>";
					obj_tag+="<param name='ScaleMode' value='1'>";
			break;

			case "alpha" :
				obj_tag+="<OBJECT id='SeeVideo2003' name='SeeVideo2003' width=100% height=100% classid='CLSID:68253470-5d4f-4cdf-8d9c-353c14a2f013'>";
					obj_tag+="<param name='MediaItem' value='145106232'>";
					obj_tag+="<param name='Level' VALUE='5'>";
					obj_tag+="<param name='Servicename' value='SeeMedia'>";
					obj_tag+="<param name='ServiceAccount' value='KoreaDemo'>";
					obj_tag+="<param name='RandomEnable' value='1'>";
					obj_tag+="<param name='EnableMessage' value='0'>";
					obj_tag+="<param name='ScaleMode' value='1'>";
					obj_tag+="<param name='WebScriptURL' VALUE='http://www.seemedia.co.kr/alphaimg.svs'>";
			break;

			case "skin" :
				obj_tag+="<OBJECT id='SeeVideo2003' width=100% height=100% classid='CLSID:68253470-5d4f-4cdf-8d9c-353c14a2f013'>";
					obj_tag+="<param name='MediaItem' value='164125783'>";
					obj_tag+="<param name='ScaleMode' value='1'>";
			break;

			case "bookmark" :
				obj_tag+="<OBJECT id='SeeVideo2003' name='SeeVideo2003' width=100% height=100% classid='CLSID:68253470-5d4f-4cdf-8d9c-353c14a2f013'>";
					obj_tag+="<param name='MediaItem' value='151359334'>";
					obj_tag+="<param name='RandomEnable' value='1'>";
					obj_tag+="<param name='BookmarkHandle' VALUE='Tomorrow'>";
				
			var bookmark_tag="";
				
				bookmark_tag+="<OBJECT ID='SeeVideo_Bookmark' width='100%' height='100%' CLASSID='CLSID:EE014CB4-0CB6-4C4F-8D15-46AE10B9B059' CODEBASE='SVBookmark.cab#version=1,0,0,5'>";
					bookmark_tag+="<param name='CtrlBarShow' VALUE='0'>";
					bookmark_tag+="<param name='Mediatype' VALUE='0'>";
					bookmark_tag+="<param name='BookMarkname' VALUE='Tomorrow'>";
					bookmark_tag+="<param name='Clipname' VALUE='Tomorrow'>";
				bookmark_tag+="</OBJECT>";
			break;

			case "mp3" :
				obj_tag+="<OBJECT id='SeeVideo2003' width=100% height=100% classid='CLSID:68253470-5d4f-4cdf-8d9c-353c14a2f013'>";
					obj_tag+="<param name='MediaItem' value='118998232'>";
					obj_tag+="<param name='RandomEnable' value='1'>";
					obj_tag+="<param name='ScaleMode' value='1'>";
					obj_tag+="<param name='EnableMessage' value='1'>";
					obj_tag+="<param name='ShowByRGBVideo' value='1'>";
			break;

			case "media" :
				obj_tag+="<OBJECT id='SeeVideo2003' width=100% height=100% classid='CLSID:68253470-5d4f-4cdf-8d9c-353c14a2f013'>";
					obj_tag+="<param name='MediaItem' value=''>";
					obj_tag+="<param name='RandomEnable' value='1'>";
					obj_tag+="<param name='ScaleMode' value='1'>";
					obj_tag+="<param name='MediaTrack' value='http://www.seemedia.co.kr/mediatrack.mt'>";
			break;

			case "event" :
				obj_tag+="<OBJECT id='SeeVideo2003' width=100% height=100% classid='CLSID:68253470-5d4f-4cdf-8d9c-353c14a2f013'>";
					obj_tag+="<param name='MediaItem' value='119069168'>";
					obj_tag+="<param name='RandomEnable' value='1'> ";
					obj_tag+="<param name='EnableMessage' value='0'>";
					obj_tag+="<param name='ScaleMode' value='1'>";
					obj_tag+="<param name='WebScriptURL' VALUE='http://www.seemedia.co.kr/event.svs'>";
			break;

			case "event1" :
				obj_tag+="<OBJECT id='SeeVideo2003' width=100% height=100% classid='CLSID:68253470-5d4f-4cdf-8d9c-353c14a2f013'>";
					obj_tag+="<param name='MediaItem' value='119069168'>";
					obj_tag+="<param name='RandomEnable' value='1'> ";
					obj_tag+="<param name='EnableMessage' value='0'>";
					obj_tag+="<param name='ScaleMode' value='1'>";
					obj_tag+="<param name='WebScriptURL' VALUE='http://www.seemedia.co.kr/svs/event1.svs'>";
				break;

			case "speed" :
				obj_tag+="<OBJECT id='SeeVideo2003' width=100% height=100% classid='CLSID:68253470-5d4f-4cdf-8d9c-353c14a2f013'>";
					obj_tag+="<param name='MediaItem' value='60165848'>";
					obj_tag+="<param name='RandomEnable' value='1'>";
					obj_tag+="<param name='ScaleMode' value='1'>";
			break;

			case "poster" :
				obj_tag+="<OBJECT id='SeeVideo2003' width=100% height=100% classid='CLSID:68253470-5d4f-4cdf-8d9c-353c14a2f013'>";
					obj_tag+="<param name='MediaItem' value='55137775'>";
					obj_tag+="<param name='RandomEnable' value='1'>";
			break;

			case "subtitle" :
				obj_tag+="<OBJECT id='SeeVideo2003' width=100% height=100% classid='CLSID:68253470-5d4f-4cdf-8d9c-353c14a2f013'>";
					obj_tag+="<param name='MediaItem' value='40588836'>";
					obj_tag+="<param name='RandomEnable' value='1'> ";
					obj_tag+="<param name='ScaleMode' value='1'>";
					obj_tag+="<param name='WebScriptURL' VALUE='http://www.seemedia.co.kr/svs/sshark_512x272_smv2.svs'>";
			break;

			default :
			break;

		}
		
		if(port=="s" || !port){
				obj_tag+="<param name='PortNum' value='80'>";
				obj_tag+="<param name='UseFixedServerPort' value='1'>";
		}else{
			obj_tag+="<param name='PortNum' value='5000'>";
			obj_tag+="<param name='UseFixedServerPort' value='0'>";
		}

			obj_tag+="<param name='ServerIP' value='211.39.142.91'>";
			obj_tag+="<param name='NoTicket' value='1'>";
			obj_tag+="<param name='AutoPlay' value='0'>";
			obj_tag+="<param name='Skinname' value='2003default_320'>";
			obj_tag+="<param name='SkinCodeBase' value='http://www.seevideo.co.kr/pub/skin/2003default_320.sbd#Version=31015'>";
			obj_tag+="<param name='CustomLogo' VALUE='http://www.seevideo.co.kr/demo/images/logo.jpg'>";
			obj_tag+="<param name='CustomLogoOnWhite' VALUE='1'>";
		obj_tag+="</OBJECT>";

		var mlayer=document.getElementById("media_layer");
		mlayer.innerHTML=obj_tag;

		if(contents=="bookmark")
			bookmark_layer.innerHTML=bookmark_tag;
	
}

function Embed_js(contents, port){
	var obj_tag="";
		
		switch(contents){
			case "dvd" :
				obj_tag+="<EMBED type='application/x-seevideo-player' ID='SeeVideo2003' WIDTH='522' HEIGHT='365' ";
					obj_tag+="MediaItem='59712137' ";
					obj_tag+="ShowControl='0' ";
					obj_tag+="RandomEnable='1' ";
					obj_tag+="StartMenu='2' ";
					obj_tag+="ScaleMode='1' ";
					obj_tag+="WebScriptURL='http://www.seemedia.co.kr/svs/E1_.svs' ";
			break;

			case "dubbing" :
				obj_tag+="<EMBED type='application/x-seevideo-player' ID='SeeVideo2003' WIDTH='522' HEIGHT='365' ";
					obj_tag+="MediaItem='410942172' ";
					obj_tag+="RandomEnable='1' ";
			break;		
				
			case "message" :
				obj_tag+="<EMBED type='application/x-seevideo-player' ID='SeeVideo2003' WIDTH='522' HEIGHT='365' ";
					obj_tag+="MediaItem='187850670' ";
					obj_tag+="RandomEnable='1' ";
					obj_tag+="ScaleMode='1' ";
					obj_tag+="EnableMessage='1' ";
					obj_tag+="ShowByRGBVideo='1' ";
			break;	

			case "chapter_menu" :
				obj_tag+="<EMBED type='application/x-seevideo-plaYer' ID='SeeVideo2003' WIDTH='522' HEIGHT='365' ";
					obj_tag+="MediaItem='260780225' ";
					obj_tag+="RandomEnable='1' ";
					obj_tag+="EnableMessage='0' ";
					obj_tag+="ScaleMode='1' ";
			break;

			case "alpha" :
				obj_tag+="<EMBED type='application/x-seevideo-player' ServiceAccount='KoreaDemo' ID='SeeVideo2003' WIDTH='522' HEIGHT='365' ";
					obj_tag+="MediaItem='145106232' ";
					obj_tag+="Level='5' ";
					obj_tag+="Servicename=SeeMedia' ";
					obj_tag+="ServiceAccount='KoreaDemo' ";
					obj_tag+="RandomEnable='1' ";
					obj_tag+="EnableMessage='0' ";
					obj_tag+="ScaleMode='1' ";
					obj_tag+="WebScriptURL='http://www.seemedia.co.kr/alphaimg.svs' ";
			break;

			case "skin" :
                obj_tag+="<EMBED type='application/x-seevideo-player' ID='SeeVideo2003' WIDTH='522' HEIGHT='365' ";
				obj_tag+="MediaItem='164125783' ";
				obj_tag+="ScaleMode='1' ";
			break;

			case "bookmark" :
			break;

			case "mp3" :
				obj_tag+="<EMBED type='application/x-seevideo-player' ID='SeeVideo2003' WIDTH='522' HEIGHT='365' ";
					obj_tag+="MediaItem='118998232' ";
					obj_tag+="RandomEnable='1' ";
					obj_tag+="ScaleMode='1' ";
					obj_tag+="EnableMessage='1' ";
					obj_tag+="ShowByRGBVideo='1' ";
			break;

			case "media" :
				obj_tag+="<EMBED type='application/x-seevideo-player' ID='SeeVideo2003' WIDTH='522' HEIGHT='365' ";
				obj_tag+="MediaItem='' ";
				obj_tag+="RandomEnable='1' ";
				obj_tag+="ScaleMode='1' ";
				obj_tag+="MediaTrack='http://www.seemedia.co.kr/mediatrack.mt' ";
			break;

			case "event" :
				obj_tag+="<EMBED type='application/x-seevideo-player' ID='SeeVideo2003' WIDTH='448' HEIGHT='365' ";
					obj_tag+="MediaItem='119069168' ";
					obj_tag+="RandomEnable='1' ";
					obj_tag+="EnableMessage='0' ";
					obj_tag+="ScaleMode='1' ";
					obj_tag+="WebScriptURL='http://www.seemedia.co.kr/event.svs' ";
					obj_tag+="EventFuncname87='ScriptEvent_EMB' ";
			break;

			case "event1" :
				obj_tag+="<EMBED type='application/x-seevideo-player' ID='SeeVideo2003' WIDTH='448' HEIGHT='365' ";
					obj_tag+="MediaItem='119069168' ";
					obj_tag+="RandomEnable='1' ";
					obj_tag+="EnableMessage='0' ";
					obj_tag+="ScaleMode'='1' ";
					obj_tag+="WebScriptURL='http://www.seemedia.co.kr/event.svs' ";
					obj_tag+="EventFuncname87='ScriptEvent_EMB' ";
				break;

			case "speed" :
				obj_tag+="<EMBED  type='application/x-seevideo-player' ID='SeeVideo2003' WIDTH='522' HEIGHT='365' ";
				obj_tag+="MediaItem='60165848' ";
				obj_tag+="RandomEnable='1' ";
				obj_tag+="ScaleMode='1' ";
			break;

			case "poster" :
				obj_tag+="<EMBED type='application/x-seevideo-player' ID='SeeVideo2003' WIDTH='522' HEIGHT='365' ";
				obj_tag+="MediaItem='55137775' ";
				obj_tag+="RandomEnable='1' ";
			break;

			case "subtitle" :
				obj_tag+="<EMBED type='application/x-seevideo-player' ID='SeeVideo2003' WIDTH='522' HEIGHT='365' ";
				obj_tag+="MediaItem='40588836' ";
				obj_tag+="RandomEnable='1' ";
				obj_tag+="ScaleMode='1' ";
				obj_tag+="WebScriptURL='http://www.seemedia.co.kr/svs/sshark_512x272_smv2.svs' ";
			break;

			default :
			break;

		}

		obj_tag+="ServerIP='211.39.142.91' ";
		obj_tag+="NoTicket='1' ";
		obj_tag+="AutoPlay='0' ";
		obj_tag+="SkinCodeBase='http://www.seevideo.co.kr/pub/skin/2003default_320.sbd#Version=31015' ";
		obj_tag+="CustomLogo='http://www.seevideo.co.kr/demo/images/logo.jpg' CustomLogoOnWhite='1' ";
		obj_tag+="Skinname='2003default_320' ";
		obj_tag+="CustomLogoOnWhite='1' ";
		obj_tag+="Servicename='SeeMedia' ";
		obj_tag+="ServiceAccount='KoreaDemo' ";

		if(contents=="event"){
			obj_tag+="EventFuncName88='MediaEvent_event'";//MediaEvent 함수 호출
		}else{
			obj_tag+="EventFuncName88='MediaEvent'";//MediaEvent 함수 호출
		}

/*		obj_tag+="EventFuncName87='ScriptEvent'";  Mozilla Event Function
		obj_tag+="EventFuncName89='DebugEvent'";
		obj_tag+="EventFuncName90='MouseEvent'";
		obj_tag+="EventFuncName91='UserButtonEvent'";
*/		
		if(port=="s" || !port){
				obj_tag+="PortNum='80' ";
				obj_tag+="UseFixedServerPort='1'>";
			obj_tag+="</EMBED>";
		}else{
				obj_tag+="PortNum='5000' ";
				obj_tag+="UseFixedServerPort='0'>";
			obj_tag+="</EMBED>";
		}
		var mlayer=document.getElementById("media_layer");
		mlayer.innerHTML=obj_tag;
}

function put_contents1(contents, port){
    var obj_tag="";
			obj_tag+="<OBJECT id='SeeLive' width='100%' height='100%' classid='CLSID:8eeb54d5-cc70-40e4-b015-ac478c02ecc8' codebase='http://www.seevideo.co.kr/pub/seelive/SLViewer.CAB#Version=1,2,15,109'>";
				obj_tag+="<param name='ServerIP' value='220.73.222.162'>";
				obj_tag+="<param name='NoTicket' value='1'>";
				obj_tag+="<param name='StartDelay' value='2'>";
				obj_tag+="<param name='AutoPlay' value='1'>";
				obj_tag+="<param name='EnableAlwaysOnTop' value='1'>";
				obj_tag+="<param name='CustomLogo' VALUE='http://www.seevideo.co.kr/demo/images/logo.jpg'>";
				obj_tag+="<param name='CustomLogoOnWhite' VALUE='1'>";

		
    switch(contents){
        case "single_ch" :
				obj_tag+="<param name='Channel' value='100'>";

			obj_tag+="<EMBED Channel='100' ";
        break;
		
		case "multi_ch" :
				obj_tag+="<param name='Channel' value='1000'>";

			obj_tag+="<EMBED Channel='1000' ";
        break;

        case "live_japan" :
				obj_tag+="<param name='Channel' VALUE='9001'>";

			obj_tag+="<EMBED Channel='9001' ";
        break;
	
		case "camera" :
				obj_tag+="<param name='Channel' value='3100'>";

		    obj_tag+="<EMBED Channel='3100' ";
	    break;
		case "camera_multi" :
				obj_tag+="<param name='Channel' value='1100'>";

			obj_tag+="<EMBED Channel='1100' ";
        break;
        
		case "scheduler" :
				obj_tag+="<param name='Channel' value='101'>";
	    
			obj_tag+="<EMBED Channel='101' ";
        break;
		
		default :
		break;
    }

		obj_tag+="WIDTH='522' HEIGHT='343' ";
		obj_tag+="ID='SeeLive_Plugin' ";
		obj_tag+="type='application/x-seelive-player' ";
		obj_tag+="pluginspage='http://seemedia.co.kr' ";
		obj_tag+="ServerIP='220.73.222.162' ";
		obj_tag+="NoTicket'='1' ";
		obj_tag+="StartDelay='2' ";
		obj_tag+="AutoPlay='1' ";
		obj_tag+="EnableAlwaysOnTop='1' ";
		obj_tag+="CustomLogo='http://www.seevideo.co.kr/demo/images/logo.jpg' ";
		obj_tag+="CustomLogoOnWhite='1' ";

		if(port=="s"){
				obj_tag+="BasePort='80' ";
				obj_tag+="UseFixedServerPort='1'>";
			obj_tag+="</EMBED>";
			
				obj_tag+="<param name='BasePort' value='80'>";
				obj_tag+="<param name='UseUniPort' value='1'>";
		}else{
				obj_tag+="BasePort='5250' ";
				obj_tag+="UseFixedServerPort='0'>";
			obj_tag+="</EMBED>";

				obj_tag+="<param name='BasePort' value='5250'>";
				obj_tag+="<param name='UseUniPort' value='0'>";
		}

			obj_tag+="</OBJECT>";

		var mlayer=document.getElementById("media_layer");
		mlayer.innerHTML=obj_tag;
 	}

	function put_contents2(contents){

		var obj_tag="";
		obj_tag+="<OBJECT id='SFileClient' height='1' widht='1' classid='CLSID:7DAA4544-D0A9-426E-87DB-676B29BFDC98' codebase='http://www.seemedia.co.kr/products/lu2/sm4387/kor/6/SeeFile.cab#version=2,0,0,6' ></OBJECT>";

		var mlayer=document.getElementById("media_layer");
		mlayer.innerHTML=obj_tag;

	}
/*********************************Mozilla Event Function
#define SCRIPT_EVENT_TYPE 87
#define MEDIA_EVENT_TYPE 88
#define DEBUG_EVENT_TYPE 89
#define MOUSE_EVENT_TYPE 90
#define USERBUTTON_EVENT_TYPE 91
*/
/*
function ScriptEvent(wParam, lParam)
{
	//var Event87 = wParam + " + " + lParam;
	//alert(Event87);
}

function MediaEvent(wParam, lParam){
	if(wParam == 3 || wParam == 7){ SeeVideo2003.ShowURL('http://seemedia.co.kr/Flash.html?widht=522&height=365');}
//	var Event88 = wParam + " + " + lParam;
//	alert(Event88);
}

function DebugEvent(offset)
{
	//alert(offset);
}

function MouseEvent(button, state, x, y)
{
	//var Event90 = button + " + " + state + " + " + x + " + " + y;
	//alert(Event90);
}

function UserButtonEvent(button, event)
{
	//var Event91 = button + " + " + event;
	//alert(Event91);
}
*/
-->
