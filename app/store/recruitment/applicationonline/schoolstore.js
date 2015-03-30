Ext.define('OnlineApplication.store.recruitment.applicationonline.schoolstore', {
	extend: 'Ext.data.Store',
	model: 'OnlineApplication.model.recruitment.applicationonline.schoolmodel',
	autoLoad: false,
	proxy: {
			type: 'direct',
			directFn: 'Ext.ss.lookup.getSchool',
			reader: {
	            root: 'topics',
	            totalProperty: 'totalCount'
	        }
		}
});
