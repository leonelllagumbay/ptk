//same as the eform simulator except for this name
Ext.define('Form.view.form.eformMainViewMain', {
	extend: 'Ext.grid.Panel',
	alias: 'widget.eformmainview',
	width: '100%',
    title: 'eForm',
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
	
		this.store = 'form.eformMainStore';
		
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
		
		
		this.bbar = Ext.create('Ext.toolbar.Paging', {
				        store: 'form.eformMainStore', 
				        displayInfo: true,
				        emptyMsg: "No topics to display"
				   });
				   
		this.tbar = [{
			xtype: 'combobox', 
			name: 'userpid',
			store: 'form.userStore',
			displayField: 'username',
			valueField: 'usercode',
			minChars: 1,
			pageSize: 20,
			width: 360,
			fieldLabel: 'User',
			action: 'selecteduser',
			padding: '5 5 5 5'
		  },{
		  	xtype: 'tbseparator'
		  },{
		  	text: 'No New eForm',
			action: 'neweforms'
		  },{
		  	xtype: 'tbseparator'
		  },{
		  	text: 'No Pending eForm',
			action: 'pendingeforms'
		  }];
		 
		
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
		   	    text: 'New',
				dataIndex: 'NEWEFORMS',
				sortable: false,
				filterable: false,
				flex: 1
		   },{
		   	    text: 'Pending', 
				dataIndex: 'PENDINGEFORMS',
				sortable: false,
				filterable: false,
				flex: 1
		   },{
		   	    text: 'Returned', 
				dataIndex: 'TOTALRETURNED',
				sortable: false,
				filterable: false,
				flex: 1,
				renderer: function(value, metaData, record) {
					var apforms = record.data.APPROVEDFORMS;
					var disforms = record.data.DISAPPROVEDFORMS;
					var returned = value; 
					
					return "<span style='background-color: #AAAAFF; border-radius: 12px; color: white;'><b>&nbsp;"+returned+"&nbsp;</b></span>&nbsp;<span style='background-color: green; border-radius: 12px; color: white;'><b>&nbsp;"+apforms+"&nbsp;</b></span>&nbsp;<span style='background-color: red; border-radius: 12px; color: white;'><b>&nbsp;"+disforms+"&nbsp;</b></span>";
				} 
		   },{
		   	    text: 'Encrypted',
				dataIndex: 'ISENCRYPTED',
				hidden: true,
				flex: 1
		   },{
		   	    text: 'Form Flow',  
				dataIndex: 'FORMFLOWPROCESS', 
				editor: 'textfield',
				hidden: true,
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
		   	    text: 'Approved Forms',
				dataIndex: 'APPROVEDFORMS',
				hidden: true,
				flex: 1 
		  },{
		   	    text: 'Dispproved Forms',
				dataIndex: 'DISAPPROVEDFORMS',
				hidden: true,
				flex: 1 
		  }],
		
		
		this.callParent(arguments);
	}
})