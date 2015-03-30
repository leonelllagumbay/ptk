Ext.define('Form.controller.query.viewquerymanagercontroller', {
    extend: 'Ext.app.Controller',
	
	views: [
        'query.optionDatasource',
        'query.optionTable',
        'query.optionField',
        'query.optionFieldFunction',
        'query.optionJoin',
        'query.optionCondition',
        'query.optionOrderBy',
        'query.selectedDatasource',
        'query.selectedTable',
        'query.selectedField',
        'query.selectedGroupBy',
        'query.selectedJoin',
        'query.selectedHaving',
        'query.selectedCondition',
        'query.selectedOrderBy',
        'query.generatedQuery',
        'query.MainListExtra'
    ],
	models: [
		'query.optionDBmodel',
		'query.optionTableModel',
		'query.optionFieldModel',
		'query.optionFieldFunctionModel',
		'query.optionOrderByModel',
		'query.selectedDBmodel',
		'query.selectedTableModel',
		'query.selectedFieldModel',
		'query.selectedGroupByModel',
		'query.selectedJoinModel',
		'query.selectedHavingModel',
		'query.selectedConditionModel',
		'query.selectedOrderByModel',
		'query.orderModel',
		'query.andormodel',
		'query.condOpModel',
		'query.aggColumnModel',
		'query.joinOpModel'
	],
	stores: [
		'query.optionDBstore',
		'query.optionTableStore',
		'query.optionFieldStore',
		'query.optionFieldFunctionStore',
		'query.optionOrderByStore',
		'query.selectedDBstore',
		'query.selectedTableStore',
		'query.selectedFieldStore',
		'query.selectedGroupByStore',
		'query.selectedJoinStore',
		'query.selectedHavingStore',
		'query.selectedConditionStore',
		'query.selectedOrderByStore',
		'query.orderStore',
		'query.andorstore',
		'query.condOpStore',
		'query.aggColumnStore',
		'query.joinOpStore'
	],
	
	
	
	onLaunch: function() {
	    var tableStore = this.getQueryOptionTableStoreStore();
	    tableStore.on('beforeload', this.tableStoreBeforeLoad);
	    tableStore.on('load', this.otableStoreLoad);
	    var fieldStore = this.getQueryOptionFieldStoreStore();
	    fieldStore.on('beforeload', this.fieldStoreBeforeLoad);
	    var orderByStore = this.getQueryOptionOrderByStoreStore();
	    orderByStore.on('beforeload', this.orderByStoreBeforeLoad);
	    var functionStore = this.getQueryOptionFieldFunctionStoreStore();
	    functionStore.on('load', this.fieldFunctionStoreLoad);
	    var sdbStore = this.getQuerySelectedDBstoreStore();
	    sdbStore.on('load', this.selectedDBStoreLoad);
	    var sTableStore = this.getQuerySelectedTableStoreStore();
	    sTableStore.on('load', this.selectedTableStoreLoad);
	},
	
    init: function() {
		console.log('init view query manager controller');
        this.control({
        	'panel button[action=runquery]': {
        		click: this.runQuery
        	},
            'selecteddatasource gridview': {
				drop: this.droppedToSelected
			},
			'selectedtable gridview': {
				drop: this.droppedToSelTable
			},
			'selectedtable gridview': {
				beforedrop: this.beforeDToSelTable
			},
			'selectedfield button[action=applyfunction]': {
				click: this.openSelectFunctionWin
			},
			'selectedfield gridview': {
				drop: this.applyGroupBy
			},
			'selectedfield': {
				edit: this.applyGroupBy
			},
			'optionfield gridview': {
				drop: this.applyGroupBy
			},
			'optiondatasource gridview': {
				drop: this.droppedToOptionDataSource
			}, 
			'optiontable gridview': {
				drop: this.droppedToSelTable
			},
			'selectedorderby gridview': {
				drop: this.droppedToSelOrderBy
			},
			'optionorderby gridview': {
				drop: this.droppedToOptOrderBy
			},
			'optionfieldfunction grid': {
				select: this.funcSelect
			},
			'optionfieldfunction button[action=applyselfunction]': {
				click: this.applyClicked
			},
			'optionfieldfunction button[action=cancelfunction]': {
				click: this.cancelClicked
			}, 
			'selectedhaving button[action=applygroupbyhaving]': {
				click: this.addHavingCondition
			},
			'selectedhaving button[action=applyaddhaving]': {
				click: this.applyHaving
			},
			'selectedhaving button[action=removehaving]': {
				click: this.removeHaving
			},
			'selectedjoin button[action=addjoinoperator]': {
				click: this.joinTable
			}, 
			'selectedjoin button[action=modifyjoinoperator]': {
				click: this.modifyJoin
			},
			'optionjoin button[action=canceljoin]': {
				click: this.joinCancel
			},
			'optionjoin button[action=addjoin]': {
				click: this.joinAdd
			},
			'optionjoin button[action=removejoin]': {
				click: this.joinRemove
			},
			'selectedcondition button[action=modifycondition]': {
				click: this.modifyCondition
			},
			'optioncondition button[action=addconditioin]': {
				click: this.conditionAdd
			},
			'optioncondition button[action=removecondition]': {
				click: this.conditionRemove
			},
			'optioncondition button[action=cancelcondition]': {
				click: this.conditionOKCancel
			},
			'selectedorderby': {
				edit: this.orderbyEdited
			}, 
			'optionjoin grid': {
				edit: this.optionJoinEdited
			},
			'optioncondition grid': {
				edit: this.optionConditionEdited
			}
			
        });
    
	},
	
	statics: {
		generateQuery: function() {
			var selDSComp 		= Ext.ComponentQuery.query('selecteddatasource')[0].getStore();
			var selTableComp 	= Ext.ComponentQuery.query('selectedtable')[0].getStore();
			var selFieldComp 	= Ext.ComponentQuery.query('selectedfield')[0].getStore();
			var selJoinComp 	= Ext.ComponentQuery.query('selectedjoin')[0].getStore();
			var selWhereComp 	= Ext.ComponentQuery.query('selectedcondition')[0].getStore();
			var selGroupByComp 	= Ext.ComponentQuery.query('selectedgroupby')[0].getStore();
			var selHavingComp 	= Ext.ComponentQuery.query('selectedhaving')[0].getStore();
			var selOrderByComp 	= Ext.ComponentQuery.query('selectedorderby')[0].getStore();
			
			var selDSCompL 		= selDSComp.data.length;
			var selTableCompL 	= selTableComp.data.length;
			var selFieldCompL 	= selFieldComp.data.length;
			var selJoinCompL 	= selJoinComp.data.length;
			var selWhereCompL 	= selWhereComp.data.length;
			var selGroupByCompL = selGroupByComp.data.length;
			var selHavingCompL 	= selHavingComp.data.length;
			var selOrderByCompL = selOrderByComp.data.length;
			
			var queryTextArea 	= Ext.ComponentQuery.query('generatedquery')[0];
			var fromTables = "";
			var fromColumns = "";
			if(selTableCompL == 0) {
				var oTableComp 	= Ext.ComponentQuery.query('optiontable')[0].getStore();
				if(oTableComp.data.items.length > 0) {
					var sd = oTableComp.data.items[0].data.TEMPTABLE;
				    queryTextArea.setValue("    SELECT *" + "\n      FROM " + sd);
				}
				
			} else if(selDSCompL > 0 && selTableCompL > 0 && selFieldCompL == 0 && selJoinCompL == 0) {
				fromTables = this.generateTablesNoJoin(selTableComp);
				condition = this.generateCondition(selWhereComp);
				groupby = ""; 
				having = "";
				orderby = this.generateOrderBy(selOrderByComp);
				
				queryTextArea.setValue("    SELECT *" + "\n      FROM  " + fromTables + condition + groupby + having + orderby);
				
			} else if(selDSCompL > 0 && selTableCompL > 0 && selFieldCompL > 0 && selJoinCompL == 0) {
				fromTables = this.generateTablesNoJoin(selTableComp);
				fromColumns = this.generateColumns(selFieldComp);
				condition = this.generateCondition(selWhereComp);
				groupby = this.generateGroupBy(selGroupByComp);
				if(groupby.trim() == "") {
					having = "";
				} else {
					having = this.generateHaving(selHavingComp);
				}
				
				orderby = this.generateOrderBy(selOrderByComp);
				
				queryTextArea.setValue("    SELECT " + fromColumns + "\n      FROM  " + fromTables + condition + groupby + having + orderby);
				
			} else if(selDSCompL > 0 && selTableCompL > 0 && selFieldCompL > 0 && selJoinCompL > 0) {
				fromTables = this.generateTablesWJoin(selJoinComp);
				fromColumns = this.generateColumns(selFieldComp);
				condition = this.generateCondition(selWhereComp);
				groupby = this.generateGroupBy(selGroupByComp);
				if(groupby.trim() == "") {
					having = "";
				} else {
					having = this.generateHaving(selHavingComp);
				}
				orderby = this.generateOrderBy(selOrderByComp);
				
				queryTextArea.setValue("    SELECT " + fromColumns + "\n      FROM  " + fromTables + condition + groupby + having + orderby);
				
			}  else if(selDSCompL == 0) {
				queryTextArea.setValue("");
			}
			
			console.log(selDSCompL);
			console.log(selTableCompL);
			console.log(selFieldCompL);
			console.log(selJoinCompL);
			console.log(selWhereCompL);
			console.log(selGroupByCompL);
			console.log(selHavingCompL);
			console.log(selOrderByCompL);
			
			
		},
		
		generateTablesNoJoin: function(selTableComp) {
			var fromTables = "";
				
			for(a=0;a<selTableComp.data.items.length;a++) {
				if(a==0) {
					fromTables = selTableComp.data.items[0].data.TEMPTABLE + " " + selTableComp.data.items[0].data.TABLEALIAS;
				} else {
					fromTables += "\n                " + selTableComp.data.items[a].data.TEMPTABLE + " " + selTableComp.data.items[a].data.TABLEALIAS;
				}
				if(a != selTableComp.data.items.length - 1) {
					fromTables += ",";
				}
			}
			
			return fromTables;
		},
		
		generateColumns: function(selFieldComp) {
			var fromColumns = "";
			var findSpace = /\s/;
			for(a=0;a<selFieldComp.data.items.length;a++) {
				if(a==0) {
					if(selFieldComp.data.items[0].data.FIELDALIAS.trim() == "") { 
						fromColumns = selFieldComp.data.items[0].data.DISPLAY;
					} else if (findSpace.exec(selFieldComp.data.items[0].data.FIELDALIAS)) {
						fromColumns = selFieldComp.data.items[0].data.DISPLAY + " AS '" + selFieldComp.data.items[0].data.FIELDALIAS + "'";
					} else {
						fromColumns = selFieldComp.data.items[0].data.DISPLAY + " AS " + selFieldComp.data.items[0].data.FIELDALIAS;
					}
					
				} else {
					if(selFieldComp.data.items[a].data.FIELDALIAS.trim() == "") { 
						fromColumns += "\n                " + selFieldComp.data.items[a].data.DISPLAY;
					} else if (findSpace.exec(selFieldComp.data.items[a].data.FIELDALIAS)) {
						fromColumns += "\n                " + selFieldComp.data.items[a].data.DISPLAY + " AS '" + selFieldComp.data.items[a].data.FIELDALIAS + "'";
					} else {
						fromColumns += "\n                " + selFieldComp.data.items[a].data.DISPLAY + " AS " + selFieldComp.data.items[a].data.FIELDALIAS;
					}
					
				}
				if(a != selFieldComp.data.items.length - 1) {
					fromColumns += ",";
				}
			}
			return fromColumns;
		},
		
		generateTablesWJoin: function(selJoinComp) {
			var fromTables = "";
				
			for(a=0;a<selJoinComp.data.items.length;a++) {
				if(a==0) {
					fromTables = selJoinComp.data.items[0].data.DISPLAY;
				} else {
					fromTables += "\n                " + selJoinComp.data.items[a].data.DISPLAY;
				}
				if(a != selJoinComp.data.items.length - 1) {
					fromTables += ",";
				}
			}
			
			return fromTables;
		},
		
		generateCondition: function(selWhereComp) {
			
			var where = " ";
				
			for(a=0;a<selWhereComp.data.items.length;a++) {
				if(a==0) {
					where = selWhereComp.data.items[0].data.DISPLAY;
				} else {
					where += "\n                " + selWhereComp.data.items[a].data.DISPLAY;
				}
			}
			
			if(where.trim() == "") return "";
			else return "\n     WHERE " + where;
		},
		
		generateGroupBy: function(selGroupByComp) {
			
			var groupby = " ";
				
			for(a=0;a<selGroupByComp.data.items.length;a++) {
				if(a==0) {
					groupby = selGroupByComp.data.items[0].data.GROUPBYCOLUMN;
				} else {
					groupby += "\n                " + selGroupByComp.data.items[a].data.GROUPBYCOLUMN;
				}
				if(a != selGroupByComp.data.items.length - 1) {
					groupby += ",";
				}
			}
			
			if(groupby.trim() == "") return "";
			else return "\nGROUP BY " +  groupby;
			
		},
		
		generateHaving: function(selHavingComp) {
			
			var having = " ";
				
			for(a=0;a<selHavingComp.data.items.length;a++) {
				if(a==0) {
					having = selHavingComp.data.items[0].data.DISPLAY;
				} else {
					having += "\n                " + selHavingComp.data.items[a].data.DISPLAY;
				}
			}
			if(having) return "";
			else return "\n    HAVING " +  having;
			
			
		},
		
		generateOrderBy: function(orderbyArray) {
			
			var orderby = " "; 
				
			for(a=0;a<orderbyArray.data.items.length;a++) {
				if(a==0) {
					orderby = orderbyArray.data.items[0].data.DISPLAY + " " + orderbyArray.data.items[0].data.ASCORDESC;
				} else {
					orderby += "\n                " + orderbyArray.data.items[a].data.DISPLAY + " " + orderbyArray.data.items[a].data.ASCORDESC;
				}
				if(a != orderbyArray.data.items.length - 1) {
					orderby += ",";
				}
			}
			
			if(orderby.trim() == "") return "";
			else return "\nORDER BY " +  orderby;
			
		}
	},
	
	
	runQuery: function(b) {
		
		var gqmask = Ext.create('Ext.LoadMask', {
						target: b.up('panel'),
						msg: 'Processing, please wait...'
					 });
		
		gqmask.show();
		var thequery = Ext.ComponentQuery.query('generatedquery')[0].getValue();
		var groupbyArr = new Array();
		var groupby = Ext.ComponentQuery.query('selectedgroupby')[0].getStore().data.items;
		for(a=0; a<groupby.length; a++) {
			groupbyArr.push(groupby[a].data.GROUPBYCOLUMN);
		}
		
		var name = ""; 
		var group = "";
		var rowsperpage = "";
		var header = "";
		var footer = "";
		var preprocess = "";
		var postprocess = "";
		Ext.ss.Query.generateQuery( thequery,  
									groupbyArr, 
									name, 
									group, 
									rowsperpage, 
									header, 
									footer, 
									preprocess, 
									postprocess, 
		function(result) {
			
			
			console.log(result);
			gqmask.hide();
		})
	},
	
	optionJoinEdited: function() {
		var joinGrid = Ext.widget('selectedjoin');
		
		var selJoin = joinGrid.getStore().data.items;
		for(a=0;a<selJoin.length;a++) {
			var jop = selJoin[a].data.JOINOPERATOR;
			var tname = selJoin[a].data.TABLENAME;
			var onc = selJoin[a].data.ONCOLUMN;
			var eqc = selJoin[a].data.EQUALTOCOLUMN;
			
			if(!jop) {
				jop = " ";
			}
			if(!tname) {
				tname = " ";
				return true;
			}
			if(!onc) {
				onc = " ";
			}
			if(!eqc) {
				eqc = " ";
			}
			
			if(a == 0) jop = "";
			
			if(onc == " " || eqc == " ") selJoin[a].set("DISPLAY", tname);
			else selJoin[a].set("DISPLAY", jop + " " + tname + " ON " + onc + " = " + eqc);	
		}
		
		Form.controller.query.viewquerymanagercontroller.generateQuery();
	},
	
	orderbyEdited: function() {
		Form.controller.query.viewquerymanagercontroller.generateQuery();
	},
	
	modifyCondition: function(btn) {
		var conditionComp = Ext.widget('optioncondition');
		conditionComp.show();
		//can be used as global function, statics
		//Form.controller.query.viewquerymanagercontroller.generateQuery();
	},
	
	optionConditionEdited: function() {
		var condGrid = Ext.widget('selectedcondition');
		var selCondition = condGrid.getStore().data.items;
		for(a=0;a<selCondition.length;a++) {
			
			var jop = selCondition[a].data.CONJUNCTIVEOPERATOR;
			var oncolumn = selCondition[a].data.ONCOLUMN;
			var condop = selCondition[a].data.CONDITIONOPERATOR;
			var value = selCondition[a].data.COLUMNVALUE;
			
			if(!jop) {
				jop = " ";
			}
			if(!oncolumn) {
				oncolumn = " ";
				return true;
			}
			if(!condop) {
				condop = " ";
			}
			if(!value) {
				value = " ";
			}
			
			if(a == 0) jop = "";
			
			if(oncolumn == " " || value == " ") selCondition[a].set("DISPLAY", oncolumn + " = " + oncolumn);
			else selCondition[a].set("DISPLAY", jop + " " + oncolumn + " " + condop + " " + value);
		}
		
		Form.controller.query.viewquerymanagercontroller.generateQuery();
	},
	
	
	joinRemove: function(btn) {
		var joinGrid = Ext.ComponentQuery.query('optionjoin grid')[0];
		var dataSel = joinGrid.getSelectionModel().getSelection();
		joinGrid.getStore().remove(dataSel);
		
		var dataLen = joinGrid.getStore().data.length;
		joinGrid.getView().select(dataLen-1);
		
		var joinGrid = Ext.widget('selectedjoin');
		
		var selJoin = joinGrid.getStore().data.items;
		for(a=0;a<selJoin.length;a++) {
			var jop = selJoin[a].data.JOINOPERATOR;
			var tname = selJoin[a].data.TABLENAME;
			var onc = selJoin[a].data.ONCOLUMN;
			var eqc = selJoin[a].data.EQUALTOCOLUMN;
			
			if(!jop) {
				jop = " ";
			}
			if(!tname) {
				tname = " ";
				return true;
			}
			if(!onc) {
				onc = " ";
			}
			if(!eqc) {
				eqc = " ";
			}
			
			if(a == 0) jop = "";
			
			if(onc == " " || eqc == " ") selJoin[a].set("DISPLAY", tname);
			else selJoin[a].set("DISPLAY", jop + " " + tname + " ON " + onc + " = " + eqc);	
		}
		
		Form.controller.query.viewquerymanagercontroller.generateQuery();
	},
	
	conditionRemove: function(btn) {
		var condGrid = Ext.ComponentQuery.query('optioncondition grid')[0];
		var dataSel = condGrid.getSelectionModel().getSelection();
		condGrid.getStore().remove(dataSel);
		
		var dataLen = condGrid.getStore().data.length;
		condGrid.getView().select(dataLen-1);
		
		
		var condGrid = Ext.widget('selectedcondition');
		var selCondition = condGrid.getStore().data.items;
		for(a=0;a<selCondition.length;a++) {
			
			var jop = selCondition[a].data.CONJUNCTIVEOPERATOR;
			var oncolumn = selCondition[a].data.ONCOLUMN;
			var condop = selCondition[a].data.CONDITIONOPERATOR;
			var value = selCondition[a].data.COLUMNVALUE;
			
			if(!jop) {
				jop = " ";
			}
			if(!oncolumn) {
				oncolumn = " ";
				return true;
			}
			if(!condop) {
				condop = " ";
			}
			if(!value) {
				value = " ";
			}
			
			if(a == 0) jop = "";
			
			if(oncolumn == " " || value == " ") selCondition[a].set("DISPLAY", oncolumn + " = " + oncolumn);
			else selCondition[a].set("DISPLAY", jop + " " + oncolumn + " " + condop + " " + value);
		}
		
		Form.controller.query.viewquerymanagercontroller.generateQuery();
	},
	
	joinAdd: function(btn) {
		var joinGrid = Ext.ComponentQuery.query('optionjoin grid')[0];
		var selJoinStore = joinGrid.getStore();
		
		selJoinStore.add({
			EVIEWJOINEDTABLECODE: '',
			EVIEWCODEFK: '',
			PRIORITYNO: '',
			JOINOPERATOR: '',
			TABLENAME: '',
			ONCOLUMN: '',
			EQUALTOCOLUMN: '',
			DISPLAY: ''
		});
		
		var dataLen = selJoinStore.data.length;
		joinGrid.getView().select(dataLen-1);
	},
	
	conditionAdd: function(btn) {
		var condGrid = Ext.ComponentQuery.query('optioncondition grid')[0];
		var selCondStore = condGrid.getStore();
		
		selCondStore.add({
			EVIEWCONDITIONCODE: '',
			EVIEWCODEFK: '',
			PRIORITYNO: '',
			CONJUNCTIVEOPERATOR: '',
			ONCOLUMN: '',
			CONDITIONOPERATOR: '',
			COLUMNVALUE: '',
			DISPLAY: ''
		});
		
		var dataLen = selCondStore.data.length;
		condGrid.getView().select(dataLen-1);
	},
	
	joinCancel: function(btn) {
		btn.up('window').close();
	},
	
	conditionOKCancel: function(btn) {
		btn.up('window').close();
	},
	
	modifyJoin: function(btn) {
		var optionJoin = Ext.widget('optionjoin');
		optionJoin.show();
	},
	
	joinTable: function(btn) {
		var optionJoin = Ext.widget('optionjoin');
		optionJoin.show();
	},
	
	removeHaving: function(btn) {
		var theHgrid = btn.up('grid');
		//dataLen = theHgrid.getStore().data.length;
		var dataSel = theHgrid.getSelectionModel().getSelection();
		theHgrid.getStore().remove(dataSel);
		
		Form.controller.query.viewquerymanagercontroller.generateQuery();
	},
	
	applyHaving: function(btn) {
		var theHgrid = btn.up('grid');
		theHgrid.columns[3].setVisible(false);
		theHgrid.columns[4].setVisible(false);
		theHgrid.columns[5].setVisible(false);
		theHgrid.columns[6].setVisible(false);
		theHgrid.columns[7].setVisible(true);
		
		
		
		var theApplyB = theHgrid.down('button[action=applygroupbyhaving]');
		var theRemoveB = theHgrid.down('button[action=removehaving]');
		theApplyB.setVisible(true);
		theRemoveB.setVisible(false);
		btn.setVisible(false);
		
		hDataItems = theHgrid.getStore().data.items;
		for(b=0;b<hDataItems.length;b++) {
			var conjOp = hDataItems[b].data.CONJUNCTIVEOPERATOR;
			var aggCol = hDataItems[b].data.AGGREGATECOLUMN;
			var condOp = hDataItems[b].data.CONDITIONOPERATOR;
			var aggVal = hDataItems[b].data.AGGREGATEVALUE;
			var val = conjOp + ' ' + aggCol + ' ' + condOp + ' ' + aggVal;
			hDataItems[b].set('DISPLAY',val);
			//hDataItems[b].data.commit();
		}
		
		//check first record shouldn't have a conjunctive operator AND/OR
		if(hDataItems[0]) {
			hDataItems[0].set('CONJUNCTIVEOPERATOR', ' ');
			var conjOp = hDataItems[0].data.CONJUNCTIVEOPERATOR;
			var aggCol = hDataItems[0].data.AGGREGATECOLUMN;
			var condOp = hDataItems[0].data.CONDITIONOPERATOR;
			var aggVal = hDataItems[0].data.AGGREGATEVALUE;
			var val    = conjOp + ' ' + aggCol + ' ' + condOp + ' ' + aggVal;
			hDataItems[0].set('DISPLAY',val);
		}
		
		Form.controller.query.viewquerymanagercontroller.generateQuery();
		
	},
	
	addHavingCondition: function(btn) {
		var theHgrid = btn.up('grid');
		theHgrid.columns[3].setVisible(true);
		theHgrid.columns[4].setVisible(true);
		theHgrid.columns[5].setVisible(true);
		theHgrid.columns[6].setVisible(true);
		theHgrid.columns[7].setVisible(false);
		dataLen = theHgrid.getStore().data.length;
		if(dataLen > 0) {
			theHgrid.getStore().add({
				CONJUNCTIVEOPERATOR: 'OR',
				AGGREGATECOLUMN: '',
				CONDITIONOPERATOR: '>',
				AGGREGATEVALUE: '0'
			});
		} else {
			theHgrid.getStore().add({
				CONJUNCTIVEOPERATOR: '',
				AGGREGATECOLUMN: '(select)',
				CONDITIONOPERATOR: '>',
				AGGREGATEVALUE: '0'
			});
		}
		
		
		theHgrid.getView().select(dataLen);
		//theHgrid.getStore().insert(1,[]);
		var theApplyB = theHgrid.down('button[action=applyaddhaving]');
		var theRemoveB = theHgrid.down('button[action=removehaving]');
		theApplyB.setVisible(true);
		theRemoveB.setVisible(true);
		btn.setVisible(false);
		
		Form.controller.query.viewquerymanagercontroller.generateQuery();
	},
	
	applyClicked: function(btn) {
		
		var selFieldComp = Ext.ComponentQuery.query('selectedfield')[0];
		var selData = selFieldComp.getSelectionModel().getSelection()[0];
		var display = selData.data.DISPLAY;
		var oldVal = display;
		var newVal = "";
		
		var funcCompGrid = Ext.ComponentQuery.query('optionfieldfunction grid[name=functionGrid]')[0];
		var funcData = funcCompGrid.getSelectionModel().getSelection()[0];
		var reqArgs = funcData.data.REQUIREDNOOFARGS;
		var funcName = funcData.data.FUNCTIONNAME;
		var funcType = funcData.data.CATEGORY;
		
		if(reqArgs == 1 || reqArgs == 0 || reqArgs == '' || reqArgs == undefined) {
			var indexofleftParenth = display.indexOf("(");
			var indexofrightParenth = display.indexOf(")");
			
			if(indexofleftParenth != -1 && indexofrightParenth != -1) {
				var display = display.substring(indexofleftParenth + 1,indexofrightParenth);
			}
			var funcEnclosed = funcName + "(" + display + ")";
			var newVal = funcEnclosed;
			selData.set("DISPLAY",funcEnclosed);
			if(funcType.toUpperCase() == 'AGGREGATE') {
				selData.set("AGGREGATEFUNC",funcName);
			} else {
				selData.set("AGGREGATEFUNC","");
			}
			
		} else {
			var tablename = selData.data.TABLENAME;
			var columnname = selData.data.FIELDNAME;
		}
		
		var selDataArr = selFieldComp.getStore().data.items;
		var aggregatefunc = "";
		var aggregatecount = 0;
		var aggregatecolumn = new Array();
		for(i=0; i<selDataArr.length; i++) {
			
			aggregatefunc = selDataArr[i].data.AGGREGATEFUNC;
			if(aggregatefunc == undefined || aggregatefunc.length < 1) {
				var display = selDataArr[i].data.DISPLAY;
				var indexofleftParenth = display.indexOf("(");
				var indexofrightParenth = display.indexOf(")");
				
				if(indexofleftParenth != -1 && indexofrightParenth != -1) {
					var display = display.substring(indexofleftParenth + 1,indexofrightParenth);
				}
				aggregatecolumn.push(display);
			} else {
				aggregatecount += 1;
			}
		}
		
		var selGroupByStore = Ext.ComponentQuery.query('selectedgroupby')[0].getStore();
		selGroupByStore.removeAll();
		if(aggregatecount > 0) {
			for(a=0;a<aggregatecolumn.length;a++) {
				selGroupByStore.add({
					GROUPBYCOLUMN: aggregatecolumn[a],
					PRIORITYNO: a
				});
			}
		} else {
			//do nothing
		}
		
		
		btn.up('window').close();
		
		//update having field also
		var theHgrid = Ext.ComponentQuery.query('selectedhaving')[0];
		hDataItems = theHgrid.getStore().data.items;
		for(b=0;b<hDataItems.length;b++) {
			var aggCol = hDataItems[b].data.AGGREGATECOLUMN;
			if(aggCol.toUpperCase() == oldVal.toUpperCase()) {
				hDataItems[b].set('AGGREGATECOLUMN',newVal);
				var conjOp = hDataItems[b].data.CONJUNCTIVEOPERATOR;
				var aggCol = newVal;
				var condOp = hDataItems[b].data.CONDITIONOPERATOR;
				var aggVal = hDataItems[b].data.AGGREGATEVALUE;
				var val = conjOp + ' ' + aggCol + ' ' + condOp + ' ' + aggVal;
				hDataItems[b].set('DISPLAY',val);
			}
		}
		
		//check first record shouldn't have a conjunctive operator AND/OR
		if(hDataItems[0]) {
			hDataItems[0].set('CONJUNCTIVEOPERATOR', ' ');
			var conjOp = hDataItems[0].data.CONJUNCTIVEOPERATOR;
			var aggCol = hDataItems[0].data.AGGREGATECOLUMN;
			var condOp = hDataItems[0].data.CONDITIONOPERATOR;
			var aggVal = hDataItems[0].data.AGGREGATEVALUE;
			var val    = conjOp + ' ' + aggCol + ' ' + condOp + ' ' + aggVal;
			hDataItems[0].set('DISPLAY',val);
		}
		
		Form.controller.query.viewquerymanagercontroller.generateQuery();
	},
	
	
	applyGroupBy: function(thisE,data) {
		var oldVal = data.originalValue;
		var newVal = data.value;
		var selFieldComp = Ext.ComponentQuery.query('selectedfield')[0];
		var selDataArr = selFieldComp.getStore().data.items;
		var aggregatefunc = "";
		var aggregatecount = 0;
		var aggregatecolumn = new Array();
		for(i=0; i<selDataArr.length; i++) {
			
			aggregatefunc = selDataArr[i].data.AGGREGATEFUNC;
			if(aggregatefunc == undefined || aggregatefunc.length < 1) {
				var display = selDataArr[i].data.DISPLAY;
				var indexofleftParenth = display.indexOf("(");
				var indexofrightParenth = display.indexOf(")");
				
				if(indexofleftParenth != -1 && indexofrightParenth != -1) {
					var display = display.substring(indexofleftParenth + 1,indexofrightParenth);
				}
				aggregatecolumn.push(display);
			} else {
				aggregatecount += 1;
			}
		}
		
		var selGroupByStore = Ext.ComponentQuery.query('selectedgroupby')[0].getStore();
		selGroupByStore.removeAll();
		if(aggregatecount > 0) {
			for(a=0;a<aggregatecolumn.length;a++) {
				selGroupByStore.add({
					GROUPBYCOLUMN: aggregatecolumn[a],
					PRIORITYNO: a
				});
			}
		} else {
			//do nothing
		}
		
		//update having field also
		var theHgrid = Ext.ComponentQuery.query('selectedhaving')[0];
		hDataItems = theHgrid.getStore().data.items;
		var aggCol = "";
		//update old to new when edited or remove having if not in the field list when dropped
		if(oldVal != undefined) {
			
			for(b=0;b<hDataItems.length;b++) {
				aggCol = hDataItems[b].data.AGGREGATECOLUMN;
				if(aggCol.toUpperCase() == oldVal.toUpperCase()) {
					hDataItems[b].set('AGGREGATECOLUMN',newVal);
					var conjOp = hDataItems[b].data.CONJUNCTIVEOPERATOR;
					var aggCol = newVal;
					var condOp = hDataItems[b].data.CONDITIONOPERATOR;
					var aggVal = hDataItems[b].data.AGGREGATEVALUE;
					var val = conjOp + ' ' + aggCol + ' ' + condOp + ' ' + aggVal;
					hDataItems[b].set('DISPLAY',val);
				}
			}
		
		} else {
			
			for(b=0;b<hDataItems.length;b++) {
				aggCol = hDataItems[b].data.AGGREGATECOLUMN;
				var existTest = 0;
				for(i=0; i<selDataArr.length; i++) {
					aggregatedisplay = selDataArr[i].data.DISPLAY;
					if(aggregatedisplay == aggCol) {
						existTest += 1;
						break;
					}
				}
				if(existTest == 0) {
					theHgrid.getStore().remove(hDataItems[b]);
				}
			}
		}
		
		//check first record shouldn't have a conjunctive operator AND/OR
		if(hDataItems[0]) {
			hDataItems[0].set('CONJUNCTIVEOPERATOR', ' ');
			var conjOp = hDataItems[0].data.CONJUNCTIVEOPERATOR;
			var aggCol = hDataItems[0].data.AGGREGATECOLUMN;
			var condOp = hDataItems[0].data.CONDITIONOPERATOR;
			var aggVal = hDataItems[0].data.AGGREGATEVALUE;
			var val    = conjOp + ' ' + aggCol + ' ' + condOp + ' ' + aggVal;
			hDataItems[0].set('DISPLAY',val);
		}
		
		Form.controller.query.viewquerymanagercontroller.generateQuery();
	},
	
	
	cancelClicked: function(btn) {
		btn.up('window').close();
	},
	
	funcSelect: function(thisGrid,b) {
		var dataSyntax = b.data.SYNTAX;
		var dataDefinition = b.data.DEFINITION;
		var theDisp = Ext.ComponentQuery.query('optionfieldfunction panel displayfield[name=displaysyntax]')[0];
		theDisp.setValue("<b>Syntax:</b><br/>" + dataSyntax + "<br/><br/><b>Definition:</b><br/>" + dataDefinition);
		return true;
	},
	
	beforeDToSelTable: function(node,data, overModel, dropPosition, dropHandlers) {
		
		if(data.fromPosition[0] < 235) {
			var records = data.records;
			var dbtabledata = Ext.widget('selectedtable').getStore().data.items;
			var dbtableno = dbtabledata.length;
			var dbTableArr = new Array();
			var dbSourceArr = new Array();
			
			for(a=0;a<records.length;a++) {
				for(b=0;b<dbtableno;b++) {
					for(c=0;c<dbtableno;c++) {
						if(dbtabledata[c].data.TABLEALIAS == records[a].data.TABLEALIAS) {
							records[a].data.TABLEALIAS = records[a].data.TABLEALIAS + "0";
						}
					}
				}
			}
		}
		dropHandlers.processDrop();
		Ext.widget('optionfield').getStore().load();
		Ext.widget('optionorderby').getStore().load();
		
		Form.controller.query.viewquerymanagercontroller.generateQuery();
	},
	
	droppedToSelected: function() 
	{
		var optionTable = Ext.widget('optiontable');
		optionTable.getStore().load();
		
	},
	
	droppedToOptionDataSource: function() 
	{
		Ext.widget('optiontable').getStore().load();
		
		Form.controller.query.viewquerymanagercontroller.generateQuery();
	},
	
	droppedToSelTable: function(thiss, d)
	{
		
		Ext.widget('optionfield').getStore().load();
		Ext.widget('optionorderby').getStore().load();
		
		var selFieldS = Ext.widget('selectedfield').getStore();
		console.log(selFieldS); //DISPLAY
		var selJoinS = Ext.widget('selectedjoin').getStore();
		console.log(selJoinS); //DISPLAY
		var selWhereS = Ext.widget('selectedcondition').getStore();
		console.log(selWhereS); //DISPLAY
		var selGroupbyS = Ext.widget('selectedgroupby').getStore();
		console.log(selGroupbyS); //GROUPBYCOLUMN
		var selHavingS = Ext.widget('selectedhaving').getStore();
		console.log(selHavingS); //DISPLAY
		var selOrderByS = Ext.widget('selectedorderby').getStore();
		console.log(selOrderByS); //DISPLAY
		
		var res = 0;
		var display = '';
		var b = 0;
		
		for(a=0; a<d.records.length; a++) {
			var tableToRemove = d.records[a].data.TABLENAME;
			tableToRemove = tableToRemove.trim();
			
			b=0;
			
			while(b<selFieldS.data.items.length) {
				display = selFieldS.data.items[b].data.DISPLAY;
				res = display.indexOf(tableToRemove,0);
				if(res > -1) {
					selFieldS.remove(selFieldS.data.items[b]);
					b=0;
				} else {
					b++;
				}
			}
			
			b=0;
			
			while(b<selJoinS.data.items.length) {
				display = selJoinS.data.items[b].data.DISPLAY;
				res = display.indexOf(tableToRemove,0);
				if(res > -1) {
					selJoinS.remove(selJoinS.data.items[b]);
					b=0;
				} else {
					b++;
				}
			}
			
			b=0;
			
			while(b<selWhereS.data.items.length) {
				display = selWhereS.data.items[b].data.DISPLAY;
				res = display.indexOf(tableToRemove,0);
				if(res > -1) {
					selWhereS.remove(selWhereS.data.items[b]);
					b=0;
				} else {
					b++;
				}
			}
			
			b=0;
			
			while(b<selGroupbyS.data.items.length) {
				display = selGroupbyS.data.items[b].data.GROUPBYCOLUMN;
				res = display.indexOf(tableToRemove,0);
				if(res > -1) {
					selGroupbyS.remove(selGroupbyS.data.items[b]);
					b=0;
				} else {
					b++;
				}
			}
			
			
			b=0;
			
			while(b<selHavingS.data.items.length) {
				display = selHavingS.data.items[b].data.DISPLAY;
				res = display.indexOf(tableToRemove,0);
				if(res > -1) {
					selHavingS.remove(selHavingS.data.items[b]);
					b=0;
				} else {
					b++;
				}
			}
			
			b=0;
			
			while(b<selOrderByS.data.items.length) {
				display = selOrderByS.data.items[b].data.DISPLAY;
				res = display.indexOf(tableToRemove,0);
				if(res > -1) {
					selOrderByS.remove(selOrderByS.data.items[b]);
					b=0;
				} else {
					b++;
				}
			}
			
		} // end for loop
		
		Form.controller.query.viewquerymanagercontroller.generateQuery();
	},
	
	
	droppedToOptOrderBy: function() 
	{
		Form.controller.query.viewquerymanagercontroller.generateQuery();
	},
	
	droppedToSelOrderBy: function(a,rec) 
	{
		
		var droppedDisp = rec.records;
		var disp = "";
		var notthere = 0;
		var selGroupBy = Ext.widget('selectedgroupby').getStore().data.items;
		for(b=0; b<droppedDisp.length; b++) {
			disp = droppedDisp[b].data.DISPLAY;
			notthere = 0;
			for(c=0; c<selGroupBy.length; c++) {
				if(selGroupBy[c].data.GROUPBYCOLUMN.trim() == disp.trim()) {
					var notthere = 1;
				}
			}
			if(notthere == 0) {
				alert(disp + ' field is not in the group by list. \nTry applying aggregate function in the order by list. \nExample: MIN('+disp+') ASC');
			}
		}
		Form.controller.query.viewquerymanagercontroller.generateQuery();
	},
	
	openSelectFunctionWin: function(btn)
	{
		var selectWin = Ext.widget('optionfieldfunction');
		var theStore = Ext.ComponentQuery.query('optionfieldfunction grid[name=functionGrid]')[0].getStore();
		theStore.load();
		selectWin.show();
	},
	
	tableStoreBeforeLoad: function(theStore,theOperation) {
		
		var dbsourcedata = Ext.widget('selecteddatasource').getStore().data.items;
		var dbsourceno = dbsourcedata.length;
		var dbSourceArr = new Array();
		
		for(a=0;a<dbsourceno;a++) {
			dbSourceArr.push(dbsourcedata[a].data.DATASOURCENAME);
		}
		
		if(theOperation.params.filter != undefined) {
			theOperation.params.dFilter = theOperation.params.filter;
		} else {
			var dFilter = new Array();
			var valObj = {value: ''};
			dFilter.push(valObj);
			theOperation.params.dFilter = dFilter;
		}
		
		theOperation.params.dSource = dbSourceArr;
		return true;
	}, 
	 
	fieldStoreBeforeLoad: function(theStore,theOperation) {
		
		var dbtabledata = Ext.widget('selectedtable').getStore().data.items;
		var dbtableno = dbtabledata.length;
		var dbTableArr = new Array();
		var dbSourceArr = new Array();
		var dbAliasArr = new Array();
		
		for(a=0;a<dbtableno;a++) {
			dbTableArr.push(dbtabledata[a].data.TABLENAME);
			dbSourceArr.push(dbtabledata[a].data.DATASOURCE);
			dbAliasArr.push(dbtabledata[a].data.TABLEALIAS);
		}
		
		if(theOperation.params.filter != undefined) {
			theOperation.params.dFilter = theOperation.params.filter;
		} else {
			var dFilter = new Array();
			var valObj = {value: ''};
			dFilter.push(valObj);
			theOperation.params.dFilter = dFilter;
		}
		
		theOperation.params.dSource = dbSourceArr;
		theOperation.params.dTable = dbTableArr;
		theOperation.params.dTableAlias = dbAliasArr;
	},
	
	orderByStoreBeforeLoad: function(theStore,theOperation) {
		var dbtabledata = Ext.widget('selectedtable').getStore().data.items;
		
		var dbtableno = dbtabledata.length;
		var dbTableArr = new Array();
		var dbSourceArr = new Array();
		var dbAliasArr = new Array();
		
		for(a=0;a<dbtableno;a++) {
			dbTableArr.push(dbtabledata[a].data.TABLENAME);
			dbSourceArr.push(dbtabledata[a].data.DATASOURCE);
			dbAliasArr.push(dbtabledata[a].data.TABLEALIAS);
		}
		
		if(theOperation.params.filter != undefined) {
			theOperation.params.dFilter = theOperation.params.filter;
		} else {
			var dFilter = new Array();
			var valObj = {value: ''};
			dFilter.push(valObj);
			theOperation.params.dFilter = dFilter;
		}
		
		theOperation.params.dSource = dbSourceArr;
		theOperation.params.dTable = dbTableArr;
		theOperation.params.dTableAlias = dbAliasArr;
		return true;
	},
	
	fieldFunctionStoreLoad: function(theStore,theOperation) {
		var theDisp = Ext.ComponentQuery.query('optionfieldfunction panel displayfield[name=displaysyntax]')[0];
		var dataSyntax = theOperation[0].data.SYNTAX;
		var dataDefinition = theOperation[0].data.DEFINITION;
		theDisp.setValue("<b>Syntax:</b><br/>" + dataSyntax + "<br/><br/><b>Definition:</b><br/>" + dataDefinition);
		
		//Ext.ComponentQuery.query('optionfieldfunction grid[name=functionGrid]')[0].getSelectionModel().select(0);
		Ext.ComponentQuery.query('optionfieldfunction grid[name=functionGrid]')[0].getView().select(0);
		
		return true;
	},
	
	otableStoreLoad: function(theStore) {
		Form.controller.query.viewquerymanagercontroller.generateQuery();
	},
	
	selectedDBStoreLoad: function(theStore) {
   	 	var optionTable = Ext.widget('optiontable');
		optionTable.getStore().load();
	},
	
	selectedTableStoreLoad: function(theStore) {
   	 	var optionField = Ext.widget('optionfield');
   	 	optionField.getStore().load(); 
   	    var optionOrderby = Ext.widget('optionorderby');
   	 	optionOrderby.getStore().load();
	},
	
	
	
});