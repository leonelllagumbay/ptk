Ext.define('cfbose.store.mainstore', {
	extend: 'Ext.data.Store',
	model: 'cfbose.model.mainmodel',
	autoLoad: true,
	
	proxy: {
		type: 'ajax',
		api: {
			cread: 'data/create.json',
			read: 'data/test.json',
			update: 'data/updateUsers.json',
			destroy: 'data/destroy.json'
		},
		reader: {
			type: 'json',
			root: 'test',
			successProperty: 'success'
		}
	}
	
});
