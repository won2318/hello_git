var xmlHttp;
var changeObj;
var selectArr = new Array();

function createXMLHttpRequest() {
    if (window.ActiveXObject) {
        xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
    } 
    else if (window.XMLHttpRequest) {
        xmlHttp = new XMLHttpRequest();
    }
}

/*
param : category°ª, target : º¯ÇÒ select id, info : category info(A, B, C..)
*/
function refreshCategoryList(ctype, param, info, target) {

	changeObj = target;

	for(var i = 3; i < arguments.length; i++){ 
		selectArr[i-3] = arguments[i];
	}

    if(param == "" && info != "A") {
        clearModelsList();
        return;
    }
    
    var url = "/vodman/vod_aod/category_select.jsp?ctype="+ctype+"&info="+info+"&category="+param+"&timeStamp=" + new Date().getTime();

    createXMLHttpRequest();
    xmlHttp.onreadystatechange = handleStateChange;
    xmlHttp.open("GET", url, true);
    xmlHttp.send(null);
}
    
function handleStateChange() {
    if(xmlHttp.readyState == 4) {
        if(xmlHttp.status == 200) {
            updateModelsList();
        }
    }
}

function updateModelsList() {
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


function clearModelsList() {
	for(var i = 0; i < selectArr.length; i++){ 	
		var obj = document.getElementById(selectArr[i]);
 
		while(obj.childNodes.length > 2) {
			obj.removeChild(obj.childNodes[obj.childNodes.length-1]);
		}
	}
}