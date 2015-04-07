/**
 * Preview
 *
 * @author LEONELL
 * @date 3/31/15
 **/
component accessors=true output=false persistent=false ExtDirect="true" {
	public struct function getApiDefinition(required string querycode) ExtDirect="true" {
		var ret = structNew();
		var controllerArr = ArrayNew(1);
		var modelArr = ArrayNew(1);
		var storeArr = ArrayNew(1);
		var viewArr = ArrayNew(1);
		var appArr = ArrayNew(1);

		setModel();
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

	private void function setModel() {
		savecontent variable="model" {
			writeoutput("Ext.define('Myquery.QueryModel', {
							extend: 'Ext.data.Model',
							fields: ['name','email','phone','active']
						});");
		}
	}

	private void function setStore() {
		savecontent variable="store" {
			writeoutput("Ext.define('Myquery.QueryStore', {
							extend: 'Ext.data.Store',
							model: 'Myquery.QueryModel',
							data   : {
						        items : [
						            { name : 'Lisa',  email : 'lisa@simpsons.com',  phone : '555-111-1224', active : true  },
						            { name : 'Bart',  email : 'bart@simpsons.com',  phone : '555-222-1234', active : true  },
						            { name : 'Homer', email : 'home@simpsons.com',  phone : '555-222-1244', active : false },
						            { name : 'Marge', email : 'marge@simpsons.com', phone : '555-222-1254', active : true  }
						        ]
						    },
						    proxy  : {
						        type   : 'memory',
						        reader : {
						            type : 'json',
						            root : 'items'
						        }
						    }
						 });");
		}
	}

	private void function setView() {
		savecontent variable="view" {
			writeoutput("Ext.define('Myquery.QueryView', {
			extend: 'Ext.grid.Panel',
			alias: 'widget.queryview',
			title    : 'Simpsons',
		    flex: 1,
		    width    : '100%',
		    store    : 'Myquery.QueryStore',
		    columns  : [
		        { text : 'Name', dataIndex : 'name' },
		        { text : 'Email', dataIndex : 'email', flex : 1 },
		        { text : 'Phone', dataIndex : 'phone' },
		        { xtype : 'checkcolumn', text : 'Active', dataIndex : 'active' }
		    ]
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