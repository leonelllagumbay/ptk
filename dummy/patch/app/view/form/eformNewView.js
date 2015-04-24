Ext.define('Form.view.form.eformNewView', {
	extend: 'Ext.grid.Panel',
	alias: 'widget.eformnewview',
	width: '100%',
    title: 'New eForms',  
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
				dataIndex: 'EFORMGROUP'
			}]
		}];
	 
	    this.plugins = [
			Ext.create('Ext.grid.plugin.CellEditing', {
			    clicksToEdit: 2
    	    })
			
		];
		this.store = 'form.eformMainStore';
		this.bbar = Ext.create('Ext.toolbar.Paging', {
				        store: 'form.eformMainStore', 
				        displayInfo: true,
				        emptyMsg: "No topics to display"
				   });
		this.tbar = [{
			text: 'Back',
			action: 'backtomain'
		  },{
		  	xtype: 'tbseparator'
		  },{
			xtype: 'combobox',
			store: 'form.maineFormStore',
			displayField: 'eformmainname',
			valueField: 'eformmaincode',
			minChars: 1,
			pageSize: 20,
			width: 360,
			fieldLabel: 'Select an eForm',
			action: 'selecteform'
		  },{
		  	xtype: 'tbseparator'
		  },{
		  	text: 'Approve',
			action: 'approveeform'
		  },{
		  	xtype: 'tbseparator'
		  },{
		  	text: 'Disapprove',
			action: 'disapprove'
		  },{
		  	xtype: 'tbseparator'
		  },{
		  	xtype: 'tbfill'
		  },{
		  	text: 'Open Details',
			action: 'newopendetails'
		  },{
		  	xtype: 'tbseparator'
		  },{
		  	text: 'View Path',
			action: 'viewpath'
		  },{
		  	xtype: 'tbseparator'
		  },{
		  	xtype: 'checkboxfield',
			fieldLabel: 'Show Active Only',
			action: 'showactiveonly'
		  }];
		  
		this.columns =  [{
            xtype: 'rownumberer',
            width: 50,
            sortable: false
	       }],
		
		
		this.callParent(arguments);
	}
});