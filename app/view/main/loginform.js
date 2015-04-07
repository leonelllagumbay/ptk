Ext.define('Form.view.main.loginform', {
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
					minLength: 1,
					maxLength: 50,
					emptyText: 'password', 
					labelAlign: 'top',
					allowBlank: false,
					cls: 'field-margin',
					width: 250
				},{
					xtype: 'displayfield',
					name: 'logindisplaymore',
					id: 'displayrespidid',
					autoScroll: true,
					value: '',
					padding: 10,
					width: 250
				},{
					xtype: 'displayfield',
					name: 'loginwithgoogle',
					padding: 10,
					value: '<a href="https://accounts.google.com/o/oauth2/auth?scope=openid email&redirect_uri=http://localhost:8500&response_type=code&client_id=561695249357-7tkuphd99v8q1ao3skn35hjgegb52s1f.apps.googleusercontent.com">Login with Google</a>'
				},{
					xtype: 'checkboxfield',
					fieldLabel: 'Login with LDAP',
					padding: '5 5 5 10',
					name: 'authtype',
					inputValue: 'ldap',
					checked: false
				},{
					xtype: 'displayfield',
					name: 'home',
					padding: 10,
					value: '<a href="./">Home</a>'
				}];
		
	this.buttons = [{
					 xtype: 'button',
					 padding: '5 50 5 50',
					 text: 'Sign in',
					 action: 'signin'
				   }];
				   
				   
	
					  
		this.callParent(arguments);
	}
});