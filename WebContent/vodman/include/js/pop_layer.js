var isIE=document.all;

function ddInit(e, idName, table_name){

  topDog=isIE ? "BODY" : "HTML";
  whichDog=isIE ? parent.document.all(""+idName+"") : parent.document.getElementById(idName);  
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

parent.document.onmouseup=Function("ddEnabled=false");
document.onmouseup=Function("ddEnabled=false");
