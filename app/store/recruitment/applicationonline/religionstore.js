Ext.define('OnlineApplication.store.recruitment.applicationonline.religionstore', {
	extend: 'Ext.data.Store',
	model: 'OnlineApplication.model.recruitment.applicationonline.religionmodel',
	autoLoad: true,
	proxy: {
			type: 'direct',
			directFn: 'Ext.ss.lookup.getReligion',
			reader: {
	            root: 'topics',
	            totalProperty: 'totalCount'
	        }
		}
});
