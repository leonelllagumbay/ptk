Ext.define('Form.view.form.defMainView', {
	extend: 'Ext.grid.Panel',
	alias: 'widget.defmainview',
	width: '100%',
    title: 'eForm Manager',  
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
		this.store = 'form.defMainStore';
		this.bbar = Ext.create('Ext.toolbar.Paging', {
				        store: 'form.defMainStore', 
				        displayInfo: true,
				        emptyMsg: "No topics to display"
				   });
		this.tbar = [{
			text: 'New',
			action: 'neweform'
		  },{
		  	xtype: 'tbseparator'
		  },{
		  	text: 'Copy',
			action: 'copyeform'
		  },{
		  	xtype: 'tbseparator'
		  },{
		  	text: 'Delete',
			action: 'deleteeform'
		  },{
		  	xtype: 'tbseparator'
		  },{
		  	text: 'View Tables',
			action: 'viewtables'
		  },{
		  	xtype: 'tbfill'
		  },{
		  	text: 'Generate',
			action: 'generatescript'
		  },{
		  	xtype: 'tbseparator'
		  },{
		  	text: 'Preview',
			action: 'formpreview'
		  },{
		  	xtype: 'tbseparator'
		  }];
		  
		this.columns =  [{
            xtype: 'rownumberer',
            width: 50,
            sortable: false
	       },{  
		    text: 'Process ID',
		    dataIndex: 'EFORMID',
			hidden: true,
		    width: 50
		  },{  
		    text: 'Company Code',
		    dataIndex: 'COMPANYCODE',
			hidden: true,
		    width: 50
		  },{
		    text: 'Group',
		    dataIndex: 'EFORMGROUP',
			filterable: true,
			editor: {
				xtype: 'combobox',
				store: 'form.maingroupstore',
				displayField: 'maingroupname',
				valueField: 'maingroupcode',
				minChars: 1,
				pageSize: 20
			},
		    width: 200
		  },{
		  	text: 'Name',
			dataIndex: 'EFORMNAME',
			filterable: true,
			maxLength: 5,
			editor: 'textfield',
			width: 250
		  },{
		  	text: 'Description',
			dataIndex: 'DESCRIPTION',
			filterable: true,
			editor: 'textfield',
			width: 250
		  },{
		  	text: 'Form Flow Process',
			dataIndex: 'FORMFLOWPROCESS',
			filterable: true,
			editor: {
				xtype: 'combobox',
				store: 'form.mainprocessstore',
				displayField: 'mainprocessname',
				valueField: 'mainprocesscode',
				minChars: 1,
				pageSize: 20
			},
			width: 350
		  },{
		     text: 'Encrypt Data',
		     dataIndex: 'ISENCRYPTED',
			 editor: {
			 	xtype: 'checkboxfield',
				checked: false,
				inputValue: 'true',
				uncheckedValue: 'false'
			 }	
		 },{
		  	text: 'View As',
			dataIndex: 'VIEWAS',
			filterable: true,
			editor: {
				xtype: 'combobox',
				queryMode: 'local',
				store: 'form.viewasstore',
				displayField: 'viewasname',
				valueField: 'viewascode'
			},
			width: 150
		  },{
		  	text: 'Form Padding',
			dataIndex: 'FORMPADDING',
			filterable: true,
			editor: 'textfield',
			width: 100
		  },{
		  	text: 'Group Margin',
			dataIndex: 'GROUPMARGIN',
			filterable: true,
			editor: 'textfield',
			width: 100
		  },{
		  	text: 'Before Load Process',
			dataIndex: 'BEFORELOAD',
			filterable: true,
			editor: {
				xtype: 'combobox',
				store: 'form.beforeloadstore',
				displayField: 'filename',
				valueField: 'filecode',
				minChars: 1,
				pageSize: 20
			},
			width: 250
		  },{
		  	text: 'After Load Process',
			dataIndex: 'AFTERLOAD',
			filterable: true,
			//hidden: true,
			editor: {
				xtype: 'combobox',
				store: 'form.afterloadstore',
				displayField: 'filename',
				valueField: 'filecode',
				minChars: 1,
				pageSize: 20
			},
			width: 250
		  },{
		  	text: 'Before Submit Process',
			dataIndex: 'BEFORESUBMIT',
			filterable: true,
			//hidden: true,
			editor: {
				xtype: 'combobox',
				store: 'form.beforesubmitstore',
				displayField: 'filename',
				valueField: 'filecode',
				minChars: 1,
				pageSize: 20
			},
			width: 250
		  },{
		  	text: 'After Submit Process',
			dataIndex: 'AFTERSUBMIT',
			filterable: true,
			//hidden: true,
			editor: {
				xtype: 'combobox',
				store: 'form.aftersubmitstore',
				displayField: 'filename',
				valueField: 'filecode',
				minChars: 1,
				pageSize: 20
			},
			width: 250
		  },{
		  	text: 'Before Approve Process',
			dataIndex: 'BEFOREAPPROVE',
			filterable: true,
			//hidden: true,
			editor: {
				xtype: 'combobox',
				store: 'form.beforeapprovestore',
				displayField: 'filename',
				valueField: 'filecode',
				minChars: 1,
				pageSize: 20
			},
			width: 250
		  },{
		  	text: 'After Approve Process',
			dataIndex: 'AFTERAPPROVE',
			filterable: true,
			//hidden: true,
			editor: {
				xtype: 'combobox',
				store: 'form.afterapprovestore',
				displayField: 'filename',
				valueField: 'filecode',
				minChars: 1,
				pageSize: 20
			},
			width: 250
		  },{
		  	text: 'On eForm Complete',
			dataIndex: 'ONCOMPLETE',
			filterable: true,
			//hidden: true,
			editor: {
				xtype: 'combobox',
				store: 'form.oncompletestore',
				displayField: 'filename',
				valueField: 'filecode',
				minChars: 1,
				pageSize: 20
			},
			width: 250
		  },{
		  	text: 'Made by',
			hidden: true,
			dataIndex: 'RECCREATEDBY',
			filterable: true
		  },{
		    text: 'Record Date Created',
		    dataIndex: 'RECDATECREATED',
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
})
