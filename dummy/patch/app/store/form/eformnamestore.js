Ext.define('Form.store.form.eformnamestore', {
	extend: 'Ext.data.Store',
	model: 'Form.model.form.eformnamemodel',
	autoLoad: false, 
	constructor: function(config){ 
		Ext.applyIf(config, {
			proxy: {
				type: 'direct',
				timeout: 300000,
				directFn: 'Ext.ss.lookup.geteFormName',
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
