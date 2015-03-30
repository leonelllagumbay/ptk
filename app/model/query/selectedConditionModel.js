Ext.define('Form.model.query.selectedConditionModel', {
	extend: 'Ext.data.Model',
	fields: [
		'EVIEWCONDITIONCODE',
		'EQRYCODEFK',
		{
			name: 'PRIORITYNO',
			type: 'int'
		},
		'CONJUNCTIVEOPERATOR',
		'ONCOLUMN',
		'CONDITIONOPERATOR',
		'COLUMNVALUE',
		'DISPLAY',
		'COLUMNORDER'
	]
})