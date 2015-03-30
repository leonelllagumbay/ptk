Ext.define('Form.view.query.queryviewerView', { 
	extend: 'Ext.grid.Panel',
	alias: 'widget.queryviewerview',
	title: 'eQuery Viewer',
	width: '100%', 
	width: '100%', 
	multiSelect: true,
    selModel: Ext.create ('Ext.selection.CheckboxModel'),
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
	 
		this.store = 'query.queryViewerStore';
		this.bbar = Ext.create('Ext.toolbar.Paging', {
				        store: 'query.queryViewerStore', 
				        displayInfo: true,
				        emptyMsg: "No query to display"
				   });
		this.tbar = [{
		  	text: 'View',
			action: 'view'
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
		    width: 250
		  },{  
		    text: 'Description',
		    dataIndex: 'EQRYDESCRIPTION',
			hidden: false,
			filterable: true,
		    flex: 1
		  },{
		    text: 'Date Last Update',
		    dataIndex: 'DATELASTUPDATE',
			hidden: true,
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