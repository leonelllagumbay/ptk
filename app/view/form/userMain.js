Ext.define('Form.view.form.userMain', {
	extend: 'Ext.grid.Panel',
	alias: 'widget.usermain', 
	width: '100%',
    title: 'eForm User Manager',
	selModel: {
		    pruneRemoved: false 
	},
	 
	viewConfig: {
	    forceFit: false,
		trackOver: false,
	    emptyText: '<h1 style="margin:20px">No matching results</h1>'
	  },
	 
	
	initComponent: function() {    
	
		this.store = 'form.eformUserMainStore';
		
		this.features = [{
			ftype: 'filters',
			encode: true, // json encode the filter query
			local: false, 
			filters: [{
				type: 'string',
				dataIndex: 'EFORMGROUP'
			}]
		}];
	 
	    
		
		this.bbar = Ext.create('Ext.toolbar.Paging', {
				        store: 'form.eformUserMainStore', 
				        displayInfo: true,
				        emptyMsg: "No topics to display"
				   });
		  
		this.columns =  [{
            	xtype: 'rownumberer',
            	width: 50,
            	sortable: false
	       },{
		   	    text: 'EFORMID',
				dataIndex: 'EFORMTABLEID',
				filterable: true,
				hidden: true
		   },{
		   	    text: 'Group',
				dataIndex: 'EFORMGROUP',
				filterable: true,
				width: 200
		   },{
		   	    text: 'Name',
				dataIndex: 'EFORMNAME',
				filterable: true,
				flex: 2
				
		   },{
		   	    text: 'Description',
				dataIndex: 'DESCRIPTION',
				filterable: true,
				flex: 3
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
		  }],
		
		
		this.callParent(arguments);
	}
})