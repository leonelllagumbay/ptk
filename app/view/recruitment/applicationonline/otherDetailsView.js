Ext.define('OnlineApplication.view.recruitment.applicationonline.otherDetailsView', { 
	extend: 'Ext.panel.Panel',
	alias: 'widget.otherdetailsview',
	title: 'OTHER DETAILS',
	width: '80%', 
	height: '100%',
	autoScroll: true,
	collapsible: true,
	defaults: {anchor: '100%'},
    defaultType: 'textfield',
	initComponent: function() {   
		this.items = [{
				xtype: 'panel',
				width: '100%',
				layout: {
					type: 'hbox',
					align: 'stretch'
				},
				items: [{
					xtype: 'displayfield',
					cls: 'field-margin',
					hidden: true,
					value: 'Do you have any physical defects?',
					flex: 5
				},{
					xtype: 'radiofield',
					cls: 'field-margin',
					hidden: true,
					inputValue: 'Y',
					labelAlign: 'top',
					fieldLabel: 'Yes',
					name: 'HASPHYSICALDEFFECTS',
					flex: 1
				},{
					xtype: 'radiofield',
					cls: 'field-margin',
					checked: true,
					hidden: true,
					inputValue: 'N',
					labelAlign: 'top',
					fieldLabel: 'No',
					name: 'HASPHYSICALDEFFECTS',
					flex: 1
				},{
					xtype: 'textfield',
					hidden: true,
					cls: 'field-margin',
					name: 'HASPHYSICALDEFFECTSNATURE',
					maxLength: 100,
					emptyText: 'If so, state nature',
					flex: 5
				}]
			},{
				xtype: 'panel',
				width: '100%',
				layout: {
					type: 'hbox',
					align: 'stretch'
				},
				items: [{
					xtype: 'displayfield',
					cls: 'field-margin',
					value: 'Have you ever had any serious physical or mental illness?',
					flex: 5
				},{
					xtype: 'radiofield',
					cls: 'field-margin',
					inputValue: 'Y',
					labelAlign: 'top',
					fieldLabel: 'Yes',
					name: 'HASOPILLNESS',
					flex: 1
				},{
					xtype: 'radiofield',
					cls: 'field-margin',
					checked: true,
					inputValue: 'N',
					labelAlign: 'top',
					fieldLabel: 'No',
					name: 'HASOPILLNESS',
					flex: 1
				},{
					xtype: 'textfield',
					cls: 'field-margin',
					name: 'HASOPILLNESSNATURE',
					maxLength: 100,
					emptyText: 'If so, state nature',
					flex: 5
				}]
			},{
				xtype: 'panel',
				width: '100%',
				layout: {
					type: 'hbox',
					align: 'stretch'
				},
				items: [{
					xtype: 'displayfield',
					cls: 'field-margin',
					value: 'Do you have any allergies? Please specify.',
					flex: 5
				},{
					xtype: 'radiofield',
					cls: 'field-margin',
					inputValue: 'Y',
					labelAlign: 'top',
					fieldLabel: 'Yes',
					name: 'HASDRUGSENSITIVE',
					flex: 1
				},{
					xtype: 'radiofield',
					cls: 'field-margin',
					inputValue: 'N',
					checked: true,
					labelAlign: 'top',
					fieldLabel: 'No',
					name: 'HASDRUGSENSITIVE',
					flex: 1
				},{
					xtype: 'textfield',
					cls: 'field-margin',
					name: 'HASDRUGSENSITIVENATURE',
					maxLength: 100,
					emptyText: 'If so, state nature',
					flex: 5
				}]
			},{
				xtype: 'panel',
				width: '100%',
				layout: {
					type: 'hbox',
					align: 'stretch'
				},
				items: [{
					xtype: 'displayfield',
					cls: 'field-margin',
					value: 'Are you engaged in the use and trade of dangerous drugs?',
					flex: 5
				},{
					xtype: 'radiofield',
					cls: 'field-margin',
					inputValue: 'Y',
					labelAlign: 'top',
					fieldLabel: 'Yes',
					name: 'HASENGAGEDRUGS',
					flex: 1
				},{
					xtype: 'radiofield',
					cls: 'field-margin',
					checked: true,
					inputValue: 'N',
					labelAlign: 'top',
					fieldLabel: 'No',
					name: 'HASENGAGEDRUGS',
					flex: 1
				},{
					xtype: 'textfield',
					cls: 'field-margin',
					name: 'HASENGAGEDRUGSNATURE',
					maxLength: 100,
					emptyText: 'If so, state nature',
					flex: 5
				}]
			},{
				xtype: 'panel',
				width: '100%',
				layout: {
					type: 'hbox',
					align: 'stretch'
				},
				items: [{
					xtype: 'displayfield',
					cls: 'field-margin',
					value: 'Are you engaged in any other businesses?',
					flex: 5
				},{
					xtype: 'radiofield',
					cls: 'field-margin',
					inputValue: 'Y',
					labelAlign: 'top',
					fieldLabel: 'Yes',
					name: 'HASINVOLVEBUSI',
					flex: 1
				},{
					xtype: 'radiofield',
					cls: 'field-margin',
					checked: true,
					inputValue: 'N',
					labelAlign: 'top',
					fieldLabel: 'No',
					name: 'HASINVOLVEBUSI',
					flex: 1
				},{
					xtype: 'textfield',
					cls: 'field-margin',
					name: 'HASINVOLVEBUSINATURE',
					maxLength: 100,
					emptyText: 'If so, state nature',
					flex: 5
				}]
				
			},{
				xtype: 'panel',
				width: '100%',
				layout: {
					type: 'hbox',
					align: 'stretch'
				},
				items: [{
					xtype: 'displayfield',
					cls: 'field-margin',
					value: 'Have you been dismissed or suspended in your previous employments?',
					flex: 5
				},{
					xtype: 'radiofield',
					cls: 'field-margin',
					inputValue: 'Y',
					labelAlign: 'top',
					fieldLabel: 'Yes',
					name: 'HASSUSPENDED',
					flex: 1
				},{
					xtype: 'radiofield',
					cls: 'field-margin',
					checked: true,
					inputValue: 'N',
					labelAlign: 'top',
					fieldLabel: 'No',
					name: 'HASSUSPENDED',
					flex: 1
				},{
					xtype: 'textfield',
					cls: 'field-margin',
					name: 'HASSUSPENDEDNATURE',
					maxLength: 100,
					emptyText: 'If so, state nature',
					flex: 5
				}]
			},{
				xtype: 'panel',
				width: '100%',
				layout: {
					type: 'hbox',
					align: 'stretch'
				},
				items: [{
					xtype: 'displayfield',
					cls: 'field-margin',
					value: 'Have you ever been convicted in any administrative, civil or criminal case?',
					flex: 5
				},{
					xtype: 'radiofield',
					cls: 'field-margin',
					inputValue: 'Y',
					labelAlign: 'top',
					fieldLabel: 'Yes',
					name: 'HASCRIMINAL',
					flex: 1
				},{
					xtype: 'radiofield',
					cls: 'field-margin',
					checked: true,
					inputValue: 'N',
					labelAlign: 'top',
					fieldLabel: 'No',
					name: 'HASCRIMINAL',
					flex: 1
				},{
					xtype: 'textfield',
					cls: 'field-margin',
					name: 'HASCRIMINALNATURE',
					maxLength: 100,
					emptyText: 'If so, state nature',
					flex: 5
				}]
			}],
			
			
		this.callParent(arguments);
	}
	
   
   
});