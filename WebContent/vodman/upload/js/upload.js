$(function () {
    $('#fileupload').fileupload({
        url: '/hmtl/master',
        maxChunkSize: 1048576,
        maxRetries: 10,
        dataType: 'json',
        multipart: false,
//        formData: function ( data){
// 
//            data.formData = {ocode:  $('#ocode').val(),ccode:  $('#ccode').val(),img_title:  $('#img_title').val()};
//       },
//        formData:  [{ name: 'ocode', value: $('#ocode').val() }, { name: 'ccode', value: $('#ccode').val()}, { name: 'img_title', value: $('#img_title').val()}],
        
        progressall: function (e, data) {
            var progress = parseInt(data.loaded / data.total * 100, 10),
                meter = $('.progress .meter'),
                percent = progress + '%';
            meter.css('width', percent).text(percent);
        },
 
        add: function (e, data) {
            data.context = $('<p/>').text('Uploading...').appendTo('.data');
            data.submit();
        },
        done: function (e, data) {
            data.context.text('Upload finished.');
        },
        fail: function (e, data) {
            data.context.text('Upload failed.');
            $('.progress').addClass('alert');
            console.warn('Error: ', data);

        }
    }).on('fileuploadchunksend', function (e, data) {
          if (data.uploadedBytes === 3145728 ) return false;
    }).on('fileuploadchunkdone', function (e, data) {
      
    });
});