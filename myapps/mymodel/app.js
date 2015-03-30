Ext.Loader.setConfig({enabled: true});
Ext.Loader.setPath('Ext.ux', '../../../scripts/extjs/examples/ux');
Ext.Loader.setPath('Form', '../../app');

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
		'Ext.layout.container.Form',
		'Ext.draw.*',
		'Form.controller.form.definitioncontroller'
	],
	name: 'Form',
	controllers: [
		'mymodel.mymodelcontroller'
	],
	
	appFolder: '../../app',
	
	init: function(app) {
		Ext.direct.Manager.addProvider(Ext.mm.APIDesc);
		
	},
	
	launch: function(){
		
	console.log('mymodel');
	_myAppGlobal = this;	
		Ext.create('Ext.container.Viewport', { 
			layout: {
				type: 'card'
			},
			items: [{
				xtype: 'mymodelview' 
			}],
			renderTo: Ext.getBody()
		});
	}
});



