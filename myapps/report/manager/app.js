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
	name: 'Report',
	controllers: [
		'report.reportmanagercontroller',  
	],
	
	appFolder: '../../../app',
	
	init: function(app) {
		Ext.direct.Manager.addProvider(Ext.ss.APIDesc);
		//application wide error handler
		Ext.Error.handle = function(err) { 
			console.log('app-wide error');
			console.log(err);
			
			var msg = err.msg;
			var res = msg.search('src="login.js"></script>');
			console.log(res); 
			if(res != -1) { 
				Ext.create('Ext.window.Window', {
						title: 'Please sign in to continue!',
						height: 240,
						width: 300,
						closable: false,
						modal: true,
						layout: 'anchor',
						items: [{
							xtype: 'form',
							flex: 1,
							items: [{
								xtype: 'textfield',
								fieldLabel: 'User name',
								name: 'username',
								labelAlign: 'top',
								height: 45,
								allowBlank: false,
								padding: '5 5 5 5',
								emptyText: 'username',
								anchor: '100%'
							}, {
								xtype: 'textfield',
								fieldLabel: 'Password',
								name: 'password',
								inputType: 'password',
								height: 45,
								emptyText: 'password',
								labelAlign: 'top',
								allowBlank: false,
								padding: '5 5 5 5',
								anchor: '100%'
							}, {
								xtype: 'displayfield',
								name: 'logindisplaymore',
								id: 'displayrespidid',
								value: '',
								padding: '5 5 5 5',
								anchor: '100%'
							}],
							
							buttons: [{
								text: 'Sign in',
								padding: '5 50 5 50', 
								action: 'signin',
								handler: function(){
									if (this.up('form').getForm().isValid()) {
										this.up('form').submit({
											url: '../../../signin.cfm', 
											reset: true,
											method: 'POST',
											failure: function(form, action){
											},
											success: function(form, action){
												console.log(action);
												if (action.result.form[0].detail=='yessuccessdetail') 
												{
													window.location.reload();
												} else
												{
													form.setValues([{
														id: 'displayrespidid',
														value: action.result.form[0].detail
													}]);
												}
												
											}
										});
									}
								}
								
							}]
						
						}]
					}).show();
				
			} else {
				Ext.Msg.show({
	  				title: 'Technical problem.',
	  				msg: 'Our apology. We are having technical problems.',
	  				buttons: Ext.Msg.OK,
	  				icon: Ext.Msg.ERROR
	  			});
			}
			
		    // any non-true return value (including none) will cause the error to be thrown
		} //end application-wide error handler 
	},
	
	launch: function(){
		
	console.log('report launch');
		
		Ext.create('Ext.panel.Panel', { 
			layout: {
				type: 'vbox',
				align: 'left'
			},
			autoScroll: true,
			items: [{
				xtype: 'panel',
				title: 'Datasource and Tables',
				layout: 'hbox',
				width: '100%',
				height: 100,
				items: [{
					xtype: 'displayfield',
					fieldLabel: 'DatasourceTable'
				}]
			},{
				xtype: 'panel',
				layout: 'hbox',
				width: '100%',
				height: 400,
				items: [{
					xtype: 'textfield',
					fieldLabel: 'DatasourceTable'
				},{
					xtype: 'textfield',
					fieldLabel: 'SelectedDatasourceTable'
				}]
			},{
				xtype: 'panel',
				layout: 'hbox',
				width: '100%',
				height: 400,
				items: [{
					xtype: 'textfield',
					fieldLabel: 'TableColumns'
				},{
					xtype: 'textfield',
					fieldLabel: 'SelectedColumns'
				}]
			},{
				xtype: 'panel',
				layout: 'hbox',
				width: '100%',
				height: 400,
				items: [{
					xtype: 'textfield',
					fieldLabel: 'Preview'
				}]
			}],
			renderTo: Ext.getBody()
		
		});
	}
});
