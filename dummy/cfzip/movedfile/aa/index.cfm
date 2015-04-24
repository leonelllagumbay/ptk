 <html>
	
<head>
    <title>iBOS/e</title>
	<style type="text/css">
		.field-margin {
			margin: 10px; 
		}
		.selected {
			background-color: #FF0;
		}
		
		.ico-test {
			background-color:#00FF00; width:20px; height:20px; background-image:url("/resource/images/Koala.jpg") !important;
		}
	</style>
	<link rel="icon" type="image/ico" href="diginfologo.ico">
	<link rel="stylesheet" type="text/css" href="scripts/extjs/resources/css/ext-all.css">
    <script type="text/javascript" src="scripts/extjs/ext-dev.js"></script>
	<script type="text/javascript" src="scripts/chat/chat.js"></script>
	<script type="text/javascript" src="scripts/extjs/printer/Printer-all.js"></script>
	<script src="./myapps/form/fielddefinition/Api.cfm"></script>
    </script>
    <script type="text/javascript"> 
    	
    	function getURLParameter(name) {
		  return decodeURIComponent((new RegExp('[?|&]' + name + '=' + '([^&;]+?)(&|#|;|$)').exec(location.search)||[,""])[1].replace(/\+/g, '%20'))||null
		}
	</script>
    
	
<cftry>
	
	
<cfwebsocket 
	     name        ="ws" 
         onMessage   ="displayMessage"  
		 subscribeto ="chat" 
		 onError     ="displayError"
		 onOpen      ="displayOpen"
		 onClose     ="displayClose" 
/>

<script type="text/javascript">
Ext.Loader.setConfig({enabled: true});
Ext.Loader.setPath('Ext.ux', './scripts/extjs/examples/ux');
	
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
		'main',
		'form.definitioncontroller', 
	],
	
	appFolder: 'app', 
	
	init: function() {
		console.log('Direct initialization here');
		
		Ext.direct.Manager.addProvider(Ext.ss.APIDesc);
		
		Ext.Error.handle = function(err) { 
			console.log('app-wide error');
			console.log(err);
			
			var msg = err.msg;
			var res = msg.search('src="login.js"><\/script>');
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
											url: 'blank.cfm', 
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
		Ext.create('Ext.container.Viewport', {
			layout: 'border',
			autoScroll: true,
			autoShow: true,
			items: [{
				region: 'north',
				flex: .2
			},{
				region: 'west',
				flex: .5,
				items: [{
					xtype: 'defmainview'
				}]
			},{
				region: 'center',
				flex: 1
			},{
				region: 'east',
				flex: .1
			},{
				region: 'south',
				flex: .1
			}]
		
		});
		
	}	
});




</script>

	
</head>
<body>
<span id="theapplicationuserid" style="display: none;" ><cfoutput>#client.userid#</cfoutput></span>
</body>

</html>

	<cfcatch>
		<cfoutput>
			{
				"success": false,
				"form": [{
					"detail": #cfcatch.Detail# #cfcatch.Message#"
				}]
			}
		</cfoutput>
	</cfcatch>

</cftry>
<cfsetting showdebugoutput="no" >

