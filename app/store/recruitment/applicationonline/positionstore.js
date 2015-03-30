Ext.define('OnlineApplication.store.recruitment.applicationonline.positionstore', {
	extend: 'Ext.data.Store',
	model: 'OnlineApplication.model.recruitment.applicationonline.positionmodel',
	autoLoad: true,
	proxy: {
			type: 'direct',
			directFn: 'Ext.ss.lookup.getPosition',
			reader: {
	            root: 'topics',
	            totalProperty: 'totalCount'
	        }
		}
});
