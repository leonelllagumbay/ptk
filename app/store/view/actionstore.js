Ext.define('Form.store.view.actionstore', {
	extend: 'Ext.data.Store',
	model: 'Form.model.view.actionmodel',
	autoLoad: false,
	proxy: {
			type: 'direct',
			timeout: 300000,
			directFn: 'Ext.aa.lookup.getActionWExpired',
			reader: {
	            root: 'topics',
	            totalProperty: 'totalCount'
	        }
		}
});
