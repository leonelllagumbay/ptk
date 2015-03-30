Ext.define('Form.store.view.groupstore', {
	extend: 'Ext.data.Store',
	model: 'Form.model.view.groupmodel',
	autoLoad: false,
	constructor: function(config){
		Ext.applyIf(config, {
			proxy: {
				type: 'direct',
				timeout: 300000,
				directFn: 'Ext.aa.lookup.getProcessGroup',
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
