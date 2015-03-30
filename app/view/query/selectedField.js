
Ext.define('Form.view.query.selectedField', {
	extend: 'Ext.grid.Panel',
	alias: 'widget.selectedfield',
	multiSelect: true,
	width: 410,
	height: 415,
	hideHeaders: true,
	viewConfig: {
        plugins: {
            ptype: 'gridviewdragdrop',
            dragText: 'Drag and drop to reorganize',
            ddGroup: 'ddfield',
            containerScroll: true,
            pluginId: 'selectedfield'
        }
    }, 
	initComponent: function() {
		this.plugins = [
			Ext.create('Ext.grid.plugin.CellEditing', {
			    clicksToEdit: 2
    	    })
		];
		this.buttonAlign = 'left',
		this.buttons = [{
			text: 'Apply Function',
			action: 'applyfunction'
		}];
		this.store = 'query.selectedFieldStore';
		this.columns = [{
			xtype: 'rownumberer',
			width: 40,
			sortable: false,
			//renderer: function(value,p,record) {console.log(record); return Ext.String.format('<a href=\'##\'><b>{0}</b></a>', value);}
		},{
			text: 'EVIEWFIELDCODE',
			dataIndex: 'EVIEWFIELDCODE',
			hidden: true,
			flex: 1
		},{
			text: 'COLUMNORDER',
			dataIndex: 'COLUMNORDER',
			hidden: true,
			flex: 1
		},{
			text: 'EQRYCODEFK',
			dataIndex: 'EQRYCODEFK',
			hidden: true,
			flex: 1
		},{
			text: 'Field Name',
			dataIndex: 'FIELDNAME',
			hidden: true,
			flex: 2
		},{
			text: '-',
			dataIndex: 'DISPLAY',
			editor: 'textfield',
			renderer: function(value,metaData,record) {
				var isPrimaryKey = record.data.IS_PRIMARYKEY;
				if(isPrimaryKey) {
				return "<u>" + value + "</u>";
				} else {
					return value;
				}
			},
			flex: 3
		},{
			text: 'Alias',
			dataIndex: 'FIELDALIAS',
			editor: 'textfield',
			flex: 1
		},{
			text: 'PRIORITYNO',
			dataIndex: 'PRIORITYNO',
			hidden: true,
			flex: 1
		},{
			text: 'Aggregate function',
			dataIndex: 'AGGREGATEFUNC',
			hidden: true,
			flex: 1
		},{
			text: 'Other function',
			dataIndex: 'DATEANDSTRINGFUNC',
			hidden: true,
			flex: 1
		},{
			text: 'Number Format',
			dataIndex: 'NUMBERFORMAT',
			hidden: true,
			flex: 1
		},{
			text: 'Distinct',
			dataIndex: 'ISDISTINCT',
			hidden: true,
			flex: 1
		},{
			text: 'WRAPON',
			dataIndex: 'WRAPON',
			hidden: true,
			flex: 1
		},{
			text: 'SUPPRESSZERO',
			dataIndex: 'SUPPRESSZERO',
			hidden: true,
			flex: 1
		},{
			text: 'Override definition',
			dataIndex: 'OVERRIDESTATEMENT',
			hidden: true,
			flex: 1
		},{
			text: 'Table Name',
			dataIndex: 'TABLENAME',
			hidden: true,
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
		}],
		this.callParent(arguments);
	}
});