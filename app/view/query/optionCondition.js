Ext.define('Form.view.query.optionCondition', {
	extend: 'Ext.window.Window',  
	alias: 'widget.optioncondition',
	width: 800,
	height: 300,
	autoDestroy: true,
	autoScroll: true,
	layout: 'fit',
	title: 'Query Condition',
	initComponent: function() {
		this.items = [{
			xtype: 'grid',
			width: '100%',
			height: '100%',
			plugins: [
				Ext.create('Ext.grid.plugin.CellEditing', {
				    clicksToEdit: 2
	    	    })
			],

			store: 'query.selectedConditionStore',
	
			columns: [{
				text: 'EVIEWCONDITIONCODE',
				dataIndex: 'EVIEWCONDITIONCODE',
				hidden: true,
				flex: 1
			},{
				text: 'EVIEWCODEFK',
				dataIndex: 'EVIEWCODEFK',
				hidden: true,
				flex: 1
			},{
				text: 'PRIORITYNO',
				dataIndex: 'PRIORITYNO',
				hidden: true,
				flex: 1
			},{
				text: 'Conjunctive Operator',
				dataIndex: 'CONJUNCTIVEOPERATOR',
				sortable: false,
				editor: {
					xtype: 'combobox',
					queryMode: 'local',
					store: 'query.andorstore', 
					displayField: 'andorname',
					valueField: 'andorcode'
				},
				width: 120
			},{
				text: 'Source Field',
				sortable: false,
				dataIndex: 'ONCOLUMN',
				width: 260,
				editor: {
					xtype: 'combobox',
					queryMode: 'remote',
					store: 'query.optionFieldStore', 
					displayField: 'DISPLAY',
					valueField: 'DISPLAY',
					pageSize: 20
				}
			},{
				text: 'Conditional Operator',
				dataIndex: 'CONDITIONOPERATOR',
				sortable: false,
				editor: {
					xtype: 'combobox',
					queryMode: 'local',
					store: 'query.condOpStore', 
					displayField: 'operatorname',
					valueField: 'operatorcode'
				},
				width: 120
			},{
				text: 'Field Value',
				sortable: false,
				dataIndex: 'COLUMNVALUE',
				flex: 1,
				editor: {
					xtype: 'combobox',
					queryMode: 'remote',
					store: 'query.optionFieldStore', 
					displayField: 'DISPLAY',
					valueField: 'DISPLAY',
					pageSize: 20
				}
			},{
				text: 'DISPLAY',
				dataIndex: 'DISPLAY',
				hidden: true,
				flex: 1
			}],
		}];
		
		this.buttons = [{
			text: 'Add',
			action: 'addconditioin',
		},{
			text: 'Remove',
			action: 'removecondition',
		},{
			text: 'Ok',
			action: 'cancelcondition'
		}];
		
		this.callParent(arguments);
	}
});
	
