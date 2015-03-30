Ext.define('Form.store.recruitment.jobposting.store', {
	extend: 'Ext.data.Store',
	storeId: 'data',
	model: 'Form.model.recruitment.jobposting.model',
	remoteFilter: true,
	remoteSort: true,
	simpleSortMode: true,
	sorters: [{
            property: 'DATELASTUPDATE',
            direction: 'DESC'
    }],
	filters: [{
			type: 'date',
            dataIndex: 'DATELASTUPDATE' 
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
			extraParams: {
				departmentcode: '__'
			},
			paramOrder: ['page', 'start', 'limit', 'sort', 'filter', 'departmentcode'],
			api: {
		        read: Ext.jp.data.GetAll,
		        create: Ext.jp.data.GetAll,
		        update: Ext.jp.data.updatenow,
		        destroy: Ext.jp.data.GetAll
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





