Ext.Loader.setConfig({enabled: true});
Ext.Loader.setPath('Ext.ux', '../../../scripts/extjs/examples/ux');

Ext.application({
	requires: [
		'Ext.Viewport',
		'Ext.direct.*',
	    'Ext.data.*',
		'Ext.panel.*',
        'Ext.layout.container.Border',
        'Ext.picker.Date',
        'Ext.layout.container.Card'
	],
	name: 'Form',
	controllers: [
		'reminder.remindercontroller'
	],
	
	appFolder: '../../app',
	
	init: function(app) {
		Ext.direct.Manager.addProvider(Ext.re.APIDesc);
		
	},
	
	launch: function(){
		
	console.log('reminder');
	_myAppGlobal = this;	
		
		Ext.create('Ext.container.Viewport', {
			layout: {
				type: 'card'
			},
			items: [{
				xtype: 'reminderapp'
			}],
			renderTo: Ext.getBody()
		
		});
	}
});



