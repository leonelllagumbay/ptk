Ext.define('View.store.view.linkstore', {
	extend: 'Ext.data.Store',
	model: 'View.model.view.linkmodel',
	autoLoad: false,
	constructor: function(config){
		Ext.applyIf(config, {
			proxy: {
					type: 'direct',
					timeout: 300000,
					directFn: 'Ext.ss.lookup.getLinkApproversBy',
					reader: {
			            root: 'topics',
			            totalProperty: 'totalCount'
			        }
				}
		});
		this.callParent([config]);
	}
});
