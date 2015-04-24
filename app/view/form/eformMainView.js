
Ext.define('Form.view.form.eformMainView', {
	extend: 'Ext.grid.Panel',
	alias: 'widget.eformmainview',
	width: '100%',
    title: 'iBOS/e eForms',
    multiSelect: true,
    clicksToEdit: 2,
	selModel: {
		    pruneRemoved: false
	},
	 
	viewConfig: {
	    forceFit: false,
		trackOver: false,
	    emptyText: '<h1 style="margin:20px"></h1>'
	  },
	 
	
	initComponent: function() {    
	
		this.store = 'form.eformMainStore';
		
		this.features = [{
			ftype: 'filters',
			encode: true, // json encode the filter query
			local: false, 
			filters: [{
				type: 'string',
				dataIndex: 'A_EFORMGROUP'
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
			action: 'selecteduser'
		  },{
			xtype: 'tbseparator'  
		  },{
		  	text: 'Back',
			action: 'backcallingpage'    
		  },{
			xtype: 'tbseparator'  
		  },{
		  	xtype: 'displayfield',
			value: '<i>>> To fill up and route an eForm, click on a particular eForm listed below and click on Add button.</i>'
		  }];
		 
		
		this.columns =  [{
            	xtype: 'rownumberer',
            	width: 50,
            	sortable: false
	       },{
		   	    text: 'EFORMID',
				dataIndex: 'A_EFORMID',
				filterable: true,
				sortable: true,
				hidden: true
		   },{
		   	    text: 'Group',
				dataIndex: 'A_EFORMGROUP',
				filterable: true,
				width: 200
		   },{
		   	    text: 'Name',
				dataIndex: 'A_EFORMNAME',
				filterable: true,
				flex: 2,
				renderer: function(value,p,record) {return Ext.String.format('<a href=\'##\'><b>{0}</b></a>', value);}
				
		   },{
		   	    text: 'Description',
				dataIndex: 'A_DESCRIPTION',
				filterable: true,
				flex: 3
		   },{
		   	    text: 'New',
				dataIndex: 'C_NEW',
				sortable: true,
				filterable: true,
				flex: 1,
				renderer: function(value,p,record) {return Ext.String.format('<a href=\'##\'><b>{0}</b></a>', value);}
		   },{
		   	    text: 'Pending', 
				dataIndex: 'C_PENDING',
				sortable: true,
				filterable: true,
				flex: 1,
				renderer: function(value,p,record) {return Ext.String.format('<a href=\'##\'><b>{0}</b></a>', value);}
		   },{
		   	    text: 'Returned', 
				dataIndex: 'C_RETURNED',
				sortable: true,
				filterable: true,
				flex: 1,
				renderer: function(value, metaData, record) {
					var apforms = record.data.C_APPROVED;
					var disforms = record.data.C_DISAPPROVED;
					var returned = value; 
					
					return "<span style='background-color: #AAAAFF; border-radius: 12px; color: white;'><b>&nbsp;"+returned+"&nbsp;</b></span>&nbsp;<span style='background-color: green; border-radius: 12px; color: white;'><b>&nbsp;"+apforms+"&nbsp;</b></span>&nbsp;<span style='background-color: red; border-radius: 12px; color: white;'><b>&nbsp;"+disforms+"&nbsp;</b></span>";
				} 
		   },{
		   	    text: 'Encrypted',
				dataIndex: 'A_ISENCRYPTED',
				hidden: true,
				flex: 1
		   },{
		   	    text: 'Form Flow',  
				dataIndex: 'A_FORMFLOWPROCESS',
				editor: 'textfield',
				hidden: true,
				flex: 1
		   },{
		    text: 'Date Last Update',
		    dataIndex: 'A_DATELASTUPDATE',
			hidden: true,
		    width: 100,
			renderer: Ext.util.Format.dateRenderer('n/j/Y'),
			filter: {
				type: 'date',
				format: 'Y-n-j'
			}
		  },{
		   	    text: 'Approved Forms',
				dataIndex: 'C_APPROVED',
				sortable: true,
				filterable: true,
				hidden: true,
				flex: 1 
		  },{
		   	    text: 'Dispproved Forms',
				dataIndex: 'C_DISAPPROVED',
				sortable: true,
				filterable: true,
				hidden: true,
				flex: 1 
		  }],
		
		
		this.callParent(arguments);
	}
})


