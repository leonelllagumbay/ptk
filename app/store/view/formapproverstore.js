Ext.define('Form.store.view.formapproverstore', {
	extend: 'Ext.data.Store',
	storeId: 'data',
	model: 'Form.model.view.formapprovermodel',
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
				processid: '__',
				routerid: '__'
			},
			paramOrder: ['page', 'start', 'limit', 'sort', 'filter', 'processid', 'routerid' ],
			api: {
		        read:    Ext.aa.approver.ReadNow,
		        create:  Ext.aa.approver.ReadNow,  
		        update:  Ext.aa.approver.UpdateNow,
		        destroy: Ext.aa.approver.DestroyNow
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





