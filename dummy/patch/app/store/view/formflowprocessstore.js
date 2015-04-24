Ext.define('View.store.view.formflowprocessstore', {
	extend: 'Ext.data.Store',
	storeId: 'data',
	model: 'View.model.view.formflowprocessmodel',
	//remoteGroup: true,
	remoteFilter: true,
	remoteSort: true,
	simpleSortMode: true,
	sorters: [{
            property: 'DATELASTUPDATE',
            direction: 'DESC'
    }],
	filters: [{
			type: 'string',
            dataIndex: 'PROCESSNAME'  
	}],
	//groupers: [{
	//	property: 'GROUPNAME',
	//	direction: 'ASC'
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
			paramOrder: ['page', 'start', 'limit', 'sort', 'filter'],
			api: {
		        read:    Ext.ss.data.ReadNow,
		        create:  Ext.ss.data.ReadNow,  
		        update:  Ext.ss.data.UpdateNow,
		        destroy: Ext.ss.data.DestroyNow
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
	console.log("process store");
}
	
	
});





