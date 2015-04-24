Ext.define('View.store.view.store', {
	extend: 'Ext.data.Store',
	storeId: 'data',
	model: 'View.model.view.model',
	//remoteGroup: true,
	remoteFilter: true,
	remoteSort: true,
	simpleSortMode: false,
	sorters: [{
            property: 'DATELASTUPDATE',
            direction: 'DESC'
    }],
	filters: [{
			type: 'string',
            dataIndex: 'REQUISITIONNO' 
	}],
	//groupers: [{
	//	property: 'DATELASTUPDATE',
	//	direction: 'DESC'
	//}],
	pageSize: 23,
	autoSave: true,
	autoLoad: true,
	autoSync: true,
	//buffered: true,  
    //leadingBufferZone: 10, 
	
	constructor : function(config) {
		
    Ext.applyIf(config, {
        proxy: {
			type: 'direct',
			timeout: 300000,
			extraParams: {
				departmentcode: '__'
			},
			paramOrder: ['page', 'start', 'limit', 'sort', 'filter', 'departmentcode'],
			api: {
		        read: Ext.ss.data.GetAll,
		        create: Ext.ss.data.createRec,
		        update: Ext.ss.data.updateRec,
		        destroy: Ext.ss.data.destroyRec
		    },
			paramsAsHash: false,
			filterParam: 'filter',
			//groupParam: 'group',
			sortParam: 'sort',
			limitParam: 'limit',
			idParam: 'ID',
			pageParam: 'page',
			//simpleGroupMode: true,
			//groupDirectionParam: 'dir',
			reader: {
	            root: 'topics',
	            totalProperty: 'totalCount'
	        }
			//,
			//writer: {
			//	encoded: false,
			//	writeAllFields: false
			//}
		}
    });

    this.callParent([config]);
}
	
});





