
Ext.define('Form.view.query.selectedJoin', {
	extend: 'Ext.grid.Panel',
	alias: 'widget.selectedjoin',
	multiSelect: true,
	width: 410,
	height: 165,
	hideHeaders: true,
	initComponent: function() {
		this.buttonAlign = 'left',
		this.buttons = [{
			text: 'Modify Join Operator',
			action: 'addjoinoperator'
		}];
		this.plugins = [
			Ext.create('Ext.grid.plugin.CellEditing', {
			    clicksToEdit: 2
    	    })
		];
		this.store = 'query.selectedJoinStore';
		this.columns = [{
			text: 'EVIEWJOINEDTABLECODE',
			dataIndex: 'EVIEWJOINEDTABLECODE',
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
			text: 'JOINOPERATOR',
			dataIndex: 'JOINOPERATOR',
			hidden: true,
			flex: 1
		},{
			text: 'PRIORITYNO',
			dataIndex: 'PRIORITYNO',
			hidden: true,
			flex: 1
		},{
			text: 'TABLENAME',
			dataIndex: 'TABLENAME',
			hidden: true,
			flex: 1
		},{
			text: 'ONCOLUMN',
			dataIndex: 'ONCOLUMN',
			hidden: true,
			flex: 1
		},{
			text: 'EQUALTOCOLUMN',
			dataIndex: 'EQUALTOCOLUMN',
			hidden: true,
			flex: 1
		},{
			text: 'DISPLAY',
			dataIndex: 'DISPLAY',
			editable: false,
			flex: 1
		}],
		this.callParent(arguments);
	}
});