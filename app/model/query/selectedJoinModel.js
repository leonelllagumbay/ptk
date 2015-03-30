Ext.define('Form.model.query.selectedJoinModel', {
	extend: 'Ext.data.Model',
	fields: [
		'EVIEWJOINEDTABLECODE',
		'EQRYCODEFK',
		'JOINOPERATOR',
		'PRIORITYNO',
		'TABLENAME',
		'ONCOLUMN',
		'EQUALTOCOLUMN',
		'DISPLAY',
		'COLUMNORDER'
	]
})