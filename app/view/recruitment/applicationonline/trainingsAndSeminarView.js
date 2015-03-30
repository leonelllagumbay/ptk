Ext.define('OnlineApplication.view.recruitment.applicationonline.trainingsAndSeminarView', { 
	extend: 'Ext.panel.Panel',
	alias: 'widget.trainingsandseminarview',
	title: 'TRAININGS AND SEMINARS',
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
					value: '<b>Topic</b>',
					flex: 1
				},{
					xtype: 'displayfield',
					cls: 'field-margin-center',
					value: '<b>Date</b>',
					flex: 1
				},{
					xtype: 'displayfield',
					cls: 'field-margin-center',
					value: '<b>Organizer</b>',
					flex: 1
				}]
				
			},{
				xtype: 'button',
				action: 'trainingseminartwelve',
				text: 'Add'
			}],
			
		this.callParent(arguments);
	}
	
   
   
});