Ext.define('Form.store.query.aggColumnStore', {
	extend: 'Ext.data.Store',
	model: 'Form.model.query.aggColumnModel',
	data: [{
		aggcolumnname: '',
		aggcolumncode: ''
	}]	
});
