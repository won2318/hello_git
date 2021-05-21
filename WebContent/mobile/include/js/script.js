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
    $('.vodList').masonry({
        // options
    	
		
		
     
        itemSelector : '.pin',
        isAnimated: true
		
    });
 
    

     
});




//]]>
