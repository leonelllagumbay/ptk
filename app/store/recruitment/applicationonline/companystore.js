Ext.define('OnlineApplication.store.recruitment.applicationonline.companystore', {
	extend: 'Ext.data.Store',
	model: 'OnlineApplication.model.recruitment.applicationonline.companymodel',
	autoLoad: true,	
	proxy: {
				type: 'direct',
				directFn: 'Ext.ss.lookup.getCompany',
				reader: {
					root: 'topics',
					totalProperty: 'totalCount'
				}
			}
   
});
