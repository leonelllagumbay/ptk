Ext.define('Form.controller.fileuploader.fileuploadercontroller', {
    extend: 'Ext.app.Controller',
	views: [
        'fileuploader.fileuploaderView'
    ],
	models: [
	],
	stores: [
	],
	init: function() {
		console.log('init controller');
        this.control({
            
			'fileuploaderview button[action=insertfileinput]': {  
				click: this.insertFileInput
			},
			'fileuploaderview button[action=upload]': {
				click: this.uploadTheFiles
			},
			'fileuploaderview button[action=cancel]': {
				click: this.cancelPopupWindow
			}
		});
     },
     
     cancelPopupWindow: function() {
    	window.close(); 
     },
     
     insertFileInput: function(btn) {
    	 var form = btn.up('form');
    	 if(typeof form.filecount === 'undefined') {
    		 form.filecount = 2;
     	 } else {
     	 	form.filecount += 1;
     	 }
    	 var hiddenCmp = form.down('hiddenfield[name=filecount]');
    	 hiddenCmp.setValue(hiddenCmp.getValue() + 1);
    	 form.insert(form.filecount - 1,[{
    		 xtype: 'container',
    		 name: 'cont' + form.filecount,
    		 layout: 'hbox',
    		 items: [{
				xtype: 'filefield',
				padding: 10,
				name: 'file' + form.filecount,
				width: 300,
				fieldLabel: 'File ' + form.filecount
			 }]	
    	}]);
     },
     uploadTheFiles: function(btn) {
    	 if(btn.up('form').getForm().isValid()) {
	    	 btn.up('form').getForm().submit({
	    		    submitEmptyText: true,
					timeout: 300000,
					waitMsg: 'Uploading, please wait',
			  		reset: true,
			  		failure: function(form, action){
			  			alert('The file may or may not be uploaded!');
			  			console.log(action);
			  		},
			  		success: function(form, action){
			  			console.log(action);
			  			window.close();
					}
	    	 });
    	 }
     }
});