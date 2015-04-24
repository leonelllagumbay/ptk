Ext.define('Form.store.form.eformUserListStore', {
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
			type: 'date',
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
				eformid: '__'
			},
			paramOrder: ['page', 'start', 'limit', 'sort', 'filter', 'eformid'],
			api: {
		        read:    Ext.ss.data.ReadNowUser,
		        create:  Ext.ss.data.ReadNowUser,  
		        update:  Ext.ss.data.ReadNowUser,
		        destroy: Ext.ss.data.ReadNowUser  
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