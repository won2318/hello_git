jQuery(function($){
	// ���� �ֽſ���
	var $tab_list = $('.NewTab.list1');
	$tab_list.removeClass('jx').find('li ul').hide();
	$tab_list.find('li li.active').parents('li').addClass('active');
	$tab_list.find('li.active>ul').show();
	$tab_list.each(function(){
		var $this = $(this);
		//$this.height($this.find('li.active>ul').height()+0);
	});
	function listTabMenuToggle(event){
		var $this = $(this);
		$this.next('ul').show().parent('li').addClass('active').siblings('li').removeClass('active').find('>ul').hide();
		//$this.closest('.NewTab.list1').height($this.next('ul').height()+0);
		if($this.attr('href') === '#'){
			return false;
		}
	}
	$tab_list.find('>ul>li>a').click(listTabMenuToggle).focus(listTabMenuToggle);
	
	// ���� �ֽſ���
	var $tab_list = $('.NewTab.list2');
	$tab_list.find('ul ul').hide();
	$tab_list.find('li li.active').parents('li').addClass('active');
	$tab_list.find('li.active>ul').show();
	$tab_list.each(function(){
		var $this = $(this);
		//$this.height($this.find('li.active>ul').height()+0);
	});
	function listTabMenuToggle(event){
		var $this = $(this);
		$this.next('ul').show().parent('li').addClass('active').siblings('li').removeClass('active').find('>ul').hide();
		//$this.closest('.NewTab.list2').height($this.next('ul').height()+0);
		if($this.attr('href') === '#'){
			return false;
		}
	}
	$tab_list.find('>ul>li>a').click(listTabMenuToggle).focus(listTabMenuToggle);
	
	// ȭ���� ����
	//var $tab_list = $('.NewTab.list3');
	//$tab_list.removeClass('jx').find('ul ul').hide();
	//$tab_list.find('li li.active').parents('li').addClass('active');
	//$tab_list.find('li.active>ul').show();
	//$tab_list.each(function(){
	//	var $this = $(this);
		//$this.height($this.find('li.active>ul').height()+0);
	//});
	//function listTabMenuToggle(event){
	//	var $this = $(this);
	//	$this.next('ul').show().parent('li').addClass('active').siblings('li').removeClass('active').find('>ul').hide();
		//$this.closest('.NewTab.list3').height($this.next('ul').height()+0);
	//	if($this.attr('href') === '#'){
	//		return false;
	//	}
	//}
	//$tab_list.find('>ul>li>a').click(listTabMenuToggle).focus(listTabMenuToggle);
	
	// ���� ����
	//var $tab_list = $('.NewTab.list4');
	//$tab_list.removeClass('jx').find('ul ul').hide();
	//$tab_list.find('li li.active').parents('li').addClass('active');
	//$tab_list.find('li.active>ul').show();
	//$tab_list.each(function(){
	//	var $this = $(this);
		//$this.height($this.find('li.active>ul').height()+0);
	//});
	//function listTabMenuToggle(event){
	//	var $this = $(this);
	//	$this.next('ul').show().parent('li').addClass('active').siblings('li').removeClass('active').find('>ul').hide();
		//$this.closest('.NewTab.list3').height($this.next('ul').height()+0);
	//	if($this.attr('href') === '#'){
	//		return false;
	//	}
	//}
	//$tab_list.find('>ul>li>a').click(listTabMenuToggle).focus(listTabMenuToggle);
	
	// �ְ�����Ʈ
	var $tab_list = $('.NewTab.list5');
	$tab_list.removeClass('jx').find('ul ul').hide();
	$tab_list.find('li li.active').parents('li').addClass('active');
	$tab_list.find('li.active>ul').show();
	$tab_list.each(function(){
		var $this = $(this);
		//$this.height($this.find('li.active>ul').height()+0);
	});
	function listTabMenuToggle(event){
		var $this = $(this);
		$this.next('ul').show().parent('li').addClass('active').siblings('li').removeClass('active').find('>ul').hide();
		//$this.closest('.NewTab.list3').height($this.next('ul').height()+0);
		if($this.attr('href') === '#'){
			return false;
		}
	}
	$tab_list.find('>ul>li>a').click(listTabMenuToggle).focus(listTabMenuToggle);
	
	// �ֽŴ���
	var $tab_list = $('.NewTab.list6');
	$tab_list.removeClass('jx').find('ul ul').hide();
	$tab_list.find('li li.active').parents('li').addClass('active');
	$tab_list.find('li.active>ul').show();
	$tab_list.each(function(){
		var $this = $(this);
		//$this.height($this.find('li.active>ul').height()+0);
	});
	function listTabMenuToggle(event){
		var $this = $(this);
		$this.next('ul').show().parent('li').addClass('active').siblings('li').removeClass('active').find('>ul').hide();
		//$this.closest('.NewTab.list3').height($this.next('ul').height()+0);
		if($this.attr('href') === '#'){
			return false;
		}
	}
	$tab_list.find('>ul>li>a').click(listTabMenuToggle).focus(listTabMenuToggle);
	
	
	
	
	
});

// ���۳�Ʈ
	jQuery(function($){
	var $tab_list = $('.sNote.list7');
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
	function listTabMenuToggle2(event){
		var $this = $(this);
		$this.next('div').hide();
		if($this.attr('href') === '#'){
			return false;
		}
	}
	$tab_list.find('>ul>li>a').mouseover(listTabMenuToggle).focus(listTabMenuToggle).mouseout(listTabMenuToggle2);
	
});

jQuery(function($){
// ȭ���� ����
	var $tab_list = $('.NewTab.list3');
	$tab_list.removeClass('jx').find('ul ul').hide();
	$tab_list.find('li li.active').parents('li').addClass('active');
	$tab_list.find('li.active>ul').show();
	$tab_list.each(function(){
		var $this = $(this);
		//$this.height($this.find('li.active>ul').height()+0);
	});
	function listTabMenuToggle(event){
		var $this = $(this);
		$this.next('ul').show().parent('li').addClass('active').siblings('li').removeClass('active').find('>ul').hide();
		//$this.closest('.NewTab.list3').height($this.next('ul').height()+0);
		if($this.attr('href') === '#'){
			return false;
		}
	}
	
	$tab_list.find('>ul>li>a').click(listTabMenuToggle).focus(listTabMenuToggle);
});
jQuery(function($){
	// ���� ����
	var $tab_list = $('.NewTab.list4');
	$tab_list.removeClass('jx').find('ul ul').hide();
	$tab_list.find('li li.active').parents('li').addClass('active');
	$tab_list.find('li.active>ul').show();
	$tab_list.each(function(){
		var $this = $(this);
		//$this.height($this.find('li.active>ul').height()+0);
	});
	function listTabMenuToggle(event){
		var $this = $(this);
		$this.next('ul').show().parent('li').addClass('active').siblings('li').removeClass('active').find('>ul').hide();
		//$this.closest('.NewTab.list3').height($this.next('ul').height()+0);
		if($this.attr('href') === '#'){
			return false;
		}
	}
	
	$tab_list.find('>ul>li>a').mouseover(listTabMenuToggle).focus(listTabMenuToggle);
});