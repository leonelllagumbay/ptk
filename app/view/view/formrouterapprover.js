var filters = {
        ftype: 'filters',
        encode: true, // json encode the filter query
        local: false,   // defaults to false (remote filtering)
	    filters: [{
            type: 'string',
            dataIndex: 'GROUPNAME'
        }]
    };


Ext.define('Form.view.view.formrouterapprover', {     
	extend: 'Ext.grid.Panel',
	alias: 'widget.formApproverGrid', 
	width: '100%',
    title: 'eForm Form Flow -> eForm Router -> Router Approvers',
    features: [filters],  
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
	    this.plugins = [
			Ext.create('Ext.grid.plugin.CellEditing', {
			    clicksToEdit: 2
    	    })
			
		];
		this.store = 'view.formapproverstore';
		this.bbar = Ext.create('Ext.toolbar.Paging', {
				        store: 'view.formapproverstore', 
				        displayInfo: true,
				        emptyMsg: "No topics to display"
				   });
		this.tbar = [{
		  	text: 'Back',
			action: 'backtorouter'
		  },{
		  	xtype: 'tbseparator'
		  },{
			text: 'New Approver',
			action: 'newapprover'
		  },{
		  	xtype: 'tbseparator'
		  },{
		  	text: 'Delete Approver',
			action: 'deleteapprover'
		  },{
		  	xtype: 'tbfill'
		  },{
		  	text: 'Preview',
			action: 'viewsampdiagram' 
		  }];
		  
		this.columns =  [{
            xtype: 'rownumberer',
            width: 50,
            sortable: false
	       },{  
		    text: 'Approvers ID',
		    dataIndex: 'APPROVERSID',
			hidden: true,
		    width: 50
		  },{  
		    text: 'Router ID FK',
		    dataIndex: 'ROUTERIDFK',
			hidden: true,
		    width: 50
		  },{  
		    text: 'Process ID FK',
		    dataIndex: 'PROCESSIDFK',
			hidden: true,
		    width: 50
		  },{
		    text: 'Order',
		    dataIndex: 'APPROVERORDER',
			filterable: true,
			editor: {
				xtype: 'numberfield',
				minValue: 0,
				maxValue: 1000000
			},
			width: 50
		  },{
		  	text: 'Mapping',
			dataIndex: 'APPROVERNAME',
			filterable: true,
			editor: {
				xtype: 'combobox',
				value: 'NA',
				store: 'view.linkstore',
				displayField: 'linkname',
				valueField: 'linkcode'
			},
			width: 150
		  },{
		  	text: 'Auto Approve',
			dataIndex: 'USERID',
			filterable: true,
			editor: {
				xtype: 'checkboxfield'
			},
			width: 130
		  },{
		  	text: 'Personnel ID No.',
			dataIndex: 'PERSONNELIDNO',
			filterable: true,
			editor: {
				xtype: 'combobox',
				store: 'view.namestore',
				displayField: 'namename',
				valueField: 'namecode',
				pageSize: 25,
				minChars: 1
			},
			width: 200
		  },{
		  	text: 'User Role',
			dataIndex: 'USERGRPID',
			filterable: true,
			editor: {
				xtype: 'combobox',
				store: 'view.rolestore',
				displayField: 'rolename',
				valueField: 'rolecode',
				pageSize: 25,
				minChars: 1
			},
			width: 200
		  },{ 
		  	text: 'Can View Process Map',
			dataIndex: 'CANVIEWROUTEMAP',
			filterable: true,
			editor: {
				xtype: 'checkboxfield'
			},
			width: 130
		  },{ 
		  	text: 'Can Override',
			dataIndex: 'CANOVERRIDE',
			filterable: true,
			editor: {
				xtype: 'checkboxfield'
			},
			width: 130
		  },{
		  	text: 'Condition Above',
			dataIndex: 'CONDITIONABOVE',
			filterable: true,
			hidden: true,
			editor: {
				xtype: 'combobox',
				store: 'view.conditionstore',
				displayField: 'conditionname',
				valueField: 'conditioncode'
			},
			width: 130
		  },{
		  	text: 'Condition Below',
			dataIndex: 'CONDITIONBELOW',
			filterable: true,
			editor: {
				xtype: 'combobox',
				store: 'view.conditionstore',
				displayField: 'conditionname',
				valueField: 'conditioncode'
			},
			width: 130
		  }],
		
		
		this.callParent(arguments);
	}
});
