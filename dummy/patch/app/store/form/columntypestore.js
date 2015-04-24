Ext.define('Form.store.form.columntypestore', {
	extend: 'Ext.data.Store',
	model: 'Form.model.form.columntypemodel',
	data: [{
		columntypename: 'String',
		columntypecode: 'string'
	},{
		columntypename: 'Integer',
		columntypecode: 'int'
	},{
		columntypename: 'Float',
		columntypecode: 'float'
	},{
		columntypename: 'Date',
		columntypecode: 'date'
	},{
		columntypename: 'Boolean',
		columntypecode: 'boolean'
	},{
		columntypename: 'Auto (no conversion)', 
		columntypecode: 'auto' 
	}]	
});
