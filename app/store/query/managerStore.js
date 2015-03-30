Ext.define('Form.store.query.managerStore', {
	extend: 'Ext.data.Store',
	model: 'Form.model.query.managerModel',
	remoteFilter: true,
	remoteSort: true,
	simpleSortMode: true,
	sorters: [{
            property: 'RECDATECREATED',
            direction: 'DESC'
    }],
	filters: [{
			type: 'string',
            dataIndex: 'EQRYNAME'  
	}],
	pageSize: 50,
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
		        read:    Ext.ss.QueryManager.ReadNow,
		        create:  Ext.ss.QueryManager.CreateNow,  
		        update:  Ext.ss.QueryManager.UpdateNow,
		        destroy: Ext.ss.QueryManager.DestroyNow
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