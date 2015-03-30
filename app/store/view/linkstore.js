Ext.define('Form.store.view.linkstore', {
	extend: 'Ext.data.Store',
	model: 'Form.model.view.linkmodel',
	autoLoad: false,
	constructor: function(config){
		Ext.applyIf(config, {
			proxy: {
					type: 'direct',
					timeout: 300000,
					directFn: 'Ext.aa.lookup.getLinkApproversBy',
					reader: {
			            root: 'topics',
			            totalProperty: 'totalCount'
			        }
				}
		});
		this.callParent([config]);
	}
});
