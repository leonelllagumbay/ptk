Ext.define('Form.store.query.queryDefinitionColumnListStore', {
	extend: 'Ext.data.Store',
	model: 'Form.model.query.optionFieldModel',
	remoteFilter: true,
	remoteSort: true,
	simpleSortMode: true,
	sorters: [{
            property: 'COLUMNORDER',
            direction: 'ASC'
    }],
	filters: [{
			type: 'string',
            dataIndex: 'TABLENAME'  
	}],
	pageSize: 50,
	autoLoad: false,
	
	constructor : function(config) {
		
	    Ext.applyIf(config, {
	        proxy: {
				type: 'direct',
				extraParams: {
					querycodefk: '-'
				},
				timeout: 300000,
				paramOrder: ['page', 'start', 'limit', 'sort', 'filter','querycodefk'],
				api: {
			        read:    Ext.qd.QueryDefinition.ReadColumnList
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