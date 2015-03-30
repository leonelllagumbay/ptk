Ext.define('OnlineApplication.view.recruitment.applicationonline.extraCurricularView', { 
	extend: 'Ext.panel.Panel',
	alias: 'widget.extracurricularview',
	title: 'EXTRA CURRICULAR',
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
					value: '<b>Name of Organization</b>',
					flex: 1
				},{
					xtype: 'displayfield',
					cls: 'field-margin-center',
					value: '<b>Inclusive Dates</b>',
					flex: 1
				},{
					xtype: 'displayfield',
					cls: 'field-margin-center',
					value: '<b>Highest Position Held</b>',
					flex: 1
				}]
				
			},{
				xtype: 'button',
				action: 'trainingseminarone',
				text: 'Add extra curricular'
			}], 
			
		this.callParent(arguments);
	}
	
   
   
});