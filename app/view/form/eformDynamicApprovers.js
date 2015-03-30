Ext.define('Form.view.form.eformDynamicApprovers', {
	extend: 'Ext.window.Window',
	alias: 'widget.eformdynamicapprovers',
	height: 410,
	width: 400,
	title: 'Select Approvers',
	autoDestroy: true,
	modal: true,
	 
	initComponent: function() {
			this.items = [{
					xtype: 'form',
					flex: 1,
					items: [{
						xtype: 'combobox', 
						name: 'userpid',
						fieldLabel: 'User',
						store: 'form.userStore',
						displayField: 'username',
						valueField: 'usercode',
						minChars: 1,
						pageSize: 20,
						width: 300,
						action: 'selecteduser', 
						padding: '5 5 5 5'
					},{
						xtype: 'combobox',
						name: 'userrole',
						fieldLabel: 'User Role',
						width: 300,
						padding: '5 5 5 5',
						store: 'form.rolestore',
						displayField: 'rolename',
						valueField: 'rolecode',
						pageSize: 25,
						minChars: 1
					},{
						xtype: 'textfield',
						hidden: true,
						name: 'routerorder'
					},{
						xtype: 'textfield',
						hidden: true,
						name: 'templaterouterid'
					},{
						xtype: 'textfield',
						hidden: true,
						name: 'eformid'
					},{
						xtype: 'displayfield',
						fieldLabel: 'Maximum',
						padding: '5 5 5 5',
						name: 'maximum'
					},{
						xtype: 'textfield',
						hidden: true,
						name: 'processid'
					},{
						xtype: 'textfield',
						hidden: true,
						name: 'level'
					},{
						xtype: 'textfield',
						hidden: true,
						name: 'table'
					}],
					api: {
						load: Ext.ss.defmain.getDetails,
						submit: Ext.ss.defmain.sendemailNow
					},
					buttons: [{
						text: 'Add',
						action: 'add'
					},{
						text: 'Remove',
						action: 'remove'
					},{
						text: 'Continue',
						action: 'continue'
					}]
					
			},{
				xtype: 'grid',
				width: '100%',
				height: 200,
				multiSelect: true,
				selModel: {
					    pruneRemoved: false 
				},
				store: 'form.eformDynamicUser',
				bbar: Ext.create('Ext.toolbar.Paging', {
				        store: 'form.eformDynamicUser', 
				        displayInfo: true,
				        emptyMsg: "No topics to display"
				}),
				columns: [{
			            	xtype: 'rownumberer',
			            	width: 50,
			            	sortable: false
				       },{
					   	    text: 'Personnel Id No',
							dataIndex: 'PERSONNELIDNO',
							hidden: true
					   },{
					   	    text: 'First Name',
							dataIndex: 'FIRSTNAME',
							flex: 2
					   },{
					   	    text: 'Middle Name',
							dataIndex: 'MIDDLENAME',
							hidden: true,
							flex: 2
							
					   },{
					   	    text: 'Last Name',
							dataIndex: 'LASTNAME',
							flex: 2
					   }]
			}];
				 
				
				this.callParent(arguments);
			}
})
