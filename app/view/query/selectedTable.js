
Ext.define('Form.view.query.selectedTable', {
	extend: 'Ext.grid.Panel',
	alias: 'widget.selectedtable',
	multiSelect: true,
	width: 410,
	height: 265,
	hideHeaders: true,
	viewConfig: {
        plugins: {
            ptype: 'gridviewdragdrop',
            dragText: 'Drag and drop to reorganize',
            ddGroup: 'ddtable',
            containerScroll: true
        }
    }, 
	initComponent: function() {
		this.plugins = [
			Ext.create('Ext.grid.plugin.CellEditing', {
			    clicksToEdit: 2
    	    })
		];
		this.store = 'query.selectedTableStore';
		this.columns = [{
			xtype: 'rownumberer',
			width: 40,
			sortable: false
		},{
			text: 'EVIEWTABLECODE',
			dataIndex: 'EVIEWTABLECODE',
			hidden: true,
			flex: 1
		},{
			text: 'COLUMNORDER',
			dataIndex: 'COLUMNORDER',
			hidden: true,
			flex: 1
		},{
			text: 'DATASOURCECODEFK',
			dataIndex: 'DATASOURCECODEFK',
			hidden: true,
			flex: 1
		},{
			text: 'EQRYCODEFK',
			dataIndex: 'EQRYCODEFK',
			hidden: true,
			flex: 1
		},{
			text: 'TABLENAME',
			dataIndex: 'TABLENAME',
			hidden: true,
			flex: 3
		},{
			text: 'TEMPTABLE',
			dataIndex: 'TEMPTABLE',
			editable: false,
			flex: 5
		},{
			text: 'TABLEALIAS',
			dataIndex: 'TABLEALIAS',
			editable: false,
			flex: 3
		},{
			text: 'DATASOURCE',
			dataIndex: 'DATASOURCE',
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