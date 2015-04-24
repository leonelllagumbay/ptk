Ext.define('Form.view.query.querymanagerView', { 
	extend: 'Ext.grid.Panel',
	alias: 'widget.querymanagerview',
	title: 'eQuery Manager',
	width: '100%', 
	multiSelect: true,
    selModel: Ext.create('Ext.selection.CheckboxModel'),
	viewConfig: {
	    forceFit: false,
		trackOver: false,
	    emptyText: '<h1 style="margin:20px">No matching results</h1>'
	},
	 
	
	initComponent: function() {    
	
		this.features = [{
			ftype: 'filters',
			encode: true,
			local: false, 
			filters: [{
				type: 'string',
				dataIndex: 'EQRYNAME'
			}]
		}];
	 
	    this.plugins = [
			Ext.create('Ext.grid.plugin.CellEditing', {
			    clicksToEdit: 2
    	    })
			
		];
		this.store = 'query.managerStore';
		this.bbar = Ext.create('Ext.toolbar.Paging', {
				        store: 'query.managerStore', 
				        displayInfo: true,
				        emptyMsg: "No query to display"
				   });
		this.tbar = [{
			text: 'Add',
			action: 'addquery'
		  },{
		  	text: 'Copy',
			action: 'copyquery'
		  },{
		  	text: 'Delete',
			action: 'deletequery'
		  },{
		  	text: 'Manage Query',
			action: 'managequery'
		  },{
		  	text: 'Preview',
			action: 'previewquery'
	    }];
		  
		this.columns =  [{
            xtype: 'rownumberer',
            width: 50,
            sortable: false
	       },{  
		    text: 'Query Code',  
		    dataIndex: 'EQRYCODE',
			hidden: true,
		    width: 150
		  },{  
		    text: 'Name',
		    dataIndex: 'EQRYNAME',
			hidden: false,
			filterable: true,
			editor: 'textfield',
		    width: 250
		  },{  
		    text: 'Description',
		    dataIndex: 'EQRYDESCRIPTION',
			hidden: false,
			filterable: true,
			editor: 'textfield',
		    flex: 1
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
		  },{
		    text: 'Date Added',
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
		  }],
		
		this.callParent(arguments);
	}
});