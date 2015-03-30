Ext.Loader.setConfig({enabled: true});
		Ext.Loader.setPath('Ext.ux', '../../otherscript/extjs/examples/ux');
		Ext.require([
			'Ext.ux.grid.FiltersFeature',
			'Ext.grid.plugin.BufferedRenderer',
			'Ext.toolbar.Paging',
			'Ext.ux.ajax.JsonSimlet',
		    'Ext.ux.ajax.SimManager',
			'Ext.util.*',
			'Ext.grid.*',
			'Ext.grid.feature.Grouping',
			'Ext.data.*'
		]);


var filters = {
        ftype: 'filters',
        encode: true, // json encode the filter query
        local: false,   // defaults to false (remote filtering)
	    filters: [{
            type: 'string',
            dataIndex: 'PROCESSID'
        }]
    };

	
	


console.log('d');

Ext.define('Form.view.view.formflowactivity', {     
	extend: 'Ext.grid.Panel',
	alias: 'widget.formActivity', 
	width: '100%',
    title: 'eForm Form-flow Activity',
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
		this.store = 'view.formflowprocessstore';
		this.bbar = Ext.create('Ext.toolbar.Paging', {
				        store: 'view.formflowprocessstore', 
				        displayInfo: true,
				        emptyMsg: "No topics to display"
				   });
		this.tbar = [{
			text: 'New',
			action: 'newprocess'
		  },{
		  	text: 'Save',
			action: 'saveprocess'
		  },{
		  	text: 'Delete',
			action: 'deleteprocess'
		  },{
		  	xtype: 'tbseparator'
		  },{
		  	text: 'View Details',
			action: 'viewdetailedactivity'
		  },{
		  	xtype: 'tbseparator'
		  },{
		  	text: 'Back',
			action: 'backtoprocess'
		  },{
		  	xtype: 'tbseparator'
		  },{
		  	text: 'View sample diagram',
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
			groupable: true,
			editor: 'textfield',
		    width: 180
		  },{
		  	text: 'Name',
			dataIndex: 'PROCESSNAME',
			filterable: true,
			groupable: true,
			editor: 'textfield',
			width: 210
		  },{
		  	text: 'Description',
			dataIndex: 'DESCRIPTION',
			filterable: true,
			groupable: true,
			editor: 'textfield',
			flex: 1
		  },{
		  	text: 'Owner',
			dataIndex: 'RECCREATEDBY',
			filterable: true,
			groupable: true,
			width: 100
		  },{
		    text: 'Date Last Update',
		    dataIndex: 'DATELASTUPDATE',
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
