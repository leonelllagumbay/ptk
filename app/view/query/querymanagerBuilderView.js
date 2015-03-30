Ext.define('Form.view.query.querymanagerBuilderView', { 
	extend: 'Ext.panel.Panel',
	alias: 'widget.querymanagerbuilderview',
	title: 'eQuery Builder',
	width: '100%',
	layout: {
		type: 'vbox',
		align: 'left'
	},
	autoScroll: true,
	initComponent: function() {   
		
		this.tbar = [{
			text: 'Back',
			action: 'back'
		},{
			text: 'Preview',
			action: 'previewquery'
		}];
		
		this.items = [{
			xtype: 'panel',
			layout: 'hbox',
			width: '100%',
			height: 2300,
			autoScroll: true,
			items: [{
				xtype: 'panel',
				title: 'Options',
				layout: 'vbox',
				padding: '10 10 10 10',
				width: 400,
				height: 2250,
				items: [{
					xtype: 'fieldset',
					title: 'Datasources',
					margin: 10,
					width: 350,
					height: 200,
					autoScroll: true,
					items: [{
						xtype: Form.view.query.optionDatasource
					}]
				},{
					xtype: 'fieldset',
					title: 'Tables',
					margin: 10,
					width: 350,
					height: 300,
					autoScroll: true,
					items: [{
						xtype: Form.view.query.optionTable
					}]
				},{
					xtype: 'fieldset',
					title: 'Fields',
					margin: 10,
					width: 350,
					height: 450,
					autoScroll: true,
					items: [{
						xtype: Form.view.query.optionField
					}]
				},{
					xtype: 'fieldset',
					//title: 'Join Operator',
					margin: 10,
					width: 350,
					height: 470,
					autoScroll: true,
					//items: [{
						//xtype: 'optionjoin'
					//}]
				},{
					xtype: 'fieldset',
					//title: 'Having',
					margin: 10,
					width: 350,
					height: 200,
					autoScroll: true
				},{
					xtype: 'fieldset',
					//title: 'Condition',
					margin: 10,
					width: 350,
					height: 200,
					autoScroll: true,
					//items: [{
						//xtype: 'optioncondition'
					//}]
				},{
					xtype: 'fieldset',
					title: 'Order By',
					margin: 10,
					width: 350,
					height: 200,
					autoScroll: true,
					items: [{
						xtype: Form.view.query.optionOrderBy
					}]
				}]
			},{
				xtype: 'panel',
				title: 'Selected',
				layout: 'vbox',
				padding: '10 10 10 10',
				width: 500,
				height: 2250,
				items: [{
					xtype: 'fieldset',
					title: 'Datasources',
					margin: 10,
					width: 450,
					height: 200,
					autoScroll: true,
					items: [{
						xtype: Form.view.query.selectedDatasource
					}]
				},{
					xtype: 'fieldset',
					title: 'Tables',
					margin: 10,
					width: 450,
					height: 300,
					autoScroll: true,
					items: [{
						xtype: Form.view.query.selectedTable
					}]
				},{
					xtype: 'fieldset',
					title: 'Fields',
					margin: 10,
					width: 450,
					height: 450,
					autoScroll: true,
					items: [{
						xtype: Form.view.query.selectedField
					}]
				},{
					xtype: 'fieldset',
					title: 'Joined Tables',
					margin: 10,
					width: 450,
					height: 200,
					autoScroll: true,
					items: [{
						xtype: Form.view.query.selectedJoin
					}]
				},{
					xtype: 'fieldset',
					title: 'Condition',
					margin: 10,
					width: 450,
					height: 250,
					autoScroll: true,
					items: [{
						xtype: Form.view.query.selectedCondition
					}]
				},{
					xtype: 'fieldset',
					title: 'Group By',
					margin: 10,
					width: 450,
					height: 200,
					autoScroll: true,
					items: [{
						xtype: Form.view.query.selectedGroupBy
					}]
				},{
					xtype: 'fieldset',
					title: 'Having',
					margin: 10,
					width: 450,
					height: 200,
					autoScroll: true,
					items: [{
						xtype: Form.view.query.selectedHaving
					}]
				},{
					xtype: 'fieldset',
					title: 'Order By',
					margin: 10,
					width: 450,
					height: 200,
					autoScroll: true,
					items: [{
						xtype: Form.view.query.selectedOrderBy
					}]
				}]
			},{
				xtype: 'form',
				title: 'Generated Query',
				layout: 'vbox',
				padding: '10 10 10 10',
				width: 400,
				height: 2250,
				autoScroll: true,
				items: [{
					xtype: Form.view.query.generatedQuery
				}]
			}]
		},{
			xtype: Form.view.query.MainListExtra
		}];
		
		this.callParent(arguments);
	}
});