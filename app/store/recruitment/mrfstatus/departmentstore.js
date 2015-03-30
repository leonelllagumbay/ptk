Ext.define('Form.store.recruitment.mrfstatus.departmentstore', {
	extend: 'Ext.data.Store',
	model: 'Form.model.recruitment.mrfstatus.departmentmodel',
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
