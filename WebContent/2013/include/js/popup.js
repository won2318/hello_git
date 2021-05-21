//Left Menu (JQuery)
function levelsmenu(rootid,menucodel1,menucodel2,menucodel3){
	var root=document.getElementById(rootid);
	var $root=$(root);
	var onstr='_on.gif';
	var offstr='.gif';
	var hoverclass='over';
	
	if(root){
		for(var i=0; i<root.getElementsByTagName('a').length; i++){
			var atag=root.getElementsByTagName('a')[i];
			atag.onclick=function(){
				cur(this);
			};
			atag.onfocus=function(){
				cur(this);
			};
			atag.onmouseover=function(){
				curh(this);
			};
		
		}

		$root.hover(function (){},function (){
			sethover();
		})
		sethover();
	}
}


		


