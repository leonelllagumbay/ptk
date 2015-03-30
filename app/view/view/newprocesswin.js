Ext.define('Form.view.view.newprocesswin', { 
			extend: 'Ext.window.Window',
			alias: 'widget.processwin',
		    title: 'New Process Window',
			closable: true,
			autoDestroy: true,
		    height: 270,
		    width: 370,
		    layout: 'fit',
			items: [{
				xtype: 'form',
				items: [{
					xtype: 'combobox',
					fieldLabel: 'Group',
					allowBlank: false,
					name: 'GROUPNAME',
					maxLength: 100,
					width: 320,
					cls: 'field-margin',
					store: 'view.groupstore',
					displayField: 'processgroupname',
					valueField: 'processgroupcode',
					minChars: 1,
					pageSize: 20
				},{
					xtype: 'textfield',
					fieldLabel: 'Name',
					name: 'PROCESSNAME',
					maxLength: 200,
					width: 320,
					allowBlank: false,
					cls: 'field-margin'
				},{
					xtype: 'textfield',
					fieldLabel: 'Description',
					name: 'DESCRIPTION',
					allowBlank: false,
					maxLength: 300,
					width: 320,
					cls: 'field-margin'
				},{
					xtype: 'numberfield',
					value: 1,
					allowBlank: false,
					minValue: 1,
					maxValue: 1000000,
					fieldLabel: 'eForm Life',
					name: 'EFORMLIFE',
					width: 320,
					cls: 'field-margin'
				},{
					xtype: 'combobox',
					allowBlank: false,
					fieldLabel: 'Action to Take',
					value: 'APPROVE',
					name: 'EXPIREDACTION',
					cls: 'field-margin',
					store: 'view.actionstore',
					displayField: 'actionname',
					valueField: 'actioncode',
					width: 320
				}]
			}],
			buttons: [{
				xtype: 'button',
				text: 'Save',
				name: 'SUBMIT',
				cls: 'field-margin',
				action: 'submit'
			}],
			
			initComponent: function() {
				/*
				 this.items = [{
					xtype: 'combobox',
					fieldLabel: 'Group',
					allowBlank: false,
					name: 'GROUPNAME',
					cls: 'field-margin',
					store: 'view.groupstore',
					displayField: 'processgroupname',
					valueField: 'processgroupcode',
				},{
					xtype: 'textfield',
					fieldLabel: 'Name',
					name: 'PROCESSNAME',
					allowBlank: false,
					cls: 'field-margin'
				},{
					xtype: 'textfield',
					fieldLabel: 'Description',
					name: 'DESCRIPTION',
					allowBlank: false,
					cls: 'field-margin'
				},{
					xtype: 'numberfield',
					value: 0,
					allowBlank: false,
					minValue: 0,
					maxValue: 1000000,
					fieldLabel: 'Level of Approvers',
					name: 'LEVELOFAPPROVERS',
					cls: 'field-margin'
				},{
					xtype: 'combobox',
					allowBlank: false,
					fieldLabel: 'Link Approvers By',
					value: 'NA',
					name: 'APPROVERBY',
					cls: 'field-margin',
					store: 'view.linkstore',
					displayField: 'linkname',
					valueField: 'linkcode',
				},{
					xtype: 'numberfield',
					value: 0,
					allowBlank: false,
					minValue: 0,
					maxValue: 1000000,
					fieldLabel: 'eForm Life',
					name: 'EFORMLIFE',
					cls: 'field-margin'
				},{
					xtype: 'combobox',
					allowBlank: false,
					fieldLabel: 'Action to Take',
					value: 'APPROVE',
					name: 'EXPIREDACTION',
					cls: 'field-margin',
					store: 'view.actionstore',
					displayField: 'actionname',
					valueField: 'actioncode',
				},{
					xtype: 'button',
					text: 'Save',
					name: 'SUBMIT',
					cls: 'field-margin',
					action: 'submit'
				}];*/
				
				this.callParent(arguments);
			}
		
});