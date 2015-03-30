Ext.define('Form.controller.myibose.micontroller', {
    extend: 'Ext.app.Controller',
	views: [
        'myibose.myiboseView'
    ],
	models: [
	],
	stores: [
	],
	init: function() {
		this.control({
			'myiboseview': {
				render: this.loadMB
			},
            'myiboseview button[action=savemyibose]': {
				click: this.submitMB
			}
		});
	},
	
	loadMB: function(thisF) {
		thisF.getForm().load();
	},
	
	submitMB: function(btn) {
		var theForm = btn.up('form');
		if(theForm.getForm().isValid()){
			theForm.getForm().submit({
				waitMsg: 'Saving, please wait...',
				timeout: 300000,
				reset: true,
		  		failure: function(form, action){
		  			Ext.Msg.show({
		  				msg: action.result.detail,
		  				buttons: Ext.Msg.OK
		  			});
		  		},
		  		success: function(form, action){
		  			Ext.Msg.show({
		  				msg: 'Saved successfully!',
		  				buttons: Ext.Msg.OK
		  			});
		  		}
			});	
		}
	}
	
	
});