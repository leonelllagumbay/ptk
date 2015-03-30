Ext.define('OnlineApplication.view.recruitment.applicationonline.educationalBackgroundView', { 
	extend: 'Ext.panel.Panel',
	alias: 'widget.educationalbackgroundview',
	title: 'EDUCATIONAL BACKGROUND',
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
					value: '<b>Name of School</b>',
					flex: 7  
				},{
					xtype: 'displayfield',
					cls: 'field-margin-center',
					value: '<b>Field of Study</b>',
					hidden: true,
					flex: 5
				},{
					xtype: 'displayfield',
					cls: 'field-margin-center',
					value: '<b>Location</b>',
					flex: 3
				},{
					xtype: 'displayfield',
					cls: 'field-margin-center',
					value: '<b>Course</b>',
					flex: 5
				},{
					xtype: 'displayfield',
					cls: 'field-margin-center',
					value: '<b>Graduate?</b>',
					flex: 3
				},{
					xtype: 'displayfield',
					cls: 'field-margin-center',
					value: '<b>From</b>',
					flex: 3
				},{
					xtype: 'displayfield',
					cls: 'field-margin-center',
					value: '<b>To</b>',
					flex: 3
				},{
					xtype: 'displayfield',
					cls: 'field-margin-center',
					value: '<b>Honors/Awards</b>',
					flex: 6
				}]
			},{
				xtype: 'container',
				width: '100%',
				layout: {
					type: 'hbox',
					align: 'left'
				},
				items: [{
					xtype: 'combobox',
					cls: 'field-margin',
					fieldLabel: 'Post Graduate',
					labelAlign: 'top',
					minChars: 1,
					name: 'POSTGRADSCHOOL',
					maxLength: 100,
					store: 'recruitment.applicationonline.schoolstore',
					displayField: 'schoolname',
					valueField: 'schoolcode',
					pageSize: 20,
					flex: 7  
				},{
					xtype: 'combobox',
					cls: 'field-margin',
					name: 'POSTGRADFIELD',
					maxLength: 100,
					fieldLabel: ' ',
					labelAlign: 'top',
					store: 'recruitment.applicationonline.schoolfieldstore',
					displayField: 'fieldname',
					valueField: 'fieldcode',
					forceSelection: true,
					hidden: true,
					minChars: 1,
					pageSize: 20,
					flex: 5
				},{
					xtype: 'textfield',
					cls: 'field-margin',
					name: 'POSTGRADLOCATION',
					maxLength: 100,
					fieldLabel: ' ',
					labelAlign: 'top',
					flex: 3
				},{
					xtype: 'combobox',
					cls: 'field-margin',
					fieldLabel: ' ',
					labelAlign: 'top',
					minChars: 1,
					name: 'POSTGRADCOURSE',
					maxLength: 100,
					store: 'recruitment.applicationonline.schoolcoursestore',
					displayField: 'coursename',
					valueField: 'coursecode',
					pageSize: 20,
					flex: 5
				},{
					xtype: 'container',
					flex: 3,
					layout: {
						type: 'hbox',
						align: 'stretch'
					},
					items: [{
						xtype: 'radiofield',
						name: 'POSTGRADISGRAD',
						inputValue: 'Y',
						checked: false,
						flex: 1,
						style: {
							marginLeft: 20
						},
						labelAlign: 'top',
						fieldLabel: 'Yes'
					},{
						xtype: 'radiofield',
						name: 'POSTGRADISGRAD',
						inputValue: 'N',
						checked: true,
						flex: 1,
						labelAlign: 'top',
						fieldLabel: 'No'
					}]
				},{
					xtype: 'monthfield',
					format: 'F Y',
					cls: 'field-margin',
					name: 'POSTGRADFROM',
					fieldLabel: ' ',
					labelAlign: 'top',
					flex: 3
				},{
					xtype: 'monthfield',
					format: 'F Y',
					cls: 'field-margin',
					fieldLabel: ' ',
					labelAlign: 'top',
					name: 'POSTGRADTO',
					flex: 3
				},{
					xtype: 'textfield',
					cls: 'field-margin',
					fieldLabel: ' ',
					labelAlign: 'top',
					maxLength: 200,
					name: 'POSTGRADHONORS',
					flex: 6
				}]
			},{
				xtype: 'container',
				width: '100%',
				layout: {
					type: 'hbox',
					align: 'left'
				},
				items: [{
					xtype: 'combobox',
					cls: 'field-margin',
					fieldLabel: 'College*',
					labelAlign: 'top',
					minChars: 1,
					name: 'COLLEGESCHOOL',
					allowBlank: false,
					maxLength: 100,
					store: 'recruitment.applicationonline.schoolstore',
					displayField: 'schoolname',
					valueField: 'schoolcode',
					pageSize: 20,
					flex: 7  
				},{
					xtype: 'combobox',
					cls: 'field-margin',
					name: 'COLLEGEFIELD',
					maxLength: 100,
					fieldLabel: '*',
					labelAlign: 'top',
					store: 'recruitment.applicationonline.schoolfieldstore',
					displayField: 'fieldname',
					valueField: 'fieldcode',
					minChars: 1,
					forceSelection: true,
					hidden: true,
					pageSize: 20,
					flex: 5
				},{
					xtype: 'textfield',
					cls: 'field-margin',
					name: 'COLLEGELOCATION',
					allowBlank: false,
					maxLength: 100,
					fieldLabel: '*',
					labelAlign: 'top',
					flex: 3
				},{
					xtype: 'combobox',
					cls: 'field-margin',
					fieldLabel: '*',
					labelAlign: 'top',
					minChars: 1,
					name: 'COLLEGECOURSE',
					allowBlank: false,
					maxLength: 100,
					store: 'recruitment.applicationonline.schoolcoursestore',
					displayField: 'coursename',
					valueField: 'coursecode',
					pageSize: 20,
					flex: 5
				},{
					xtype: 'container',
					flex: 3,
					layout: {
						type: 'hbox',
						align: 'stretch'
					},
					items: [{
						xtype: 'radiofield',
						name: 'COLLEGEISGRAD1',
						inputValue: 'Y',
						flex: 1,
						style: {
							marginLeft: 20
						},
						labelAlign: 'top',
						fieldLabel: 'Yes'
					},{
						xtype: 'radiofield',
						name: 'COLLEGEISGRAD1',
						inputValue: 'N',
						checked: true,
						flex: 1,
						labelAlign: 'top',
						fieldLabel: 'No'
					}]
				},{
					xtype: 'monthfield',
					format: 'F Y',
					cls: 'field-margin',
					name: 'COLLEGEFROM',
					fieldLabel: ' ',
					labelAlign: 'top',
					flex: 3
				},{
					xtype: 'monthfield',
					format: 'F Y',
					cls: 'field-margin',
					fieldLabel: ' ',
					labelAlign: 'top',
					name: 'COLLEGETO',
					flex: 3
				},{
					xtype: 'textfield',
					cls: 'field-margin',
					fieldLabel: ' ',
					labelAlign: 'top',
					name: 'COLLEGEHONORS',
					maxLength: 200,
					flex: 6
				}]
			},{
				xtype: 'container',
				width: '100%',
				layout: {
					type: 'hbox',
					align: 'left'
				},
				items: [{
					xtype: 'button',
					action: 'addschool',
					text: 'Add school'
				}]
			},{
				xtype: 'container',
				width: '100%',
				layout: {
					type: 'hbox',
					align: 'left'
				},
				items: [{
					xtype: 'combobox',
					cls: 'field-margin',
					fieldLabel: 'Vocational',
					labelAlign: 'top',
					minChars: 1,
					name: 'VOCATIONALSCHOOL',
					maxLength: 100,
					store: 'recruitment.applicationonline.schoolstore',
					displayField: 'schoolname',
					valueField: 'schoolcode',
					pageSize: 20,
					flex: 7  
				},{
					xtype: 'combobox',
					cls: 'field-margin',
					name: 'VOCATIONALFIELD',
					maxLength: 100,
					fieldLabel: ' ',
					labelAlign: 'top',
					store: 'recruitment.applicationonline.schoolfieldstore',
					displayField: 'fieldname',
					valueField: 'fieldcode',
					forceSelection: true,
					minChars: 1,
					pageSize: 20,
					hidden: true,
					flex: 5
				},{
					xtype: 'textfield',
					cls: 'field-margin',
					name: 'VOCATIONALLOCATION',
					maxLength: 100,
					fieldLabel: ' ',
					labelAlign: 'top',
					flex: 3
				},{
					xtype: 'combobox',
					cls: 'field-margin',
					fieldLabel: ' ',
					labelAlign: 'top',
					minChars: 1,
					name: 'VOCATIONALCOURSE',
					maxLength: 100,
					store: 'recruitment.applicationonline.schoolcoursestore',
					displayField: 'coursename',
					valueField: 'coursecode',
					pageSize: 20,
					flex: 5
				},{
					xtype: 'container',
					flex: 3,
					layout: {
						type: 'hbox',
						align: 'stretch'
					},
					items: [{
						xtype: 'radiofield',
						name: 'VOCATIONALISGRAD',
						inputValue: 'Y',
						flex: 1,
						style: {
							marginLeft: 20
						},
						labelAlign: 'top',
						fieldLabel: 'Yes'
					},{
						xtype: 'radiofield',
						name: 'VOCATIONALISGRAD',
						inputValue: 'N',
						checked: true,
						flex: 1,
						labelAlign: 'top',
						fieldLabel: 'No'
					}]
				},{
					xtype: 'monthfield',
					format: 'F Y',
					cls: 'field-margin',
					name: 'VOCATIONALFROM',
					fieldLabel: ' ',
					labelAlign: 'top',
					flex: 3
				},{
					xtype: 'monthfield',
					format: 'F Y',
					cls: 'field-margin',
					fieldLabel: ' ',
					labelAlign: 'top',
					name: 'VOCATIONALTO',
					flex: 3
				},{
					xtype: 'textfield',
					cls: 'field-margin',
					fieldLabel: ' ',
					labelAlign: 'top',
					name: 'VOCATIONALHONORS',
					maxLength: 200,
					flex: 6
				}]
			},{
				xtype: 'container',
				width: '100%',
				layout: {
					type: 'hbox',
					align: 'left'
				},
				items: [{
					xtype: 'combobox',
					cls: 'field-margin',
					fieldLabel: 'Secondary',
					labelAlign: 'top',
					minChars: 1,
					name: 'SECONDARYSCHOOL',
					maxLength: 100,
					store: 'recruitment.applicationonline.schoolstore',
					displayField: 'schoolname',
					valueField: 'schoolcode',
					pageSize: 20,
					flex: 7  
				},{
					xtype: 'combobox',
					cls: 'field-margin',
					name: 'SECONDARYFIELD',
					maxLength: 100,
					fieldLabel: ' ',
					labelAlign: 'top',
					store: 'recruitment.applicationonline.schoolfieldstore',
					displayField: 'fieldname',
					valueField: 'fieldcode',
					minChars: 1,
					forceSelection: true,
					pageSize: 20,
					hidden: true,
					flex: 5
				},{
					xtype: 'textfield',
					cls: 'field-margin',
					name: 'SECONDARYLOCATION',
					maxLength: 100,
					fieldLabel: ' ',
					labelAlign: 'top',
					flex: 3
				},{
					xtype: 'combobox',
					cls: 'field-margin',
					fieldLabel: ' ',
					labelAlign: 'top',
					minChars: 1,
					name: 'SECONDARYCOURSE',
					maxLength: 100,
					store: 'recruitment.applicationonline.schoolcoursestore',
					displayField: 'coursename',
					valueField: 'coursecode',
					pageSize: 20,
					flex: 5
				},{
					xtype: 'container',
					flex: 3,
					layout: {
						type: 'hbox',
						align: 'stretch'
					},
					items: [{
						xtype: 'radiofield',
						name: 'SECONDARYISGRAD',
						inputValue: 'Y',
						flex: 1,
						style: {
							marginLeft: 20
						},
						labelAlign: 'top',
						fieldLabel: 'Yes'
					},{
						xtype: 'radiofield',
						name: 'SECONDARYISGRAD',
						inputValue: 'N',
						checked: true,
						flex: 1,
						labelAlign: 'top',
						fieldLabel: 'No'
					}]
				},{
					xtype: 'monthfield',
					format: 'F Y',
					cls: 'field-margin',
					name: 'SECONDARYFROM',
					fieldLabel: ' ',
					labelAlign: 'top',
					flex: 3
				},{
					xtype: 'monthfield',
					format: 'F Y',
					cls: 'field-margin',
					fieldLabel: ' ',
					labelAlign: 'top',
					name: 'SECONDARYTO',
					flex: 3
				},{
					xtype: 'textfield',
					cls: 'field-margin',
					fieldLabel: ' ',
					labelAlign: 'top',
					name: 'SECONDARYHONORS',
					maxLength: 200,
					flex: 6
				}]
			}],
			
		this.callParent(arguments);
	}
	
   
   
});