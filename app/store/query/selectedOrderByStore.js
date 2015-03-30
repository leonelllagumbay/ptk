Ext.define('Form.store.query.selectedOrderByStore', {
	extend: 'Ext.data.Store',
	model: 'Form.model.query.selectedOrderByModel',
	storeId: 'selorderbystore',
	remoteFilter: true,
	remoteSort: true,
	simpleSortMode: true,
	autoLoad: false,
	sorters: [{
            property: 'FIELDNAME',
            direction: 'ASC'
    }],
	filters: [{
			type: 'string',
            dataIndex: 'FIELDNAME'  
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
				paramOrder: ['page', 'start', 'limit', 'sort', 'filter','querycode'],
				api: {
			        read:    Ext.ss.SelectedSource.getSelectedOrderBy
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