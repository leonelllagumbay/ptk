Ext.define('Form.store.form.eformDynamicUser', {
	extend: 'Ext.data.Store',
	model: 'Form.model.form.eformUserListModel',
	storeId: 'mainMainStoreaabbb',
	remoteFilter: true,
	remoteSort: true,
	simpleSortMode: true,
	sorters: [{
            property: 'PERSONNELIDNO',
            direction: 'ASC'
    }],
	filters: [{
			dataIndex: 'PERSONNELIDNO'  
	}],
	pageSize: 30,
	autoLoad: false,
	
	constructor : function(config) {
		
    Ext.applyIf(config, {
        proxy: {
			type: 'direct',
			timeout: 300000,
			extraParams: {
				eformid: '__',
				routerid: '__'
			},
			paramOrder: ['page', 'start', 'limit', 'sort', 'filter', 'eformid', 'routerid'],
			api: {
		        read:    Ext.ss.data.ReadNowDynamicApprover,
		        create:  Ext.ss.data.ReadNowDynamicApprover,  
		        update:  Ext.ss.data.ReadNowDynamicApprover,
		        destroy: Ext.ss.data.ReadNowDynamicApprover  
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