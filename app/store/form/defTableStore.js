Ext.define('Form.store.form.defTableStore', {
	extend: 'Ext.data.Store',
	model: 'Form.model.form.defTableModel',
	storeId: 'defTableStore',
	remoteFilter: true,
	remoteSort: true,
	simpleSortMode: true,
	sorters: [{
            property: 'DATELASTUPDATE',
            direction: 'DESC'
    }],
	filters: [{
			type: 'string',
            dataIndex: 'TABLENAME'  
	}],
	pageSize: 30,
	autoSave: true,
	autoLoad: false,
	autoSync: true,
	
	constructor : function(config) {
		
    Ext.applyIf(config, {
        proxy: {
			extraParams: {
				eformid: '__'
			},
			type: 'direct',
			timeout: 300000,
			paramOrder: ['page', 'start', 'limit', 'sort', 'filter', 'eformid'],
			api: {
		        read:    Ext.ss.defdata.TableReadNow,  
		        create:  Ext.ss.defdata.TableCreateNow,  
		        update:  Ext.ss.defdata.TableUpdateNow,  
		        destroy: Ext.ss.defdata.TableDestroyNow 
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