Ext.define('Form.store.form.defColumnStore', {
	extend: 'Ext.data.Store',
	model: 'Form.model.form.defColumnModel',
	storeId: 'defColumnStore',
	remoteFilter: true,
	remoteSort: true,
	simpleSortMode: true,
	sorters: [{
            property: 'DATELASTUPDATE', 
            direction: 'DESC'
    }],
	filters: [{
			type: 'string',
            dataIndex: 'COLUMNNAME'  
	}],
	pageSize: 24,
	autoSave: true,
	autoLoad: false,
	autoSync: true,
	
	constructor : function(config) {
		
    Ext.applyIf(config, {
		
        proxy: {
			extraParams: {
				tableid: '__'
			},
			type: 'direct',
			timeout: 300000,
			paramOrder: ['page', 'start', 'limit', 'sort', 'filter', 'tableid'],
			api: {
		        read:    Ext.ss.defdata.ColumnReadNow,  
		        create:  Ext.ss.defdata.ColumnCreateNow,  
		        update:  Ext.ss.defdata.ColumnUpdateNow,  
		        destroy: Ext.ss.defdata.ColumnDestroyNow 
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