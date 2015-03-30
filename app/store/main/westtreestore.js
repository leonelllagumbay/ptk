Ext.define('Form.store.main.westtreestore', {
	extend: 'Ext.data.TreeStore',
	proxy: {
		type: 'ajax',
		url: 'data/main/maintree.cfm'
	}
	
	
});

