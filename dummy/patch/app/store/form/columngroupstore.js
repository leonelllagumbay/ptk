Ext.define('Form.store.form.columngroupstore', {
	extend: 'Ext.data.Store',
	model: 'Form.model.form.columngroupmodel',
	autoLoad: false,
	constructor: function(config){
		Ext.applyIf(config, {
			proxy: {
				type: 'direct',
				timeout: 300000,
				directFn: 'Ext.ss.lookup.getColumnGroup',
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
