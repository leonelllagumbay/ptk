
Ext.define('Form.view.query.selectedOrderBy', {
	extend: 'Ext.grid.Panel',
	alias: 'widget.selectedorderby',
	multiSelect: true,
	width: 410,
	height: 165,
	hideHeaders: true,
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
		this.plugins = [
			Ext.create('Ext.grid.plugin.CellEditing', {
			    clicksToEdit: 2
    	    })
		];
		this.store = 'query.selectedOrderByStore';
		this.columns = [{
			xtype: 'rownumberer',
			width: 40,
			sortable: false
		},{
			text: 'EVIEWORDERBYCODE',
			dataIndex: 'EVIEWORDERBYCODE',
			hidden: true,
		},{
			text: 'EQRYCODEFK',
			dataIndex: 'EQRYCODEFK',
			hidden: true,
		},{
			text: 'COLUMNORDER',
			dataIndex: 'COLUMNORDER',
			hidden: true,
		},{
			text: 'PRIORITYNO',
			dataIndex: 'PRIORITYNO',
			hidden: true,
		},{
			text: 'FIELDNAME',
			dataIndex: 'FIELDNAME',
			hidden: true,
			flex: 1
		},{
			text: '-',
			dataIndex: 'DISPLAY',
			editor: 'textfield',
			flex: 3,
		},{
			text: 'Order',
			dataIndex: 'ASCORDESC',
			editor: {
				xtype: 'combobox',
				queryMode: 'local',
				store: 'query.orderStore', 
				displayField: 'ORDERNAME',
				valueField: 'ORDERCODE' 
			},
			flex: 1
			
		}],
		this.callParent(arguments);
	}
});