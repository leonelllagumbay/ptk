Ext.define('Form.controller.header.headerController', {
    extend: 'Ext.app.Controller',
	
	views: [
        'header.headerView'
    ],
	models: [
		
	],
	stores: [
	
	],
	
    init: function() {
		console.log('init controller');
        this.control({
            
			'viewport panel': {  
				afterrender: this.panelRendered
			}
		});
    
	},
	
	panelRendered: function(panel)
	{
		try {
		   	var complogodisp = panel.down('displayfield[name=companylogo]');
		   	var userprofilepic = panel.down('displayfield[name=userprofilepic]');
		   	if(complogodisp != null && userprofilepic != null) {
		   		complogodisp.setValue("<img title='" + GLOBAL_VARS_DIRECT.COMPANYNAME + "' height='35' width='150' src='" + GLOBAL_VARS_DIRECT.COMPANYLOGO + "'>");
		   		userprofilepic.setValue("<img title='" + GLOBAL_VARS_DIRECT.FIRSTNAME + " " + GLOBAL_VARS_DIRECT.MIDDLENAME + " " + GLOBAL_VARS_DIRECT.LASTNAME + "' style='border-radius: 10px;' align='right' height='35' width='40' src='" + GLOBAL_VARS_DIRECT.MYPROFILEPIC + "'>");
		   	}
		   	
	   } catch(err) {
	   	 console.log('header controller ')
	   	 console.log(err);
	   }
	}
	
	 
});