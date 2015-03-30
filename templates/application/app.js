Ext.Loader.setConfig({enabled: true});
Ext.Loader.setPath('Ext.ux', '../../scripts/extjs/examples/ux');


Ext.application({
	requires: [
		'Ext.container.Viewport',
		'Ext.layout.container.Form',
		'Ext.window.MessageBox',
		'Ext.panel.Panel',
		'Ext.form.Panel',
	    'Ext.tip.*',
		'Ext.direct.*',
	    'Ext.data.*'
	],
	name: 'OnlineApplication',
	id: 'applyonlinecuteid',
	controllers: [
		'recruitment.applicationonline.controller' 
	],
	appFolder: '../../app',
	init: function(app) {
		console.log('init me apply online');
		Ext.direct.Manager.addProvider(Ext.ss.APIDesc);
	},
	
	launch: function(){
		_myAppGlobal = this;	
			Ext.create('Ext.form.Panel', { 
				layout: {
					type: 'vbox',
	        		align: 'center'
				},
				buttonAlign: 'center',
				width: '100%',
				title: 'iBOS/e Application Online Form',
				titleAlign: 'center',
				items: [{
					xtype: 'instructionview' 
				},{
					xtype: 'personalinfoview' 
				},{
					xtype: 'employmentinfoview' 
				},{
					xtype: 'familybackgroundview' 
				},{
					xtype: 'educationalbackgroundview' 
				},{
					xtype: 'extracurricularview' 
				},{
					xtype: 'additionalinfoview' 
				},{
					xtype: 'trainingsandseminarview' 
				},{
					xtype: 'employmenthistoryview' 
				},{
					xtype: 'specialskillsview' 
				},{
					xtype: 'sourceview' 
				},{
					xtype: 'referencesview' 
				},{
					xtype: 'otherdetailsview' 
				},{
					xtype: 'footerview' 
				}],
				renderTo: Ext.getBody()
			
			});
		}
	});