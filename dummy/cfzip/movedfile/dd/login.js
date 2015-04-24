Ext.application({
	requires: ['Ext.container.Viewport'],
	name: 'Form',
	controllers: [
		'main.login'
	],
	
	appFolder: 'app',
	
	launch: function(){
		Ext.create('Ext.container.Viewport', {
			layout: {
				type: 'vbox',
				align: 'center'
			},
			items: [{
				flex: 2,
				xtype: 'container',
			},{
				flex: 3,
				xtype: 'littleloginform',
			},{
				flex: 2,
				xtype: 'container'
			}]
		
		});
	}
	
});


