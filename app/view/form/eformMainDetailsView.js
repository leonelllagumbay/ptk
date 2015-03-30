Ext.define('Form.view.form.eformMainDetailsView', { 
	extend: 'Ext.form.Panel',
	alias: 'widget.eformmaindetailsview',
	title: 'eForm -> Add',
	width: '100%', 
	height: '100%',
	autoScroll: true,
	defaults: {anchor: '100%'},
    defaultType: 'textfield',
	initComponent: function() {   
		this.tbar = [{
			  	text: 'Back',
				action: 'backtoeformmain'   
			 }];
		  
		this.items = [{
	        	fieldLabel: 'EFORMTABLEID',
		        name: 'EFORMTABLEID',
				xtype: 'textfield',
				hidden: true
		    },{
	        	fieldLabel: 'PROCESSIDFK',
		        name: 'PROCESSIDFK',
				xtype: 'textfield',
				hidden: true
		    },{
	        	fieldLabel: 'EFORMIDFK',
		        name: 'EFORMIDFK',
				xtype: 'textfield',
				hidden: true
		    },{
	        	fieldLabel: 'MAINTABLEIDFK',
		        name: 'MAINTABLEIDFK',
				xtype: 'textfield',
				hidden: true
		    },{
	        	fieldLabel: 'STATUS',
		        name: 'STATUS',
				xtype: 'textfield',
				hidden: true
		    },{
	        	fieldLabel: 'RECCREATEDBY',
		        name: 'RECCREATEDBY',
				xtype: 'textfield',
				hidden: true
		    },{
	        	fieldLabel: 'RECDATECREATED',
		        name: 'RECDATECREATED',
				xtype: 'textfield',
				hidden: true
		    },{
	        	fieldLabel: 'DATELASTUPDATE',
		        name: 'DATELASTUPDATE',
				xtype: 'textfield',
				hidden: true
		    },{ 
		        fieldLabel: 'Check box sample',
		        xtype: 'checkboxgroup',
				padding: '5 400 5 400',
				labelWidth: 200,
				uncheckedValue: 'false',
				columns: 1,
				vertical: true,
				padding: '5 400 5 400',
				labelWidth: 200,
				items: [{
					boxLabel: 'Left',
					name: 'CHECKBOXSAMPLE',
					inputValue: 'left',
					checked: true
				},{
					boxLabel: 'Top',
					name: 'CHECKBOXSAMPLE',
					inputValue: 'top'
				},{
					boxLabel: 'Right',
					name: 'CHECKBOXSAMPLE',
					inputValue: 'right'
				}]
		    },{
		        fieldLabel: 'Combo Box sample',
		        name: 'COMBOBOXSAMPLE',
				xtype: 'combobox',
				queryMode: 'local',
				//store: 'form.fieldtypestore', 
				displayField: 'fieldtypename',
				valueField: 'fieldtypecode',
				padding: '5 400 5 400',
				labelWidth: 200,
				maxLength: 60,
				allowBlank: false
		    },{
			    fieldLabel: 'Date sample',
			    name: 'DATESAMPLE',
				padding: '5 400 5 400',
				labelWidth: 200,
				xtype: 'datefield'
			 },{ 
		        fieldLabel: 'Display sample',
		        name: 'DISPLAYSAMPLE',
				xtype: 'displayfield',
				padding: '5 400 5 400',
				value: 'Display more here...'
		    },{ 
		        fieldLabel: 'File sample',
		        name: 'FILESAMPLE',
				xtype: 'filefield',
				padding: '5 400 5 400',
				maxLength: 60,
				labelWidth: 200,
		    },{ 
		        fieldLabel: 'Hidden sample',
		        name: 'HIDDENSAMPLE',
				xtype: 'hiddenfield',
				padding: '5 400 5 400'
		    },{ 
		        fieldLabel: 'HTML Editor sample',
		        name: 'HTMLEDITORSAMPLE',
				xtype: 'htmleditor',
				padding: '5 400 5 400'
		    },{
		        fieldLabel: 'Number sample',
		        name: 'NUMBERSAMPLE',
				xtype: 'numberfield',
				minValue: 0,
				maxValue: 100000,
				value: 0,
				padding: '5 400 5 400',
				labelWidth: 200,
				allowBlank: false
		    },{
		        fieldLabel: 'Radio sample',
		        xtype: 'radiogroup',
				columns: 1,
				vertical: true,
				padding: '5 400 5 400',
				labelWidth: 200,
				items: [{
					boxLabel: 'Left',
					name: 'RADIOSAMPLE',
					inputValue: 'left',
					checked: true
				},{
					boxLabel: 'Top',
					name: 'RADIOSAMPLE',
					inputValue: 'top'
				},{
					boxLabel: 'Right',
					name: 'RADIOSAMPLE',
					inputValue: 'right'
				}]

		    },{ 
		        fieldLabel: 'Text sample',
				allowBlank: false,
		        name: 'TEXTSAMPLE',
				xtype: 'textfield',
				padding: '5 400 5 400'
		    },{ 
		        fieldLabel: 'Text Area sample',
		        name: 'TEXTAREASAMPLE',
				xtype: 'textareafield',
				padding: '5 400 5 400'
		    },{ 
		        fieldLabel: 'Time Sample',
		        name: 'TIMESAMPLE',
				xtype: 'timefield',
				padding: '5 400 5 400'
		    }]; 
		// configs for BasicForm
		 this.api = {
				        // The server-side method to call for load() requests
				        load: Ext.ss.eformmain.getMainDetails,
				        // The server-side must mark the submit handler as a 'formHandler'
				        submit: Ext.ss.eformmain.addeForm
				    };
		// specify the order for the passed params
		this.paramOrder = ['eformid'];
		//this.reader = {
         //       type: 'json',
          //      root: 'data'
          //  },
		this.buttons = [{
				text: 'Update',
				action: 'saveeform'
		    },{
				text: 'Add',
				action: 'submiteform'
			}];
			
		
		this.callParent(arguments);
	}
	
   
   
});