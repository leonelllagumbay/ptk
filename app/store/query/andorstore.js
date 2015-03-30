Ext.define('Form.store.query.andorstore', {
	extend: 'Ext.data.Store',
	model: 'Form.model.query.andormodel',
	data: [{
		andorname: 'AND',
		andorcode: 'AND'
	},{
		andorname: 'OR',
		andorcode: 'OR'
	},{
		andorname: '(Empty)',
		andorcode: ' '
	}]	
});
