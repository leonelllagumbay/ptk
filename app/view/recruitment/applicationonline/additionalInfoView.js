Ext.define('OnlineApplication.view.recruitment.applicationonline.additionalInfoView', { 
	extend: 'Ext.panel.Panel',
	alias: 'widget.additionalinfoview',
	title: 'ADDITIONAL INFORMATION',
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
					value: '<b>Government or Licensure Exam Passed</b>',
					flex: 1
				},{
					xtype: 'displayfield',
					cls: 'field-margin-center',
					value: '<b>Date Taken</b>',
					flex: 1
				},{
					xtype: 'displayfield',
					cls: 'field-margin-center',
					value: '<b>Rating</b>',
					flex: 1
				}]
				
			},{
				xtype: 'button',
				action: 'trainingseminarseven',
				text: 'Add'
			},{
				xtype: 'textfield',
				cls: 'field-margin',
				name: 'BOARDEXAMRESULT',
				fieldLabel: 'Board Exam Results and Ratings',
				maxLength: 100,
				labelWidth: 300,
				width: 600
			},{
				xtype: 'textfield',
				cls: 'field-margin',
				name: 'LICENSECERT',
				fieldLabel: 'License and Certification of Present Profession',
				maxLength: 100,
				labelWidth: 300,
				width: 600
			},{
				xtype: 'textfield',
				cls: 'field-margin',
				name: 'LICENSENUMBER',
				fieldLabel: 'License Number',
				maxLength: 50,
				labelWidth: 300,
				width: 600
			}],  
			
			
		this.callParent(arguments);
	}
	
   
   
});