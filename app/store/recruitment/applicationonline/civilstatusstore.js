Ext.define('OnlineApplication.store.recruitment.applicationonline.civilstatusstore', {
	extend: 'Ext.data.Store',
	model: 'OnlineApplication.model.recruitment.applicationonline.civilstatusmodel',
	autoLoad: true,
	proxy: {
			type: 'direct',
			directFn: 'Ext.ss.lookup.getCivilstatus',
			reader: {
	            root: 'topics',
	            totalProperty: 'totalCount'
	        }
		}
});
