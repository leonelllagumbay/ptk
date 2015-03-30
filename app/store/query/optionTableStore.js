Ext.define('Form.store.query.optionTableStore', {
	extend: 'Ext.data.Store',
	model: 'Form.model.query.optionTableModel',
	storeId: 'optiontablestorestore',
	remoteFilter: true,
	remoteSort: true,
	simpleSortMode: true,
	autoLoad: true,
	sorters: [{
            property: 'TABLENAME',
            direction: 'ASC'
    }],
	filters: [{
			type: 'string',
            dataIndex: 'TABLENAME'
	}],
	pageSize: 50,
	constructor : function(config) {
		
	    Ext.applyIf(config, {
	        proxy: {
				type: 'direct',
				timeout: 300000,
				extraParams: {
					dSource: '_',
					dFilter: [{
						value: ''
					}]
				},
				paramOrder: ['page', 'start', 'limit', 'sort', 'filter', 'dSource', 'dFilter'],
				api: {
			        read:    Ext.ss.SourceOption.getTables
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