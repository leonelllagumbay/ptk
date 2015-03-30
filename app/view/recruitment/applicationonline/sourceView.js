Ext.define('OnlineApplication.view.recruitment.applicationonline.sourceView', { 
	extend: 'Ext.panel.Panel',
	alias: 'widget.sourceview',
	title: 'SOURCE',
	width: '80%', 
	height: '100%',
	autoScroll: true,
	collapsible: true,
	defaults: {anchor: '100%'},
    defaultType: 'textfield',
	initComponent: function() {   
		this.items = [{
				xtype: 'displayfield',
				cls: 'field-margin',
				value: 'How did you come to know about this job opening?'
			},{
				xtype: 'radiofield',
				checked: true,
				inputValue: 'companysite',
				fieldLabel: 'Company Career Site',
				cls: 'field-margin',
				name: 'SOURCEEMPLOYMENT'
			},{
				xtype: 'container',
				layout: {
					type: 'hbox',
					align: 'left'
				},
				items: [{
					xtype: 'radiofield',
					fieldLabel: 'Online',
					cls: 'field-margin',
					inputValue: 'online',
					name: 'SOURCEEMPLOYMENT',
					action: 'online'
				},{
					xtype: 'textfield',
					fieldLabel: 'Web Site',
					padding: '0 0 0 50',
					maxLength: 100,
					width: 400,
					hidden: true,
					name: 'WEBSITE'
				}]
			},{
				xtype: 'radiofield',
				inputValue: 'walkin',
				fieldLabel: 'Walk-in',
				cls: 'field-margin',
				name: 'SOURCEEMPLOYMENT'
			},{
				xtype: 'container',
				layout: {
					type: 'hbox',
					align: 'left'
				},
				items: [{
					xtype: 'radiofield',
					fieldLabel: 'Jobfair',
					cls: 'field-margin',
					inputValue: 'jobfair',
					name: 'SOURCEEMPLOYMENT',
					action: 'jobfair'
				},{
					xtype: 'textfield',
					fieldLabel: 'Where',
					padding: '0 0 0 50',
					maxLength: 100,
					style: {
						marginLeft: 25,
						marginTop: 5
					},
					hidden: true,
					name: 'SOURCEJOBFAIRWHERE'
				},{
					xtype: 'monthfield',
					format: 'F Y',
					padding: '0 0 0 50',
					fieldLabel: 'Date',
					style: {
						marginLeft: 25,
						marginTop: 5
					},
					hidden: true,
					name: 'SOURCEJOBFAIRDATE'
				}]
			},{
				xtype: 'container',
				layout: {
					type: 'hbox',
					align: 'left'
				},
				items: [{
					xtype: 'radiofield',
					inputValue: 'referral',
					fieldLabel: 'Referral',
					cls: 'field-margin',
					name: 'SOURCEEMPLOYMENT',
					action: 'referral'
				},{
					xtype: 'textfield',
					maxLength: 30,
					padding: '0 0 0 50',
					fieldLabel: 'Referred by',
					style: {
						marginLeft: 25,
						marginTop: 5
					},
					hidden: true,
					name: 'SOURCEREFERREDBY'
				}]
			},{
				xtype: 'container',
				layout: {
					type: 'hbox',
					align: 'left'
				},
				items: [{
					xtype: 'radiofield',
					inputValue: 'other',
					fieldLabel: 'Other',
					cls: 'field-margin',
					name: 'SOURCEEMPLOYMENT',
					action: 'other'
				},{
					xtype: 'textfield',
					maxLength: 50,
					padding: '0 0 0 50',
					fieldLabel: 'Specify',
					hidden: true,
					style: {
						marginLeft: 25,
						marginTop: 5
					},
					name: 'SOURCEOTHERVALUE'
				}]
			}],
			
		this.callParent(arguments);
	}
	
   
   
});