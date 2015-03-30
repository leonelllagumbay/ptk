Ext.define('Form.store.recruitment.setting.emailstore', {
	extend: 'Ext.data.Store',
	model: 'Form.model.recruitment.setting.emailmodel',
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
	pageSize: 10,
	autoSave: false,
	autoLoad: true,
	autoSync: false,
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
		        read: Ext.ss.setting.readsettings,
		        create: Ext.ss.setting.createsettings,
		        update: Ext.ss.setting.updatesettings,
		        destroy: Ext.ss.setting.destroysettings
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