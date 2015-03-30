
Ext.define('Form.view.query.optionJoin', {
	extend: 'Ext.window.Window',
	alias: 'widget.optionjoin',
	width: 1000,
	height: 300,
	autoDestroy: true,
	autoScroll: true,
	layout: 'fit',
	title: 'Join Table',
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

			store: 'query.selectedJoinStore',
	
			columns: [{
				text: 'EVIEWJOINEDTABLECODE',
				dataIndex: 'EVIEWJOINEDTABLECODE',
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
				text: 'Join Operator',
				dataIndex: 'JOINOPERATOR',
				sortable: false,
				editor: {
					xtype: 'combobox',
					queryMode: 'local',
					store: 'query.joinOpStore', 
					displayField: 'joinopname',
					valueField: 'joinopcode'
				},
				flex: 1
			},{
				text: 'Table Name',
				dataIndex: 'TABLENAME',
				sortable: false,
				editor: {
					xtype: 'combobox',
					name: 'tableName',
					queryMode: 'local',
					store: 'query.aggColumnStore', 
					displayField: 'aggcolumnname',
					valueField: 'aggcolumncode',
					forceSelection: true,
					listeners: {
						focus: function() {
							var selTableComp = Ext.ComponentQuery.query('selectedtable')[0];
							var selDataArr = selTableComp.getStore().data.items;
							var tableName = new Array();
							for(i=0; i<selDataArr.length; i++) {
								tableName.push(selDataArr[i].data.TEMPTABLE + '  ' + selDataArr[i].data.TABLEALIAS);
							}
							var thisStore = this.getStore();
							thisStore.removeAll();
							if(tableName.length > 0) {
								for(a=0;a<tableName.length;a++) {
									thisStore.add({
										aggcolumnname: tableName[a],
										aggcolumncode: tableName[a]
									});
								}
							} else {
								thisStore.add({
									aggcolumnname: 'No table selected.',
									aggcolumncode: ''
								});
							}
						} //end focus function 
					} // end listeners 
				},	
				flex: 2
			},{
				text: 'On Column',
				sortable: false,
				dataIndex: 'ONCOLUMN',
				width: 240,
				editor: {
					xtype: 'combobox',
					queryMode: 'remote',
					store: 'query.optionFieldStore', 
					displayField: 'DISPLAY',
					valueField: 'DISPLAY',
					pageSize: 20
				}
			},{
				text: 'Equal To Column',
				sortable: false,
				dataIndex: 'EQUALTOCOLUMN',
				width: 240,
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
			action: 'addjoin',
		},{
			text: 'Remove',
			action: 'removejoin',
		},{
			text: 'Ok',
			action: 'canceljoin'
		}];
		
		this.callParent(arguments);
	}
});
	
