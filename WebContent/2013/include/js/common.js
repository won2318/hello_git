
//<! [CDATA [
		jQuery(function($){
			
			// Menu
			var menu = $('div.topmenu');
			var major = $('div.major');
			var li_list = major.find('>span');
			
			// Selected
			function onselectmenu(){
				var myclass = [];
				
				$(this).parent('span').each(function(){
					myclass.push( $(this).attr('class') );
				});
				
				myclass = myclass.join(' ');
				if (!major.hasClass(myclass)) major.attr('class','major').addClass(myclass);
			}
			
			// Show Menu
			function show_menu(){
				t = $(this);
				li_list.removeClass('active');
				t.parent('span').addClass('active');
				// IE7 or IE7 documentMode bug fix
				if($.browser.msie) {
					var v = document.documentMode || parseInt($.browser.version);
					if (v == 7) {
						var subWidth = t.next('div.sub').eq(-1).width();
						t.next('div.sub').css('width',subWidth);
					}
				}
			}
			li_list.find('>a').click(onselectmenu).mouseover(show_menu).focus(show_menu);
			
			// Hide Menu
			function hide_menu(){
				li_list.removeClass('active');
				
			}
			menu.mouseleave(hide_menu);
			li_list.find('div.sub').mouseleave(hide_menu);
			
			
			//icon
			//major.find('div.sub').prev('a').find('>span').append('<span class="i"></span>');
			
			
		});
		//]]>
		
/*right_side slider*/
$(function(){
	var menuFlag = false;
	$("#LocationTxt").text( $(".lastLocation").find(".on").text() );
	$('.flexslider').flexslider({ animation: "slide", pauseOnHover: true });	
	$(".sMenu").bind("focusin mouseover" , function(){		
		$(".sMenu").addClass("on");
		$(this).stop().animate({ "height" : "245px" }, 200);	
	}).bind("focusout mouseleave" , function(){				
		$(".sMenu").removeClass("on");
		$(this).stop().animate({ "height" : "65px" }, 200);	
	});
	$(".nb > ul > .on").bind("focusin mouseover" , function(){
		var w = $(this).width()-2;
		$(this).find("ul").width(w).show();
	}).bind("focusout mouseleave" , function(){
		$(this).find("ul").hide();
	});

	$(".top_btn").click(function(){
		$('body, html').animate({ scrollTop: 0 }, "fast");
	});
	// TOP 버튼 활성화
	$(window).scroll(function(){
		var scrollTop = $(document).scrollTop();				
		if (scrollTop > 200 )
			$(".top_btn").show();
	});

	// SIDE > 보고서
	$(".divide a").click(function(){
		$(".divide a").removeClass("on");
		$(".btnWrap").hide();
		$(this).addClass("on");
		$("#"+$(this).attr("data-id")).show();
	});
});



/* Layer */
var is_mask_run = false;
//$(window).resize(function() {if(is_mask_run){modalWindow();}}); 
//$(window).scroll(function() {if(is_mask_run){modalWindow();}}); 
function modalWindow(id) {
	if (!id)
		id = 'layerWrap';
	
	// 활성화    
	is_mask_run = true;         
	
	// 마스크 사이즈    
	var maskHeight = $(document).height();    
	var maskWidth = $(window).width();    
	$('#layerMask').css({'width':maskWidth,'height':maskHeight});     
	
	// 마스크 effect      
	$('#layerMask').fadeTo("slow",0.8);      
	
	// 윈도우 화면 사이즈 구하기    
	var winH = $(window).height();    
	var winW = $(window).width();     
	
	// 스크롤 높이 구하기    
	var _y =(window.pageYOffset) ? window.pageYOffset   
	: (document.documentElement && document.documentElement.scrollTop) ? document.documentElement.scrollTop   
	: (document.body) ? document.body.scrollTop : 0;     
	
	if(_y<1) var h = winH/2;   
	else var h = winH/2+_y;   

	// dialog창 리사이즈    
	var dial_width =$('#'+id).width();    
	var dial_height = $('#'+id).height();    
	$('#'+id).css({'width':dial_width,'height':dial_height});    
	if (dial_height > $(window).height() )
		$('#'+id).css('top', 50);   		
	else
		$('#'+id).css('top', h-dial_height/2-150);
	$('#'+id).css('left', winW/2-dial_width/2); 
	$('#'+id).show();
}

function layerClose(id)
{
	if (!id) {
		$('#layerMask').hide();
		$('.layerWrap').hide();
	} else {
		$('#layerMask').hide();
		$('#' + id).hide();
	}

	
	is_mask_run= false;
}

function printAction() {
 window.open("/print_hidden.php", "hiddenFrame");
 window.frames['hiddenFrame'].focus();
}

function clipboard(text)
{
	var IE=(document.all)?true:false;
	if (IE)
	{
		window.clipboardData.setData('Text',text);
		alert("클립보드에 복사되었습니다.");
	}	
	else
	{
		temp = prompt("Ctrl+C를 눌러 복사하세요", text);
	}
}

function showLoading() {
	// 마스크 사이즈    
	var maskHeight = $(document).height();    
	var maskWidth = $(window).width();    
	$('#loadingMask').css({'width':maskWidth,'height':maskHeight});     
	
	// 마스크 effect      
	$('#loadingMask').fadeTo("slow",0.8);  
	
	// 윈도우 화면 사이즈 구하기    
	var winH = $(window).height();    	
	
	// 스크롤 높이 구하기    
	var _y =(window.pageYOffset) ? window.pageYOffset   
	: (document.documentElement && document.documentElement.scrollTop) ? document.documentElement.scrollTop   
	: (document.body) ? document.body.scrollTop : 0;     
	
	if(_y<1) var h = winH/2;   
	else var h = winH/2+_y;   
	
	var loadingImg = $("<img/>").attr('src', '/images/common/loading.gif');
	var tmp = $("<div style='height:; text-align:center; margin-top:" + h + "px;'/>").attr("id", "temp").html(loadingImg);

	//$('#loadingMask').css('background', 'none');
	$('#loadingMask').html(tmp).show();	
}


jQuery(function($){	
    // Global Navigation Bar
    var gMenu = $('.lnb_wrap>div.gnb');
    var gItem = gMenu.find('>ul>li');
    var ggItem = gMenu.find('>ul>li>ul>li');
    var lastEvent = null;
    gItem.find('>ul').hide();
	gItem.filter(':first').addClass('first');
    function gMenuToggle(){
        var t = $(this);
        if (t.next('ul').is(':hidden') || t.next('ul').length == 0) {
            gItem.find('>ul').slideUp(200);
            gItem.find('a').removeClass('hover');
            t.next('ul').slideDown(200);
            t.addClass('hover');            
        }; 
    };
    function gMenuOut(){
        gItem.find('ul').slideUp(200);
        gItem.find('a').removeClass('hover');
    };
    gItem.find('>a').mouseover(gMenuToggle).focus(gMenuToggle);
    gItem.mouseleave(gMenuOut);
});