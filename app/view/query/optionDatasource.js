
Ext.define('Form.view.query.optionDatasource', {
	extend: 'Ext.grid.Panel',
	alias: 'widget.optiondatasource',
	multiSelect: true,
	width: 310,
	height: 165,
	viewConfig: {
	    forceFit: false,
		trackOver: false,
	    emptyText: '<h1 style="margin:20px">No datasources found</h1>',
	    plugins: {
            ptype: 'gridviewdragdrop',
            ddGroup: 'thiscontainer',
            containerScroll: true
        }
	},
	initComponent: function() {
		
		this.features = [{
			ftype: 'filters',
			encode: true, // json encode the filter query
			local: false, 
			filters: [{
				type: 'string',
				dataIndex: 'DATASOURCENAME'
			}]
		}];
		this.store = 'query.optionDBstore';
		this.fbar = Ext.create('Ext.toolbar.Paging', {
				        store: 'query.optionDBstore', 
				        displayInfo: false,
				        emptyMsg: "_"
		});
		this.columns = [{
			xtype: 'rownumberer',
			width: 50,
			sortable: false
		},{
			text: '-',
			dataIndex: 'DATASOURCENAME',
			filterable: true,
			sortable: true,
			flex: 1
		},{
			text: 'Type',
			dataIndex: 'DATASOURCETYPE',
			hidden: true
		},{
			text: 'DATASOURCECODE',
			dataIndex: 'DATASOURCECODE',
			hidden: true,
			flex: 1
		},{
			text: 'COLUMNORDER',
			dataIndex: 'COLUMNORDER',
			hidden: true,
			flex: 1
		},{
			text: 'EQRYCODEFK',
			dataIndex: 'EQRYCODEFK',
			hidden: true,
			flex: 1
		}],
		this.callParent(arguments);
	}
});