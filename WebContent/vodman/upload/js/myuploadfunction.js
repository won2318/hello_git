$(function () {
 
    $('#fileupload').fileupload({ 
    	
        dataType: 'json',
//        formData: function ( data){ 
//        	alert( $('#ocode').val());
//            data.formData = {ocode:  $('#ocode').val(),ccode:  $('#ccode').val(),img_title:  $('#img_title').val()};
//        },
        add: function (e, data) {
 
        	 var jqXHR = data.submit()
             .success(function (result, textStatus, jqXHR) {
            	 
            })
             .error(function (jqXHR, textStatus, errorThrown) {
            	 alert("��� ����!!");
             })
             .complete(function (result, textStatus, jqXHR) {
            	 alert("��ϵǾ����ϴ�.");
             })
             ;
        	  
//            data.context = $('<button/>').text(' �� �� ')
//                .appendTo(document.body)
//                .click(function () {
//                    data.context = $('<p/>').text('���ε���...').replaceAll($(this));
//                    data.submit();
//                });
        	

//        	 $("#upload").append(
//        			 $('<button/>').text(' �� �� ')
//               	  .appendTo(document.body)
//               	  .click(function () {
//                           data.context = $('<p/>').text('���ε���...').replaceAll($(this));
//                           data.submit();
//                  })); 
              
        } ,
    progressall: function (e, data) {
        var progress = parseInt(data.loaded / data.total * 100, 10),
            meter = $('.progress .meter'),
            percent = progress + '%';
        meter.css('width', percent).text(percent);
    }
        
//        done: function (e, data) {
//            data.context.text('��� �Ϸ�');
//        } 
 
    }) ;
    
});
 
 