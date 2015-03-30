Ext.define('OnlineApplication.view.recruitment.applicationonline.personalInfoView', { 
	extend: 'Ext.panel.Panel',
	alias: 'widget.personalinfoview',
	title: 'PERSONAL INFORMATION',
	width: '80%', 
	height: '100%',
	autoScroll: true,
	defaults: {anchor: '100%'},
    defaultType: 'textfield',
    collapsible: true,
	initComponent: function() {   
		this.items = [{
				xtype: 'container',
				width: '100%',
				layout: {
					type: 'hbox',
					align: 'left'
				},
				items: [{
					xtype: 'textfield',
					fieldLabel: 'Last name*',
					name: 'LASTNAME',
					allowBlank: false,
					maxLength: 30,
					cls: 'field-margin',
					labelAlign: 'top',
					flex: 2
				},{
					xtype: 'textfield',
					name: 'FIRSTNAME',
					fieldLabel: 'First name*',
					allowBlank: false,
					maxLength: 30,
					cls: 'field-margin',
					labelAlign: 'top',
					flex: 2
				},{
					xtype: 'textfield',
					name: 'MIDDLENAME',
					fieldLabel: 'Middle name*',
					allowBlank: false,
					maxLength: 30,
					cls: 'field-margin',
					labelAlign: 'top',
					flex: 2
				},{
					xtype: 'textfield',
					name: 'SUFFIX',
					fieldLabel: 'Suffix',
					maxLength: 10,
					cls: 'field-margin',
					labelAlign: 'top',
					flex: 1
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
					name: 'PRESENTADDRESSPOSTAL',
					allowBlank: false,
					maxLength: 250,
					fieldLabel: 'Present Address and Postal Code*',
					cls: 'field-margin',
					labelAlign: 'top',
					flex: 6
				},{
					xtype: 'radiofield',
					name: 'PRESENTADDRESSOWN',
					fieldLabel: 'Owned',
					inputValue: 'Owned',
					checked: true,
					cls: 'field-margin',
					labelAlign: 'top',
					flex: 1
				},{
					xtype: 'radiofield',
					name: 'PRESENTADDRESSOWN',
					fieldLabel: 'Living with relatives',
					inputValue: 'Living with relatives',
					cls: 'field-margin',
					labelAlign: 'top',
					flex: 2
				},{
					xtype: 'radiofield',
					name: 'PRESENTADDRESSOWN',
					fieldLabel: 'Rented',
					inputValue: 'Rented',
					cls: 'field-margin',
					labelAlign: 'top',
					flex: 1
				},{
					xtype: 'radiofield',
					name: 'PRESENTADDRESSOWN',
					fieldLabel: 'Others',
					inputValue: ' ',
					cls: 'field-margin',
					labelAlign: 'top',
					flex: 1
				},{
					xtype: 'textfield',
					name: 'PRESENTADDRESSOWN',
					fieldLabel: 'Others, specify',
					maxLength: 15,
					cls: 'field-margin',
					labelAlign: 'top',
					flex: 3
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
					name: 'PROVINCIALADDRESSPOSTAL',
					allowBlank: false,
					maxLength: 250,
					fieldLabel: 'Probationary Address and Postal Code*',
					cls: 'field-margin',
					labelAlign: 'top',
					flex: 6
				},{
					xtype: 'radiofield',
					name: 'PROVINCEADDRESSOWN',
					fieldLabel: 'Owned',
					inputValue: 'Owned',
					checked: true,
					cls: 'field-margin',
					labelAlign: 'top',
					flex: 1
				},{
					xtype: 'radiofield',
					name: 'PROVINCEADDRESSOWN',
					fieldLabel: 'Living with relatives',
					inputValue: 'Living with relatives',
					cls: 'field-margin',
					labelAlign: 'top',
					flex: 2
				},{
					xtype: 'radiofield',
					name: 'PROVINCEADDRESSOWN',
					fieldLabel: 'Rented',
					inputValue: 'Rented',
					cls: 'field-margin',
					labelAlign: 'top',
					flex: 1
				},{
					xtype: 'radiofield',
					name: 'PROVINCEADDRESSOWN',
					fieldLabel: 'Others',
					inputValue: ' ',
					cls: 'field-margin',
					labelAlign: 'top',
					flex: 1
				},{
					xtype: 'textfield',
					name: 'PROVINCEADDRESSOWN',
					fieldLabel: 'Others, specify',
					maxLength: 15,
					cls: 'field-margin',
					labelAlign: 'top',
					flex: 3
				}]
			},{
				xtype: 'panel',
				width: '100%',
				layout: {
					type:'hbox',
					align: 'left'
				},
				items: [{
					xtype: 'textfield',
					fieldLabel: 'Cellphone Number*',
					name: 'CELLPHONENUMBER', 
					labelWidth: 130,
					allowBlank: false,
					maxLength: 15,
					width: 400,
					cls: 'field-margin',
					vtype: 'numberonly',
					flex: 2
				},{
					xtype: 'textfield',
					name: 'LANDLINENUMBER',
					fieldLabel: 'Landline Number',
					maxLength: 15,
					padding: '0 0 0 50',
					vtype: 'numberonly',
					labelWidth: 130,
					width: 400,
					cls: 'field-margin',
					flex: 2
				},{
					xtype: 'textfield',
					name: 'EMAILADDRESS',
					emptyText: 'myemail@someone.com',
					allowBlank: false,
					maxLength: 50,
					padding: '0 0 0 50',
					labelWidth: 130,
					width: 400,
					fieldLabel: 'Email Address*',
					cls: 'field-margin',
					vtype: 'email',
					flex: 2
				}]
			},{
				xtype: 'panel',
				width: '100%',
				layout: {
					type: 'hbox',
					align: 'left'
				},
				items: [{
					xtype: 'datefield',
					fieldLabel: 'Date of Birth*',
					name: 'DATEOFBIRTH', 
					cls: 'field-margin',
					allowBlank: false,
					labelAlign: 'top',
					listeners: {
						change: function(field,value) {
									var d1=new Date(value);
									var d2=new Date();
									var milli=d2-d1;
									var milliPerYear=1000*60*60*24*365.26;
									var yearsApart=milli/milliPerYear;
									yearsApart = Math.floor(yearsApart);
									var formPanel = field.up('form');
									var form = formPanel.getForm();
									form.setValues([{
										id: 'aaggeeid',
										value: yearsApart
									}]);
								}
					},
					flex: 3
				},{
					xtype: 'textfield',
					name: 'PLACEOFBIRTH',
					allowBlank: false,
					maxLength: 100,
					fieldLabel: 'Place of Birth*',
					cls: 'field-margin',
					labelAlign: 'top',
					flex: 4
				},{
					xtype: 'numberfield',
					name: 'AGE',
					id: 'aaggeeid',
					fieldLabel: 'Age*',
					cls: 'field-margin',
					labelAlign: 'top',
					allowBlank: false,
					value: 0,
					minValue: 0,
					maxValue: 99,
					flex: 1
				},{
					xtype: 'combobox',
					editable: false,
					fieldLabel: 'Gender*',
					name: 'GENDER',
					allowBlank: false,
					labelAlign: 'top',
					cls: 'field-margin',
					queryMode: 'local',
					store: 'recruitment.applicationonline.genderstore',
					displayField: 'gendername',
					valueField: 'gendercode',
					flex: 2
				},{
					xtype: 'combobox',
					editable: false,
					fieldLabel: 'Civil Status*',
					id: 'cciivviillstatusid',
					name: 'CIVILSTATUS',
					allowBlank: false,
					labelAlign: 'top',
					cls: 'field-margin',
					store: 'recruitment.applicationonline.civilstatusstore',
					displayField: 'civilstatusname',
					valueField: 'civilstatuscode',
					listeners: {
						change: function(field, value) {
					            var rex = /single|s(?![a-zA-Z])/i;
						        res = rex.exec(value);
							  	if(Array.isArray(res)) {
									var spousepanel = Ext.getCmp('spouseididone');
									Ext.apply(spousepanel, {allowBlank: true}, {});
									var spousepanel = Ext.getCmp('spouseididtwo');
									Ext.apply(spousepanel, {allowBlank: true}, {});
									var spousepanel = Ext.getCmp('spouseididthree');
									Ext.apply(spousepanel, {allowBlank: true}, {});
									var spousepanel = Ext.getCmp('spouseididfour');
									Ext.apply(spousepanel, {allowBlank: true}, {});
								} else {
									var spousepanel = Ext.getCmp('spouseididone');
									Ext.apply(spousepanel, {allowBlank: false}, {});
									var spousepanel = Ext.getCmp('spouseididtwo');
									Ext.apply(spousepanel, {allowBlank: false}, {});
									var spousepanel = Ext.getCmp('spouseididthree');
									Ext.apply(spousepanel, {allowBlank: false}, {});
									var spousepanel = Ext.getCmp('spouseididfour');
									Ext.apply(spousepanel, {allowBlank: false}, {});
								}
						}
					},
					flex: 2
				}]
			},{
				xtype: 'panel',
				width: '100%',
				layout: {
					type: 'hbox',
					align: 'left'
				},
				items: [{
					xtype: 'combobox',
					editable: true,
					fieldLabel: 'Citizenship*',
					name: 'CITIZENSHIP',
					allowBlank: false,
					labelAlign: 'top',
					cls: 'field-margin',
					store: 'recruitment.applicationonline.citizenshipstore',
					displayField: 'citizenshipname',
					valueField: 'citizenshipcode',
					flex: 3
				},{
					xtype: 'textfield',
					editable: true,
					fieldLabel: 'ACR No. ',
					name: 'ACRNUMBER',
					maxLength: 15,
					padding: '0 0 0 50',
					labelAlign: 'top',
					cls: 'field-margin',
					flex: 3
				},{
					xtype: 'combobox',
					editable: true,
					fieldLabel: 'Religion',
					padding: '0 0 0 50',
					name: 'RELIGION',
					labelAlign: 'top',
					cls: 'field-margin',
					store: 'recruitment.applicationonline.religionstore',
					displayField: 'religionname',
					valueField: 'religioncode',
					flex: 3
				}]
			},{
				xtype: 'panel',
				width: '100%',
				layout: {
					type: 'hbox',
					align: 'left'
				},
				items: [{
					xtype: 'textfield',
					fieldLabel: 'SSS',
					name: 'SSSNUMBER', 
					cls: 'field-margin',
					labelAlign: 'top',
					allowBlank: true,
					vtype: 'sssformat',
					emptyText: 'XX-XXXXXXX-X',
					flex: 2
				},{
					xtype: 'textfield',
					name: 'TINNUMBER',
					padding: '0 0 0 50',
					fieldLabel: 'TIN',
					cls: 'field-margin',
					labelAlign: 'top',
					allowBlank: true,
					vtype: 'tinformat',
					emptyText: 'XXX-XXX-XXX',
					flex: 2
				},{
					xtype: 'textfield',
					name: 'PHILHEALTHNUMBER',
					fieldLabel: 'PhilHealth',
					padding: '0 0 0 50',
					cls: 'field-margin',
					labelAlign: 'top',
					allowBlank: true,
					vtype: 'phformat',
					emptyText: 'XX-XXXXXXXXX-X',
					flex: 2
				},{
					xtype: 'textfield',
					name: 'PAGIBIGNUMBER',
					padding: '0 0 0 50',
					fieldLabel: 'PAG-IBIG',
					cls: 'field-margin',
					labelAlign: 'top',
					allowBlank: true,
					vtype: 'pagibigformat',
					emptyText: 'XXXX-XXXX-XXXX',
					flex: 2
				}]
			},{
				xtype: 'panel',
				width: '100%',
				layout: {
					type: 'hbox',
					align: 'left'
				},
				items: [{
					xtype: 'textfield',
					fieldLabel: 'Height',
					name: 'HEIGHT', 
					maxLength: 15,
					labelWidth: 70,
					cls: 'field-margin',
					flex: 4
				},{
					xtype: 'textfield',
					name: 'WEIGHT',
					fieldLabel: 'Weight',
					labelWidth: 70,
					padding: '0 0 0 30',
					cls: 'field-margin',
					maxLength: 15,
					flex: 4
				},{
					xtype: 'textfield',
					name: 'BLOODTYPE',
					fieldLabel: 'Blood Type',
					labelWidth: 70,
					padding: '0 0 0 30',
					cls: 'field-margin',
					maxLength: 2,
					flex: 4
				},{
					xtype: 'textfield',
					cls: 'field-margin',
					name: 'LANGUAGESPOKEN',
					fieldLabel: 'Languages and Dialects Spoken/Written',
					maxLength: 50,
					labelWidth: 230,
					flex: 11,
					padding: '0 0 0 30',
				}]
			}],
			
		this.callParent(arguments);
	}
	
   
   
});