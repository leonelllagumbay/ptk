Ext.define('Form.view.form.eformEmailWindow', {
	extend: 'Ext.window.Window',
	alias: 'widget.eformemailwindow',
	height: 550,
	width: '90%',
	title: 'e-mail Form',
	autoDestroy: true,
	layout: 'fit',
	 
	initComponent: function() {
			this.items = [{
					xtype: 'form',
					items: [{
						xtype: 'hiddenfield',
						allowBlank: true,
						name: 'eformid'
					},{
						xtype: 'hiddenfield',
						allowBlank: true,
						name: 'processid'
					},{
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
						xtype: 'checkboxfield',
						fieldLabel: 'Table',
						uncheckedValue: false,
						name: 'emailAsTable',
						margin: 10
					},{
						xtype: 'checkboxfield',
						fieldLabel: 'Attachment',
						name: 'enableAttachments',
						uncheckedValue: false,
						margin: 10
					},{
						xtype: 'htmleditor',
						overflowY: 'auto',
						overflowX: 'auto',
						width: '100%',
						height: 300,
						name: 'body',
						margin: '10 10 10 10'
					}],
					api: {
						load: Ext.ss.defmain.getDetails,
						submit: Ext.ss.defmain.sendemailNow
					},
					buttons: [{
						xtype: 'button',
						text: 'Print Content',
						name: 'printContent',
						padding: '5 5 5 5',
						action: 'printcontent'
					},{
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
