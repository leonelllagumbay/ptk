
Ext.define('Form.view.query.optionFieldFunction', {
	extend: 'Ext.window.Window',
	alias: 'widget.optionfieldfunction',
	width: 850,
	height: 450,
	autoDestroy: true,
	autoScroll: true,
	layout: 'fit',
	title: 'Field Functions',
	initComponent: function() {
		this.items = [{
			xtype: 'panel',
			layout: 'hbox',
			//autoScroll: true,
			items: [{
				xtype: 'grid',
				width: 320,
				name: 'functionGrid',
				padding: 5,
				autoScroll: true,
				height: '100%',
				//hideHeaders: true,
				features: [{
					ftype: 'filters',
					encode: true,
					local: false, 
					filters: [{
						type: 'string',
						dataIndex: 'FUNCTIONNAME'
				    }]
				}],
				store: 'query.optionFieldFunctionStore',
				bbar: [{
					xtype: 'pagingtoolbar',
					store: 'query.optionFieldFunctionStore'
				}],
				columns: [{
					dataIndex: 'SQLCODE',
					hidden: true,
					flex: 1
				},{
					dataIndex: 'CATEGORY',
					text: 'Category',
					filterable: true,
					flex: 1
				},{
					dataIndex: 'FUNCTIONNAME',
					text: 'Name',
					filterable: true,
					flex: 1
				},{
					dataIndex: 'SYNTAX',
					text: 'SYNTAX',
					hidden: true,
					flex: 1
				},{
					dataIndex: 'DEFINITION',
					text: 'DEFINITION',
					filterable: true,
					hidden: true,
					flex: 1
				},{
					dataIndex: 'DBMSNAME',
					text: 'DBMSNAME',
					hidden: true,
					flex: 1
				},{
					dataIndex: 'TOTALNOOFARGS',
					text: 'TOTALNOOFARGS',
					hidden: true,
					flex: 1
				},{
					dataIndex: 'REQUIREDNOOFARGS',
					text: 'REQUIREDNOOFARGS',
					hidden: true,
					flex: 1
				},{
					dataIndex: 'DEFAULTTYPE',
					text: 'DEFAULTTYPE',
					hidden: true,
					flex: 1
				},{
					dataIndex: 'TOTALNOOFARGS',
					text: 'TOTALNOOFARGS',
					hidden: true,
					flex: 1
				}]
			},{
			   xtype: 'container',
			   layout: 'fit',
			   width: 500,
			   height: '100%',
			   autoScroll: true,
			   items: [{
					xtype: 'displayfield',
					name: 'displaysyntax',
					width: 500,
					height: '100%',
					margin: 5,
					style: {
						backgroundColor: '#FFFF99',
						borderRadius: 10
					},
					value: ''
				}]
			}] 
		}];
		
		this.buttons = [{
			text: 'Apply',
			action: 'applyselfunction'
		},{
			text: 'Cancel',
			action: 'cancelfunction'
		}];
		
		this.callParent(arguments);
	}
});