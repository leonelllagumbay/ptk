Ext.define('Form.store.form.rolestore', {
	extend: 'Ext.data.Store',
	model: 'Form.model.form.rolemodel',
	autoLoad: false,
	constructor: function(config){
		Ext.applyIf(config, {
			proxy: {
				type: 'direct',
				timeout: 300000,
				directFn: 'Ext.ss.lookup.getRole',
				reader: {
					root: 'topics',
					totalProperty: 'totalCount'
				}
			}
		});
		this.callParent([config]);
	}
});
