
Ext.define('Form.view.query.selectedHaving', {
	extend: 'Ext.grid.Panel',
	alias: 'widget.selectedhaving',
	multiSelect: true,
	width: 410,
	height: 165,
	hideHeaders: true,
	initComponent: function() {
		this.plugins = [
			Ext.create('Ext.grid.plugin.CellEditing', {
			    clicksToEdit: 2
    	    })
		];
		this.buttonAlign = 'left',
		this.buttons = [{
			text: 'Add Group Condition',
			action: 'applygroupbyhaving'
		},{
			text: 'Apply',
			action: 'applyaddhaving',
			hidden: true
		},{
			text: 'Cancel',
			action: 'cancelhaving',
			hidden: true
		},{
			text: 'Remove',
			action: 'removehaving',
			hidden: true
		}];
		this.store = 'query.selectedHavingStore';
		this.columns = [{
			text: 'PRIORITYNO',
			dataIndex: 'PRIORITYNO',
			hidden: true
		},{
			text: 'EVIEWHAVINGCODE',
			dataIndex: 'EVIEWHAVINGCODE',
			hidden: true
		},{
			text: 'EQRYCODEFK',
			dataIndex: 'EQRYCODEFK',
			hidden: true
		},{
			text: 'COLUMNORDER',
			dataIndex: 'COLUMNORDER',
			hidden: true
		},{
			text: 'CONJUNCTIVEOPERATOR',
			dataIndex: 'CONJUNCTIVEOPERATOR',
			editor: {
				xtype: 'combobox',
				queryMode: 'local',
				store: 'query.andorstore', 
				displayField: 'andorname',
				valueField: 'andorcode'
			},
			listeners: {
				afterrender: function() {
					this.hide();
				}
			},
			flex: 2
		},{
			text: 'AGGREGATECOLUMN',
			dataIndex: 'AGGREGATECOLUMN',
			editor: {
				xtype: 'combobox',
				name: 'aggregateColumn',
				queryMode: 'local',
				store: 'query.aggColumnStore', 
				displayField: 'aggcolumnname',
				valueField: 'aggcolumncode',
				listeners: {
					focus: function() {
						var selFieldComp = Ext.ComponentQuery.query('selectedfield')[0];
						var selDataArr = selFieldComp.getStore().data.items;
						var aggregatefunc = "";
						var aggregatecolumn = new Array();
						for(i=0; i<selDataArr.length; i++) {
							aggregatefunc = selDataArr[i].data.AGGREGATEFUNC;
							if(aggregatefunc == undefined || aggregatefunc.length < 1) {
								// do nothing here
							} else {
								var display = selDataArr[i].data.DISPLAY;
								aggregatecolumn.push(display);
							}
						}
						var thisStore = this.getStore();
						thisStore.removeAll();
						if(aggregatecolumn.length > 0) {
							for(a=0;a<aggregatecolumn.length;a++) {
								thisStore.add({
									aggcolumnname: aggregatecolumn[a],
									aggcolumncode: aggregatecolumn[a]
								});
							}
						} else {
							thisStore.add({
								aggcolumnname: 'No group condition available',
								aggcolumncode: ''
							});
						}
					} //end focus function
				} // end listeners
			},	
			listeners: {
				afterrender: function() {
					this.hide();
				}
			},
			flex: 5
		},{
			text: 'CONDITIONOPERATOR',
			dataIndex: 'CONDITIONOPERATOR',
			editor: {
				xtype: 'combobox',
				queryMode: 'local',
				store: 'query.condOpStore', 
				displayField: 'operatorname',
				valueField: 'operatorcode'
			},
			listeners: {
				afterrender: function() {
					this.hide();
				}
			},
			flex: 2
		},{
			text: 'AGGREGATEVALUE',
			dataIndex: 'AGGREGATEVALUE',
			editor: {
				xtype: 'combobox',
				name: 'aggregateColumn',
				queryMode: 'local',
				store: 'query.aggColumnStore', 
				displayField: 'aggcolumnname',
				valueField: 'aggcolumncode',
				listeners: {
					focus: function() {
						var selFieldComp = Ext.ComponentQuery.query('selectedfield')[0];
						var selDataArr = selFieldComp.getStore().data.items;
						var aggregatefunc = "";
						var aggregatecolumn = new Array();
						for(i=0; i<selDataArr.length; i++) {
							aggregatefunc = selDataArr[i].data.AGGREGATEFUNC;
							if(aggregatefunc == undefined || aggregatefunc.length < 1) {
								// do nothing here
							} else {
								var display = selDataArr[i].data.DISPLAY;
								aggregatecolumn.push(display);
							}
						}
						var thisStore = this.getStore();
						thisStore.removeAll();
						if(aggregatecolumn.length > 0) {
							for(a=0;a<aggregatecolumn.length;a++) {
								thisStore.add({
									aggcolumnname: aggregatecolumn[a],
									aggcolumncode: aggregatecolumn[a]
								});
							}
						} else {
						}
					} //end focus function
				} // end listeners
			},
			listeners: {
				afterrender: function() {
					this.hide();
				}
			},
			flex: 3
		},{
			text: 'DISPLAY',
			dataIndex: 'DISPLAY',
			editor: 'textfield',
			flex: 1
		}],
		this.callParent(arguments);
	}
});