Ext.define('Form.store.recruitment.screeningandreservation.departmentstore', {
	extend: 'Ext.data.Store',
	model: 'Form.model.recruitment.screeningandreservation.departmentmodel',
	autoLoad: true,
	proxy: {
			type: 'direct',
			directFn: 'Ext.ss.lookup.getDepartments',
			reader: {
	            root: 'topics',
	            totalProperty: 'totalCount'
	        }
		}
});
