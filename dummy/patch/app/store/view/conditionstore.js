Ext.define('View.store.view.conditionstore', {
	extend: 'Ext.data.Store',
	model: 'View.model.view.conditionmodel',
	autoLoad: false,
	constructor: function(config){
		Ext.applyIf(config, {
			proxy: {
					type: 'direct',
					timeout: 300000,
					directFn: 'Ext.ss.lookup.getConditions',
					reader: {
			            root: 'topics',
			            totalProperty: 'totalCount'
			        }
				}
		});
		this.callParent([config]);
	}
});
