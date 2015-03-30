Ext.define('Form.store.query.yesno', {
	extend: 'Ext.data.Store',
	fields: ['yesnoname','yesnocode'],
	data: [{
		yesnoname: 'True',
		yesnocode: 'true'
	},{
		yesnoname: 'False',
		yesnocode: 'false'
	}]	
});
