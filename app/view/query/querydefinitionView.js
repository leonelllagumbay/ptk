Ext.define('Form.view.query.querydefinitionView', { 
	extend: 'Ext.grid.Panel',
	alias: 'widget.querydefinitionview',
	title: 'eQuery Definition',
	width: '100%',
	 
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
	 
		this.store = 'query.queryDefinitionStore';
		this.bbar = Ext.create('Ext.toolbar.Paging', {
				        store: 'query.queryDefinitionStore', 
				        displayInfo: true,
				        emptyMsg: "No query to display"
				   });
		this.tbar = [{
		  	text: 'Edit Details',
			action: 'editdetails'
		},{
		  	text: 'Show Columns',
			action: 'showcolumns'
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