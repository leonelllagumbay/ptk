Ext.define('Form.view.fileuploader.fileuploaderView', { 
	extend: 'Ext.form.Panel',
	alias: 'widget.fileuploaderview',
	title: 'File Uploader',
	width: '100%', 
	height: '100%',
	autoScroll: true,
	initComponent: function() {   
		this.items = [{
			xtype: 'filefield',
			padding: 10,
			allowBlank: false,
			name: 'file1',
			fieldLabel: 'File 1'
		},{
			xtype: 'button',
			text: 'Insert file input',
			margin: 10,
			action: 'insertfileinput'
		},{
			xtype: 'button',
			text: 'Upload',
			margin: 10,
			action: 'upload'
		},{
			xtype: 'button',
			text: 'Cancel',
			margin: 10,
			action: 'cancel'
		},{
			xtype: 'hiddenfield',
			name: 'filecount',
			value: "1"
		}];
		this.api = {
				submit: Ext.fileuploader.FileUploader.uploadFile
		}
		this.callParent(arguments);
		
	}
});