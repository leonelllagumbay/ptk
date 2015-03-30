Ext.define('Form.store.file.folderStore', {
	extend: 'Ext.data.TreeStore',
	model: 'Form.model.file.folderModel',
	//autoSave: true,
	//autoLoad: true,
	defaultRootProperty: 'children',
	defaultRootText: 'root',
	defaultSortDirection: 'ASC',
	folderSort: true,
	remoteFilter: true,
	remoteSort: true,
	sorters: [{
        property: 'FOLDERORDER',
        direction: 'DESC'
	}],
	filters: [{
			type: 'string',
	        dataIndex: 'FOLDERNAME'  
	}],
	
	listeners: {
		beforeload: function(dstore, doperation) {
			if(doperation.id != "root") {
				return false;
			}
		}
	},
	
	constructor : function(config) {
	
	

    Ext.applyIf(config, {
        proxy: {
			type: 'direct',
			timeout: 300000,
			api: {
		        read:    Ext.file.File.readMyFolder,
		        create:  Ext.file.File.createMyFolder, 
		        update:  Ext.file.File.updateMyFolder,
		        destroy: Ext.file.File.destroyMyFolder
		    },
			paramsAsHash: false,
			reader: {
				type: 'json',
	            root: 'children'
	        }
		}
    });

    this.callParent([config]);
}
	
	
});