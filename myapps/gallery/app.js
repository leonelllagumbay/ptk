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
		'Ext.grid.plugin.BufferedRenderer',
		'Ext.toolbar.Paging',
		'Ext.ux.ajax.JsonSimlet',
	    'Ext.ux.ajax.SimManager',
		'Ext.util.*',
		'Ext.grid.*',
		'Ext.data.*',
		'Ext.form.*',
		'Ext.layout.container.Form'
	],
	name: 'Form',
	controllers: [
		'gallery.gallerycontroller'
	],
	
	appFolder: '../../app',
	
	init: function(app) {
		Ext.direct.Manager.addProvider(Ext.gallery.APIDesc);
		
	},
	
	launch: function(){
		
	console.log('gallery launch');
	_myAppGlobal = this;	
		Ext.create('Ext.container.Viewport', { 
			layout: {
				type: 'card'
			},
			items: [{
				xtype: 'galleryview' 
			}],
			renderTo: Ext.getBody()
		});
	}
});



