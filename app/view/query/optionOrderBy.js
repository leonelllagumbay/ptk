
Ext.define('Form.view.query.optionOrderBy', {
	extend: 'Ext.grid.Panel',
	alias: 'widget.optionorderby',
	multiSelect: true,
	width: 310,
	height: 165,
	viewConfig: {
	    forceFit: false,
		trackOver: false,
	    emptyText: '<h1 style="margin:20px">No results found</h1>',
	    plugins: {
            ptype: 'gridviewdragdrop',
            ddGroup: 'ddorderby',
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
				dataIndex: 'FIELDNAME'
			}]
		}];
		this.store = 'query.optionOrderByStore';
		this.fbar = Ext.create('Ext.toolbar.Paging', {
				        store: 'query.optionOrderByStore', 
				        displayInfo: false,
				        emptyMsg: "_"
		});
		this.columns = [{
			xtype: 'rownumberer',
			width: 50,
			sortable: false
		},{
			text: 'FIELDNAME',
			dataIndex: 'FIELDNAME',
			filterable: true,
			sortable: true,
			hidden: true,
			flex: 1
		},{
			text: '-',
			dataIndex: 'DISPLAY',
			filterable: true,
			sortable: true,
			flex: 1
		}],
		this.callParent(arguments);
	}
});