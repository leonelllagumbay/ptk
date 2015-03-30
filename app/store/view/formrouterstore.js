Ext.define('Form.store.view.formrouterstore', {
	extend: 'Ext.data.Store',
	storeId: 'data',
	model: 'Form.model.view.formroutermodel',
	remoteFilter: true,
	remoteSort: true,
	simpleSortMode: true,
	sorters: [{
            property: 'ROUTERORDER',
            direction: 'ASC'
    }],
	filters: [{
			type: 'string',
            dataIndex: 'ROUTERNAME'  
	}],
	pageSize: 25,
	autoSave: true,
	autoLoad: true,
	autoSync: true,
	
	
	constructor : function(config) {  
		
    Ext.applyIf(config, {
        proxy: {
			type: 'direct',
			timeout: 300000,
			extraParams: {
				processid: '__'
			},
			paramOrder: ['page', 'start', 'limit', 'sort', 'filter', 'processid'],
			api: {
		        read:    Ext.aa.formrouter.ReadNow,
		        create:  Ext.aa.formrouter.ReadNow,
		        update:  Ext.aa.formrouter.UpdateNow,
		        destroy: Ext.aa.formrouter.DestroyNow
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
	console.log("router store");
}
	
});





