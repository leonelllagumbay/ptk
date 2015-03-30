Ext.Loader.setConfig({enabled: true});
Ext.Loader.setPath('Ext.ux', '../../../scripts/extjs/examples/ux');

Ext.application({
	requires: [
		'Ext.container.Viewport',
		'Ext.direct.*',
	    'Ext.data.*',
		'Ext.panel.*',
		'Ext.layout.container.Card',
		'Ext.form.*',
		'Ext.layout.container.Form'
	],
	name: 'Form',
	controllers: [
		'myibose.micontroller'
	],
	
	appFolder: '../../app',
	
	init: function(app) {
		Ext.direct.Manager.addProvider(Ext.mi.APIDesc);
		
	},
	
	launch: function(){
		
	console.log('myibose');
	_myAppGlobal = this;	
		Ext.create('Ext.container.Viewport', { 
			layout: {
				type: 'card'
			},
			items: [{
				xtype: 'myiboseview' 
			}],
			renderTo: Ext.getBody()
		});
	}
});



