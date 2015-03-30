
Ext.define('Form.view.query.selectedGroupBy', {
	extend: 'Ext.grid.Panel',
	alias: 'widget.selectedgroupby',
	multiSelect: true,
	width: 410,
	height: 165,
	hideHeaders: true,
	viewConfig: {
        plugins: {
            ptype: 'gridviewdragdrop',
            dragText: 'Drag and drop to reorganize',
            ddGroup: 'ddgroup',
            containerScroll: true
        }
    }, 
	initComponent: function() {
		this.plugins = [
			Ext.create('Ext.grid.plugin.CellEditing', {
			    clicksToEdit: 2
    	    })
		];
		this.store = 'query.selectedGroupByStore';
		this.columns = [{
			xtype: 'rownumberer',
			width: 30,
			sortable: false
		},{
			text: 'EVIEWGROUPBYCODE',
			dataIndex: 'EVIEWGROUPBYCODE',
			hidden: true,
			flex: 1
		},{
			text: 'EQRYCODEFK',
			dataIndex: 'EQRYCODEFK',
			hidden: true,
			flex: 1
		},{
			text: 'COLUMNORDER',
			dataIndex: 'COLUMNORDER',
			hidden: true,
			flex: 1
		},{
			text: 'PRIORITYNO',
			dataIndex: 'PRIORITYNO',
			hidden: true,
			flex: 1
		},{
			text: '-',
			dataIndex: 'GROUPBYCOLUMN',
			filterable: true,
			editor: 'textfield',
			sortable: true,
			flex: 1
		}],
		this.callParent(arguments);
	}
});