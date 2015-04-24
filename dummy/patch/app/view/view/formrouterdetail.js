Ext.require([
    'Ext.form.Panel',
    'Ext.tip.*'
]);

Ext.define('View.view.view.formrouterdetail', { 
	extend: 'Ext.form.Panel',
	alias: 'widget.routerForm', 
    title: 'eForm Router -> Router Details',
	width: '100%', 
	height: '100%',
	autoScroll: true,
	defaults: {anchor: '100%'},
    defaultType: 'textfield',
	initComponent: function() {   
		this.tbar = [{
			  	text: 'Back',
				action: 'backtorouter' 
			 }];
		  
		this.items = [{
	        	fieldLabel: 'Router Order',
				padding: '5 400 5 400',
				labelWidth: 200,
		        name: 'ROUTERORDER',
				xtype: 'numberfield',
				minValue: 0,
				maxValue: 100000,
				allowBlank: false
		    },{
		        fieldLabel: 'Router ID',
		        name: 'ROUTERID',
				padding: '5 400 5 400',
				labelWidth: 200,
				hidden: true
		    },{
		        fieldLabel: 'Process ID',
		        name: 'PROCESSIDFK',
				padding: '5 400 5 400',
				labelWidth: 200,
				hidden: true
		    },{
		        fieldLabel: 'Router Name',
		        name: 'ROUTERNAME',
				padding: '5 400 5 400',
				labelWidth: 200,
				allowBlank: false
		    },{
		        fieldLabel: 'Description',
				padding: '5 400 5 400',
				labelWidth: 200,
		        name: 'DESCRIPTION'
		    },{
		        fieldLabel: 'Allow Notification',
		        name: 'NOTIFYNEXTAPPROVERS',
				xtype: 'checkboxfield',
				checked: true,
				padding: '5 400 5 400',
				labelWidth: 200,
				inputValue: 'true',
				uncheckedValue: 'false'
		    },{
		        fieldLabel: 'Notify All Following Approvers',
		        name: 'NOTIFYALLAPPROVERS',
				xtype: 'checkboxfield',
				checked: true,
				inputValue: 'true',
				padding: '5 400 5 400',
				hidden: true,
				labelWidth: 200,
				uncheckedValue: 'false'
		    },{
		        fieldLabel: 'Notify Originator',
		        name: 'NOTIFYORIGINATOR',
				xtype: 'checkboxfield',
				checked: true,
				inputValue: 'true',
				padding: '5 400 5 400',
				labelWidth: 200,
				uncheckedValue: 'false'
		    },{
		        fieldLabel: 'Follow up form via email every (in hours)',
		        name: 'FREQUENCYFOLLOUP',
				xtype: 'numberfield',
				minValue: 1,
				maxValue: 24, 
				value: 0,
				padding: '5 400 5 400',
				labelWidth: 200,
				allowBlank: false
		    },{
		        fieldLabel: 'No. of Days Before Expiration',
		        name: 'EFORMSTAYTIME',
				xtype: 'numberfield',
				minValue: 0,
				maxValue: 100000,
				padding: '5 400 5 400',
				labelWidth: 200,
				allowBlank: false
		    },{
		        fieldLabel: 'Action if Expired',
		        name: 'EXPIREDACTION',
				xtype: 'combobox',
				store: 'view.actionstore',
				displayField: 'actionname',
				valueField: 'actioncode',
				padding: '5 400 5 400',
				labelWidth: 200,
				value: 'APPROVE'
		    },{
		        fieldLabel: 'Approve At Least',
		        name: 'APPROVEATLEAST',
				xtype: 'numberfield',
				minValue: 1,
				maxValue: 100000,
				value: 1,
				padding: '5 400 5 400',
				labelWidth: 200,
				allowBlank: false
		    },{
		        fieldLabel: 'With Conditions',
		        name: 'USECONDITIONS',
				xtype: 'checkboxfield',
				checked: false,
				inputValue: 'true',
				padding: '5 400 5 400',
				labelWidth: 200,
				uncheckedValue: 'false'
		    },{
		        fieldLabel: 'Auto Approve',
		        name: 'AUTOAPPROVE',
				xtype: 'checkboxfield',
				checked: false,
				inputValue: 'true',
				padding: '5 400 5 400',
				labelWidth: 200,
				uncheckedValue: 'false'
		    },{
		        fieldLabel: 'Is Last Router?',
		        name: 'ISLASTROUTER',
				xtype: 'checkboxfield',
				checked: false,
				inputValue: 'true',
				padding: '5 400 5 400',
				labelWidth: 200,
				uncheckedValue: 'false'
		    },{
		        fieldLabel: 'Maximum Approvers',
		        name: 'MAXIMUMAPPROVERS',
				minValue: 0,
				maxValue: 100000, 
				hidden: true,
				value: 0,
				padding: '5 400 5 400',
				labelWidth: 200,
				allowBlank: false
		    },{
		        fieldLabel: 'Allow Override?',
		        name: 'CANOVERRIDE',
				checked: true,
				xtype: 'checkboxfield',
				inputValue: 'true',
				padding: '5 400 5 400',
				labelWidth: 200,
				uncheckedValue: 'false'
		    },{
		        fieldLabel: 'Copy Notification To',
		        name: 'MOREEMAILADD',
				padding: '5 400 5 400',
				labelWidth: 200,
				xtype: 'textareafield'
		    }];
		// configs for BasicForm
		 this.api = {
				        // The server-side method to call for load() requests
				        load: Ext.ss.formrouter.getDetails,
				        // The server-side must mark the submit handler as a 'formHandler'
				        submit: Ext.ss.formrouter.submitRouterRecords
				    };
		// specify the order for the passed params
		
		this.buttons = [{
				text: 'Update',
				action: 'saverouterdetail'
		    },{
				text: 'Add',
				action: 'submitRouter'
			}];
			
		
    	this.paramOrder = ['actiontype'];
		this.callParent(arguments);
	}
	
   
   
});