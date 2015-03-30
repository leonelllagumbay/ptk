Ext.define('Form.store.recruitment.mrfstatus.templatestore', {
	extend: 'Ext.data.Store',
	model: 'Form.model.recruitment.mrfstatus.templatemodel',
	proxy: {
		type: 'direct',
		type: 'direct',
			directFn: 'Ext.ss.lookup.getEmailTemplate',
			reader: {
	            root: 'topics',
	            totalProperty: 'totalCount'
	        }
	},
	autoLoad: true
});
