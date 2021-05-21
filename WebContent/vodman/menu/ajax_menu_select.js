var xmlHttp;
var xmlHttp1;
var xmlHttp2;
var xmlHttp3;
var xmlHttp4;

var changeObj;
var selectArr = new Array();
var menu1;
var menu2;
var menu3;
var menu4;

function createXMLHttpRequest() {
    if (window.ActiveXObject) {
        xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
    } 
    else if (window.XMLHttpRequest) {
        xmlHttp = new XMLHttpRequest();
    }
}
function createXMLHttpRequestA() {
    if (window.ActiveXObject) {
 
        xmlHttp1 = new ActiveXObject("Microsoft.XMLHTTP");
 
    } 
    else if (window.XMLHttpRequest) {
 
        xmlHttp1 = new XMLHttpRequest();
 
    }
}
function createXMLHttpRequestB() {
    if (window.ActiveXObject) {
 
        xmlHttp2 = new ActiveXObject("Microsoft.XMLHTTP");
 
    } 
    else if (window.XMLHttpRequest) {
 
        xmlHttp2 = new XMLHttpRequest();
 
    }
}
function createXMLHttpRequestC() {
    if (window.ActiveXObject) {
 
        xmlHttp3 = new ActiveXObject("Microsoft.XMLHTTP");
 
    } 
    else if (window.XMLHttpRequest) {
 
        xmlHttp3 = new XMLHttpRequest();
 
    }
}
function createXMLHttpRequestD() {
    if (window.ActiveXObject) {
 
        xmlHttp4 = new ActiveXObject("Microsoft.XMLHTTP");
    } 
    else if (window.XMLHttpRequest) {
 
        xmlHttp4 = new XMLHttpRequest();
    }
}


/*
param : menu°ª, target : º¯ÇÒ select id, info : category info(A, B, C..)
*/
function refreshMenuList( param, info, target) {

	changeObj = target;

	for(var i = 2; i < arguments.length; i++){ 
		selectArr[i-2] = arguments[i];
 
	}
 

    if(param == "" && info != "A") {
        clearModelsList();
        return;
    }
    
    var url = "/vodman/menu/menu_select.jsp?info="+info+"&menu="+param;

    createXMLHttpRequest();
    xmlHttp.onreadystatechange = handleStateChange;
    xmlHttp.open("GET", url, true);
    xmlHttp.send(null);
}

function refreshMenuList_A( param, info, menu ) {

	menu1 = menu.substring(0,3)+"000000000";
 
	 var url = "/vodman/menu/menu_select.jsp?info="+info+"&menu=";
    createXMLHttpRequestA();
 
    	 xmlHttp1.onreadystatechange = handleStateChangeA;
    	 xmlHttp1.open("GET", url, true);
    	 xmlHttp1.send(null);

}

function refreshMenuList_B( param, info, menu ) {
	 
	menu2 = menu.substring(0,6)+"000000";
 

	 var url = "/vodman/menu/menu_select.jsp?info="+info+"&menu="+menu2;
    createXMLHttpRequestB();
 
     xmlHttp2.onreadystatechange = handleStateChangeB;
	 xmlHttp2.open("GET", url, true);
	 xmlHttp2.send(null); 
}
function refreshMenuList_C( param, info, menu ) {
	 
	menu3 = menu.substring(0,9)+"000";
 
 
	var url = "/vodman/menu/menu_select.jsp?info="+info+"&menu="+menu3;
    createXMLHttpRequestC();

     xmlHttp3.onreadystatechange = handleStateChangeC;
	 xmlHttp3.open("GET", url, true);
	 xmlHttp3.send(null);
}
function refreshMenuList_D( param, info, menu ) {
	 
	menu4 = menu ;
 

	var url = "/vodman/menu/menu_select.jsp?info="+info+"&menu="+menu4;
    createXMLHttpRequestD();

     xmlHttp4.onreadystatechange = handleStateChangeD;
	 xmlHttp4.open("GET", url, true);
	 xmlHttp4.send(null);
}
    
function handleStateChange() {
    if(xmlHttp.readyState == 4) {
        if(xmlHttp.status == 200) {
 
            updateModelsList0();
        }
    }
}
function handleStateChangeA() {
    if(xmlHttp1.readyState == 4) {
        if(xmlHttp1.status == 200) {
 
            updateModelsList(menu1, 'A');
        }
    }
}
function handleStateChangeB() {
    if(xmlHttp2.readyState == 4) {
        if(xmlHttp2.status == 200) {
            updateModelsList(menu2, 'B');
 
        }
    }
}
function handleStateChangeC() {
    if(xmlHttp3.readyState == 4) {
        if(xmlHttp3.status == 200) {
            updateModelsList(menu3, 'C');
        }
    }
}
function handleStateChangeD() {
    if(xmlHttp4.readyState == 4) {
        if(xmlHttp4.status == 200) {
            updateModelsList(menu4, 'D');
        }
    }
}


function updateModelsList0() {
    clearModelsList();

    var obj = document.getElementById(changeObj);

    var results = xmlHttp.responseXML.getElementsByTagName("menu");
    var option = null;
//    alert(results.length);   
	for(var i = 0; i < results.length; i++) {
        option = document.createElement("option");
        attr = document.createAttribute("value");
		attr.nodeValue = results[i].childNodes.item(0).firstChild.nodeValue;
        option.appendChild(document.createTextNode(results[i].childNodes.item(1).firstChild.nodeValue));
		option.attributes.setNamedItem(attr);
        obj.appendChild(option);
    }
	
}

function updateModelsList(menu, info_value) {
    clearModelsList();
 
    var obj;
    var results;
 
    if ( info_value == "A") {
    	results = xmlHttp1.responseXML.getElementsByTagName("menu");
    	obj = document.getElementById("mmenu1");
    } else if (info_value == "B") {
    	results = xmlHttp2.responseXML.getElementsByTagName("menu");
    	obj = document.getElementById("mmenu2");   	
    } else if (info_value == "C") {
    	results = xmlHttp3.responseXML.getElementsByTagName("menu");
    	obj = document.getElementById("mmenu3");
    }else if (info_value == "D") {
    	results = xmlHttp4.responseXML.getElementsByTagName("menu");
    	obj = document.getElementById("mmenu4");
    }
    var option = null;
    	
	for(var i = 0; i < results.length; i++) {
        option = document.createElement("option");
        attr = document.createAttribute("value");
		attr.nodeValue = results[i].childNodes.item(0).firstChild.nodeValue;
        option.appendChild(document.createTextNode(results[i].childNodes.item(1).firstChild.nodeValue));
		option.attributes.setNamedItem(attr);
		if (menu ==  results[i].childNodes.item(0).firstChild.nodeValue) {
			option.setAttribute("selected", true);
		}

        obj.appendChild(option);
    }
	
}


function clearModelsList() {
	for(var i = 0; i < selectArr.length; i++){ 	
		var obj = document.getElementById(selectArr[i]);
		while(obj.childNodes.length > 2) {
			obj.removeChild(obj.childNodes[obj.childNodes.length-1]);
		}
	}
}