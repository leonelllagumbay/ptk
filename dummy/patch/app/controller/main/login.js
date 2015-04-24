Ext.define('cfbose.controller.main.login', {
    extend: 'Ext.app.Controller',

	views: [
        'main.loginform'
    ],
	
	stores: [
		//'Users'
	],
	
	models: [
		//'User'
	],
	
    init: function() {
        this.control({
            'viewport > panel': {
                render: this.onPanelRendered
            },
			'littleloginform button[action=signin]': {
				click: this.logYouIn
			}
		
        });
    },

    onPanelRendered: function() {
        console.log('The login panel was rendered');
    },
	
	logYouIn: function(button) {
		if (button.up('form').getForm().isValid()) {
		  	button.up('form').submit({
		  		url: 'signin.cfm',
		  		reset: true,
		  		method: 'POST',
		  		failure: function(form, action){
		  			console.log(action);
				 	form.setValues([{
						id: 'displayrespidid',
						value: action.result.form[0].detail
					}]);
					
		  		},
		  		success: function(form, action){
		  			window.location.href = './form/main/index.cfm';
		  		}
	  	});
	  } 
	}
	
});