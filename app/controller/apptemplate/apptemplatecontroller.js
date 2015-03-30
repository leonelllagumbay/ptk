Ext.define('Form.controller.apptemplate.apptemplatecontroller', {
    extend: 'Ext.app.Controller',
	views: [
        'apptemplate.apptemplateView'
    ],
	models: [
	],
	stores: [
	],
	init: function() {
		console.log('init controller');
        this.control({
            
			'apptemplateview button[action=x]': {  
			}
		});
     }	
});