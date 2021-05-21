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
            	 alert("등록 오류!!");
             })
             .complete(function (result, textStatus, jqXHR) {
            	 alert("등록되었습니다.");
             })
             ;
        	  
//            data.context = $('<button/>').text(' 등 록 ')
//                .appendTo(document.body)
//                .click(function () {
//                    data.context = $('<p/>').text('업로드중...').replaceAll($(this));
//                    data.submit();
//                });
        	

//        	 $("#upload").append(
//        			 $('<button/>').text(' 등 록 ')
//               	  .appendTo(document.body)
//               	  .click(function () {
//                           data.context = $('<p/>').text('업로드중...').replaceAll($(this));
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
//            data.context.text('등록 완료');
//        } 
 
    }) ;
    
});
 
 