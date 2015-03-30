Ext.define('OnlineApplication.view.recruitment.applicationonline.referencesView', { 
	extend: 'Ext.panel.Panel',
	alias: 'widget.referencesview',
	title: 'REFERENCES',
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
					cls: 'field-margin-center',
					value: '<b>Name*</b>',
					flex: 2
				},{
					xtype: 'displayfield',
					cls: 'field-margin-center',
					value: '<b>Occupation*</b>',
					flex: 2
				},{
					xtype: 'displayfield',
					cls: 'field-margin-center',
					value: '<b>Company*</b>',
					flex: 2
				},{
					xtype: 'displayfield',
					cls: 'field-margin-center',
					value: '<b>Contact Number*</b>',
					flex: 1
				}]
			},{
				xtype: 'container',
				width: '100%',
				layout: {
					type: 'hbox',
					align: 'stretch'
				},
				items: [{
					xtype: 'textfield',
					cls: 'field-margin',
					name: 'REFERENCENAME1',
					allowBlank: false,
					maxLength: 50,
					flex: 2
				},{
					xtype: 'textfield',
					cls: 'field-margin',
					name: 'REFERENCEOCCUPATION1',
					allowBlank: false,
					maxLength: 50,
					flex: 2
				},{
					xtype: 'textfield',
					cls: 'field-margin',
					name: 'REFERENCECOMPANY1',
					allowBlank: false,
					maxLength: 50,
					flex: 2
				},{
					xtype: 'textfield',
					cls: 'field-margin',
					name: 'REFERENCECONTACT1',
					vtype: 'numberonly',
					allowBlank: false,
					maxLength: 15,
					flex: 1
				}]
			},{
				xtype: 'container',
				width: '100%',
				layout: {
					type: 'hbox',
					align: 'stretch'
				},
				items: [{
					xtype: 'textfield',
					cls: 'field-margin',
					name: 'REFERENCENAME2',
					allowBlank: false,
					maxLength: 50,
					flex: 2
				},{
					xtype: 'textfield',
					cls: 'field-margin',
					name: 'REFERENCEOCCUPATION2',
					allowBlank: false,
					maxLength: 50,
					flex: 2
				},{
					xtype: 'textfield',
					cls: 'field-margin',
					name: 'REFERENCECOMPANY2',
					allowBlank: false,
					maxLength: 50,
					flex: 2
				},{
					xtype: 'textfield',
					cls: 'field-margin',
					name: 'REFERENCECONTACT2',
					vtype: 'numberonly',
					allowBlank: false,
					maxLength: 15,
					flex: 1
				}]
			},{
				xtype: 'container',
				width: '100%',
				layout: {
					type: 'hbox',
					align: 'stretch'
				},
				items: [{
					xtype: 'textfield',
					cls: 'field-margin',
					name: 'REFERENCENAME3',
					allowBlank: false,
					maxLength: 50,
					flex: 2
				},{
					xtype: 'textfield',
					cls: 'field-margin',
					name: 'REFERENCEOCCUPATION3',
					allowBlank: false,
					maxLength: 50,
					flex: 2
				},{
					xtype: 'textfield',
					cls: 'field-margin',
					name: 'REFERENCECOMPANY3',
					allowBlank: false,
					maxLength: 50,
					flex: 2
				},{
					xtype: 'textfield',
					cls: 'field-margin',
					name: 'REFERENCECONTACT3',
					vtype: 'numberonly',
					allowBlank: false,
					maxLength: 15,
					flex: 1
				}]
			}],
			
		this.callParent(arguments);
	}
	
   
   
});