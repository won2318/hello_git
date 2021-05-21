/**
 *
 * Pinterest-like script - a series of tutorials
 *
 * Licensed under the MIT license.
 * http://www.opensource.org/licenses/mit-license.php
 * 
 * Copyright 2012, Script Tutorials
 * http://www.script-tutorials.com/
 */
 var $container_list;


$(document).ready(function(){ 

     //masonry initialization
	 $container_list =
    $('#vodList').masonry({
        // options
    	 columnWidth: 20,
     
        itemSelector : '.pin',
        isAnimated: true,
        isFitWidth: true
		
    }); 
     
});
  

function link_colorbox(url) {
 
	location.href=url;
	//window.open(url,"link_view", "width=100%,height=100%,scrollbars=yes,resizeable=no"); 
}
 

//]]>
