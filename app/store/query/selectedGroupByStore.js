Ext.define('Form.store.query.selectedGroupByStore', {
	extend: 'Ext.data.Store',
	model: 'Form.model.query.selectedGroupByModel',
	storeId: 'selgroupbystore',
	remoteFilter: true,
	remoteSort: true,
	simpleSortMode: true,
	autoLoad: false,
	sorters: [{
            property: 'PRIORITYNO',
            direction: 'DESC'
    }],
	filters: [{
			type: 'string',
            dataIndex: 'GROUPBYCOLUMN'  
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
			        read:    Ext.ss.SelectedSource.getGroupBy
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