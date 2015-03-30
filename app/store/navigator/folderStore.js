Ext.define('Form.store.navigator.folderStore', {
	extend: 'Ext.data.Store',
	//model: 'Form.model.navigator.folderModel',
	proxy: {
		type: 'ajax',
		url: 'data/main/maintree.cfm'
	}
	
});
