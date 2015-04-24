Ext.define('cfbose.view.main.loginwindow', {
	extend: 'Ext.window.Window',
	alias: 'widget.loginwindow',
	title: 'Log in',
	
	initComponent: function() {
		
		this.height = 200;
		this.autoShow = true;
		this.width = 400;
		this.layout = 'fit';
		this.items = {  // Let's put an empty grid in just to illustrate fit layout
				        xtype: 'grid',
				        border: false,
				        columns: [{header: 'World'}],                 // One header just for show. There's no data,
				        store: Ext.create('Ext.data.ArrayStore', {}) // A dummy empty data store
				     }
		//
		
		
		this.callParent(arguments);
	}
});

	