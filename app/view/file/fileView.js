Ext.define('Form.view.file.fileView', { 
	extend: 'Ext.tree.Panel',
	alias: 'widget.fileview',
	title: 'eFiles',
	width: '100%', 
	height: '100%',
	editable: true,
	autoScroll: true,
	rootVisible: false,
	plugins: [
        Ext.create('Ext.grid.plugin.CellEditing', {
        	clicksToEdit:1
        })
    ],
	initComponent: function() {   
		this.store = 'file.folderStore';
		this.viewConfig = {
			    plugins: { 
			    	ptype: 'treeviewdragdrop',
			    	enableDrag: true,
	                enableDrop: true,
	                toggleOnDblClick: false
			    }
		};
		this.selType =  'cellmodel';
        
		this.callParent(arguments);
	}
});


