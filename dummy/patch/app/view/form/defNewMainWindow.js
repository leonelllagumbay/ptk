Ext.define('Form.view.form.defNewMainWindow', { 
			extend: 'Ext.window.Window',
			alias: 'widget.defnewmainwindow',
		    title: 'New eForm Window',
			closable: true,
			autoDestroy: true,
		    height: 470,
		    width: 400,
		    layout: 'fit',
					
			initComponent: function() {
				this.items = [{
						xtype: 'form',
						autoScroll: true,
						items: [{
							xtype: 'combobox',
							fieldLabel: 'Group',
							width: 350,
							allowBlank: false,
							name: 'EFORMGROUP',
							store: 'form.maingroupstore',
							displayField: 'maingroupname',
							valueField: 'maingroupcode',
							minChars: 1,
							pageSize: 20,
							labelWidth: 150,
							padding: '5 5 5 5'
						},{
							xtype: 'textfield',
							fieldLabel: 'Name',
							width: 350,
		    				name: 'EFORMNAME',
							allowBlank: false,
							labelWidth: 150,
							padding: '5 5 5 5'
						},{
							xtype: 'textfield',
							fieldLabel: 'Description',
							width: 350,
		    				name: 'DESCRIPTION',
							labelWidth: 150,
							padding: '5 5 5 5'
						},{
							xtype: 'combobox',
							fieldLabel: 'Form Flow Process',
							allowBlank: false,
							width: 350,
							name: 'FORMFLOWPROCESS',
							store: 'form.mainprocessstore',
							displayField: 'mainprocessname',
							valueField: 'mainprocesscode',
							minChars: 1,
							pageSize: 20,
							labelWidth: 150,
							padding: '5 5 5 5'
						},{
							xtype: 'checkboxfield',
							name: 'ISENCRYPTED',
							fieldLabel: 'Encrypt Data',
							inputValue: 'true',
							checked: false,
							uncheckedValue: 'false',
							labelWidth: 150,
							padding: '5 5 5 5'
						},{
							xtype: 'combobox',
							fieldLabel: 'View As',
							allowBlank: false,
							forceSelection: true,
							name: 'VIEWAS',
							width: 350,
							queryMode: 'local',
							store: 'form.viewasstore',
							displayField: 'viewasname',
							valueField: 'viewascode',
							labelWidth: 150,
							padding: '5 5 5 5'
						},{
							xtype: 'textfield',
							fieldLabel: 'Form Padding',
							allowBlank: false,
							width: 350,
		    				name: 'FORMPADDING', 
							value: '0 100 0 100',
							labelWidth: 150,
							padding: '5 5 5 5'
						},{
							xtype: 'textfield',
							fieldLabel: 'Group Margin',
							allowBlank: false,
							width: 350,
							value: '10 10 10 10',
		    				name: 'GROUPMARGIN',
							labelWidth: 150,
							padding: '5 5 5 5'
						},{
							xtype: 'combobox',
							fieldLabel: 'Before Load Process',
							width: 350,
							forceSelection: true,
							allowBlank: false,
							name: 'BEFORELOAD',
							store: 'form.beforeloadstore',
							displayField: 'filename',
							valueField: 'filecode',
							minChars: 1,
							pageSize: 20,
							labelWidth: 150,
							padding: '5 5 5 5',
							value: 'NA'
						},{
							xtype: 'combobox',
							fieldLabel: 'After Load Process',
							width: 350,
							allowBlank: false,
							forceSelection: true,
							name: 'AFTERLOAD',
							store: 'form.afterloadstore',
							displayField: 'filename',
							valueField: 'filecode',
							minChars: 1,
							pageSize: 20,
							labelWidth: 150,
							padding: '5 5 5 5',
							value: 'NA'
						},{
							xtype: 'combobox',
							fieldLabel: 'Before Add Process',
							width: 350,
							allowBlank: false,
							forceSelection: true,
							name: 'BEFORESUBMIT',
							store: 'form.beforesubmitstore',
							displayField: 'filename',
							valueField: 'filecode',
							minChars: 1,
							pageSize: 20,
							labelWidth: 150,
							padding: '5 5 5 5',
							value: 'NA'
						},{
							xtype: 'combobox',
							fieldLabel: 'After Add Process',
							width: 350,
							allowBlank: false,
							forceSelection: true,
							name: 'AFTERSUBMIT',
							store: 'form.aftersubmitstore',
							displayField: 'filename',
							valueField: 'filecode',
							minChars: 1,
							pageSize: 20,
							labelWidth: 150,
							padding: '5 5 5 5',
							value: 'NA'
						},{
							xtype: 'combobox',
							fieldLabel: 'Before Approve Process',
							width: 350,
							allowBlank: false,
							forceSelection: true,
							name: 'BEFOREAPPROVE',
							store: 'form.beforeapprovestore',
							displayField: 'filename',
							valueField: 'filecode',
							minChars: 1,
							pageSize: 20,
							labelWidth: 150,
							padding: '5 5 5 5',
							value: 'NA'
						},{
							xtype: 'combobox',
							fieldLabel: 'After Approve Process',
							width: 350,
							forceSelection: true,
							allowBlank: false,
							name: 'AFTERAPPROVE',
							store: 'form.afterapprovestore',
							displayField: 'filename',
							valueField: 'filecode',
							minChars: 1,
							pageSize: 20,
							labelWidth: 150,
							padding: '5 5 5 5',
							value: 'NA'
						},{
							xtype: 'combobox',
							fieldLabel: 'On Complete Process',
							width: 350,
							forceSelection: true,
							allowBlank: false,
							name: 'ONCOMPLETE',
							store: 'form.oncompletestore',
							displayField: 'filename',
							valueField: 'filecode',
							minChars: 1,
							pageSize: 20,
							labelWidth: 150,
							padding: '5 5 5 5',
							value: 'NA'
						}],
						api: {
						        load: Ext.ss.defmain.getDetails,
						        submit: Ext.ss.defmain.submitRecords
						},
						buttons: [{
							xtype: 'button',
							text: 'Add',
							name: 'SUBMIT',
							cls: 'field-margin',
							action: 'submit'
						}],
						
					}];
						
				this.callParent(arguments);
			}
		
});