Ext.define('Form.view.form.eformNewDetailsView', {
	extend: 'Ext.form.Panel',
	alias: 'widget.eformnewdetailsview',
	title: 'eForm -> New eForms -> Details', 
	width: '100%', 
	height: '100%',
	autoScroll: true,
	defaults: {anchor: '100%'}, 
    defaultType: 'textfield',
	initComponent: function() {   
		this.tbar = [{
			  	text: 'Back',
				action: 'backtoneweforms'   
			 }];
		  
		this.items = []; 
		// configs for BasicForm
		 this.api = {
				        // The server-side method to call for load() requests
				        load: Ext.ss.eformmain.getMainDetails,
				        // The server-side must mark the submit handler as a 'formHandler'
				        submit: Ext.ss.eformmain.submitMaineForm
				    };
		// specify the order for the passed params
		
		this.buttons = [{
				text: 'Approve',
				action: 'approve'
		    },{
				text: 'Disapprove',
				action: 'disapprove'
			},{
				text: 'Return to Sender',
				action: 'returntosender'
			},{
				text: 'Return to Originator',
				action: 'returntooriginator'
			}];
			
		
		this.callParent(arguments);
	}
	
});
