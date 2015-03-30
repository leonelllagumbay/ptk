Ext.define('OnlineApplication.view.recruitment.applicationonline.specialSkillsView', { 
	extend: 'Ext.panel.Panel',
	alias: 'widget.specialskillsview',
	title: 'SPECIAL SKILLS',
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
					value: '<b>Equipment … Software and Others you are familiar with:</b>',
					flex: 6
				},{
					xtype: 'displayfield',
					cls: 'field-margin-center',
					value: '<b>Years of Experience</b>',
					hidden: true,
					flex: 1
				},{
					xtype: 'displayfield',
					cls: 'field-margin-center',
					value: '<b>Level of Expertise</b>',
					flex: 3
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
					name: 'SPECIALSKILLS',
					maxLength: 255,
					flex: 6
				},{
					xtype: 'numberfield',
					value: 0,
					minValue: 0,
					maxValue: 99,
					cls: 'field-margin',
					name: 'SPECIALSKILLSYEARSP',
					hidden: true,
					flex: 1
				},{
					xtype: 'combobox',
					cls: 'field-margin',
					name: 'SPECIALSKILLSLEVEL',
					maxLength: 35,
					store: 'recruitment.applicationonline.specialskillstore',
					displayField: 'skillname',
					valueField: 'skillcode',
					flex: 3
				}]
			},{
				xtype: 'button',
				action: 'specialskills',
				text: 'Add'
			}],
			
			
		this.callParent(arguments);
	}
	
   
   
});