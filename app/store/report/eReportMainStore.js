Ext.define('Report.store.report.eReportMainStore', {
	extend: 'Ext.data.Store',
	model: 'Report.model.report.eReportMainModel',
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
		load: function() { 
		   try {
			   	var mainGrid = Ext.ComponentQuery.query('eformmainview');
				var newFormbutton = mainGrid[0].down('button[action=neweforms]'); 
				var pendingFormbutton = mainGrid[0].down('button[action=pendingeforms]');
				var imagedisp = mainGrid[0].down('displayfield[name=imagedisplay]');
				Ext.ss.data.getInitForms(function(result) {
					newFormbutton.setText(result[0]);
					pendingFormbutton.setText(result[1]);
					imagedisp.setValue(result[2]);
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