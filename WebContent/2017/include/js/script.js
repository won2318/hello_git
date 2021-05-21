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

$(document).ready(function(){

    parent.$('.modal_pop').colorbox({
		
        closeButton:true,
		escKey:true,
    	iframe:true, 
		fixed:true,
		transition:"elastic",
    	innerWidth:800 ,
    	innerHeight:"90%",
       onOpen:function(){
     
       },
       onLoad:function(){
     
       },
       onComplete:function(){
    	$('html').css('overflow', 'hidden');
   		$('body').css('overflow', 'scroll');
       $(window).resize(function () {
				$(this).colorbox.resize({width:"90%", height:"90%"});
       });
  
 
       },
       onCleanup:function(){ 
             // location.reload(); 
       
       },
       onClosed:function(){
    	$('html').css('overflow', 'auto');
   		$('body').css('overflow', 'visible');
       	//alert("onClosed");
       }
     } ); 
	 $(".view_page").colorbox({
    	 closeButton:false,
    	 escKey:false,
    	 iframe:true, 
    	 innerWidth:915 ,
    	 innerHeight:"90%",
      onOpen:function(){

      },
      onLoad:function(){

      },
      onComplete:function(){
       $('body').css({overflow:'hidden', display:'block'});
      	$(window).resize(function () {
      		$(this).colorbox.resize({width:915, height:"90%"});
      	});

      // alert(location.hostname);
      // alert(location.pathname);   //  
      // alert($(location).attr("href"));  // 
      // alert($(this).attr("href"));    //  
      },
      onCleanup:function(){ 
            // location.reload(); 
     	 var this_url = $(this).attr("href");
    	 
    	   //slCtl =   parent.$.colorbox(document.getElementById("silver_player").content.PlayerSilverlight.Stop());
    	   // parent.$.colorbox(StopSilverlight()); 
    	   //window.parent.StopSilverlight();

    	//alert('onCleanup');
      },
      onClosed:function(){
    	   $('body').css({overflow:'auto', display:'block'});
      	//alert("onClosed");
      }
    } );   
});

$(document).on('scroll', function() {
   if ($(document).scrollTop() > 59) {
	  $('#pTitle').addClass('pwrap-shrink');
   } else {
	  $('#pTitle').removeClass('pwrap-shrink');
   }
   if ($(document).scrollTop() > 229) {
	  $('#lnb').addClass('lnb-shrink');
   } else {
	  $('#lnb').removeClass('lnb-shrink');
   }
});
