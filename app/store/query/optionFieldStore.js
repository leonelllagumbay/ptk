Ext.define('Form.store.query.optionFieldStore', {
	extend: 'Ext.data.Store',
	model: 'Form.model.query.optionFieldModel',
	storeId: 'optionfieldstorestore',
	remoteFilter: true,
	remoteSort: true,
	simpleSortMode: true,
	autoLoad: true,
	sorters: [{
            property: 'FIELDNAME',
            direction: 'ASC'
    }],
	filters: [{
			type: 'string',
            dataIndex: 'FIELDNAME'  
	}],
	pageSize: 20,
	
	constructor : function(config) {
		
	    Ext.applyIf(config, {
	        proxy: {
				type: 'direct',
				timeout: 300000,
				extraParams: {
					dTable: '',
					dSource: '',
					dTableAlias: '',
					dFilter: [{
						value: ''
					}]
				},
				paramOrder: ['page', 'start', 'limit', 'sort', 'filter', 'dSource', 'dTable', 'dTableAlias', 'dFilter'],
				api: {
			        read:    Ext.ss.SourceOption.getFields
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