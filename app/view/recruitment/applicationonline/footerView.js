Ext.define('OnlineApplication.view.recruitment.applicationonline.footerView', { 
	extend: 'Ext.panel.Panel',
	alias: 'widget.footerview',
	width: '80%',
	height: '100%',
	autoScroll: true,
	defaults: {anchor: '100%'},
	buttonAlign: 'center',
    defaultType: 'textfield',
	initComponent: function() {   
		this.items = [{
				xtype: 'container',
				layout: {
					type: 'hbox',
					align: 'center'
				},
				items: [{
					xtype: 'displayfield',
					height: 90,
					width: 500,
					cls: 'field-margin',
					padding: '10 10 10 10',
					border: 1,
					margin: '10 10 10 60',
					style: {
					    borderStyle: 'solid'
					},
					value: '<p style="padding: 10px 10px 10px 30px;">I certify that the above information is true and correct and hereby authorize the company to verify said information. I understand that any misrepresentation and false information contained herein shall be considered sufficient cause for cancellation of my application or ground for my dismissal anytime during my employment.</p>'
				},{
				    height: 130,
					xtype: 'container',
					layout: {
						type: 'vbox',
						align: 'center'
					},
					items: [{
						xtype: 'radiofield',
						fieldLabel: 'I agree',
						padding: 10,
						checked: true,
						listeners: {
							change: function(thiss, newval, oldval, eOpts) {
							  if(newval == true) {
							  	var bropanel = Ext.getCmp('buttonsubmitid');
					                bropanel.setVisible(true); 
							  }	else {
							  	var bropanel = Ext.getCmp('buttonsubmitid');
					                bropanel.setVisible(false); 
							  }
							}
						},
						style: {
							marginLeft: 40,
							marginTop: 10
						},
						name: 'agree'
					},{
						xtype: 'radiofield',
						padding: 10,
						fieldLabel: 'I do not agree',
						style: {
							marginLeft: 40,
							marginTop: 10
						},
						name: 'agree'
					}]
				}]
			},{
				xtype: 'displayfield',
				id: 'thecaptchaa',
				name: 'mycaptcha',
				cls: 'field-margin-center',
				padding: '0 0 0 100',
				value: ' -- '
				
			},{
				xtype: 'button',
				text: 'Regenerate captcha',
				action: 'regeneratecaptcha',
				margin: '0 0 0 100',
			},{
				xtype: 'textfield',
				maxLength: 20,
				padding: '0 0 0 100',
				fieldLabel: 'Type the characters above (no spaces)',
				cls: 'field-margin',
				labelWidth: 260,
				name: 'capchaval',
				allowBlank: false,
				id: 'capchachavalddd',
				vtype: 'captcha'
			},{
				xtype: 'textfield',
				hidden: true,
				maxLength: 20,
				cls: 'field-margin',
				value: ' -- ',
				name: 'chapchacontenttent',
				id: 'chapchacontenttent'
			}],
			
		this.buttons = [{
			type: 'submit',
			action: 'submitonlineapp',
			text: '<b>Submit</b>',
			padding: '5 25 5 25',
			id: 'buttonsubmitid'
		}],
		
		this.callParent(arguments);
	}
	
   
   
});