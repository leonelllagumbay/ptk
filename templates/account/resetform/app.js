Ext.application({
	requires: [
		'Ext.container.Viewport',
		'Ext.data.*',
		'Ext.form.*',
		'Ext.layout.container.Form'
	],
	name: 'Form',
	controllers: [
		'main.login'
	],

	appFolder: '../../../app',
	
	launch: function() {
		
		Ext.create('Ext.container.Viewport', {
			layout: {
				type: 'vbox',
				align: 'center'
			},
			items: [{
				flex: 2,
				xtype: 'container'
			},{
				flex: 3,
				xtype: 'littleloginformchangepwdrequest'
			},{
				flex: 2,
				xtype: 'container'
			}]
		
		});
	}
	
});


