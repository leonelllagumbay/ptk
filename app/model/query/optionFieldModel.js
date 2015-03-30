Ext.define('Form.model.query.optionFieldModel', {
	extend: 'Ext.data.Model',
	fields: [
	 		'EVIEWFIELDCODE',
	 		'EQRYCODEFK',
	 		'TABLENAME',
	 		'FIELDNAME',
	 		'FIELDALIAS',
	 		{
	 			name: 'PRIORITYNO',
	 			type: 'int'
	 		},
	 		'AGGREGATEFUNC',
	 		'DATEANDSTRINGFUNC',
	 		'NUMBERFORMAT',
	 		'ISDISTINCT',
	 		'WRAPON',
	 		'SUPPRESSZERO',
	 		'OVERRIDESTATEMENT',
	 		'DISPLAY',
	 		'IS_PRIMARYKEY',
	 		'ORDINAL_POSITION',
	 		'TYPE_NAME',
	 		'DECIMAL_DIGITS',
	 		'IS_NULLABLE',
	 		'COLUMN_DEFAULT_VALUE',
	 		'CHAR_OCTET_LENGTH',
	 		'IS_FOREIGNKEY',
	 		'REFERENCED_PRIMARYKEY',
	 		'REFERENCED_PRIMARYKEY_TABLE',
	 		'COLUMNORDER'
	 	]
})