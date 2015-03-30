Ext.define('Form.controller.main.login', {
    extend: 'Ext.app.Controller',

	views: [
        'main.loginform',
        'main.loginformchangepwdrequest'
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
			},
			'littleloginform textfield': {
				specialkey: this.logYouIn
			},
			'littleloginformchangepwdrequest button[action=signin]': {
				click: this.changePassword
			},
			'littleloginformchangepwdrequest textfield': {
				specialkey: this.changePassword
			}
		
        });
        
    },

    onPanelRendered: function() {
        console.log('The login panel was rendered');
    },
	
	logYouIn: function(button, e) {
		if(e.type == 'keydown')
		{
			if(e.getKey() != e.ENTER) { 
		         return true;
		    } 
	    }
		console.log('logyouin');
		if (button.up('form').getForm().isValid()) {
			button.up('form').getEl().mask("Authenticating...", "loading");
			var dform = button.up('form');
			var dpwd = dform.down('textfield[name=password]');
			var rpwd = dpwd.getValue();
			dpwd.setValue(Ext.util.md5.hash(rpwd));
		  	button.up('form').submit({
		  		url: 'blank.cfm',
		  		reset: true,
		  		method: 'POST',
		  		failure: function(form, action){
		  			button.up('form').getEl().unmask();	
		  		},
		  		success: function(form, action){
		  			button.up('form').getEl().unmask();
		  			console.log(action);
					if (action.result.form[0].detail=='yessuccessdetail') 
					{
						window.location.href = './?bdg=' + action.result.form[0].message;
					} else if(action.result.form[0].message == 'accountlockedout') {
						var msg = action.result.form[0].detail;
						dur = action.result.form[0].duration;
						button.up('form').down('textfield[name=username]').setDisabled(true);
						button.up('form').down('textfield[name=password]').setDisabled(true);
						button.up('form').down('button[action=signin]').setDisabled(true);
						startTime = function() {
						    if(dur < 1) {
								dur = 0;
								clearTimeout(timeoutGGGG);
								button.up('form').down('textfield[name=username]').setDisabled(false);
								button.up('form').down('textfield[name=password]').setDisabled(false);
								button.up('form').down('button[action=signin]').setDisabled(false);
								form.setValues([{
									id: 'displayrespidid',
									value: msg
								}]);
							} else {
								form.setValues([{
									id: 'displayrespidid',
									value: msg + "<br>" + "<b>" + dur + "</b>"
								}]);
								dur = dur - 1;
								timeoutGGGG = setTimeout(function(){ startTime() }, 1500);
							}
						   
						}
						startTime();
					} else if ( action.result.form[0].detail=='changepassword' ) {
						var title = 'Change Password Window';
						
						var winRL = Ext.create('Ext.window.Window', {
						    title: title,
						    height: 350,
						    width: 320,
						    modal: true,
						    closable: false,
						    layout: 'fit',
						    items: {  
						        xtype: 'littleloginformchangepwdrequest',
						        border: false
						    }
						}).show();
						
						var theForm = winRL.down('form');
						theForm.getForm().findField("username").setValue(action.result.form[0].username);
						theForm.getForm().findField("myoldhashedpwd").setValue(action.result.form[0].hashpwd);
						if (action.result.form[0].type == 'pwdisexpired') {
							theForm.getForm().findField("logindisplaymore").setValue("Your password is already expired.");
						}
					} else if(action.result.form[0].message == 'invalidunameorpassword') {
						var msg = action.result.form[0].detail;
						dur = action.result.form[0].duration;
						button.up('form').down('textfield[name=username]').setDisabled(true);
						button.up('form').down('textfield[name=password]').setDisabled(true);
						button.up('form').down('button[action=signin]').setDisabled(true);
						startTime = function() {
						    if(dur < 1) {
						    	dur = 0;
						    	clearTimeout(timeoutGGGG);
								button.up('form').down('textfield[name=username]').setDisabled(false);
								button.up('form').down('textfield[name=password]').setDisabled(false);
								button.up('form').down('button[action=signin]').setDisabled(false);
								form.setValues([{
									id: 'displayrespidid',
									value: msg
								}]);
							} else {
								form.setValues([{
									id: 'displayrespidid',
									value: msg + "<br>" + "<b>" + dur + "</b>"
								}]);
								dur = dur - 1;
								timeoutGGGG = setTimeout(function(){ startTime() }, 1500);
							}
						   
						}
						startTime();
					} else {
						form.setValues([{
							id: 'displayrespidid',
							value: action.result.form[0].detail
						}]);
					}
		  			
		  		}
	  	});
	  } 
	},
	
	changePassword: function(button,e) {
		if(e.type == 'keydown')
		{
			if(e.getKey() != e.ENTER) { 
		         return true;
		    } 
	    }
		if (button.up('form').getForm().isValid()) {
			button.up('form').getEl().mask("Authenticating...", "loading");
			var dform = button.up('form');
			var npwd = dform.down('textfield[name=newpassword]');
			var rpwd = npwd.getValue();
			npwd.setValue(Ext.util.md5.hash(rpwd));
			var cpwd = dform.down('textfield[name=confirmedpassword]');
			var rpwd = cpwd.getValue();
			cpwd.setValue(Ext.util.md5.hash(rpwd));
		  	button.up('form').submit({
		  		url: 'blank.cfm',
		  		reset: false,
		  		method: 'POST',
		  		failure: function(form, action){
		  			button.up('form').getEl().unmask();
		  			console.log('Log on error.');
		  			console.log(action);
		  		},
		  		success: function(form, action){
		  			button.up('form').getEl().unmask();
		  			console.log(action);
					if (action.result.form[0].detail=='yessuccessdetail') 
					{
						window.location.href = './?bdg=' + action.result.form[0].message;
					} else {
						form.setValues([{
							id: 'displayrespididrequest',
							value: action.result.form[0].detail
						}]);
					}
		  		}
	  	});
	  } 
	}
	
});