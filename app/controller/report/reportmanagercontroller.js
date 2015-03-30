Ext.define('Report.controller.report.reportmanagercontroller', {
    extend: 'Ext.app.Controller',
	
	views: [
        
    ],
	models: [
		
	],
	stores: [
		
	],
	
    init: function() {
		console.log('init report manager controller');
        this.control({
            'defcolumnview button[action=applydefaultfields]': {
				click: this.applyDefaultFields
			}
			 
        });
    
	},
	
	applyDefaultFields: function(btn) {
	},
	 
});