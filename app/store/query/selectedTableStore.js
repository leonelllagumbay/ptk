Ext.define('Form.store.query.selectedTableStore', {
	extend: 'Ext.data.Store',
	model: 'Form.model.query.selectedTableModel',
	storeId: 'seltablestorestore',
	remoteFilter: true,
	remoteSort: true,
	simpleSortMode: true,
	autoLoad: false,
	sorters: [{
            property: 'TABLENAME',
            direction: 'ASC'
    }],
	filters: [{
			type: 'string',
            dataIndex: 'TABLENAME'  
	}],
	pageSize: 20,
	
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
			        read:    Ext.ss.SelectedSource.getSelectedTable
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