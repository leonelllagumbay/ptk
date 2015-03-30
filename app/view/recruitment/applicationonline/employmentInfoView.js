Ext.define('OnlineApplication.view.recruitment.applicationonline.employmentInfoView', { 
	extend: 'Ext.panel.Panel',
	alias: 'widget.employmentinfoview',
	title: 'EMPLOYMENT INFORMATION',
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
				value: 'Positions Applied For:'
				
			},{
				xtype: 'container',
				width: '100%',
				layout: {
					type: 'hbox',
					align: 'stretch'
				},
				items: [{
						fieldLabel: 'First Choice',
						allowBlank: false,
						name: 'POSITIONFIRSTPRIORITY',
						xtype: 'combobox',
						cls: 'field-margin',
						value: getURLParameter('position') || getURLParameter('positioncode') || '',
						labelAlign: 'top',
						width: 350,
						store: 'recruitment.applicationonline.positionstore',
						minChars: 1,
						editable: false,
						pageSize: 20,
						displayField: 'positionname',
						valueField: 'positioncode'
				},{
						fieldLabel: 'First Choice Company',
						allowBlank: false,
						name: 'COMPANYFIRSTPRIORITY',
						value: getURLParameter('companycode') || getURLParameter('company') || '',
						xtype: 'combobox',
						cls: 'field-margin',
						labelAlign: 'top',
						width: 350,
						store: 'recruitment.applicationonline.companystore',
						minChars: 1,
						editable: false,
						pageSize: 20,
						displayField: 'companyname',
						valueField: 'companycode'
				}]
			},{
				xtype: 'container',
				width: '100%',
				layout: {
					type: 'hbox',
					align: 'stretch'
				},
				items: [{
						fieldLabel: 'Second Choice',
						name: 'POSITIONSECONDPRIORITY',
						xtype: 'combobox',
						cls: 'field-margin',
						labelAlign: 'top',
						width: 350,
						store: 'recruitment.applicationonline.positionstore',
						minChars: 1,
						forceSelection: true,
						pageSize: 20,
						displayField: 'positionname',
						valueField: 'positioncode'
				},{
						fieldLabel: 'Second Choice Company',
						name: 'COMPANYSECONDPRIORITY',
						xtype: 'combobox',
						cls: 'field-margin',
						labelAlign: 'top',
						width: 350,
						store: 'recruitment.applicationonline.companystore',
						minChars: 1,
						forceSelection: true,
						pageSize: 20,
						displayField: 'companyname',
						valueField: 'companycode'
				}]
			},{
				xtype: 'container',
				width: '100%',
				layout: {
					type: 'hbox',
					align: 'stretch'
				},
				items: [{
						fieldLabel: 'Third Choice',
						name: 'POSITIONTHIRDPRIORITY',
						xtype: 'combobox',
						cls: 'field-margin',
						labelAlign: 'top',
						width: 350,
						store: 'recruitment.applicationonline.positionstore',
						minChars: 1,
						forceSelection: true,
						pageSize: 20,
						displayField: 'positionname',
						valueField: 'positioncode'
				},{
						fieldLabel: 'Third Choice Company',
						name: 'COMPANYTHIRDPRIORITY',
						xtype: 'combobox',
						cls: 'field-margin',
						labelAlign: 'top',
						width: 350,
						store: 'recruitment.applicationonline.companystore',
						minChars: 1,
						forceSelection: true,
						pageSize: 20,
						displayField: 'companyname',
						valueField: 'companycode'
				}]
			},{
				xtype: 'numberfield',
				name: 'EXPECTEDSALARY',
				cls: 'field-margin',
				fieldLabel: 'Expected Salary',
				value: 0,
				minValue: 0,
				maxValue: 1000000,
				width: 300
			},{
				xtype: 'numberfield',
				name: 'CURRENTSALARY',
				cls: 'field-margin',
				fieldLabel: 'Current Salary',
				value: 0,
				minValue: 0,
				maxValue: 1000000,
				width: 300
			},{
				xtype: 'displayfield',   
				cls: 'field-margin',
				value: 'Previously Employed with Filinvest Group of Companies?'
			},{
				xtype: 'container',
				layout: {
					type: 'hbox',
					align: 'left'
				},
				items: [{
					xtype: 'radiofield',
					inputValue: 'N',
					checked: true,
					cls: 'field-margin',
					fieldLabel: 'No',
					labelAlign: 'right',
					width: 130,
					name: 'PREVEMPLOYED'
				},{
					xtype: 'radiofield',
					inputValue: 'Y',
					cls: 'field-margin',
					fieldLabel: 'Yes',
					labelAlign: 'right',
					action: 'yesprevapplied',
					name: 'PREVEMPLOYED',
					width: 130
				},{
					xtype: 'monthfield',
					format: 'F Y',
					name: 'PREVEMPLOYEDFROM',
					cls: 'field-margin',
					labelWidth: 70,
					width: 220,
					fieldLabel: 'From',
					hidden: true
				},{
					xtype: 'monthfield',
					format: 'F Y',
					name: 'PREVEMPLOYEDTO',
					cls: 'field-margin',
					labelWidth: 70,
					fieldLabel: 'To',
					width: 220,
					hidden: true
				}]
			},{
				xtype: 'displayfield',
				cls: 'field-margin',
				value: 'Previously Applied Here?'
			},{
				xtype: 'container',
				layout: {
					type: 'hbox',
					align: 'left'
				},
				items: [{
					xtype: 'radiofield',
					inputValue: 'N',
					checked: true,
					cls: 'field-margin',
					fieldLabel: 'No',
					name: 'PREVAPPLIED',
					labelAlign: 'right',
					width: 130
				},{
					xtype: 'radiofield',
					inputValue: 'Y',
					cls: 'field-margin',
					fieldLabel: 'Yes',
					name: 'PREVAPPLIED',
					action: 'yesiapplied',
					labelAlign: 'right',
					width: 130
				},{
					xtype: 'monthfield',
					name: 'PREVAPPLIEDLAST',
					format: 'F Y',
					cls: 'field-margin',
					labelAlign: 'left',
					fieldLabel: 'Last',
					hidden: true,
					labelWidth: 70,
					width: 220
				}]
			},{
				xtype: 'datefield',
				name: 'DATEAVAILEMP',
				labelAlign: 'top',
				cls: 'field-margin',
				fieldLabel: 'Date Available for Employment',
				width: 200
			}],
			
			
		this.callParent(arguments);
	}
	
   
   
});