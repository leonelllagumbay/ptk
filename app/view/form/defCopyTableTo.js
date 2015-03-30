Ext.define('Form.view.form.defCopyTableTo', { 
			extend: 'Ext.window.Window',
			alias: 'widget.defcopytableto',
		    title: 'Copy Table to',
			closable: true,
			autoDestroy: true,
		    height: 130,
		    width: 370,
		    layout: 'fit', 
					
			initComponent: function() {
				this.items = [{
						xtype: 'form',
						autoScroll: true,
						items: [{
							xtype: 'combobox',
							fieldLabel: 'eForm Name',   
							forceSelection: true,
							allowBlank: false,
							name: 'EFORMIDFK2',
							store: 'form.eformnamestore',
							displayField: 'eformnamename',
							valueField: 'eformnamecode',
							width: 330,
							padding: '5 5 5 5',
							minChars: 1,
							pageSize: 20
						},{
							xtype: 'textfield',
							fieldLabel: 'Table id',
		    				name: 'TABLEID',
							hidden: true
						},{
							xtype: 'textfield',
							fieldLabel: 'Table Name',
		    				name: 'TABLENAME',
							hidden: true
						},{
							xtype: 'textfield',
							fieldLabel: 'Description',
		    				name: 'DESCRIPTION',
							hidden: true
						},{
							xtype: 'textfield',
							fieldLabel: 'Table Type',
							name: 'TABLETYPE',
							hidden: true
						},{
							xtype: 'textfield',
							fieldLabel: 'Level ID',
							name: 'LEVELID',
							hidden: true
						},{
							xtype: 'textfield',
							fieldLabel: 'Link Table To',
							name: 'LINKTABLETO',
							hidden: true
						},{
							xtype: 'textfield',
							fieldLabel: 'Link Column To',
							name: 'LINKINGCOLUMN',
							hidden: true  
						},{
							xtype: 'textfield',
							fieldLabel: 'Made by',
							name: 'RECCREATEDBY',
							hidden: true
						}], 
						api: {
								//load: Ext.ss.defmain.getTableDetails,
						        submit: Ext.ss.defmain.submitCopyTableTo
						},
						buttons: [{
							xtype: 'button',
							text: 'Ok',
							name: 'SUBMIT',
							cls: 'field-margin',
							action: 'submit'
						}],
						
					}];
						
				this.callParent(arguments);
			}
		
});
