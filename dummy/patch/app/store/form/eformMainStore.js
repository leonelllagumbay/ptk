Ext.define('Form.store.form.eformMainStore', {
	extend: 'Ext.data.Store',
	model: 'Form.model.form.eformMainModel',
	storeId: 'mainMainStore',
	remoteFilter: true,
	remoteSort: true,
	simpleSortMode: true,
	sorters: [{
            property: 'DATELASTUPDATE',
            direction: 'DESC'
    }],
	filters: [{
			type: 'date',
            dataIndex: 'DATELASTUPDATE'  
	}],
	pageSize: 24,
	autoSave: true,
	autoLoad: true,
	autoSync: true,
	listeners: {
		load: function() { 
		   try {
			   	var mainGrid = Ext.ComponentQuery.query('eformmainview');
				var newFormbutton = mainGrid[0].down('button[action=neweforms]'); 
				var pendingFormbutton = mainGrid[0].down('button[action=pendingeforms]');
				Ext.ss.data.getInitForms(function(result) {
					newFormbutton.setText(result[0]);
					pendingFormbutton.setText(result[1]);
				});
		   } catch(err) {
		   	 console.log(err);
		   }
			
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