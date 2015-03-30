
Ext.define('Form.view.query.selectedDatasource', {
	extend: 'Ext.grid.Panel',
	alias: 'widget.selecteddatasource',
	multiSelect: true,
	width: 410,
	height: 165,
	hideHeaders: true,
	viewConfig: {
        plugins: {
            ptype: 'gridviewdragdrop',
            dragText: 'Drag and drop to reorganize',
            ddGroup: 'thiscontainer',
            containerScroll: true
        }
    }, 
	initComponent: function() {
		
		this.store = 'query.selectedDBstore';
		this.columns = [{
			xtype: 'rownumberer',
			width: 30,
			sortable: false
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
		},{
			text: '-',
			dataIndex: 'DATASOURCENAME',
			flex: 1
		},{
			text: 'Type',
			dataIndex: 'DATASOURCETYPE',
			hidden: true
		}],
		this.callParent(arguments);
	}
});