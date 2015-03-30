Ext.Loader.setConfig({enabled: true});
Ext.Loader.setPath('Ext.ux', '../../../scripts/extjs/examples/ux');

Ext.application({
	requires: [
		'Ext.container.Viewport',
		'Ext.direct.*',
	    'Ext.data.*',
		'Ext.panel.*',
		'Ext.layout.container.Card',
		'Ext.ux.grid.FiltersFeature',
		'Ext.toolbar.Paging',
		'Ext.util.*',
		'Ext.grid.*',
		'Ext.form.*',
		'Ext.layout.container.Form'
	],
	name: 'Form',
	controllers: [
		'file.filecontroller'
	],
	
	appFolder: '../../app',
	
	init: function(app) {
		Ext.direct.Manager.addProvider(Ext.file.APIDesc);
		
	},
	
	launch: function(){
		
	console.log('efiles launch');
	_myAppGlobal = this;	
		Ext.create('Ext.container.Viewport', { 
			layout: {
				type: 'card'
			},
			items: [{
				xtype: 'fileview' 
			}],
			renderTo: Ext.getBody()
		});
	}
});



