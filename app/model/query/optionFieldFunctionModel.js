Ext.define('Form.model.query.optionFieldFunctionModel', {
	extend: 'Ext.data.Model',
	fields: [
		'SQLCODE',
		'DBMSNAME',
		'PRODUCTVERSION',
		'FUNCTIONNAME',
		'SYNTAX',
		'DEFINITION',
		{
			name: 'TOTALNOOFARGS',
			type: 'int'
		},
		{
			name: 'REQUIREDNOOFARGS',
			type: 'int'
		},
		'CATEGORY',
		'DEFAULTTYPE'
	]
})