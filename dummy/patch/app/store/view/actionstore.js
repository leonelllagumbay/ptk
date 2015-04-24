Ext.define('View.store.view.actionstore', {
	extend: 'Ext.data.Store',
	model: 'View.model.view.actionmodel',
	autoLoad: false,
	proxy: {
			type: 'direct',
			timeout: 300000,
			directFn: 'Ext.ss.lookup.getActionWExpired',
			reader: {
	            root: 'topics',
	            totalProperty: 'totalCount'
	        }
		}
});
