Ext.define('Form.store.form.afterloadstore', {
	extend: 'Ext.data.Store',
	model: 'Form.model.form.filemodel',
	autoLoad: false,
	constructor: function(config){
		Ext.applyIf(config, {
			proxy: {
				type: 'direct',
				timeout: 300000,
				directFn: 'Ext.ss.lookup.getafterload',
				paramOrder: ['limit', 'page', 'query', 'start'],
				reader: {
					root: 'topics',
					totalProperty: 'totalCount'
				}
			}
		});
		this.callParent([config]);
	}
});
