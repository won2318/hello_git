// 제작노트
jQuery(function($){
	var $tab_list = $('.NewTab.list5');
	$tab_list.removeClass('jx').find('ul div').hide();
	$tab_list.find('li li.active').parents('li').addClass('active');
	$tab_list.find('li.active>div').show();
	$tab_list.each(function(){
		var $this = $(this);
		//$this.height($this.find('li.active>ul').height()+0);
	});
	function listTabMenuToggle(event){
		var $this = $(this);
		$this.next('div').show().parent('li').addClass('active').siblings('li').removeClass('active').find('>div').hide();
		//$this.closest('.NewTab.list3').height($this.next('ul').height()+0);
		if($this.attr('href') === '#'){
			return false;
		}
	}

	$tab_list.find('>ul>li>a').click(listTabMenuToggle).focus(listTabMenuToggle);
	
});
