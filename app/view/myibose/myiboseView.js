Ext.define('Form.view.myibose.myiboseView', { 
	extend: 'Ext.form.Panel',
	alias: 'widget.myiboseview',
	title: 'My iBOS/e',
	width: '100%', 
	height: '100%',
	buttonAlign: 'center',
	autoScroll: true,
	initComponent: function() {   
		this.items = [{
			xtype: 'filefield',
			fieldLabel: 'My iBOS/e Avatar',
			name: 'AVATAR',
			allowBlank: true,
			maxLength: 600,
			width: 400,
			labelWidth: 150,
			padding: '25 20 5 100'
		},{
			xtype: 'displayfield',
			fieldLabel: ' ',
			labelWidth: 150,
			name: 'AVATARDISPLAY',
			width: 400,
			padding: '5 20 5 100',
			value: '(empty)'
		},{
			xtype: 'textfield',
			name: 'PROFILENAME',
			allowBlank: false,
			fieldLabel: 'e-mail Profile Name',
			width: 400,
			labelWidth: 150,
			padding: '5 20 5 100'
		},{
			xtype: 'textareafield',
			name: 'MYMESSAGE',
			allowBlank: true,
			maxLength: 255,
			fieldLabel: 'Welcome Message',
			width: 400,
			labelWidth: 150,
			padding: '5 20 5 100'
		},{
			xtype: 'textfield',
			name: 'DEFAULTAPPID',
			allowBlank: true,
			fieldLabel: 'Default Application',
			width: 400,
			labelWidth: 150,
			padding: '5 20 5 100'
		},{
			xtype: 'textareafield',
			name: 'SIGNATURE',
			allowBlank: true,
			maxLength: 600,
			fieldLabel: 'My Signature',
			width: 400,
			labelWidth: 150,
			padding: '5 20 5 100'
		},{
			xtype: 'textfield',
			name: 'currentpassword',
			allowBlank: true,
			fieldLabel: 'Current password',
			width: 400,
			labelWidth: 150,
			inputType: 'password',
			padding: '5 20 5 100'
		},{
			xtype: 'textfield',
			name: 'newpassword',
			allowBlank: true,
			fieldLabel: 'New password',
			width: 400,
			labelWidth: 150,
			inputType: 'password',
			padding: '5 20 5 100'
		},{
			xtype: 'textfield',
			name: 'retypenewpassword',
			allowBlank: true,
			fieldLabel: 'Re-type new password',
			width: 400,
			labelWidth: 150,
			inputType: 'password',
			padding: '5 20 5 100'
		}];
		
		this.buttons = [{
			text: 'Save',
			action: 'savemyibose'
		}];
		
		this.api = {
			load: Ext.mi.Myibose.getMyibose,
			submit: Ext.mi.Myibose.submitMyibose
		};
				    
				    
		this.callParent(arguments);
	}

});