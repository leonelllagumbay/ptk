Ext.define('Form.view.form.defTableView', {
	extend: 'Ext.grid.Panel',
	alias: 'widget.deftableview',
	width: '100%',
    title: 'eForm Manager -> Tables',   
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
		this.store = 'form.defTableStore';  
		this.bbar = Ext.create('Ext.toolbar.Paging', {
				        store: 'form.defTableStore', 
				        displayInfo: true,
				        emptyMsg: "No topics to display"
				   });
		this.tbar = [{
		  	text: 'Back',
			action: 'backtoeformmanager'
		  },{
		  	xtype: 'tbseparator'
		  },{
			text: 'New Table',
			action: 'newtable'
		  },{
		  	xtype: 'tbseparator'
		  },{
		  	text: 'Copy Table',
			action: 'copytable'
		  },{
		  	xtype: 'tbseparator'
		  },{
		  	text: 'Copy Table to',
			action: 'copytableto'
		  },{
		  	xtype: 'tbseparator'
		  },{
		  	text: 'View Columns',
			action: 'viewcolumns'
		  },{
		  	xtype: 'tbseparator'
		  },{
		  	text: 'Delete Table',
			action: 'deletetable'
		  }];
		  
		this.columns =  [{
            xtype: 'rownumberer',
            width: 50,
            sortable: false
	       },{
		  	text: 'Table ID',
			dataIndex: 'TABLEID',
			hidden: true,
			filterable: true,
			width: 250
		  },{
		  	text: 'eForm ID FK',
			dataIndex: 'EFORMIDFK',
			hidden: true,
			filterable: true,
			width: 250
		  },{
		  	text: 'Table Name',
			dataIndex: 'TABLENAME',
			filterable: true,
			editor: 'textfield',
			width: 250
		  },{
		  	text: 'Description',
			dataIndex: 'DESCRIPTION',
			filterable: true,
			editor: 'textfield',
			flex: 1
		  },{
		  	text: 'Link Table To',
			dataIndex: 'LINKTABLETO',
			filterable: true,
			hidden: true,
			flex: 1
		  },{
		  	text: 'Linking Column',
			dataIndex: 'LINKINGCOLUMN',
			filterable: true,
			hidden: true,
			flex: 1
		  },{
		  	text: 'Table Type',
			dataIndex: 'TABLETYPE',
			filterable: true,
			editor: {
				xtype: 'combobox',
				queryMode: 'local',
				store: 'form.tabletypestore',
				displayField: 'tabletypename',
				valueField: 'tabletypecode'
			},
			width: 150
		  },{
		  	text: 'Level ID',
			dataIndex: 'LEVELID',
			filterable: true,
			editor: {
				xtype: 'combobox',
				queryMode: 'local',
				store: 'form.levelidstore',
				displayField: 'levelidname',
				valueField: 'levelidcode'
			},
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
