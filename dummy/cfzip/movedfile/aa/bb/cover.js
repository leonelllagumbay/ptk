Ext.onReady(function() {


var formPanel = Ext.create('Ext.form.Panel', {
	title: 'Login',
	width: 400,
	height: 200,
	renderTo: Ext.getBody(),
	style: 'margin: 50px',
	items: [{
		xtype: 'container',
		layout: 'vbox',
		items: [{
			xtype: 'textfield',
			fieldLabel: 'Email',
			name: 'email',
			labelAlign: 'top',
			cls: 'field-margin',
			flex: 1 
		},{
			xtype: 'textfield',
			fieldLabel: 'Password',
			name: 'password',
			labelAlign: 'top',
			cls: 'field-margin',
			flext: 1
		}]
	}],
	buttons: [{
        text: 'Cancel',
        handler: function() {
            formPanel.getForm().reset();
        }
    }, {
        text: 'Send',
        handler: function() {
            if (this.up('form').getForm().isValid()) {
                // In a real application, this would submit the form to the configured url
                formPanel.getForm().submit({
					url: 'login.cfm'
				});
                //this.up('form').getForm().reset();
                
                //Ext.MessageBox.alert('Thank you!', 'Your inquiry has been sent. We will respond as soon as possible.');
            }
        }
    },{
		text: 'Rotate',
		handler: function() {
			alert('Rotate clicked.');
		}
	},{
		text: 'Remove',
		handler: function() {
			alert('Remove clicked.');
		}
	}]
	
	
	
});




});

