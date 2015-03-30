Ext.define('Form.store.view.namestore', {
	extend: 'Ext.data.Store',
	model: 'Form.model.view.namemodel',
	autoLoad: false,
	constructor: function(config){
		Ext.applyIf(config, {
			proxy: {
				type: 'direct',
				timeout: 300000,
				directFn: 'Ext.aa.lookup.getName',
				reader: {
					root: 'topics',
					totalProperty: 'totalCount'
				}
			}
		});
		this.callParent([config]);
	}
});
