isIE=document.all;
isNN=!document.all&&document.getElementById;
isN4=document.layers;
isHot=false;

function ddInit(e, idName, table_name){
  topDog=isIE ? "BODY" : "HTML";
  whichDog=isIE ? document.all[""+idName+""] : document.getElementById(idName);  
  hotDog=isIE ? event.srcElement : e.target;  
  while (hotDog.id!=table_name&&hotDog.tagName!=topDog){
    hotDog=isIE ? hotDog.parentElement : hotDog.parentNode;
  }  
  if (hotDog.id==table_name){
    offsetx=isIE ? event.clientX : e.clientX;
    offsety=isIE ? event.clientY : e.clientY;
    nowX=parseInt(whichDog.style.left);
    nowY=parseInt(whichDog.style.top);
    ddEnabled=true;
    document.onmousemove=dd;
  }
}

function ddInit2(e, idName, table_name){
  topDog=isIE ? "BODY" : "HTML";
  whichDog=isIE ? document.all[""+idName+""] : document.getElementById(idName);  
  hotDog=isIE ? event.srcElement : e.target;  
  while (hotDog.id!=table_name&&hotDog.tagName!=topDog){
    hotDog=isIE ? hotDog.parentElement : hotDog.parentNode;
  }  
  if (hotDog.id==table_name){
    offsetx=isIE ? event.clientX : e.clientX;
    offsety=isIE ? event.clientY : e.clientY;
    nowX=parseInt(whichDog.style.left);
    nowY=parseInt(whichDog.style.top);
    ddEnabled=true;
    document.onmousemove=dd;
  }
}

function dd(e){
  if (!ddEnabled) return;
  whichDog.style.left=isIE ? nowX+event.clientX-offsetx : nowX+e.clientX-offsetx; 
  whichDog.style.top=isIE ? nowY+event.clientY-offsety : nowY+e.clientY-offsety;
  return false;  
}

function ddN4(whatDog){
  if (!isN4) return;
  N4=eval(whatDog);
  N4.captureEvents(Event.MOUSEDOWN|Event.MOUSEUP);
  N4.onmousedown=function(e){
    N4.captureEvents(Event.MOUSEMOVE);
    N4x=e.x;
    N4y=e.y;
  }
  N4.onmousemove=function(e){
    if (isHot){
      N4.moveBy(e.x-N4x,e.y-N4y);
      return false;
    }
  }
  N4.onmouseup=function(){
    N4.releaseEvents(Event.MOUSEMOVE);
  }
}
//document.onmousedown=ddInit;
document.onmouseup=Function("ddEnabled=false");
 function outTip(boxObj) {
	if (ie) {
		boxObj.style.visibility = "visible";
		boxObj.filters.item(0).transition = 13;
		boxObj.filters.item(0).apply();
		boxObj.style.visibility = "hidden";
		boxObj.filters.item(0).play();
	}
}
 function overTip(boxObj) {
	if (ie) {
        boxObj.style.visibility = "hidden";
		boxObj.filters.item(0).transition =14;
		boxObj.filters.item(0).apply();
		boxObj.style.visibility = "visible";
		boxObj.filters.item(0).play();
	}          
}








