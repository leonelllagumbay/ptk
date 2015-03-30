Ext.define('Form.store.recruitment.mrfstatus.store', {
	extend: 'Ext.data.Store',
	storeId: 'data',
	model: 'Form.model.recruitment.mrfstatus.model',
	remoteFilter: true,
	remoteSort: true,
	simpleSortMode: true,
	sorters: [{
            property: 'A_APPLICATIONDATE',
            direction: 'DESC'
    }],
	filters: [{
			type: 'string',
            dataIndex: 'G_REQUISITIONNO' 
	}],
	pageSize: 27,
	autoSave: false,
	autoLoad: true,
	autoSync: false,
	
	constructor : function(config) {
		
    Ext.applyIf(config, {
        proxy: {
			type: 'direct',
			timeout: 300000,
			extraParams: {
				departmentcode: '__'
			},
			paramOrder: ['page', 'start', 'limit', 'sort', 'filter', 'departmentcode'],
			api: {
		        read: Ext.ss.data.GetAll
		        //create: Ext.ss.data.GetAll,
		        //update: Ext.ss.data.GetAll,
		        //destroy: null,
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





