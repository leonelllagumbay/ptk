Ext.define('OnlineApplication.store.recruitment.applicationonline.govexamstore', {
	extend: 'Ext.data.Store',
	model: 'OnlineApplication.model.recruitment.applicationonline.govexammodel',
	autoLoad: true,
	proxy: {
			type: 'direct',
			directFn: 'Ext.ss.lookup.getGovexam',
			reader: {
	            root: 'topics',
	            totalProperty: 'totalCount'
	        }
		}
});
