Ext.define('Form.model.query.selectedOrderByModel', {
	extend: 'Ext.data.Model',
	fields: [
		'EVIEWORDERBYCODE',
		'EQRYCODEFK',
		{
			name: 'PRIORITYNO',
			type: 'int'
		},
		'FIELDNAME',
		'DISPLAY',
		'ASCORDESC',
		'COLUMNORDER'
		
	]
})