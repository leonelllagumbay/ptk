Ext.define('Form.store.form.eformUserMainStore', {
	extend: 'Ext.data.Store',
	model: 'Form.model.form.eformUserMainModel',
	storeId: 'mainMainStoreaa',
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
	autoLoad: true,
	
	constructor : function(config) {
		
    Ext.applyIf(config, {
        proxy: {
			type: 'direct',
			timeout: 300000,
			paramOrder: ['page', 'start', 'limit', 'sort', 'filter'],
			api: {
		        read:    Ext.ss.data.ReadNow,
		        create:  Ext.ss.data.ReadNow,  
		        update:  Ext.ss.data.ReadNow,
		        destroy: Ext.ss.data.ReadNow  
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