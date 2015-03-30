Ext.define('Form.view.query.querydefinitionQueryDetailsFeature', { 
	extend: 'Ext.form.FieldSet',
	alias: 'widget.querydefinitionquerydetailsfeature',
	title: 'Feature Details',
	collapsible: true,
	autoScroll: true,
	initComponent: function() {  
		
		this.defaults = {
				xtype: 'textfield',
				labelWidth: 150,
				padding: 5,
				width: 400
		};
		this.items = [{
			name: 'REMOTEROOT',
			fieldLabel: 'Remote root',
			maxLength: 50,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "The name of the property which contains the Array of summary objects. It allows to use server-side calculated summaries."
		            });
		        }
		    }
		},{
			name: 'SHOWSUMMARYROW',
			fieldLabel: 'Show summary row',
			xtype: 'combobox',
			queryMode: 'local',
			store: 'query.yesno', 
			displayField: 'yesnoname',
			valueField: 'yesnocode',
			width: 300,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "True to show the summary row.\nDefaults to: true"
		            });
		        }
		    }
		},{
			name: 'FCOLLAPSIBLE',
			fieldLabel: 'Collapsible',
			xtype: 'combobox',
			queryMode: 'local',
			store: 'query.yesno', 
			displayField: 'yesnoname',
			valueField: 'yesnocode',
			width: 300,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "Set to false to disable collapsing groups from the UI.\nThis is set to false when the associated store is buffered.\nDefaults to: true"
		            });
		        }
		    }
		},{
			name: 'ENABLEGROUPINGMENU',
			fieldLabel: 'Enable grouping menu',
			xtype: 'combobox',
			queryMode: 'local',
			store: 'query.yesno', 
			displayField: 'yesnoname',
			valueField: 'yesnocode',
			width: 300,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "True to enable the grouping control in the header menu.\nDefaults to: true"
		            });
		        }
		    }
		},{
			name: 'ENABLENOGROUPS',
			fieldLabel: 'Enable no groups',
			xtype: 'combobox',
			queryMode: 'local',
			store: 'query.yesno', 
			displayField: 'yesnoname',
			valueField: 'yesnocode',
			width: 300,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "True to allow the user to turn off grouping.\nDefaults to: true"
		            });
		        }
		    }
		},{
			name: 'HIDEGROUPEDHEADER',
			fieldLabel: 'Hide grouped header',
			xtype: 'combobox',
			queryMode: 'local',
			store: 'query.yesno', 
			displayField: 'yesnoname',
			valueField: 'yesnocode',
			width: 300,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "True to hide the header that is currently grouped.\nDefaults to: false"
		            });
		        }
		    }
		},{
			name: 'STARTCOLLAPSED',
			fieldLabel: 'Start collapsed',
			xtype: 'combobox',
			queryMode: 'local',
			store: 'query.yesno', 
			displayField: 'yesnoname',
			valueField: 'yesnocode',
			width: 300,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "True to start all groups collapsed.\nDefaults to: false"
		            });
		        }
		    }
		},{
			name: 'GROUPBYTEXT',
			fieldLabel: 'Group by text',
			maxLength: 50,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "Text displayed in the grid header menu for grouping by header.\nDefaults to: \"Group by this field\""
		            });
		        }
		    }
		},{
			name: 'GROUPHEADERTPL',
			fieldLabel: 'Group header template',
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "A string Template snippet, an array of strings (optionally followed by an object containing Template methods) to be used to construct a Template, or a Template instance."
		            });
		        }
		    }
		},{
			name: 'SHOWGROUPSTEXT',
			fieldLabel: 'Show groups text',
			maxLength: 50,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "Text displayed in the grid header for enabling/disabling grouping.\nDefaults to: \"Show in groups\""
		            });
		        }
		    }
		},{
			name: 'DEPTHTOINDENT',
			fieldLabel: 'Depth to indent',
			xtype: 'numberfield',
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "Number of pixels to indent per grouping level\nDefaults to: 17"
		            });
		        }
		    },
		    width: 250,
		    maxValue: 1000
		},{
			name: 'GROUPINGLISTENERS',
			fieldLabel: 'Listeners',
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "A config object containing one or more event handlers to be added to this object during initialization. This should be a valid listeners config object as specified in the addListener example for attaching multiple handlers at once."
		            });
		        }
		    }
		},{
			name: 'FEATUREEXTRA',
			xtype: 'textareafield',
			fieldLabel: 'Extra feature properties (Object)'
		}];
		this.callParent(arguments);
	}
});