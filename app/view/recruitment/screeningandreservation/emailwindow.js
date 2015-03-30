Ext.define('Form.view.recruitment.screeningandreservation.emailwindow', { 
			extend: 'Ext.window.Window',
			alias: 'widget.emailwin',
		    title: 'Email',
			closable: true,
		    height: 450,
		    width: 600,
		    layout: 'form',
			initComponent: function() {
				 this.items = [{
					xtype: 'combobox',
					fieldLabel: 'Email Template',
					name: 'emailtemplate',
					store: 'recruitment.screeningandreservation.templatestore',
					displayField: 'templatename',
					valueField: 'templatecode',
					cls: 'field-margin'
				},{
					xtype: 'textfield',
					fieldLabel: 'To',
					allowBlank: false,
					name: 'to',
					cls: 'field-margin'
				},{
					xtype: 'textfield',
					fieldLabel: 'Subject',
					name: 'subject',
					cls: 'field-margin'
				},{
					xtype: 'htmleditor',
					height: 270,
					name: 'body',
					cls: 'field-margin'
				},{
					xtype: 'button',
					text: 'Send',
					name: 'sendemailbutton',
					cls: 'field-margin',
					action: 'sendnow'
				}];
				
				this.callParent(arguments);
			}
		
});