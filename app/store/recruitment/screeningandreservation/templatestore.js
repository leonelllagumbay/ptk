Ext.define('Form.store.recruitment.screeningandreservation.templatestore', {
	extend: 'Ext.data.Store',
	model: 'Form.model.recruitment.screeningandreservation.templatemodel',
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
