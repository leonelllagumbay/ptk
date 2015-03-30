Ext.define('Form.store.query.optionFieldFunctionStore', {
	extend: 'Ext.data.Store',
	model: 'Form.model.query.optionFieldFunctionModel',
	storeId: 'optionfieldfunctionstore',
	remoteFilter: true,
	remoteSort: true,
	simpleSortMode: true,
	autoLoad: false,
	sorters: [{
            property: 'FUNCTIONNAME',
            direction: 'ASC'
    }],
	filters: [{
			type: 'string',
            dataIndex: 'FUNCTIONNAME'  
	}],
	pageSize: 50,
	
	constructor : function(config) {
		
	    Ext.applyIf(config, {
	        proxy: {
				type: 'direct',
				timeout: 300000,
				paramOrder: ['page', 'start', 'limit', 'sort', 'filter'],
				api: {
			        read:    Ext.ss.SourceOption.getFunctions
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