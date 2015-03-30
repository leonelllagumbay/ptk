Ext.define('OnlineApplication.store.recruitment.applicationonline.citizenshipstore', {
	extend: 'Ext.data.Store',
	model: 'OnlineApplication.model.recruitment.applicationonline.citizenshipmodel',
	autoLoad: true,
	proxy: {
			type: 'direct',
			directFn: 'Ext.ss.lookup.getCitizenship',
			reader: {
	            root: 'topics',
	            totalProperty: 'totalCount'
	        }
		}
});
