Ext.define('Form.view.view.newapproverwin', { 
			extend: 'Ext.window.Window',
			alias: 'widget.approverwin',
		    title: 'New Approver Window',
			closable: true,
			autoDestroy: true,
		    height: 390,
		    width: 380,
		    layout: 'fit',
			
			initComponent: function() {
				this.items = [{
						xtype: 'form',
						autoScroll: true,
						items: [{
							xtype: 'numberfield',
							fieldLabel: 'Order',
							name: 'APPROVERORDER',
							allowBlank: false,
							padding: '5 5 5 5'
						},{
							xtype: 'combobox',
							allowBlank: false,
							fieldLabel: 'Mapping',
							value: 'NA',
							name: 'APPROVERNAME',
							cls: 'field-margin',
							store: 'view.linkstore',
							displayField: 'linkname',
							valueField: 'linkcode',
						},{
							xtype: 'checkboxfield',
							fieldLabel: 'Can View Flow Map',
							name: 'CANVIEWROUTEMAP',
							xtype: 'checkboxfield',
							checked: true,
							inputValue: 'true',
							padding: '5 5 5 5',
							uncheckedValue: 'false'
						},{
							xtype: 'checkboxfield',
							fieldLabel: 'Can Override',
							name: 'CANOVERRIDE',
							xtype: 'checkboxfield',
							checked: true,
							inputValue: 'true',
							padding: '5 5 5 5',
							uncheckedValue: 'false'
						},{
							xtype: 'checkboxfield',
							fieldLabel: 'Auto Approve', 
							name: 'USERID',
							xtype: 'checkboxfield',
							checked: true,
							inputValue: 'true',
							padding: '5 5 5 5',
							uncheckedValue: 'false'
						},{
							xtype: 'combobox',
							fieldLabel: 'Name (Specific Name)',
							name: 'PERSONNELIDNO',
							emptyText: 'if mapping is specific name',
							allowBlank: false,
							width: 350,
							padding: '5 5 5 5',
							store: 'view.namestore',
							displayField: 'namename',
							valueField: 'namecode',
							pageSize: 25,
							value: "NA",
							minChars: 1
						},{
							xtype: 'combobox',
							fieldLabel: 'User Role',
							name: 'USERGRPID',
							width: 350,
							padding: '5 5 5 5',
							store: 'view.rolestore',
							displayField: 'rolename',
							valueField: 'rolecode',
							pageSize: 25,
							minChars: 1
						},{ 
							xtype: 'combobox',
							fieldLabel: 'Condition Above',
							allowBlank: true,
							hidden: true,
							name: 'CONDITIONABOVE',
							padding: '5 5 5 5',
							store: 'view.conditionstore',
							displayField: 'conditionname',
							valueField: 'conditioncode'
						},{ 
							xtype: 'combobox',
							fieldLabel: 'Condition Below',
							allowBlank: false,
							name: 'CONDITIONBELOW',
							padding: '5 5 5 5',
							store: 'view.conditionstore',
							displayField: 'conditionname',
							valueField: 'conditioncode'
						}],
						api: {
						        load: Ext.aa.approver.getDetails,
						        submit: Ext.aa.approver.submitApproverRecords
						},
						buttons: [{
							xtype: 'button',
							text: 'Save',
							name: 'SUBMIT',
							cls: 'field-margin',
							action: 'submit'
						}],
						
					}];
						
				this.callParent(arguments);
			}
		
});