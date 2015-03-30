Ext.define('Report.controller.report.reportresultcontroller', {
    extend: 'Ext.app.Controller',
	
	views: [
        
    ],
	models: [
		
	],
	stores: [
		
	],
	
    init: function() {
		console.log('init controller');
        this.control({
            'defcolumnview button[action=applydefaultfields]': {
				click: this.applyDefaultFields
			}
			 
        });
    
	},
	
	applyDefaultFields: function(btn) {
	},
	 
});