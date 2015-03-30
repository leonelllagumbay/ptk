
Ext.define('Form.view.query.optionTable', {
	extend: 'Ext.grid.Panel',
	alias: 'widget.optiontable',
	multiSelect: true,
	width: 310,
	height: 265,
	viewConfig: {
	    forceFit: false,
		trackOver: false,
	    emptyText: '<h1 style="margin:20px">No results found</h1>',
	    plugins: {
            ptype: 'gridviewdragdrop',
            ddGroup: 'ddtable',
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
				dataIndex: 'TABLENAME'
			}]
		}];
		this.store = 'query.optionTableStore';
		this.tbar = Ext.create('Ext.toolbar.Paging', {
				        store: 'query.optionTableStore', 
				        displayInfo: false,
				        emptyMsg: "_"
		});
		this.columns = [{
			xtype: 'rownumberer',
			width: 50,
			sortable: false
		},{
			text: 'Datasource',
			dataIndex: 'DATASOURCE',
			//filterable: true,
			//sortable: true,
			flex: 1
		},{
			text: 'Table Name',
			dataIndex: 'TABLENAME',
			filterable: true,
			sortable: true,
			flex: 2
		},{
			text: 'Table Alias',
			dataIndex: 'TABLEALIAS',
			hidden: true,
			flex: 1
		},{
			text: '-',
			dataIndex: 'TEMPTABLE',
			//filterable: true,
			//sortable: true,
			hidden: true,
			flex: 1
		},{
			text: 'Table Type',
			dataIndex: 'TABLE_TYPE',
			hidden: true
		},{
			text: 'Table Remarks',
			dataIndex: 'REMARKS',
			hidden: true
		}],
		this.callParent(arguments);
	}
});