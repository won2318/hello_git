var xmlHttp;
var xmlHttp1;
var xmlHttp2;
var xmlHttp3;
var xmlHttp4;

var xmlHttpv;
var xmlHttp1v;
var xmlHttp2v;

var changeObjv;
var changeObj;

var selectArr = new Array();
var selectArrV = new Array();

var cate1;
var cate2;
var cate3;
var cate4;
var cate1v;
var cate2v;

function createXMLHttpRequestV() {
    if (window.ActiveXObject) {
        xmlHttpv = new ActiveXObject("Microsoft.XMLHTTP");
    } 
    else if (window.XMLHttpRequest) {
        xmlHttpv = new XMLHttpRequest();
    }
}

function createXMLHttpRequestAV() {
    if (window.ActiveXObject) {
 
        xmlHttp1v = new ActiveXObject("Microsoft.XMLHTTP");
 
    } 
    else if (window.XMLHttpRequest) {
 
        xmlHttp1v = new XMLHttpRequest();
 
    }
}
function createXMLHttpRequestBV() {
    if (window.ActiveXObject) {
 
        xmlHttp2v = new ActiveXObject("Microsoft.XMLHTTP");
 
    } 
    else if (window.XMLHttpRequest) {
 
        xmlHttp2v = new XMLHttpRequest();
 
    }
}

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


function handleStateChangeV() {
    if(xmlHttpv.readyState == 4) {
        if(xmlHttpv.status == 200) {
 
            updateModelsList0V();
        }
    }
}
function handleStateChangeAV() {
    if(xmlHttp1v.readyState == 4) {
        if(xmlHttp1v.status == 200) {
 
            updateModelsListV(cate1v, 'A');
        }
    }
}
function handleStateChangeBV() {
    if(xmlHttp2v.readyState == 4) {
        if(xmlHttp2v.status == 200) {
            updateModelsListV(cate2v, 'B');
 
        }
    }
}

/*
param : category��, target : ���� select id, info : category info(A, B, C..)
*/


/*
param : category��, target : ���� select id, info : category info(A, B, C..)
*/
function refreshCategoryListV(ctype, param, info,target) {
 
	changeObjv = target;

	for(var i = 3; i < arguments.length; i++){ 
		selectArrV[i-3] = arguments[i];
	}
 
    if(param == "" && info != "A") {
        clearModelsListV();
        return;
    }
    
    var url = "../include/category_select2v.jsp?ctype="+ctype+"&info="+info+"&vcategory="+param;

    createXMLHttpRequestV();
   	xmlHttpv.onreadystatechange = handleStateChangeV;   
    xmlHttpv.open("GET", url, true);
    xmlHttpv.send(null);
}


function refreshCategoryList_AV(ctype, param, info, ccode ) {

	cate1v = ccode.substring(0,3)+"000000000";
 
    var url = "../include/category_select2v.jsp?ctype="+ctype+"&info="+info+"&vcategory=";
    createXMLHttpRequestAV();
 
    	 xmlHttp1v.onreadystatechange = handleStateChangeAV;
    	 xmlHttp1v.open("GET", url, true);
    	 xmlHttp1v.send(null);

}

function refreshCategoryList_BV(ctype, param, info, ccode ) {
	 
	cate2v = ccode.substring(0,6)+"000000";
 

    var url = "../include/category_select2v.jsp?ctype="+ctype+"&info="+info+"&vcategory="+cate2v;
    createXMLHttpRequestBV();
 
     xmlHttp2v.onreadystatechange = handleStateChangeBV;
	 xmlHttp2v.open("GET", url, true);
	 xmlHttp2v.send(null); 
}


function refreshCategoryList(ctype, param, info,target) {
	changeObj = target;
	for(var i = 3; i < arguments.length; i++){ 
		selectArr[i-3] = arguments[i];
	}


    if(param == "" && info != "A") {
        clearModelsList();
        return;
    }
    
    var url = "../include/category_select2.jsp?ctype="+ctype+"&info="+info+"&category="+param;
    
    createXMLHttpRequest();
   	xmlHttp.onreadystatechange = handleStateChange;   
    xmlHttp.open("GET", url, true);
    xmlHttp.send(null);
    
}

