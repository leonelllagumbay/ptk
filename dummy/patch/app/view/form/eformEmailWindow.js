Ext.define('Form.view.form.eformEmailWindow', {
	extend: 'Ext.window.Window',
	alias: 'widget.eformemailwindow',
	height: '80%',
	width: '90%',
	title: 'e-mail Form',
	autoDestroy: true,
	layout: 'fit',
	 
	initComponent: function() {
			this.items = [{
					xtype: 'form',
					items: [{
						xtype: 'textfield',
						fieldLabel: 'To',
						allowBlank: false,
						anchor: '100%',
						name: 'to',
						margin: '10 10 10 10'
					},{
						xtype: 'textfield',
						fieldLabel: 'Subject',
						anchor: '100%',
						name: 'subject',
						margin: '10 10 10 10'
					},{
						xtype: 'htmleditor',
						overflowY: 'auto',
						overflowX: 'auto',
						anchor: '100% 85%',
						name: 'body',
						margin: '10 10 10 10'
					}],
					api: {
						load: Ext.ss.defmain.getDetails,
						submit: Ext.ss.defmain.sendemailNow
					},
					buttons: [{
						xtype: 'button',
						text: 'Send',
						name: 'sendemailbutton',
						padding: '5 5 5 5',
						action: 'sendnow'
					}]
					
			}];
				 
				
				this.callParent(arguments);
			}
})
