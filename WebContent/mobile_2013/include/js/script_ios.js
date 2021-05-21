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
    	columnWidth: 5, 
     
        itemSelector : '.pin',
        isAnimated: true,
        isFitWidth: true
		
    });
 
 
    
      $(".view_page").colorbox({
    	
    	 iframe:true,
    	 innerWidth:"100%" ,
    	 innerHeight:"100%",
       onOpen:function(){
     
       },
       onLoad:function(){
 
       },
       onComplete:function(){
        $('body').css({overflow:'hidden', display:'block'});
        
       },
       onCleanup:function(){
    	   //alert('onCleanup');
          // location.reload();
       },
       onClosed:function(){
    	   $("body").unbind('touchmove');
       //	alert("onClosed");
       }
     } );  
      


     
});
  

function link_colorbox(url) {
 location.href=url;
//	jQuery.colorbox({
//	   	 iframe:true,
//	   	 href:url,
//	   	 innerWidth:"100%" ,
//	   	 innerHeight:"100%",
//	      onOpen:function(){
//	 	      },
//	      onLoad:function(){
//	 	      },
//	      onComplete:function(){
// 	    	//$("body").css({overflow:'hidden'}).live('touchmove', function(e){e.preventDefault()});
//
//	      },
//	      onCleanup:function(){
// 	      },
//	      onClosed:function(){
//	   	   // $('body').css({overflow:'auto', display:'block'}).unlive('touchmove');
// 	      }
//	    } );    

}
 

//]]>
