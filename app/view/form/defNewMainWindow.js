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
							value: '2 200 2 200',
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
						},{
							xtype: 'displayfield',
							padding: 5,
							value: '------------------------------------------------'
						},{
							xtype: 'button',
							text: 'Advanced Options',
							action: 'showadvopt',
							margin: '5 5 5 5'
						},{
							xtype: 'checkboxfield',
							name: 'ENABLEAUDITTRAIL',
							fieldLabel: 'Audit Trail',
							hidden: true,
							labelWidth: 70,
							inputValue: 'true',
							checked: false,
							uncheckedValue: 'false',
							padding: '5 5 5 5'
						},{
							xtype: 'textfield',
							fieldLabel: 'Datasource',
							labelAlign: 'right',
							width: 350,allowBlank: true,
							name: 'AUDITTDSOURCE',
							labelWidth: 150,
							padding: '5 5 5 5',
							value: 'NA',
							hidden: true
						},{
							xtype: 'textfield',
							fieldLabel: 'Table Name',
							labelAlign: 'right',
							width: 350,
							allowBlank: true,
							name: 'AUDITTNAME',
							labelWidth: 150,
							padding: '5 5 5 5',
							value: 'NA',
							hidden: true
						},{
							xtype: 'displayfield',
							padding: 5,
							value: '------------------------------------------------'
						},{
							xtype: 'checkboxfield',
							name: 'ENABLEEFORMLOGGING',
							fieldLabel: 'Logging',
							inputValue: 'true',
							checked: false,
							uncheckedValue: 'false',
							labelWidth: 70,
							padding: '5 5 5 5',
							hidden: true
						},{
							xtype: 'radiofield',
							name: 'ENABLELOGGING',
							fieldLabel: 'Save to file',
							action: 'loggingtofile',
							labelAlign: 'right',
							inputValue: 'true',
							checked: false,
							uncheckedValue: 'false',
							labelWidth: 150,
							padding: '5 5 5 5',
							hidden: true
						},{
							xtype: 'textfield',
							fieldLabel: 'File Name',
							width: 350,
		    				name: 'LOGFILENAME',
							labelWidth: 150,
							padding: '5 5 5 5',
							value: 'NA',
							hidden: true
						},{
							xtype: 'radiofield',
							name: 'ENABLELOGGING',
							fieldLabel: 'Save to database',
							action: 'loggingtodb',
							labelAlign: 'right',
							inputValue: 'true',
							checked: false,
							uncheckedValue: 'false',
							labelWidth: 150,
							padding: '5 5 5 5',
							hidden: true
						},{
							xtype: 'textfield',
							fieldLabel: 'Datasource',
							width: 350,
							allowBlank: true,
							name: 'LOGDBSOURCE',
							labelWidth: 150,
							padding: '5 5 5 5',
							value: 'NA',
							hidden: true
						},{
							xtype: 'textfield',
							fieldLabel: 'Table Name',
							width: 350,
							allowBlank: true,
							name: 'LOGTABLENAME',
							labelWidth: 150,
							padding: '5 5 5 5',
							value: 'NA',
							hidden: true
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