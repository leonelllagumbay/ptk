Ext.define('cfbose.view.main.loginform', {
	extend: 'Ext.form.Panel',
	alias: 'widget.littleloginform',
	
	initComponent: function() {
		
		 this.items = [{
					xtype: 'textfield',
					fieldLabel: 'User name',
					name: 'username',
					labelAlign: 'top',
					height: 45,
					allowBlank: false,
					cls: 'field-margin',
					emptyText: 'username',
					width: 250
				},{
					xtype: 'textfield',
					fieldLabel: 'Password',
					name: 'password',
					inputType: 'password',
					height: 45,
					emptyText: 'password', 
					labelAlign: 'top',
					allowBlank: false,
					cls: 'field-margin',
					width: 250
				},{
					xtype: 'displayfield',
					name: 'logindisplaymore',
					id: 'displayrespidid',
					value: '',
					cls: 'field-margin',
					width: 250
				}];
		
	this.buttons = [{
					 xtype: 'button',
					 text: 'Sign in',
					 action: 'signin'
				   }];
					  
		this.callParent(arguments);
	}
});