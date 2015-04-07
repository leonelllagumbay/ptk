/**
 * Preview
 *
 * @author LEONELL
 * @date 3/31/15
 **/
component accessors=true output=false persistent=false ExtDirect="true" {
	public struct function getGridDefinition(required string querycode) ExtDirect="true" {
		var ret = structNew();
		var controllerArr = ArrayNew(1);
		var modelArr = ArrayNew(1);
		var storeArr = ArrayNew(1);
		var viewArr = ArrayNew(1);
		var appArr = ArrayNew(1);

		setModel(querycode);
		setStore();
		setView();
		setController();
		setApp();

		ArrayAppend(modelArr, model);
		ArrayAppend(storeArr, store);
		ArrayAppend(viewArr, view);
		ArrayAppend(controllerArr,controller);
		ArrayAppend(appArr, app);

		ret["model"] = modelArr;
		ret["store"] = storeArr;
		ret["view"] = viewArr;
		ret["controller"] = controllerArr;
		ret["app"] = appArr;
		return ret;
	}

	private void function setModel(required string querycode) {

		// query egrgeviewfields => tablename, fieldname
		// query egrgqrycolumn => outputtype
		var tablecolumnArr = OrmExecuteQuery("SELECT EVIEWFIELDCODE, TABLENAME, FIELDNAME FROM EGRGEVIEWFIELDS WHERE EQRYCODEFK = '#querycode#'",false);
		var fieldArray = ArrayNew(1);

		for(a=1; a<=ArrayLen(tablecolumnArr); a++) {
			nametypeStruct = StructNew();
			var type = OrmExecuteQuery("SELECT OUTPUTTYPE FROM EGRGQRYCOLUMN WHERE EVIEWFIELDCODE = '#tablecolumnArr[a][1]#'",true);
			if(Isdefined("type")) {
				if(trim(type) eq "") {
					type = "string";
				}
			} else {
				type = "string";
			}
			nametypeStruct["name"] = trim(tablecolumnArr[a][2]) & trim(tablecolumnArr[a][3]);
			nametypeStruct["type"] = type;
			ArrayAppend(fieldArray, nametypeStruct);
		}
		dstring = Serializejson(fieldArray);

		//save content
		savecontent variable="model" {
			writeoutput("Ext.define('Myquery.QueryModel', {
							extend: 'Ext.data.Model',
							fields: #dstring#
						});");
		}
	}

	private void function setStore() {
		savecontent variable="store" {
			writeoutput("Ext.define('Myquery.QueryStore', {
							extend: 'Ext.data.Store',
							model: 'Myquery.QueryModel',
							remoteFilter: true,
							remoteSort: true,
							simpleSortMode: true,
							autoSave: true,
							autoLoad: true,
							autoSync: true,
							constructor : function(config) {
								Ext.applyIf(config, {
									proxy  : {
								        type: 'direct',
										timeout: 300000,
								        extraParams: {
											eformid: ''
										},
										paramOrder: ['page', 'start', 'limit', 'sort', 'filter', 'eformid'],
										api: {
											create:  Ext.qd.OutputProcess.Create,
									        read:    Ext.qd.OutputProcess.Read,
									        update:  Ext.qd.OutputProcess.Update,
									        destroy: Ext.qd.OutputProcess.Destroy
									    },
									    paramsAsHash: false,
										filterParam: 'filter',
										sortParam: 'sort',
										limitParam: 'limit',
										idParam: 'ID',
										pageParam: 'page',
										reader: {
								            root: 'topics',
								            totalProperty: 'totalCount'
								        }
								    }
								});
								this.callParent([config]);
							}
						 });");
		}
	}

	private void function setView() {
		var fieldArray = ArrayNew(1);
		b = 200;
		for(a=1; a<=b; a++) {
			nametypeStruct = StructNew();
			nametypeStruct["text"] = "name" & a;
			nametypeStruct["dataIndex"] = "name" & a;
			ArrayAppend(fieldArray, nametypeStruct);
		}
		dstring = Serializejson(fieldArray);
		savecontent variable="view" {
			writeoutput("Ext.define('Myquery.QueryView', {
			extend: 'Ext.grid.Panel',
			alias: 'widget.queryview',
			title    : 'Simpsons',
		    flex: 1,
		    width    : '100%',
		    store    : 'Myquery.QueryStore',
		    columns  : #dstring#,
		    initComponent: function() {
		    	this.tbar = [{
		    		text: 'Share'
		    	},{
		    		text: 'Print'
		    	},{
		    		text: 'Export to excel'
		    	},{
		    		text: 'Add data'
		    	},{
		    		text: 'Edit selection'
		    	},{
		    		text: 'Remove selection'
		    	},{
		    		text: 'Email'
		    	}];
		    	this.fbar = Ext.create('Ext.toolbar.Paging', {
				        store: 'Myquery.QueryStore',
				        displayInfo: true,
				        emptyMsg: 'No query to display'
				});
				this.callParent(arguments);
		    }
		});");
		}
	}

	private void function setController() {
		savecontent variable="controller" {
			writeoutput("Ext.define('Myquery.QueryController', {
    						extend: 'Ext.app.Controller',
    						views: ['Myquery.QueryView'],
    						models: ['Myquery.QueryModel'],
    						stores: ['Myquery.QueryStore'],
    						init: function() {
    							this.control({
    								'panel': {
    									render: this.initPanel
    								}
    							})
    						},
    						initPanel: function(b) {
    							console.log('init panel');
    						}
			})");
		}
	}

	private void function setApp() {
		savecontent variable="app" {
			writeoutput("
				Ext.application({
					name: 'Myquery',
					controllers: ['Myquery.QueryController'],
					appFolder: './app',
					init: function(app) {
						console.log('init app');
					},
					launch: function(){
					   console.log('app launched');
					   qdetails.add([{
					   	   xtype: 'queryview'
					   }]);
					}
				});
			");
		}
	}
}