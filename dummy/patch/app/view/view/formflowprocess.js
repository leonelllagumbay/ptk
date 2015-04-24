Ext.define('View.view.view.formflowprocess', {     
	extend: 'Ext.grid.Panel',
	alias: 'widget.formGrid', 
	width: '100%',
    title: 'eForm Form Flow Process',  
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
				dataIndex: 'GROUPNAME'
			}]
		}];
	  
	    this.plugins = [
			Ext.create('Ext.grid.plugin.CellEditing', {
			    clicksToEdit: 2
    	    })
			
		];
		this.store = 'view.formflowprocessstore';
		this.bbar = Ext.create('Ext.toolbar.Paging', {
				        store: 'view.formflowprocessstore', 
				        displayInfo: true,
				        emptyMsg: "No topics to display"
				   });
		this.tbar = [{
			text: 'New Process',
			action: 'newprocess'
		  },{
		  	xtype: 'tbseparator'
		  },{
		  	text: 'Copy Selected',
			action: 'copyprocess'
		  },{
		  	xtype: 'tbseparator'
		  },{
		  	text: 'Delete',
			action: 'deleteprocess'
		  },{
		  	xtype: 'tbseparator'
		  },{
		  	text: 'View Router',
			action: 'viewactivities'
		  },{
		  	xtype: 'tbseparator'
		  },{
		  	text: 'Preview',
			action: 'viewsampdiagram'
		  }];
		  
		this.columns =  [{
            xtype: 'rownumberer',
            width: 50,
            sortable: false
	       },{  
		    text: 'Process ID',
		    dataIndex: 'PROCESSID',
			hidden: true,
		    width: 50
		  },{  
		    text: 'Company Code',
		    dataIndex: 'COMPANYCODE',
			hidden: true,
		    width: 50
		  },{
		    text: 'Group',
		    dataIndex: 'GROUPNAME',
			filterable: true,
			editor: {
				xtype: 'combobox',
				store: 'view.groupstore',
				displayField: 'processgroupname',
				valueField: 'processgroupcode',
				minChars: 1,
				pageSize: 20
			},
		    width: 200
		  },{
		  	text: 'Name',
			dataIndex: 'PROCESSNAME',
			filterable: true,
			editor: 'textfield',
			width: 250
		  },{
		  	text: 'Description',
			dataIndex: 'DESCRIPTION',
			filterable: true,
			editor: 'textfield',
			flex: 1
		  },/*{
		  	text: 'Level of Approvers',
			dataIndex: 'LEVELOFAPPROVERS',
			filterable: true,
			editor: {
				xtype: 'numberfield',
				minValue: 0,
				maxValue: 1000000
			},
			width: 105
		  },{
		  	text: 'Link Approvers By',
			dataIndex: 'APPROVERBY',
			filterable: true,
			//groupable: true,
			editor: {
				xtype: 'combobox',
				store: 'view.linkstore',
				displayField: 'linkname',
				valueField: 'linkcode'
			},
			width: 100
		  },*/{
		  	text: 'eForm Life (in days)',
			dataIndex: 'EFORMLIFE',
			filterable: true,
			editor: {
				xtype: 'numberfield',
				minValue: 0,
				maxValue: 1000000
			},
			width: 150
		  },{
		  	text: 'Action to Take',
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
		  	text: 'Process Owner',
			dataIndex: 'RECCREATEDBY',
			filterable: true,
			hidden: true,
			width: 100
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
		  }],
		
		
		this.callParent(arguments);
	}
});
