Ext.define('OnlineApplication.store.recruitment.applicationonline.schoolcoursestore', {
	extend: 'Ext.data.Store',
	model: 'OnlineApplication.model.recruitment.applicationonline.schoolcoursemodel',
	autoLoad: false,
	proxy: {
			type: 'direct',
			directFn: 'Ext.ss.lookup.getCourse',
			reader: {
	            root: 'topics',
	            totalProperty: 'totalCount'
	        }
		}
});
