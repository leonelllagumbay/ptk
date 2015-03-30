Ext.define('Form.store.recruitment.screeningandreservation.mrfstore', {
	extend: 'Ext.data.Store',
	model: 'Form.model.recruitment.screeningandreservation.mrfmodel',
	remoteFilter: true,
	remoteSort: true,
	simpleSortMode: true,
	sorters: [{
            property: 'DATELASTUPDATE',
            direction: 'DESC'
    }],
	filters: [{
			type: 'string',
            dataIndex: 'REQUISITIONNO' 
	}],
	pageSize: 30,
	autoSave: true,
	autoLoad: true,
	autoSync: true,
	
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
		        read: Ext.ss.data.GetMRF
		        //create: Ext.ss.data.GetAll,
		        //update: Ext.ss.data.GetAll,
		        //destroy: Ext.ss.data.GetAll,
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





