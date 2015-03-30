Ext.define('Form.store.recruitment.screeningandreservation.localpoolstore', {
	extend: 'Ext.data.Store',
	model: 'Form.model.recruitment.screeningandreservation.localpoolmodel',
	remoteFilter: true,
	remoteSort: true,
	simpleSortMode: false,
	sorters: [{
            property: 'A_APPLICATIONDATE',
            direction: 'DESC'
    }],
	filters: [{
			type: 'string',
            dataIndex: 'G_REQUISITIONNO' 
	}],
	pageSize: 30,
	autoSave: true,
	autoLoad: false,
	autoSync: true,
	
	constructor : function(config) {
		
    Ext.applyIf(config, {
        proxy: {
			type: 'direct',
			timeout: 300000,
			extraParams: {
				requisitionno: '__'
			},
			paramOrder: ['page', 'start', 'limit', 'sort', 'filter', 'requisitionno'],
			api: {
		        read: Ext.ss.data.GetLocalPool
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





