Ext.define('Form.store.recruitment.setting.tatstore', {
	extend: 'Ext.data.Store',
	model: 'Form.model.recruitment.setting.tatmodel',
	autoLoad: true,
	proxy: {
			type: 'direct',
			timeout: 300000,
			directFn: 'Ext.ss.setting.getmaxtat',
			reader: {
	            root: 'topics',
	            totalProperty: 'totalCount'
	        }
		}
});
