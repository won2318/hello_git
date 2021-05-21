/* PHOTOGALLERY ******************/
(function ($) {
	$.fn.photoGallery = function(options){
		var $photo_list = $(this);
		var $photo_list_selector = $photo_list.find(">dl>dt");
		var $photo_cnt = $photo_list_selector.length;
		var $photo_this = 0;
		var $photo_btn_prev = $photo_list.find(".btn-prev");
		var $photo_btn_next = $photo_list.find(".btn-next");
		var $photo_btn_lstop = $photo_list.find(".btn-stop"); 
		var $photo_btn_play = $photo_list.find(".btn-play"); 
		var $photo_timer;

		if($photo_cnt>0){
			$photo_list.each(function(){
				$(this).find("dd").hide();
				$(this).find("dt").eq(0).next().show();
				$(this).find("dt").eq(0).addClass("on");
			});

			photoGalleryBtn();
			$photo_timer = setInterval(photoAutoChange,4000);

			$photo_list_selector.bind("click",function(){
				clearInterval($photo_timer);
				$photo_this = $photo_list_selector.index($(this));
				photoGalleryAnimation();
			});

			$photo_btn_next.bind("click",function(){
				clearInterval($photo_timer);
				$photo_this++;
				if($photo_this>$photo_cnt-1) $photo_this = $photo_cnt-1;
				photoGalleryAnimation();
			});

			$photo_btn_prev.bind("click",function(){
				clearInterval($photo_timer);
				$photo_this--;
				if($photo_this<0) $photo_this = 0;
				photoGalleryAnimation();
			});

			$photo_btn_lstop.bind("click",function(){
				clearInterval($photo_timer);
			});

			$photo_btn_play.bind("click",function(){
				$photo_timer = setInterval(photoAutoChange,4000);
			});

		}

		function photoGalleryAnimation(){
			if($photo_list_selector.index($photo_list.find("dt.on"))!=$photo_this){
				$photo_list.find("dt").removeClass("on");
				//$photo_list.find("dd").find("img").fadeOut("slow");
				$photo_list.find("dd").find("img").hide();
				$photo_list_selector.eq($photo_this).addClass('on');
				$photo_list_selector.eq($photo_this).next().find('img').fadeIn('slow');
				$photo_list_selector.eq($photo_this).next().find('img').show();
				$photo_list_selector.eq($photo_this).next().find('img');
				$photo_list_selector.eq($photo_this).next().show();
				photoGalleryBtn();
				clearInterval($photo_timer);
				$photo_timer = setInterval(photoAutoChange,4000); 
			}
		}

		function photoGalleryBtn(){
			if($photo_this<1) $photo_btn_prev.hide();
			else $photo_btn_prev.show();
			
			if($photo_this>=$photo_cnt-1) $photo_btn_next.hide();
			else $photo_btn_next.show();
		}

		function photoAutoChange(){
			$photo_this++;
			if($photo_this>$photo_cnt-1) $photo_this = 0;
			photoGalleryAnimation();
		}
	};
})(jQuery);
