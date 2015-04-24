Ext.define('View.store.view.formapproverstore', {
	extend: 'Ext.data.Store',
	storeId: 'data',
	model: 'View.model.view.formapprovermodel',
	remoteFilter: true,
	remoteSort: true,
	simpleSortMode: true,
	sorters: [{
            property: 'APPROVERORDER',
            direction: 'ASC'
    }],
	filters: [{
			type: 'string',
            dataIndex: 'APPROVERNAME'  
	}],
	pageSize: 23,
	autoSave: true,
	autoLoad: true,
	autoSync: true,
	
	constructor : function(config) {
		
    Ext.applyIf(config, {
        proxy: {
			type: 'direct',
			timeout: 300000,
			extraParams: {
				processid: '__',
				routerid: '__'
			},
			paramOrder: ['page', 'start', 'limit', 'sort', 'filter', 'processid', 'routerid' ],
			api: {
		        read:    Ext.ss.approver.ReadNow,
		        create:  Ext.ss.approver.ReadNow,  
		        update:  Ext.ss.approver.UpdateNow,
		        destroy: Ext.ss.approver.DestroyNow
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





