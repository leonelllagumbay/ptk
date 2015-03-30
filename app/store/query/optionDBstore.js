Ext.define('Form.store.query.optionDBstore', {
	extend: 'Ext.data.Store',
	model: 'Form.model.query.optionDBmodel',
	storeId: 'optiondbstorestore',
	remoteFilter: true,
	remoteSort: true,
	simpleSortMode: true,
	autoLoad: true,
	sorters: [{
            property: 'DATASOURCENAME',
            direction: 'ASC'
    }],
	filters: [{
			type: 'string',
            dataIndex: 'DATASOURCENAME'  
	}],
	pageSize: 10,
	
	constructor : function(config) {
		
	    Ext.applyIf(config, {
	        proxy: {
				type: 'direct',
				timeout: 300000,
				paramOrder: ['page', 'start', 'limit', 'sort', 'filter'],
				api: {
			        read:    Ext.ss.SourceOption.getDatasource
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