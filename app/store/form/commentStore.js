Ext.define('Form.store.form.commentStore', {
	extend: 'Ext.data.Store',
	model: 'Form.model.form.commentModel',
	autoLoad: false,
	
	constructor: function(config){
		Ext.applyIf(config, {
			proxy: {
				type: 'direct',  
				timeout: 300000,
				directFn: 'Ext.ss.lookup.getComment',
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
