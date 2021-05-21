
//popupzone
;(function($){		
	
	
	$.fn.PopupZone = function(options) {
		
		var settings = {
			prevBtn : '',
			nextBtn : '',
			playBtn : '',
			waitingTime : ''
		};
		
		$.extend(settings, options);
		settings.areaDiv = this;
		settings.prevBtn = $(settings.prevBtn);
		settings.nextBtn = $(settings.nextBtn);
		settings.playBtn = $(settings.playBtn);
		
		settings.cnt = settings.areaDiv.find('li').length;	//팝업존 개수 			
		settings.waitingTime = parseInt(settings.waitingTime);
		settings.nowNum = 0;
		settings.moveFlag = true;
		settings.moveType;
		settings.setTimeOut;
		var status=true;
		
		function emptySetting() {
			settings.areaDiv.find('.currentCount').html(settings.nowNum+1);
			settings.areaDiv.find('.currentCount2').html(settings.cnt);
			settings.areaDiv.find('li').hide();
		}
		
		function setRolling(aniFlag) {
			if(!settings.moveFlag){
				if(settings.moveType=="next" || settings.moveType == null){ 
					settings.nowNum++;
					if(settings.nowNum == settings.cnt) settings.nowNum = 0;
				} else if(settings.moveType=="prev") {
					settings.nowNum--;
					if(settings.nowNum < 0) settings.nowNum = (settings.cnt-1);
				}
			}
			
			emptySetting();
			
			if(aniFlag) settings.areaDiv.find('li').eq(settings.nowNum).show();
			else settings.areaDiv.find('li').eq(settings.nowNum).fadeIn(0);
			
			aniFlag = false;
			settings.moveFlag = false;
			if(status){
				settings.setTimeOut= setTimeout(setRolling , settings.waitingTime);
			}
		}
		
		function playRolling(){
			if(status){
				clearTimeout(settings.setTimeOut);
				settings.playBtn.find('img').attr('src',"../include/images/btn_play.png");
				status = false;
			}else{
				settings.playBtn.find('img').attr('src',"../include/images/btn_stop.png");
				status = true;
				setRolling();
			}
			return false;
		}
		
		function prevRolling(){
			clearTimeout(settings.setTimeOut);
			settings.moveType = "prev";
			setRolling();
			return false;
		}
		
		function nextRolling() {
			clearTimeout(settings.setTimeOut);
			settings.moveType = "next";
			setRolling();
			return false;
		}
		 
		 
		setRolling();
		settings.prevBtn.click(prevRolling);
		settings.nextBtn.click(nextRolling);
		settings.playBtn.click(playRolling);
		
		
		/*settings.areaDiv.find('dt').each(function(n){
			$(this).find('a').click(function(){
				emptySetting();
				clearTimeout(settings.setTimeOut);
				settings.nowNum = n;
				settings.areaDiv.find('dd').eq(n).fadeIn('normal');
				//setRolling(true);
				return false;
			});
		});*/
	};
})(jQuery);