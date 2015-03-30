Ext.define('Form.store.recruitment.jobposting.departmentstore', {
	extend: 'Ext.data.Store',
	model: 'Form.model.recruitment.jobposting.departmentmodel',
	autoLoad: false,
	proxy: {
			type: 'direct',
			timeout: 300000,
			directFn: 'Ext.jp.lookup.getDepartments',
			paramOrder: ['limit', 'page', 'query', 'start'],
			reader: {
	            root: 'topics',
	            totalProperty: 'totalCount'
	        }
		}
});
