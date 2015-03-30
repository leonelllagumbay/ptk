Ext.define('Form.controller.email.emailcontroller', {
    extend: 'Ext.app.Controller',
	views: [
        'email.emailView'
    ],
	models: [
	],
	stores: [
	],
	init: function() {
		console.log('init email controller');
        this.control({
            'emailview': {  
			}
		});
     }	
});