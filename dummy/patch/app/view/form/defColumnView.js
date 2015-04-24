Ext.define('Form.view.form.defColumnView', {
	extend: 'Ext.grid.Panel',
	alias: 'widget.defcolumnview',
	width: '100%',
    title: 'eForm Manager -> eForm Tables -> Fields',   
    multiSelect: true,
    clicksToEdit: 2,
	selModel: {
		    pruneRemoved: false
	},
	 
	viewConfig: {
	    forceFit: false,
		trackOver: false,
	    emptyText: '<h1 style="margin:20px">No matching results</h1>'
	  },
	 
	
	initComponent: function() {    
	
		this.features = [{
			ftype: 'filters',
			encode: true, // json encode the filter query
			local: false, 
			filters: [{
				type: 'string',
				dataIndex: 'TABLENAME'
			}]
		}];
	 
	    this.plugins = [
			Ext.create('Ext.grid.plugin.CellEditing', {
			    clicksToEdit: 2
    	    })
			
		];
		this.store = 'form.defColumnStore';  
		this.bbar = Ext.create('Ext.toolbar.Paging', {
				        store: 'form.defColumnStore', 
				        displayInfo: true,
				        emptyMsg: "No topics to display"
				   });
		this.tbar = [{
		  	text: 'Back',
			action: 'backtoeformtables'
		  },{
		  	xtype: 'tbseparator'
		  },{
			text: 'New Column',
			action: 'newcolumn'
		  },{
		  	xtype: 'tbseparator'
		  },{
		  	text: 'Edit Column Details',  
			action: 'editeform'
		  },{
		  	xtype: 'tbseparator'
		  },{
		  	text: 'Delete Column',
			action: 'deletecolumn'
		  }];
		  
		this.columns =  [{
            xtype: 'rownumberer',
            width: 50,
            sortable: false
	       },{
		  	text: 'Column ID',
			dataIndex: 'COLUMNID',
			filterable: true,
			editor: 'textfield',
			hidden: true
		  },{
		  	text: 'Table ID Fk',
			dataIndex: 'TABLEIDFK',
			filterable: true,
			editor: 'textfield',
			hidden: true
		  },{
		  	text: 'Column Name',
			dataIndex: 'COLUMNNAME',
			filterable: true,
			editor: 'textfield',
			flex: 1
		  },{ 
		  	text: 'Field Type',
			dataIndex: 'XTYPE',
			filterable: true,
			editor: {
				xtype: 'combobox', 
				queryMode: 'local',
				store: 'form.fieldtypestore',
				displayField: 'fieldtypename',
				valueField: 'fieldtypecode'
			},
			flex: 1
		  },{ 
		  	text: 'Field Group',
			dataIndex: 'COLUMNGROUP',
			filterable: true,
			editor: {
				xtype: 'combobox',
				store: 'form.columngroupstore',
				displayField: 'columngroupname',
				valueField: 'columngroupcode',
				minChars: 1,
				pageSize: 15
			},
			flex: 1
		  },{ 
		  	text: 'Field Label',
			dataIndex: 'FIELDLABEL',
			filterable: true,
			editor: 'textfield',
			flex: 1
		  },{ 
		  	text: 'Field Label Align',
			dataIndex: 'FIELDLABELALIGN',
			filterable: true,
			hidden: true,
			editor: {
				xtype: 'combobox',
				//store: 'form.fieldalignstore',
				displayField: 'fieldalignname',
				valueField: 'fieldaligncode'
			},
			width: 150
		  },{ 
		  	text: 'Field Label Width',
			dataIndex: 'FIELDLABELWIDTH',
			filterable: true,
			hidden: true,
			editor: 'textfield',
			width: 150
		  },{
		  	text: 'Allow Blank',
			dataIndex: 'ALLOWBLANK',
			filterable: true,
			hidden: true,
			editor: {
				xtype: 'checkboxfield'
			},
			width: 200
		  },{
		  	text: 'Checked',
			dataIndex: 'CHECKED',
			filterable: true,
			hidden: true,
			editor: {
				xtype: 'checkboxfield'
			},
			width: 100
		  },{
		  	text: 'Disabled',
			dataIndex: 'DISABLED',
			filterable: true,
			hidden: true,
			editor: {
				xtype: 'checkboxfield'
			},
			width: 100
		  },{
		  	text: 'Hidden',
			dataIndex: 'HIDDEN',
			filterable: true,
			hidden: true,
			editor: {
				xtype: 'checkboxfield'
			},
			width: 100
		  },{
		  	text: 'Read Only',
			dataIndex: 'READONLY',
			filterable: true,
			hidden: true,
			editor: {
				xtype: 'checkboxfield'
			},
			width: 100
		  },{ 
		  	text: 'CSS Class',
			dataIndex: 'CSSCLASS',
			filterable: true,
			hidden: true,
			editor: 'textfield',
			width: 150
		  },{ 
		  	text: 'Height',
			dataIndex: 'HEIGHT',
			filterable: true,
			hidden: true,
			editor: 'textfield',
			width: 150
		  },{ 
		  	text: 'Width',
			dataIndex: 'WIDTH',
			filterable: true,
			hidden: true,
			editor: 'textfield',
			width: 150
		  },{
		  	text: 'Minimum Value',
			dataIndex: 'MINVALUE',
			filterable: true,
			hidden: true,
			editor: {
				xtype: 'numberfield',
				minValue: 0,
				maxValue: 1000000
			},
			width: 200
		  },{
		  	text: 'Maximum Value',
			dataIndex: 'MAXVALUE',
			filterable: true,
			hidden: true,
			editor: {
				xtype: 'numberfield',
				minValue: 0,
				maxValue: 1000000
			},
			width: 200
		  },{
		  	text: 'Minimum Length',
			dataIndex: 'MINLENGTH',
			filterable: true,
			hidden: true,
			editor: {
				xtype: 'numberfield',
				minValue: 0,
				maxValue: 1000000
			},
			width: 200
		  },{
		  	text: 'Maximum Length',
			dataIndex: 'MAXLENGTH',
			filterable: true,
			hidden: true,
			editor: {
				xtype: 'numberfield',
				minValue: 0,
				maxValue: 1000000
			},
			width: 200
		  },{
		  	text: 'X',
			dataIndex: 'X',
			filterable: true,
			hidden: true,
			editor: {
				xtype: 'numberfield'
			},
			width: 200
		  },{
		  	text: 'Y',
			dataIndex: 'Y',
			filterable: true,
			hidden: true,
			editor: {
				xtype: 'numberfield'
			},
			width: 200
		  },{ 
		  	text: 'ID',
			dataIndex: 'ID',
			hidden: true,
			filterable: true,
			editor: 'textfield',
			width: 150
		  },{ 
		  	text: 'Margin',
			dataIndex: 'MARGIN',
			filterable: true,
			hidden: true,
			editor: 'textfield',
			width: 150
		  },{ 
		  	text: 'Padding',
			dataIndex: 'PADDING',
			filterable: true,
			editor: 'textfield',
			hidden: true,
			width: 150
		  },{ 
		  	text: 'Border',
			dataIndex: 'BORDER',
			filterable: true,
			hidden: true,
			editor: 'textfield',
			width: 150
		  },{ 
		  	text: 'Style',
			dataIndex: 'STYLE',
			filterable: true,
			editor: 'textfield',
			hidden: true,
			width: 150
		  },{ 
		  	text: 'Unchecked Value',
			dataIndex: 'UNCHECKEDVALUE',
			filterable: true,
			hidden: true,
			editor: 'textfield',
			width: 150
		  },{ 
		  	text: 'Default Value',
			dataIndex: 'VALUE',
			filterable: true,
			editor: 'textfield',
			hidden: true,
			width: 150
		  },{ 
		  	text: 'Validation Type',
			dataIndex: 'VALIDATIONTYPE',
			filterable: true,
			hidden: true,
			editor: 'textfield',
			width: 150
		  },{ 
		  	text: 'Validation Type Text',
			dataIndex: 'VTYPETEXT',
			filterable: true,
			hidden: true,
			editor: 'textfield',
			width: 150
		  },{ 
		  	text: 'Renderer',
			dataIndex: 'RENDERER',
			filterable: true,
			hidden: true,
			editor: 'textfield',
			width: 150
		  },{ 
		  	text: 'Anchor',
			dataIndex: 'ANCHOR',
			filterable: true,
			hidden: true,
			editor: 'textfield',
			width: 150
		  },{ 
		  	text: 'Format',
			dataIndex: 'FORMAT',
			filterable: true,
			hidden: true,
			editor: 'textfield',
			width: 150
		  },{ 
		  	text: 'Checkbox/Radio Items',
			dataIndex: 'CHECKITEMS',
			filterable: true,
			hidden: true,
			editor: 'textfield',
			width: 150
		  },{ 
		  	text: 'Checkbox/Radio No. of Columns',
			dataIndex: 'NOOFCOLUMNS',
			filterable: true,
			hidden: true,
			editor: 'textfield',
			width: 150
		  },{ 
		  	text: 'Auto Generated Text Format',
			dataIndex: 'AUTOGENTEXT',
			filterable: true,
			hidden: true,
			editor: 'textfield',
			width: 150
		  },{ 
		  	text: 'Combobox Local Data',
			dataIndex: 'COMBOLOCALDATA',
			filterable: true,
			hidden: true,
			editor: 'textfield',
			width: 150
		  },{ 
		  	text: 'Combobox Remote Data',
			dataIndex: 'COMBOREMOTEDATA',
			filterable: true,
			hidden: true,
			editor: 'textfield',
			width: 150
		  },{ 
		  	text: 'Editable on Router No.',
			dataIndex: 'EDITABLEONROUTENO',
			filterable: true,
			hidden: true,
			editor: 'textfield',
			width: 150
		  },{ 
		  	text: 'Made by',
			hidden: true,
			dataIndex: 'RECCREATEDBY',
			filterable: true
		  },{
		    text: 'Record Date Created',
		    dataIndex: 'RECDATECREATED',
			hidden: true,
			editor: {
				xtype: 'datefield'
			},
		    width: 100,
			renderer: Ext.util.Format.dateRenderer('n/j/Y'),
			filter: {
				type: 'date',
				format: 'Y-n-j'
			}
		  },{
		    text: 'Date Last Update',
		    dataIndex: 'DATELASTUPDATE',
			hidden: true,
			editor: {
				xtype: 'datefield'
			},
		    width: 100,
			renderer: Ext.util.Format.dateRenderer('n/j/Y'),
			filter: {
				type: 'date',
				format: 'Y-n-j'
			}
		  }],
		
		
		this.callParent(arguments);
	}
});

