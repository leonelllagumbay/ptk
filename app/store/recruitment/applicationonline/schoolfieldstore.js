Ext.define('OnlineApplication.store.recruitment.applicationonline.schoolfieldstore', {
	extend: 'Ext.data.Store',
	model: 'OnlineApplication.model.recruitment.applicationonline.schoolfieldmodel',
	autoLoad: false,
	proxy: {
			type: 'direct',
			directFn: 'Ext.ss.lookup.getField',
			reader: {
	            root: 'topics',
	            totalProperty: 'totalCount'
	        }
		}
});
