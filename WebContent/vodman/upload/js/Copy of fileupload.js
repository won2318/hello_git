$(function () {
	alert("제목을 입력하세요!");
    $('#fileupload').fileupload({
    	
        dataType: 'json',
//        
//        formData: {
//            ocode: $('#ocode').val()
//            ,ccode: $('#ccode').val()
//            ,img_title:$('#img_title').val()
//        },
 
        done: function (e, data) { 
        	opener.document.location.reload();
        },
        
        progressall: function (e, data) {
            var progress = parseInt(data.loaded / data.total * 100, 10),
                meter = $('.progress .meter'),
                percent = progress + '%';
            meter.css('width', percent).text(percent);
        }
		 
    }).bind('fileuploadsubmit', function (e, data) {
	   //	alert(data.files.length);
    	//alert(data.files[0].name);
    	//alert(data.files[0].size);
    	//alert(data.files[0].type);
	    // The example input, doesn't have to be part of the upload form:
    	
    	 data.formData = {ocode: $('#ocode').val(),ccode: $('#ccode').val(),img_title: $('#img_title').val()};
                
    });
   
});