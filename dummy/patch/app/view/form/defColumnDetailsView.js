Ext.define('Form.view.form.defColumnDetailsView', {
	extend: 'Ext.form.Panel',
	alias: 'widget.defcolumndetailsview',
	title: 'eForm Manager -> eForm Tables -> eForm Column',
	width: '100%', 
	height: '100%',
	autoScroll: true,
	defaults: {anchor: '100%'},
    defaultType: 'textfield',
	initComponent: function() {   
		this.tbar = [{
			  	text: 'Back',
				action: 'backtoeformcolumns'   
			 }];
		  
		this.items = [{
	        	fieldLabel: 'Column ID',
		        name: 'COLUMNID',
				xtype: 'textfield',
				hidden: true
		    },{
	        	fieldLabel: 'Table ID FK',
		        name: 'TABLEIDFK',
				xtype: 'textfield',
				hidden: true
		    },{ 
		        fieldLabel: 'Column Name',
		        name: 'COLUMNNAME',
				xtype: 'textfield',
				padding: '5 400 5 400',
				labelWidth: 200,
				maxLength: 60,
				allowBlank: false
		    },{ 
		        fieldLabel: 'Column Type',
		        name: 'COLUMNTYPE',
				xtype: 'combobox',
				queryMode: 'local',
				store: 'form.columntypestore', 
				displayField: 'columntypename',
				valueField: 'columntypecode',
				padding: '5 400 5 400',
				labelWidth: 200,
				maxLength: 60,
				allowBlank: false
		    },{ 
		        fieldLabel: 'Field Label',
		        name: 'FIELDLABEL',
				xtype: 'textfield',
				padding: '5 400 5 400',
				maxLength: 60,
				labelWidth: 200,
		    },{
		        fieldLabel: 'Field Type',
		        name: 'XTYPE',
				xtype: 'combobox',
				queryMode: 'local',
				store: 'form.fieldtypestore', 
				displayField: 'fieldtypename',
				valueField: 'fieldtypecode',
				padding: '5 400 5 400',
				labelWidth: 200,
				maxLength: 60,
				allowBlank: false
		    },{ 
		        fieldLabel: 'Field Label Width',
		        name: 'FIELDLABELWIDTH',
				xtype: 'textfield',
				padding: '5 400 5 400',
				maxLength: 10,
				labelWidth: 200,
		    },{
		        fieldLabel: 'Column Order',
		        name: 'COLUMNORDER',
				xtype: 'numberfield',
				minValue: 0,
				maxValue: 100000,
				value: 0,
				padding: '5 400 5 400',
				labelWidth: 200,
				allowBlank: false
		    },{
		        fieldLabel: 'Field Group',
		        name: 'COLUMNGROUP',
				xtype: 'combobox',
				store: 'form.columngroupstore',   
				displayField: 'columngroupname',
				valueField: 'columngroupcode',  
				padding: '5 400 5 400',
				labelWidth: 200,
				maxLength: 100,
				minChars: 1,
				pageSize: 15,
				value: ''
		    },{
		        fieldLabel: 'Field Label Align',
		        xtype: 'radiogroup',
				columns: 1,
				vertical: true,
				padding: '5 400 5 400',
				labelWidth: 200,
				items: [{
					boxLabel: 'Left',
					name: 'FIELDLABELALIGN',
					inputValue: 'left',
					checked: true
				},{
					boxLabel: 'Top',
					name: 'FIELDLABELALIGN',
					inputValue: 'top'
				},{
					boxLabel: 'Right',
					name: 'FIELDLABELALIGN',
					inputValue: 'right'
				}]

		    },{ 
		        fieldLabel: 'Height',
		        name: 'HEIGHT',
				xtype: 'textfield',
				padding: '5 400 5 400',
				labelWidth: 200,
				maxLength: 10
		    },{ 
		        fieldLabel: 'Width',
		        name: 'WIDTH',
				xtype: 'textfield',
				padding: '5 400 5 400',
				labelWidth: 200,
				maxLength: 10
		    },{ 
		        fieldLabel: 'Margin',
		        name: 'MARGIN',
				xtype: 'textfield',
				padding: '5 400 5 400',
				maxLength: 20,
				labelWidth: 200
		    },{ 
		        fieldLabel: 'Padding',
		        name: 'PADDING',
				xtype: 'textfield',
				padding: '5 400 5 400',
				maxLength: 20,
				labelWidth: 200,
		    },{ 
		        fieldLabel: 'Border', 
		        name: 'BORDER',
				xtype: 'textfield',
				padding: '5 400 5 400',
				labelWidth: 200,
				maxLength: 20
		    },{ 
		        fieldLabel: 'Style',
		        name: 'STYLE',
				xtype: 'textfield',
				padding: '5 400 5 400',
				labelWidth: 200,
				maxLength: 100,
		    },{ 
		        fieldLabel: 'Default Value',
		        name: 'INPUTVALUE',
				xtype: 'textfield',
				padding: '5 400 5 400',
				labelWidth: 200,
		    },{ 
		        fieldLabel: 'Validation Type',
		        name: 'VALIDATIONTYPE',
				xtype: 'textareafield',
				padding: '5 400 5 400',
				emptyText: 'alpha, alphanum, email, url',
				value: '',
				labelWidth: 200,
		    },{ 
		        fieldLabel: 'Validation Type Text',
		        name: 'VTYPETEXT',
				xtype: 'textfield',
				padding: '5 400 5 400',
				labelWidth: 200,
				maxLength: 250
		    },{ 
		        fieldLabel: 'Renderer',
		        name: 'RENDERER',
				xtype: 'textareafield',
				padding: '5 400 5 400',
				labelWidth: 200,
		    },{ 
		        fieldLabel: 'X Absolute Position',
		        name: 'XPOSITION',
				xtype: 'numberfield',
				minValue: 0,
				maxValue: 100000,
				value: 0,
				padding: '5 400 5 400',
				labelWidth: 200,
				allowBlank: false
		    },{ 
		        fieldLabel: 'Y Absolute Position',
		        name: 'YPOSITION',
				xtype: 'numberfield',
				minValue: 0,
				maxValue: 100000,
				value: 0,
				padding: '5 400 5 400',
				labelWidth: 200,
				allowBlank: false
		    },{ 
		        fieldLabel: 'Anchor',
		        name: 'ANCHORPOSITION',
				xtype: 'textfield',
				padding: '5 400 5 400',
				labelWidth: 200,
				maxLength: 40
		    },{ 
		        fieldLabel: 'Format',  
		        name: 'INPUTFORMAT',
				xtype: 'textfield',
				padding: '5 400 5 400',
				labelWidth: 200,
				maxLength: 250
		    },{ 
		        fieldLabel: 'CSS Class',
		        name: 'CSSCLASS',
				xtype: 'textfield',
				padding: '5 400 5 400',
				maxLength: 250,
				labelWidth: 200,
		    },{
		        fieldLabel: 'Allow Blank',
		        name: 'ALLOWBLANK',
				xtype: 'checkboxfield',
				checked: false,
				inputValue: 'true',
				padding: '5 400 5 400',
				labelWidth: 200,
				uncheckedValue: 'false'
		    },{
		        fieldLabel: 'Disabled',
		        name: 'ISDISABLED',
				xtype: 'checkboxfield',
				checked: false,
				inputValue: 'true',
				padding: '5 400 5 400',
				labelWidth: 200,
				uncheckedValue: 'false'
		    },{
		        fieldLabel: 'Read Only',
		        name: 'ISREADONLY',
				xtype: 'checkboxfield',
				checked: false,
				inputValue: 'true',
				padding: '5 400 5 400',
				labelWidth: 200,
				uncheckedValue: 'false'
		    },{
		        fieldLabel: 'Hidden',
		        name: 'ISHIDDEN',
				xtype: 'checkboxfield',
				checked: false,
				inputValue: 'true',
				padding: '5 400 5 400',
				labelWidth: 200,
				uncheckedValue: 'false'
		    },{
		        fieldLabel: 'Checked',
		        name: 'ISCHECKED',
				xtype: 'checkboxfield',
				checked: true,
				inputValue: 'true',
				padding: '5 400 5 400',
				labelWidth: 200,
				uncheckedValue: 'false'
		    },{
		        fieldLabel: 'Minimum Value',
		        name: 'MININPUTVALUE',
				xtype: 'numberfield',
				minValue: 0,
				maxValue: 100000,
				value: 0,
				padding: '5 400 5 400',
				labelWidth: 200
		    },{
		        fieldLabel: 'Maximum Value',
		        name: 'MAXINPUTVALUE',
				xtype: 'numberfield',
				minValue: 0,
				maxValue: 100000,
				value: 10000,
				padding: '5 400 5 400',
				labelWidth: 200
		    },{
		        fieldLabel: 'Minimum Character Length',
		        name: 'MINCHARLENGTH',
				xtype: 'numberfield',
				minValue: 0,
				maxValue: 100000,
				value: 0,
				padding: '5 400 5 400',
				labelWidth: 200
		    },{ 
		        fieldLabel: 'Maximum Character Length',
		        name: 'MAXCHARLENGTH',
				xtype: 'numberfield',
				minValue: 0,
				maxValue: 100000,
				value: 100,
				padding: '5 400 5 400',
				labelWidth: 200
		    },{ 
		        fieldLabel: 'Unchecked Value',
		        name: 'UNCHECKEDVALUE',
				xtype: 'textfield', 
				padding: '5 400 5 400',
				labelWidth: 200,
				maxLength: 50,
				value: '_'
		    },{ 
		        fieldLabel: 'Checkbox/Radio Items',
		        name: 'CHECKITEMS',
				xtype: 'textfield',
				padding: '5 400 5 400',
				labelWidth: 200,
				emptyText: 'label1,value1;label2,value2; and so on...',
				maxLength: 4000
		    },{ 
		        fieldLabel: 'Checkbox/Radio No. of Columns',
		        name: 'NOOFCOLUMNS',
				xtype: 'numberfield',
				minValue: 1,
				maxValue: 100000,
				value: 1,
				padding: '5 400 5 400',
				labelWidth: 200
		    },{  
		        fieldLabel: 'Auto Generated Text Format',  
		        name: 'AUTOGENTEXT',
				xtype: 'textfield',
				padding: '5 400 5 400',
				labelWidth: 200,
				maxLength: 250
		    },{  
		        fieldLabel: 'Variables For Auto-Generated Text',  
		        xtype: 'displayfield',
				padding: '5 400 5 400',
				labelWidth: 200, 
				value: '<p>{RANDOM} - Random Characters</p><p>{NUMBER} - e.i; 00{NUMBER} may generate 01, 45, or 23. Supports up to 10 digits.</p><p>{DATE} or {TIME} - Current date or time. Format: YYYYMMDD or HHMMSS</p><p>{DATEFORMAT} or {TIMEFORMAT} - Current formatted date or time.</p><p>{UUID} - Universally Unique Identifier (UUID). A UUID is a 35-character string representation of a unique 128-bit integer.</p>'
		    },{
		        fieldLabel: 'Combobox Data',
		        xtype: 'radiogroup',
				name: 'SELECTDATA',
				columns: 1,
				vertical: true,
				padding: '5 400 5 400',
				labelWidth: 200,
				items: [{
					boxLabel: 'Local',
					name: 'combodata',
					inputValue: 'local'
				},{
					boxLabel: 'Remote',
					name: 'combodata',
					inputValue: 'remote'
				}]

		    },{  
		        fieldLabel: 'Combobox Local Data',  
		        name: 'COMBOLOCALDATA',
				emptyText: 'DisplayValue1,Value1;DisplayValue2,Value2;DisplayValueN,ValueN',
				xtype: 'textareafield',
				padding: '5 400 5 400',
				hidden: true,
				labelWidth: 200,
				maxLength: 4000
		    },{  
		        fieldLabel: 'Combobox Remote Data',  
		        name: 'COMBOREMOTEDATA',
				emptyText: 'TableName;DisplayColumnName1,DisplayColumnNameN;ValueColumnName;ColumnsDependencyName1,ColumnsDependencyNameN',
				xtype: 'textareafield',
				padding: '5 400 5 400',
				hidden: true, 
				labelWidth: 200,
				maxLength: 4000
		    },{  
		        fieldLabel: 'Editable on Router No.',  
		        name: 'EDITABLEONROUTENO', 
				xtype: 'textfield',
				padding: '5 400 5 400',
				emptyText: 'comma-separated list',
				labelWidth: 200,
				maxLength: 250
		    }]; 
		// configs for BasicForm
		 this.api = {
				        // The server-side method to call for load() requests
				        load: Ext.ss.defmain.getDetails,
				        // The server-side must mark the submit handler as a 'formHandler'
				        submit: Ext.ss.defmain.submitColumnRecords
				    };
		// specify the order for the passed params
		
		this.buttons = [{
				text: 'Update',
				action: 'saverouterdetail'
		    },{
				text: 'Add',
				action: 'submitRouter'
			}];
			
		
		this.callParent(arguments);
	}
	
   
   
});