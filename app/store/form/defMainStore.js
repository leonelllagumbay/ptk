Ext.define('Form.store.form.defMainStore', {
	extend: 'Ext.data.Store',
	model: 'Form.model.form.defMainModel',
	storeId: 'defMainStore',
	remoteFilter: true,
	remoteSort: true,
	simpleSortMode: true,
	sorters: [{
            property: 'DATELASTUPDATE',
            direction: 'DESC'
    }],
	filters: [{
			type: 'string',
            dataIndex: 'EFORMNAME'  
	}],
	pageSize: 30,
	autoSave: true,
	autoLoad: true,
	autoSync: true,
	
	constructor : function(config) {
		
    Ext.applyIf(config, {
        proxy: {
			type: 'direct',
			timeout: 300000,
			paramOrder: ['page', 'start', 'limit', 'sort', 'filter'],
			api: {
		        read:    Ext.ss.defdata.ReadNow,
		        create:  Ext.ss.defdata.CreateNow,  
		        update:  Ext.ss.defdata.UpdateNow,
		        destroy: Ext.ss.defdata.DestroyNow
		    },
			paramsAsHash: false,
			filterParam: 'filter',
			sortParam: 'sort',
			limitParam: 'limit',
			idParam: 'ID',
			pageParam: 'page',
			reader: {
	            root: 'topics',
	            totalProperty: 'totalCount'
	        }
		}
    });

    this.callParent([config]);
}
	
	
});