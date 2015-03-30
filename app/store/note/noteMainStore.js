Ext.define('Note.store.note.noteMainStore', {
	extend: 'Ext.data.Store',
	model: 'Note.model.note.noteMainModel',
	storeId: 'noteMainStore',
	remoteFilter: true,
	remoteSort: true,
	simpleSortMode: true,
	sorters: [{
            property: 'DATELASTUPDATE',
            direction: 'DESC'
    }],
	filters: [{
			type: 'string',
            dataIndex: 'EFORMNAME'  
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
			paramOrder: ['page', 'start', 'limit', 'sort', 'filter'],
			api: {
		        read:    Ext.ss.Note.readNotes,
		        create:  Ext.ss.Note.createNoteTitle,  
		        update:  Ext.ss.Note.updateNoteDetails,
		        destroy: Ext.ss.Note.destroyNoteTitle
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