Ext.Loader.setConfig({enabled: true});
Ext.Loader.setPath('Ext.ux', '../../scripts/extjs/examples/ux');

Ext.application({
	requires: [
		'Ext.container.Viewport',
		'Ext.layout.container.Card',
		'Ext.util.*',
		'Ext.data.*',
		'Ext.direct.*'
	],
	name: 'Form',
	controllers: [
		'home.homecontroller'
	],
	
	appFolder: '../app',
	
	init: function(app) {
		Ext.direct.Manager.addProvider(Ext.home.APIDesc);
		
	},
	
	launch: function(){
		
	console.log('home');
	_myAppGlobal = this;	
		Ext.create('Ext.container.Viewport', { 
			layout: {
				type: 'card'
			},
			items: [],
			renderTo: Ext.getBody()
		});
	}
});



