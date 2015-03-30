Ext.define('Form.store.view.rolestore', {
	extend: 'Ext.data.Store',
	model: 'Form.model.view.rolemodel',
	autoLoad: false,
	constructor: function(config){
		Ext.applyIf(config, {
			proxy: {
				type: 'direct',
				timeout: 300000,
				directFn: 'Ext.aa.lookup.getRole',
				reader: {
					root: 'topics',
					totalProperty: 'totalCount'
				}
			}
		});
		this.callParent([config]);
	}
});
