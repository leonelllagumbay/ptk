Ext.define('Form.store.query.selectedHavingStore', {
	extend: 'Ext.data.Store',
	model: 'Form.model.query.selectedHavingModel',
	storeId: 'selhavingstorestore',
	remoteFilter: true,
	remoteSort: true,
	simpleSortMode: true,
	autoLoad: false,
	sorters: [{
            property: 'AGGREGATECOLUMN',
            direction: 'ASC'
    }],
	filters: [{
			type: 'string',
            dataIndex: 'AGGREGATECOLUMN'  
	}],
	pageSize: 10,
	
	constructor : function(config) {
		
	    Ext.applyIf(config, {
	        proxy: {
				type: 'direct',
				timeout: 300000,
				extraParams: {
					querycode: '_',
				},
				paramOrder: ['page', 'start', 'limit', 'sort', 'filter', 'querycode'],
				api: {
			        read:    Ext.ss.SelectedSource.getGroupByHaving
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