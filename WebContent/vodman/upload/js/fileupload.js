$(function () {
 
    $('#fileupload').fileupload({
         dataType: 'json',
         cache:false,
//        
//        formData: {
//            ocode: $('#ocode').val()
//            ,ccode: $('#ccode').val()
//            ,img_title:$('#img_title').val()
//        },
   add: function (e, data) {
        	 
	   var uploadFile = data.files[0];
       var isValid = true;
       if (!(/mp4|wmv|avi/i).test(uploadFile.name)) {
           alert('mp4, wmv, avi �� �����մϴ�');
           isValid = false;
       } else if (uploadFile.size > 10240000000 * 3) { // 1000mb *3
           alert('���� �뷮�� 3Gbyte�� �ʰ��� �� �����ϴ�.');
           isValid = false;
       }
       if (isValid) {
        	 var jqXHR = data.submit()
             .success(function (result, textStatus, jqXHR) {
            	 
            })
             .error(function (jqXHR, textStatus, errorThrown) {
             
             })
             .complete(function (result, textStatus, jqXHR) {
             
            	 alert('������ ���ε� �Ǿ����ϴ�!');
               
             })
             ;
       }
 
              
        } ,
        done: function (e, data) { 
        	//opener.document.location.reload();
			
		 //  alert('������ ���ε� �Ǿ����ϴ�.');
          // parent.file_reload();
        	 
        	 //console.log('Processing ' + data.files[data.index].name + ' done.');
        },
        
        progressall: function (e, data) {
            var progress = parseInt(data.loaded / data.total * 100, 10),
                meter = $('.progress .meter'),
                percent = progress + '%';
            meter.css('width', percent).text(percent); 
			
			if (progress == 100) {
//			   alert('������ ���ε� �Ǿ����ϴ�.');
//				parent.file_reload();
			}
        }
        ,success:function(args){
      
        	var file_name = args.data.fileName;
        	//alert(file_name);  // ��ϵ� ���ϸ�
        	var ext = "";
        	if (file_name.length > 17) {
        		window.parent.document.getElementById('filename').value=file_name;
        		file_name = file_name.slice(file_name.indexOf("\\") + 1);
      		    ext = file_name.slice(0,file_name.indexOf(".")).toLowerCase();
            	window.parent.document.getElementById('ocode').value=ext;
      		 
        	}
        	var subfolder = args.data.ccode+"/"+ext;
        	//alert(subfolder);
        	window.parent.document.getElementById('subfolder').value=subfolder;
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