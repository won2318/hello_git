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

    // masonry initialization
    $('.vodList').masonry({
        // options
        itemSelector : '.pin',
        isAnimated: true,
        isFitWidth: true
		
    }); 
    $('.ajax').colorbox({
    	innerWidth:915, 
        onOpen:function(){
        	//alert("onOpen");
        },
        onLoad:function(){
        	//alert("onLoad");
        },
        onComplete:function(){
         //  $(this).colorbox.resize();
        	//alert("onComplete"); 
        },
        onCleanup:function(){
        	//alert("onCleanup");
        },
        onClosed:function(){
        	//alert("onClosed");
        }
    });
 
     $(".html").colorbox({
    	 iframe:true,
    	 innerWidth:420, 
    	 innerHeight:430
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

  
 
function name_check_conform(url) {
	//alert(url);
	//jQuery.colorbox.close();
	//jQuery.colorbox({href:url,  open:true});
	jQuery.colorbox(
	{
	 href:url,
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
 
    	//alert('onCleanup');
      },
      onClosed:function(){
   	   $('body').css({overflow:'auto', display:'block'});
      	//alert("onClosed");
      }
    }
	);
	

}

function link_open(url){
	jQuery.colorbox({
	 closeButton:false,
	 escKey:false,
   	 iframe:true,
   	 href:url,
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
      },
      onCleanup:function(){
      //alert("onCleanup");
      },
      onClosed:function(){
   	   $('body').css({overflow:'auto', display:'block'});
      
      //alert("onClosed");
      }
    } );    
}

 

var cc=0
function showHide(id) {
		if (cc==0) {
				cc=1
				document.getElementById(id).style.display="block";
		} else {
				cc=0
				document.getElementById(id).style.display="none";
		}
} 
 
var slCtl = null; 

function onSilverlightLoad(sender, args) {
	if(slCtl == null){
 
		slCtl = document.getElementById("silver_player");
	 	} 
}

function PlaySilverlight() {
    slCtl.content.PlayerSilverlight.Play();
}
function PauseSilverlight() {
    slCtl.content.PlayerSilverlight.Pause();
}
function StopSilverlight() {  
	if(slCtl != null){ 
		slCtl.content.PlayerSilverlight.Stop(); 
	}  
}
function SeekToPlaybackTimeSilverlight(sender, args) { 
    slCtl.content.PlayerSilverlight.SeekToPlaybackTime(20.0); //DOUBLE SECONDS!!!
}

 
function returnPath(State )
{  
    //alert(State);
    if (State == 'State=Playing'  ) {
    	if (document.getElementById("today_vod") != null) {
    		 document.getElementById('today_vod').style.visibility='hidden'; 
		}
    }
    if (State == 'State=Paused' || State == 'State=Stopped') {
    	if (document.getElementById("today_vod") != null) {
    		document.getElementById('today_vod').style.visibility='visible'; 
		}
    }
	 
}

    function onSilverlightError(sender, args) {

        var appSource = "";
        if (sender != null && sender != 0) {
            appSource = sender.getHost().Source;
        } 
        var errorType = args.ErrorType;
        var iErrorCode = args.ErrorCode;
        
        var errMsg = "Unhandled Error in Silverlight Application " +  appSource + "\n" ;

        errMsg += "Code: "+ iErrorCode + "    \n";
        errMsg += "Category: " + errorType + "       \n";
        errMsg += "Message: " + args.ErrorMessage + "     \n";

        if (errorType == "ParserError")
        {
            errMsg += "File: " + args.xamlFile + "     \n";
            errMsg += "Line: " + args.lineNumber + "     \n";
            errMsg += "Position: " + args.charPosition + "     \n";
        }
        else if (errorType == "RuntimeError")
        {           
            if (args.lineNumber != 0)
            {
                errMsg += "Line: " + args.lineNumber + "     \n";
                errMsg += "Position: " +  args.charPosition + "     \n";
            }
            errMsg += "MethodName: " + args.methodName + "     \n";
        }

        throw new Error(errMsg);
    }
    function mplayer(text){
    	document.write(document.getElementById(text).value);
   }
	
