var filters = {
        ftype: 'filters',
        encode: true,
        local: false,
	    filters: [{
            type: 'string',
            dataIndex: 'ROUTERNAME'
        }]
    };


Ext.define('Form.view.view.formrouter', {     
	extend: 'Ext.grid.Panel',
	alias: 'widget.formRouter', 
	width: '100%',
    title: 'eForm Form Flow -> eForm Router',
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
		this.store = 'view.formrouterstore';
		this.bbar = Ext.create('Ext.toolbar.Paging', {
				        store: 'view.formrouterstore', 
				        displayInfo: true,
				        emptyMsg: "No topics to display"
				   });
		this.tbar = [{
		  	text: 'Back',
			action: 'backtoprocess'
		  },{
		  	xtype: 'tbseparator'
		  },{
			text: 'New Router',
			action: 'newrouter'
		  },{
		  	text: 'Delete',
			action: 'deleterouter'
		  },{
		  	xtype: 'tbseparator'
		  },{
		  	text: 'Edit Details',
			action: 'viewdetailesrouter'
		  },{
		  	xtype: 'tbseparator'
		  },{
		  	text: 'View Approvers',
			action: 'viewapprovers'
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
		    text: 'Router ID',
		    dataIndex: 'ROUTERID',
			hidden: true,
		    width: 50
		  },{  
		    text: 'Process ID',
		    dataIndex: 'PROCESSIDFK',
			hidden: true,
		    width: 50 
		  },{
		  	text: 'Router Order',
			dataIndex: 'ROUTERORDER',
			filterable: true,
			editor: {
				xtype: 'numberfield',
				minValue: 0,
				maxValue: 1000000
			},
			width: 100
		  },{
		    text: 'Name',
		    dataIndex: 'ROUTERNAME',
			filterable: true,
			editor: 'textfield',
		    width: 180
		  },{
		  	text: 'Description',
			dataIndex: 'DESCRIPTION',
			filterable: true,
			editor: 'textfield',
			width: 250
		  },{
		  	text: 'No. of Days Before Expiration',
			dataIndex: 'EFORMSTAYTIME',
			filterable: true,
			editor: {
				xtype: 'numberfield',
				minValue: 0,
				maxValue: 1000000
			},
			width: 200
		  },{
		  	text: 'Allow Notification',
			dataIndex: 'NOTIFYNEXTAPPROVERS',
			filterable: true,
			editor: {
				xtype: 'checkboxfield'
			},
			width: 150
		  },{
		  	text: 'Notify All Following Approvers',
			dataIndex: 'NOTIFYALLAPPROVERS',
			filterable: true,
			hidden: true,
			editor: {
				xtype: 'checkboxfield'
			},
			width: 200
		  },{
		  	text: 'Notify Originator',
			dataIndex: 'NOTIFYORIGINATOR',
			filterable: true,
			editor: {
				xtype: 'checkboxfield'
			},
			width: 150
		  },{
		  	text: 'Follow up form via email every (in hours)',
			dataIndex: 'FREQUENCYFOLLOUP',
			filterable: true,
			editor: {
				xtype: 'numberfield',
				minValue: 0,
				maxValue: 24
			},
			width: 250
		  },{ 
		  	text: 'Action if Expired',
			dataIndex: 'EXPIREDACTION',
			filterable: true,
			editor: {
				xtype: 'combobox',
				store: 'view.actionstore',
				displayField: 'actionname',
				valueField: 'actioncode'
			},
			width: 150
		  },{
		  	text: 'With Conditions',
			dataIndex: 'USECONDITIONS',
			filterable: true,
			editor: {
				xtype: 'checkboxfield'
			},
			width: 150
		  },{
		  	text: 'Approve At Least',
			dataIndex: 'APPROVEATLEAST',
			filterable: true,
			editor: {
				xtype: 'numberfield',
				minValue: 1,
				maxValue: 1000000
			},
			width: 150
		  },{
		  	text: 'Auto Approve',
			dataIndex: 'AUTOAPPROVE',
			filterable: true,
			editor: {
				xtype: 'checkboxfield'
			},
			width: 150
		  },{
		  	text: 'Is Last Router?',
			dataIndex: 'ISLASTROUTER',
			filterable: true,
			editor: {
				xtype: 'checkboxfield'
			},
			width: 150
		  },{
		  	text: 'Maximum Approvers',
			dataIndex: 'MAXIMUMAPPROVERS',
			filterable: true,
			hidden: true,
			editor: {
				xtype: 'numberfield',
				minValue: 0,
				maxValue: 1000000
			},
			width: 150
		  },{
		  	text: 'Allow Override?',
			dataIndex: 'CANOVERRIDE',
			filterable: true,
			editor: {
				xtype: 'checkboxfield'
			},
			width: 200
		  },{
		  	text: 'Copy Notification To',
			dataIndex: 'MOREEMAILADD',
			filterable: true,
			editor: 'textfield',
			width: 350
		  }],
		
		
		this.callParent(arguments);
	}
});
