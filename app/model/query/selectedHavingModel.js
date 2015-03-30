Ext.define('Form.model.query.selectedHavingModel', {
	extend: 'Ext.data.Model',
	fields: [
		{
			name: 'PRIORITYNO',
			type: 'int'
		},
		'EVIEWHAVINGCODE',
		'EQRYCODEFK',
		'CONJUNCTIVEOPERATOR',
		'AGGREGATECOLUMN',
		'CONDITIONOPERATOR',
		'AGGREGATEVALUE',
		'DISPLAY',
		'COLUMNORDER'
	]
})