function clearModelsList() {
	for(var i = 0; i < selectArr.length; i++){ 	
		var obj = document.getElementById(selectArr[i]);
		
		while(obj.childNodes.length > 2) {
			obj.removeChild(obj.childNodes[obj.childNodes.length-1]);
		}
	}
}

function refreshCategoryList_A(ctype, param, info, ccode ) {

	cate1 = ccode.substring(0,3)+"000000000";
	targetId = param; 
    var url = "../include/category_select2.jsp?ctype="+ctype+"&info="+info+"&category=";
 
    	createXMLHttpRequestA();
 
    	 xmlHttp1.onreadystatechange = handleStateChangeA;
 
    	 xmlHttp1.open("GET", url, true);
 
    	 xmlHttp1.send(null);
 
}

function refreshCategoryList_B(ctype, param, info, ccode ) {
	 
	cate2 = ccode.substring(0,6)+"000000";
	targetId = param; 
    var url = "../include/category_select2.jsp?ctype="+ctype+"&info="+info+"&category="+cate2;
    createXMLHttpRequestB();
 
     xmlHttp2.onreadystatechange = handleStateChangeB;
	 xmlHttp2.open("GET", url, true);
	 xmlHttp2.send(null); 
}
function refreshCategoryList_C(ctype, param, info, ccode ) {
	 
	cate3 = ccode.substring(0,9)+"000";
	targetId = param; 
    var url = "../include/category_select2.jsp?ctype="+ctype+"&info="+info+"&category="+cate3;
    createXMLHttpRequestC();

     xmlHttp3.onreadystatechange = handleStateChangeC;
	 xmlHttp3.open("GET", url, true);
	 xmlHttp3.send(null);
}
function refreshCategoryList_D(ctype, param, info, ccode ) {
	 
	cate4 = ccode ;
	targetId = param; 
    var url = "../include/category_select2.jsp?ctype="+ctype+"&info="+info+"&category="+cate4;
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
 
            updateModelsList(cate1, 'A', targetId);
        }
    }
}
function handleStateChangeB() {
    if(xmlHttp2.readyState == 4) {
        if(xmlHttp2.status == 200) {
            updateModelsList(cate2, 'B', targetId);
 
        }
    }
}
function handleStateChangeC() {
    if(xmlHttp3.readyState == 4) {
        if(xmlHttp3.status == 200) {
            updateModelsList(cate3, 'C', targetId);
        }
    }
}
function handleStateChangeD() {
    if(xmlHttp4.readyState == 4) {
        if(xmlHttp4.status == 200) {
            updateModelsList(cate4, 'D', targetId);
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

function updateModelsList0V() {
    clearModelsListV();
    
    var obj = document.getElementById(changeObjv);

    var results = xmlHttpv.responseXML.getElementsByTagName("vcategory");
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

function updateModelsList(cate, info_value, targetId) {
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




function updateModelsListV(cate, info_value) {
    clearModelsListV();
 
//    var obj = document.getElementById(changeObj);
//	  var results = xmlHttp.responseXML.getElementsByTagName("category");
    var obj;
    var results;
 
    if ( info_value == "A") {
    	results = xmlHttp1v.responseXML.getElementsByTagName("vcategory");
    	obj = document.getElementById("vcategory1");
    } else if (info_value == "B") {
    	results = xmlHttp2v.responseXML.getElementsByTagName("vcategory");
    	obj = document.getElementById("vcategory2");   	
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

function clearModelsListV() {
	for(var i = 0; i < selectArrV.length; i++){ 	
		var obj = document.getElementById(selectArrV[i]);
		
		while(obj.childNodes.length > 2) {
			obj.removeChild(obj.childNodes[obj.childNodes.length-1]);
		}
	}
}

