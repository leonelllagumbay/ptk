Ext.define('Form.store.recruitment.screeningandreservation.positionstore', {
	extend: 'Ext.data.Store',
	model: 'Form.model.recruitment.screeningandreservation.positionmodel',
	autoLoad: false,
	proxy: {
			type: 'direct',
			timeout: 300000,
			directFn: 'Ext.ss.lookup.getPosition',
			paramOrder: ['limit', 'page', 'query', 'start'],
			reader: {
	            root: 'topics',
	            totalProperty: 'totalCount'
	        }
		}
});
