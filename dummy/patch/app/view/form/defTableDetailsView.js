Ext.define('Form.view.form.defTableDetailsView', { 
			extend: 'Ext.window.Window',
			alias: 'widget.deftabledetailsview',
		    title: 'New eForm Table Window',
			closable: true,
			autoDestroy: true,
		    height: 280,
		    width: 370,
		    layout: 'fit',
					
			initComponent: function() {
				this.items = [{
						xtype: 'form',
						autoScroll: true,
						items: [{
							xtype: 'textfield',
							fieldLabel: 'Table Name',
		    				name: 'TABLENAME',
							allowBlank: false,
							maxLength: 60,
							labelWidth: 150,
							padding: '5 5 5 5'
						},{
							xtype: 'textfield',
							fieldLabel: 'EFORMIDFK',
		    				name: 'EFORMIDFK',
							hidden: true,
							labelWidth: 150,
							padding: '5 5 5 5'
						},{
							xtype: 'textfield',
							fieldLabel: 'Description',
		    				name: 'DESCRIPTION',
							maxLength: 250,
							labelWidth: 150,
							padding: '5 5 5 5'
						},{
							xtype: 'textfield',
							fieldLabel: 'Link Table To',
		    				name: 'LINKTABLETO',
							maxLength: 250,
							labelWidth: 150,
							hidden: true,
							padding: '5 5 5 5'
						},{
							xtype: 'textfield',
							fieldLabel: 'Linking Column',
		    				name: 'LINKINGCOLUMN',
							maxLength: 250,
							labelWidth: 150,
							hidden: true,
							padding: '5 5 5 5'
						},{
							xtype: 'combobox',
							fieldLabel: 'Table Type',
							allowBlank: false,
							name: 'TABLETYPE',
							queryMode: 'local',
							store: 'form.tabletypestore',
							displayField: 'tabletypename',
							valueField: 'tabletypecode',
							labelWidth: 150,
							padding: '5 5 5 5' 
						},{
							xtype: 'combobox',
							fieldLabel: 'Level ID',
							allowBlank: false,
							name: 'LEVELID',
							queryMode: 'local',
							store: 'form.levelidstore',
							displayField: 'levelidname',
							valueField: 'levelidcode',
							labelWidth: 150,
							padding: '5 5 5 5'
						}],
						api: {
						        load: Ext.ss.defmain.getTableDetails,
						        submit: Ext.ss.defmain.submitTableRecords
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
