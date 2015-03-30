Ext.define('OnlineApplication.view.recruitment.applicationonline.employmentHistoryView', { 
	extend: 'Ext.panel.Panel',
	alias: 'widget.employmenthistoryview',
	title: 'EMPLOYMENT HISTORY',
	width: '80%', 
	height: '100%',
	autoScroll: true,
	collapsible: true,
	defaults: {anchor: '100%'},
    defaultType: 'textfield',
	initComponent: function() {   
		this.items = [{
				xtype: 'displayfield',
				value: 'Fill-up the following legibly. Start from the most recent employment.',
				cls: 'field-margin'
			},{
				xtype: 'panel',
				width: '100%',
				layout: {
					type: 'hbox',
					align: 'left'
				},
				items: [{
					xtype: 'container',
					flex: 1,
					layout: {
						type: 'vbox',
						align: 'left'
					},
					items: [{
						xtype: 'textfield',
						cls: 'field-margin',
						width: 400,
						fieldLabel: 'Company Name',
						maxLength: 50,
						name: 'EMPHISTORYNAME'
					},{
						xtype: 'textfield',
						width: 400,
						cls: 'field-margin',
						fieldLabel: 'Company Address',
						maxLength: 100,
						name: 'EMPHISTORYADDRESS'
					},{
						xtype: 'textfield',
						width: 400,
						cls: 'field-margin',
						fieldLabel: 'Contact Information',
						maxLength: 200,
						name: 'EMPHISTORYCONTACTINFO'
					},{  
						xtype: 'textfield',
						width: 400,
						cls: 'field-margin',
						fieldLabel: 'Last Position Held',
						maxLength: 50,
						name: 'EMPHISTORYLASTPOS'
					},{
						xtype: 'textareafield',
						width: 400,
						cls: 'field-margin',
						fieldLabel: 'Major Accomplishments',
						maxLength: 200,
						name: 'EMPHISTORYACCOMPLISHMENT'
					},{
						xtype: 'textareafield',
						width: 400,
						cls: 'field-margin',
						fieldLabel: 'Reason/s for leaving',
						maxLength: 255,
						name: 'EMPHISTORYLEAVEREASONS'
					}]  
				},{
					xtype: 'container',
					flex: 1,
					layout: {
						type: 'vbox',
						align: 'left'
					},
					items: [{
						xtype: 'monthfield',
					    format: 'F Y',
						cls: 'field-margin',
						fieldLabel: 'Date Employed',
						width: 400,
						name: 'EMPHISTORYDATEEMP'
					},{
						xtype: 'monthfield',
					    format: 'F Y',
						width: 400,
						cls: 'field-margin',
						fieldLabel: 'Date Separated',
						name: 'EMPHISTORYDATESEP'
						
					},{
						xtype: 'numberfield',
						width: 400,
						cls: 'field-margin',
						fieldLabel: 'Initial Salary',
						name: 'EMPHISTORYINISALARY',
						allowBlank: false,
						value: 0,
						hidden: true,
						minValue: 0,
						maxValue: 1000000
					},{
						xtype: 'numberfield',
						width: 400,
						cls: 'field-margin',
						fieldLabel: 'Last Salary',
						name: 'EMPHISTORYLASTSALARY',
						allowBlank: false,
						value: 0,
						minValue: 0,
						maxValue: 1000000
					},{
						xtype: 'textfield',
						width: 400,
						cls: 'field-margin',
						fieldLabel: 'Immediate Superior',
						maxLength: 30,
						name: 'EMPHISTORYSUPERIOR'
					},{
						xtype: 'textfield',
						width: 400,
						cls: 'field-margin',
						fieldLabel: 'Position',
						maxLength: 50,
						name: 'EMPHISTORYPOSITION'
					},{
						xtype: 'textfield',
						width: 400,
						cls: 'field-margin',
						fieldLabel: 'Contact Number',
						vtype: 'numberonly',
						maxLength: 15,
						name: 'EMPHISTORYCONTACTNO'
					}]
				}]
			},{
				xtype: 'button',
				action: 'ehistoryone',
				text: 'Add'
			}],
			
			
		this.callParent(arguments);
	}
	
   
   
});