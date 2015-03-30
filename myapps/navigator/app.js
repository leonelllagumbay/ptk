Ext.Loader.setConfig({enabled: true});
Ext.Loader.setPath('Ext.ux', '../../scripts/extjs/examples/ux');

Ext.application({
	requires: [
		'Ext.container.Viewport',
		'Ext.direct.*',
		'Ext.form.action.DirectSubmit',
		'Ext.form.action.DirectLoad',
		'Ext.form.field.File',
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
		'navigator.navigatorController',  
	],
	
	appFolder: '../../app',
	
	init: function(app) {
		Ext.direct.Manager.addProvider(Ext.nav.APIDesc);
	},
	
	launch: function(){
		
	console.log('navigator');
		
		Ext.create('Ext.container.Viewport', {
			layout: {
				type: 'vbox',
				align: 'center'
			},
			items: [{
				xtype: 'accordionview' 
			}],
			renderTo: Ext.getBody()
		});
	}
});



