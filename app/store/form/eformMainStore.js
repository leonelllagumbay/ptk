Ext.define('Form.store.form.eformMainStore', {
	extend: 'Ext.data.Store',
	model: 'Form.model.form.eformMainModel',
	storeId: 'mainMainStore',
	remoteFilter: true,
	remoteSort: true,
	simpleSortMode: true,
	sorters: [{
            property: 'A_DATELASTUPDATE',
            direction: 'DESC'
    }],
	filters: [{
			type: 'date',
            dataIndex: 'A_DATELASTUPDATE'  
	}],
	pageSize: 30,
	autoSave: true,
	autoLoad: true,
	autoSync: true,
	listeners: {
		load: function(thisStore, records) { 
			
			var navctrl = _myAppGlobal.getController("navigator.navigatorController");
			var themenuW = Ext.ComponentQuery.query('accordionview menu[name=myworklist]')[0];
			navctrl.myWorklistRenderF(themenuW);
		}
	},
	
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
		        read:    Ext.ss.eformmain.ReadNow,
		        create:  Ext.ss.eformmain.ReadNow,  
		        update:  Ext.ss.eformmain.ReadNow,
		        destroy: Ext.ss.eformmain.ReadNow 
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