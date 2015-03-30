Ext.define('Form.store.view.conditionstore', {
	extend: 'Ext.data.Store',
	model: 'Form.model.view.conditionmodel',
	autoLoad: false,
	constructor: function(config){
		Ext.applyIf(config, {
			proxy: {
					type: 'direct',
					timeout: 300000,
					directFn: 'Ext.aa.lookup.getConditions',
					reader: {
			            root: 'topics',
			            totalProperty: 'totalCount'
			        }
				}
		});
		this.callParent([config]);
	}
});
