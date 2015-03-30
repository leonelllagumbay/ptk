Ext.define('OnlineApplication.view.recruitment.applicationonline.familyBackgroundView', { 
	extend: 'Ext.panel.Panel',
	alias: 'widget.familybackgroundview',
	title: 'FAMILY BACKGROUND',
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
					align: 'left'
				},
				items: [{
					xtype: 'displayfield',
					flex: 5,
					value: '<b>Name</b>',
					cls: 'field-margin-center'
				},{
					xtype: 'displayfield',
					flex: 1,
					value: '<b>Age</b>',
					cls: 'field-margin-center'
				},{
					xtype: 'displayfield',
					flex: 3,
					value: '<b>Occupation</b>',
					cls: 'field-margin-center'
				},{
					xtype: 'displayfield',
					flex: 3,
					value: '<b>Company or School</b>',
					cls: 'field-margin-center'
				},{
					xtype: 'displayfield',
					flex: 2,
					value: '<b>Contact Number</b>',
					cls: 'field-margin-center'
				},{
					xtype: 'displayfield',
					flex: 2,
					value: '<b>Birthday</b>',
					cls: 'field-margin-center'
				}]
			},{
				xtype: 'container',
				width: '100%',
				layout: {
					type: 'hbox',
					align: 'left'
				},
				items: [{
					xtype: 'textfield',
					flex: 5,
					name: 'FATHERFULLNAME',
					fieldLabel: 'Father*',
					allowBlank: false,
					maxLength: 50,
					cls: 'field-margin'
				},{
					xtype: 'numberfield',
					flex: 1,
					name: 'FATHERAGE',
					cls: 'field-margin',
					allowBlank: false,
					value: 0,
					minValue: 0,
					maxValue: 99
				},{
					xtype: 'textfield',
					flex: 3,
					name: 'FATHEROCCUPATION',
					allowBlank: false,
					maxLength: 50,
					cls: 'field-margin'
				},{
					xtype: 'textfield',
					flex: 3,
					name: 'FATHERCOMPANY',
					allowBlank: false,
					maxLength: 50,
					cls: 'field-margin'
				},{
					xtype: 'textfield',
					flex: 2,
					name: 'FATHERCONTACTNO',
					allowBlank: false,
					maxLength: 15,
					vtype: 'numberonly',
					cls: 'field-margin'
				},{
					xtype: 'datefield',
					flex: 2,
					name: 'FATHERBIRTHDAY',
					allowBlank: true,
					cls: 'field-margin'
				}]
			},{
				xtype: 'container',
				width: '100%',
				layout: {
					type: 'hbox',
					align: 'left'
				},
				items: [{
					xtype: 'checkboxfield',
					flex: 5,
					name: 'FATHERDECEASED',
					fieldLabel: 'Deceased?',
					labelAlign: 'right',
					uncheckedValue: 'N',
					value: 'Y',
					maxLength: 50,
					cls: 'field-margin'
				}]
			},{
				xtype: 'container',
				width: '100%',
				layout: {
					type: 'hbox',
					align: 'center'
				},
				items: [{
					xtype: 'textfield',
					flex: 5,
					name: 'MOTHERFULLNAME',
					allowBlank: false,
					maxLength: 50,
					fieldLabel: 'Mother*',
					cls: 'field-margin'
				},{
					xtype: 'numberfield',
					flex: 1,
					name: 'MOTHERAGE',
					cls: 'field-margin',
					allowBlank: false,
					value: 0,
					minValue: 0,
					maxValue: 99
				},{
					xtype: 'textfield',
					flex: 3,
					name: 'MOTHEROCCUPATION',
					allowBlank: false,
					maxLength: 50,
					cls: 'field-margin'
				},{
					xtype: 'textfield',
					flex: 3,
					name: 'MOTHERCOMPANY',
					allowBlank: false,
					maxLength: 50,
					cls: 'field-margin'
				},{
					xtype: 'textfield',
					flex: 2,
					name: 'MOTHERCONTACTNO',
					allowBlank: false,
					maxLength: 15,
					vtype: 'numberonly',
					cls: 'field-margin'
				},{
					xtype: 'datefield',
					flex: 2,
					name: 'MOTHERBIRTHDAY',
					allowBlank: true,
					cls: 'field-margin'
				}]
			},{
				xtype: 'container',
				width: '100%',
				layout: {
					type: 'hbox',
					align: 'left'
				},
				items: [{
					xtype: 'checkboxfield',
					flex: 5,
					name: 'MOTHERDECEASED',
					fieldLabel: 'Deceased?',
					labelAlign: 'right',
					uncheckedValue: 'N',
					value: 'Y',
					maxLength: 50,
					cls: 'field-margin'
				}]
			},{
				xtype: 'container',
				id: 'spousepanelidid',
				width: '100%',
				layout: {
					type: 'hbox',
					align: 'center'
				},
				items: [{
					xtype: 'checkboxfield',
					name: 'SPOUSEDECEASED',
					uncheckedValue: 'N',
					hidden: true
				},{
					xtype: 'textfield',
					id: 'spouseididone',
					flex: 5,
					name: 'SPOUSEFULLNAME',
					fieldLabel: 'Spouse*',
					emptyText: '(if married)',
					allowBlank: false,
					maxLength: 50,
					cls: 'field-margin'
				},{
					xtype: 'numberfield',
					id: 'spouseididtwo',
					flex: 1,
					name: 'SPOUSEAGE',
					cls: 'field-margin',
					allowBlank: false,
					value: 0,
					minValue: 0,
					maxValue: 99
				},{
					xtype: 'textfield',
					id: 'spouseididthree',
					flex: 3,
					name: 'SPOUSEOCCUPATION',
					allowBlank: false,
					maxLength: 50,
					cls: 'field-margin'
				},{
					xtype: 'textfield',
					id: 'spouseididfour',
					flex: 3,
					name: 'SPOUSECOMPANY',
					allowBlank: false,
					maxLength: 50,
					cls: 'field-margin'
				},{
					xtype: 'textfield',
					flex: 2,
					name: 'SPOUSECONTACTNO',
					maxLength: 15,
					vtype: 'numberonly',
					cls: 'field-margin'
				},{
					xtype: 'datefield',
					flex: 2,
					name: 'SPOUSEBIRTHDAY',
					allowBlank: true,
					cls: 'field-margin'
				}]
			},{
				xtype: 'button',
				id: 'buttonchildone',
				text: 'Add a child',
				action: 'addchild'
			},{
				xtype: 'button',
				id: 'buttonbroone',
				text: 'Add Sibling',
				action: 'addsibling'
			},{
				xtype: 'displayfield',
				cls: 'field-margin',
				value: 'In case of emergency, please notify:'
			},{
				xtype: 'panel',
				width: '100%',
				layout: {
					type: 'hbox',
					align: 'left'
				},
				items: [{
					xtype: 'container',
						layout: {
						type: 'vbox',
						align: 'left'
					},
					items: [{
						xtype: 'textfield',
						cls: 'field-margin',
						name: 'INCASEEMERNAME',
						allowBlank: false,
						maxLength: 100,
						fieldLabel: 'Name*',
						width: 400
					},{
						xtype: 'textfield',
						cls: 'field-margin',
						name: 'INCASEEMERRELATION',
						allowBlank: false,
						maxLength: 30,
						fieldLabel: 'Relationship*',
						width: 400
					}]
				},{
					xtype: 'container',
						layout: {
						type: 'vbox',
						align: 'left'
					},
					items: [{
						xtype: 'textfield',
						padding: '0 0 0 100',
						labelWidth: 150,
						cls: 'field-margin',
						name: 'INCASEEMERCELLNUM',
						vtype: 'numberonly',
						allowBlank: false,
						maxLength: 15,
						fieldLabel: 'Cellphone Number*',
						width: 400
					},{
						xtype: 'textfield',
						padding: '0 0 0 100',
						labelWidth: 150,
						cls: 'field-margin',
						name: 'INCASEEMERTELNUM',
						vtype: 'numberonly',
						allowBlank: false,
						maxLength: 15,
						fieldLabel: 'Telephone Number*',
						width: 400
					}]
				}]
			},{
				xtype: 'displayfield',
				cls: 'field-margin',
				value: 'Relatives/Friends Working in Filinvest Group of Companies:'
			},{
				xtype: 'panel',
				layout: {
					type: 'hbox',
					align: 'stretch'
				},
				items: [{
					xtype: 'displayfield',
					cls: 'field-margin-center',
					flex: 1,
					value: '<b>Name</b>'
				},{
					xtype: 'displayfield',
					cls: 'field-margin-center',
					flex: 1,
					value: '<b>Company\'s Name or Occupation</b>'
				},{
					xtype: 'displayfield',
					cls: 'field-margin-center',
					flex: 1,
					value: '<b>Degree of Afinity</b>'
				}]
			},{
				xtype: 'container',
				layout: {
					type: 'hbox',
					align: 'stretch'
				},
				items: [{
					xtype: 'textfield',
					cls: 'field-margin',
					name: 'RELWORKINNAMEONE',
					maxLength: 30,
					flex: 1
				},{
					xtype: 'textfield',
					cls: 'field-margin',
					name: 'RELWORKINCOMPONE',
					maxLength: 50,
					flex: 1
				},{
					xtype: 'textfield',
					cls: 'field-margin',
					name: 'RELWORKINAFINITYONE',
					maxLength: 50,
					flex: 1
				}]
			},{
				xtype: 'container',
				layout: {
					type: 'hbox',
					align: 'stretch'
				},
				items: [{
					xtype: 'textfield',
					cls: 'field-margin',
					name: 'RELWORKINNAMETWO',
					maxLength: 30,
					flex: 1
				},{
					xtype: 'textfield',
					cls: 'field-margin',
					name: 'RELWORKINCOMPTWO',
					maxLength: 50,
					flex: 1
				},{
					xtype: 'textfield',
					cls: 'field-margin',
					name: 'RELWORKINAFINITYTWO',
					maxLength: 50,
					flex: 1
				}]
			},{
				xtype: 'container',
				layout: {
					type: 'hbox',
					align: 'stretch'
				},
				items: [{
					xtype: 'textfield',
					cls: 'field-margin',
					name: 'RELWORKINNAMETHREE',
					maxLength: 30,
					flex: 1
				},{
					xtype: 'textfield',
					cls: 'field-margin',
					name: 'RELWORKINCOMPTHREE',
					maxLength: 50,
					flex: 1
				},{
					xtype: 'textfield',
					cls: 'field-margin',
					name: 'RELWORKINAFINITYTHREE',
					maxLength: 50,
					flex: 1
				}]
			}],
		this.callParent(arguments);
	}
	
   
   
});