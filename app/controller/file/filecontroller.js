Ext.define('Form.controller.file.filecontroller', {
    extend: 'Ext.app.Controller',
	views: [
        'file.fileView',
        'file.fileGrid'
    ],
	models: [
	    'file.folderModel'
	],
	stores: [
	    'file.folderStore'
	],
	init: function() {
		console.log('init file controller');
        this.control({
            
			'fileview': { 
				//select: this.treeSelected,
				containercontextmenu: this.myFolderContextMenu,
				itemcontextmenu: this.myFolderItemRightClicked,
				render: this.treeRendered
			}
		});
     },
     
     treeRendered: function(thisTree) {
    	 
     },
     
     treeSelected: function(disrow, rec, ind) {
    	 console.log(disrow);
    	 console.log(rec);
    	 console.log(ind);
     },
     
     myFolderItemRightClicked: function(thisitem, record, item, index, re) {
    	 console.log(thisitem);
    	 console.log(record);
    	 console.log(item);
    	 console.log(index);
    	 re.stopEvent();
         Ext.create('Ext.menu.Menu', {
         	listeners: {
 			    hide: function(dmenu) {
 			        Ext.destroy(dmenu);
 			    }
 			},
             items : [{
                 text : 'Add',
                 handler : function() {
                     console.log('add');
                 }
             },{
            	 text: 'Copy'
             },{
            	 text: 'Move'
             },{
            	 text: 'Delete'
             },{
            	 text: 'Rename'
             },{
            	 text: 'Order By'
             },{
            	 text: 'Filter'
             }]
         }).showAt(re.getXY());
     },
     
     myFolderContextMenu: function(thisview, rawevent, eOpts) {
    	 var thiscontroller = this;
    	 rawevent.stopEvent();
         Ext.create('Ext.menu.Menu', {
         	listeners: {
 			    hide: function(dmenu) {
 			        Ext.destroy(dmenu);
 			    }
 			},
             items : [{
                 text : 'New folder',
                 handler : function() {
                     console.log('add');
                 }
             },{
            	 text: 'Refresh',
            	 action: 'refresh',
            	 handler: function() {
            		 thiscontroller.refreshTree(thisview);
            	 }
             }]
         }).showAt(rawevent.getXY());


         return false;
     },
     
     refreshTree: function(thisview) {
		 var treeStore = thisview.up('panel').getStore();
		 treeStore.getRootNode().removeAll();
		 treeStore.load();
	 }
});