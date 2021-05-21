var xmlHttp;
var xmlHttp1;
var xmlHttp2;
var xmlHttp3;
var xmlHttp4;

var changeObj;
var selectArr = new Array();
var cate1;
var cate2;
var cate3;
var cate4;

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
param : category°ª, target : º¯ÇÒ select id, info : category info(A, B, C..)
*/
function refreshCategoryList(ctype, param, info,target) {
 
	changeObj = target;

	for(var i = 3; i < arguments.length; i++){ 
		selectArr[i-3] = arguments[i];
//		alert(arguments[i]);
	}
	
//	alert(selectArr);

    if(param == "" && info != "A") {
        clearModelsList();
        return;
    }
    
    var url = "/vodman/vod_aod/category_select.jsp?ctype="+ctype+"&info="+info+"&category="+param;

    createXMLHttpRequest();
   	xmlHttp.onreadystatechange = handleStateChange;   
    xmlHttp.open("GET", url, true);
    xmlHttp.send(null);
}

function refreshCategoryList_A(ctype, param, info, ccode ) {

	cate1 = ccode.substring(0,3)+"000000000";
 
    var url = "/vodman/vod_aod/category_select.jsp?ctype="+ctype+"&info="+info+"&category=";
    createXMLHttpRequestA();
 
    	 xmlHttp1.onreadystatechange = handleStateChangeA;
    	 xmlHttp1.open("GET", url, true);
    	 xmlHttp1.send(null);

}

function refreshCategoryList_B(ctype, param, info, ccode ) {
	 
	cate2 = ccode.substring(0,6)+"000000";
 

    var url = "/vodman/vod_aod/category_select.jsp?ctype="+ctype+"&info="+info+"&category="+cate2;
    createXMLHttpRequestB();
 
     xmlHttp2.onreadystatechange = handleStateChangeB;
	 xmlHttp2.open("GET", url, true);
	 xmlHttp2.send(null); 
}
function refreshCategoryList_C(ctype, param, info, ccode ) {
	 
	cate3 = ccode.substring(0,9)+"000";
 
 
    var url = "/vodman/vod_aod/category_select.jsp?ctype="+ctype+"&info="+info+"&category="+cate3;
    createXMLHttpRequestC();

     xmlHttp3.onreadystatechange = handleStateChangeC;
	 xmlHttp3.open("GET", url, true);
	 xmlHttp3.send(null);
}
function refreshCategoryList_D(ctype, param, info, ccode ) {
	 
	cate4 = ccode ;
 

    var url = "/vodman/vod_aod/category_select.jsp?ctype="+ctype+"&info="+info+"&category="+cate4;
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
 
            updateModelsList(cate1, 'A');
        }
    }
}
function handleStateChangeB() {
    if(xmlHttp2.readyState == 4) {
        if(xmlHttp2.status == 200) {
            updateModelsList(cate2, 'B');
 
        }
    }
}
function handleStateChangeC() {
    if(xmlHttp3.readyState == 4) {
        if(xmlHttp3.status == 200) {
            updateModelsList(cate3, 'C');
        }
    }
}
function handleStateChangeD() {
    if(xmlHttp4.readyState == 4) {
        if(xmlHttp4.status == 200) {
            updateModelsList(cate4, 'D');
        }
    }
}
function updateModelsList0() {
    clearModelsList();
    
    var obj = document.getElementById(changeObj);

    var results = xmlHttp.responseXML.getElementsByTagName("category");
    var option = null;
 	
	for(var i = 0; i < results.length; i++) {
        option = document.createElement("option");
        attr = document.createAttribute("value");
		attr.nodeValue = results[i].childNodes.item(0).firstChild.nodeValue;
        option.appendChild(document.createTextNode(results[i].childNodes.item(1).firstChild.nodeValue));
		option.attributes.setNamedItem(attr);
        obj.appendChild(option);
    }
	
}


function updateModelsList(cate, info_value) {
    clearModelsList();
 
//    var obj = document.getElementById(changeObj);
//	  var results = xmlHttp.responseXML.getElementsByTagName("category");
    var obj;
    var results;
 
    if ( info_value == "A") {
    	results = xmlHttp1.responseXML.getElementsByTagName("category");
    	obj = document.getElementById("ccategory1");
    } else if (info_value == "B") {
    	results = xmlHttp2.responseXML.getElementsByTagName("category");
    	obj = document.getElementById("ccategory2");   	
    } else if (info_value == "C") {
    	results = xmlHttp3.responseXML.getElementsByTagName("category");
    	obj = document.getElementById("ccategory3");
    }else if (info_value == "D") {
    	results = xmlHttp4.responseXML.getElementsByTagName("category");
    	obj = document.getElementById("ccategory4");
    }
    var option = null;
    	
	for(var i = 0; i < results.length; i++) {
        option = document.createElement("option");
        attr = document.createAttribute("value");
		attr.nodeValue = results[i].childNodes.item(0).firstChild.nodeValue;
        option.appendChild(document.createTextNode(results[i].childNodes.item(1).firstChild.nodeValue));
		option.attributes.setNamedItem(attr);
		if (cate ==  results[i].childNodes.item(0).firstChild.nodeValue) {
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