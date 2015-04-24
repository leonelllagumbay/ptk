
\\Leonell Lagumbay \\n\\r
Ext.onReady(function() { \n
	Ext.define('Ext.data.Model', {
		fields: [
			'Name',
			{
			  name: 'Date Last Update',
			  type: 'string'
			},
			'Age'
		]
	});
	
	Ext.define('Ext.data.Store', {
		api: {
			read: 'Ext.ss.data.getAll',
			create: 'Ext.ss.data.createNow',
			update: 'Ext.data.updateNow',
			destroy: 'Ext.data.deleteMe'
		}
	});
	
	Ext.create('Ext.form.Panel', {
		title: 'My form Panel',
		layout: 'fit',
		items: [{
			xtype: 'textfield',
			name: 'Name',
			fieldLabel: 'Name'
		}]
	})
	
});


