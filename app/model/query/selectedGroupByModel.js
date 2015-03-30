Ext.define('Form.model.query.selectedGroupByModel', {
	extend: 'Ext.data.Model',
	fields: [
	    'EVIEWGROUPBYCODE',
	    'EQRYCODEFK',
	    'GROUPBYCOLUMN',
		{
			name: 'PRIORITYNO',
			type: 'int'
		},
		'COLUMNORDER'
	]
})