
Ext.define('Form.view.query.optionField', {
	extend: 'Ext.grid.Panel',
	alias: 'widget.optionfield',
	multiSelect: true,
	width: 310,
	height: 415,
	viewConfig: {
	    forceFit: false,
		trackOver: false,
	    emptyText: '<h1 style="margin:20px">No results found</h1>',
	    plugins: {
            ptype: 'gridviewdragdrop',
            ddGroup: 'ddfield',
            containerScroll: true,
            pluginId: 'optionfield'
        }
	},
	initComponent: function() {
		
		this.features = [{
			ftype: 'filters',
			encode: true, // json encode the filter query
			local: false, 
			filters: [{
				type: 'string',
				dataIndex: 'DBSOURCENAME'
			}]
		}];
		this.store = 'query.optionFieldStore';
		this.tbar = Ext.create('Ext.toolbar.Paging', {
				        store: 'query.optionFieldStore', 
				        displayInfo: false,
				        emptyMsg: "_"
		});
		this.columns = [{
			xtype: 'rownumberer',
			width: 50,
			sortable: false
		},{
			text: 'Table Name',
			dataIndex: 'TABLENAME',
			filterable: true,
			sortable: true,
			hidden: true,
			flex: 1
		},{
			text: 'Field Name',
			dataIndex: 'FIELDNAME',
			filterable: true,
			sortable: true,
			hidden: true,
			flex: 1
		},{
			text: 'Alias',
			dataIndex: 'FIELDALIAS',
			filterable: true,
			sortable: true,
			hidden: true,
			flex: 1
		},{
			text: '-',
			dataIndex: 'DISPLAY',
			filterable: true,
			sortable: true,
			renderer: function(value,metaData,record) {
				var isPrimaryKey = record.data.IS_PRIMARYKEY;
				if(isPrimaryKey) {
				return "<u>" + value + "</u>";
				} else {
					return value;
				}
			},
			flex: 1
		},{
			text: 'IS_PRIMARYKEY',
			dataIndex: 'IS_PRIMARYKEY',
			hidden: true
		},{
			text: 'ORDINAL_POSITION',
			dataIndex: 'ORDINAL_POSITION',
			hidden: true
		},{
			text: 'TYPE_NAME',
			dataIndex: 'TYPE_NAME',
			hidden: true
		},{
			text: 'DECIMAL_DIGITS',
			dataIndex: 'DECIMAL_DIGITS',
			hidden: true
		},{
			text: 'IS_NULLABLE',
			dataIndex: 'IS_NULLABLE',
			hidden: true
		},{
			text: 'COLUMN_DEFAULT_VALUE',
			dataIndex: 'COLUMN_DEFAULT_VALUE',
			hidden: true
		},{
			text: 'CHAR_OCTET_LENGTH',
			dataIndex: 'CHAR_OCTET_LENGTH',
			hidden: true
		},{
			text: 'IS_FOREIGNKEY',
			dataIndex: 'IS_FOREIGNKEY',
			hidden: true
		},{
			text: 'REFERENCED_PRIMARYKEY',
			dataIndex: 'REFERENCED_PRIMARYKEY',
			hidden: true
		},{
			text: 'REFERENCED_PRIMARYKEY_TABLE',
			dataIndex: 'REFERENCED_PRIMARYKEY_TABLE',
			hidden: true
		},{
			text: 'Aggregate function',
			dataIndex: 'AGGREGATEFUNC',
			hidden: true,
			flex: 1
		}],
		this.callParent(arguments);
	}
});