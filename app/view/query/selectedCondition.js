
Ext.define('Form.view.query.selectedCondition', {
	extend: 'Ext.grid.Panel',
	alias: 'widget.selectedcondition',
	multiSelect: true,
	width: 410,
	height: 215,
	hideHeaders: true,
	initComponent: function() {
		this.buttonAlign = 'left',
		this.buttons = [{
			text: 'Modify Condition',
			action: 'modifycondition'
		}];
		this.store = 'query.selectedConditionStore';
		this.columns = [{
			text: 'EVIEWCONDITIONCODE',
			dataIndex: 'EVIEWCONDITIONCODE',
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
			text: 'DISPLAY',
			dataIndex: 'DISPLAY',
			flex: 1
		},{
			text: 'PRIORITYNO',
			dataIndex: 'PRIORITYNO',
			hidden: true,
			flex: 1
		},{
			text: 'CONJUNCTIVEOPERATOR',
			dataIndex: 'CONJUNCTIVEOPERATOR',
			hidden: true,
			flex: 1
		},{
			text: 'ONCOLUMN',
			dataIndex: 'ONCOLUMN',
			hidden: true,
			flex: 1
		},{
			text: 'CONDITIONOPERATOR',
			dataIndex: 'CONDITIONOPERATOR',
			hidden: true,
			flex: 1
		},{
			text: 'COLUMNVALUE',
			dataIndex: 'COLUMNVALUE',
			hidden: true,
			flex: 1
		}],
		this.callParent(arguments);
	}
});