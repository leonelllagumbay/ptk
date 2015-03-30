Ext.define('Form.model.query.selectedTableModel', {
	extend: 'Ext.data.Model',
	fields: [
		'EVIEWTABLECODE',
		'DATASOURCECODEFK',
		'EQRYCODEFK',
		'TABLENAME',
		'TABLEALIAS',
		'DATASOURCE',
		'TEMPTABLE',
		'TABLE_TYPE',
		'REMARKS',
		'COLUMNORDER'
	]
})