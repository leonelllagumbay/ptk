Ext.define('Form.view.form.userList', {
	extend: 'Ext.grid.Panel',
	alias: 'widget.userlist', 
	width: '100%',
    title: 'eForm User Manager',
	selModel: {
		    pruneRemoved: false 
	},
	multiSelect: true,
	viewConfig: {
	    forceFit: false, 
		trackOver: false,
	    emptyText: '<h1 style="margin:20px">No matching results</h1>'
	  },
	 
	
	initComponent: function() {    
	
		this.store = 'form.eformUserListStore';
		
		this.features = [{
			ftype: 'filters',
			encode: true, // json encode the filter query
			local: false, 
			filters: [{
				type: 'string', 
				dataIndex: 'FIRSTNAME'
			}]
		}];
	 
	    this.tbar = [{
			text: 'Back',
			action: 'back'
		},{
	  		xtype: 'tbseparator'
	    },{
			xtype: 'combobox', 
			name: 'userpid',
			fieldLabel: 'User',
			labelAlign: 'right',
			store: 'form.userStore',
			displayField: 'username',
			valueField: 'usercode',
			minChars: 1,
			pageSize: 20,
			width: 300,
			action: 'selecteduser', 
			padding: '5 5 5 5'
	    },{
			xtype: 'tbseparator'
		},{
			xtype: 'combobox',
			name: 'userrole',
			fieldLabel: 'User Role',
			labelAlign: 'right',
			width: 350,
			padding: '5 5 5 5',
			store: 'form.rolestore',
			displayField: 'rolename',
			valueField: 'rolecode',
			pageSize: 25,
			minChars: 1
		},{
	  		xtype: 'tbseparator'
	    },{
	  		text: 'Add',
			action: 'add'
	    },{
	  		xtype: 'tbfill'
	    },{
	  		text: 'Delete',
			action: 'delete'
	    }];
		
		this.bbar = Ext.create('Ext.toolbar.Paging', {
				        store: 'form.eformUserListStore', 
				        displayInfo: true,
				        emptyMsg: "No topics to display"
				   });
				   
		
		this.columns =  [{
            	xtype: 'rownumberer',
            	width: 50,
            	sortable: false
	       },{
		   	    text: 'Personnel Id No',
				dataIndex: 'PERSONNELIDNO',
				filterable: true,
				hidden: true
		   },{
		   	    text: 'First Name',
				dataIndex: 'FIRSTNAME',
				filterable: true,
				flex: 2
		   },{
		   	    text: 'Middle Name',
				dataIndex: 'MIDDLENAME',
				filterable: true,
				flex: 2
				
		   },{
		   	    text: 'Last Name',
				dataIndex: 'LASTNAME',
				filterable: true,
				flex: 2
		   }],
		
		
		this.callParent(arguments);
	}
})