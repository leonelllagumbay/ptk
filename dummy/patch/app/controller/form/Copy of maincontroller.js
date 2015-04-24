Ext.define('Form.controller.form.maincontroller', {
    extend: 'Ext.app.Controller',
	
	views: [
        'form.eformMainView',
		'form.eformMainDetailsView',
		'form.eformNewView',
		'form.eformNewDetailsView',
		'form.eformPendingView',
		'form.eformPendingDetailsView', 
		'form.eformEmailWindow',
		'form.eformStatusMap'
    ],
	models: [
		'form.eformMainModel',
		'form.eformNewModel',
		'form.eformPendingModel',
		'form.maineFormModel',
		'form.userModel'
	],
	stores: [
		'form.eformMainStore',
		'form.eformNewStore',
		'form.eformPendingStore',
		'form.maineFormStore',
		'form.userStore'
	],
	
    init: function() {
		console.log('init controller');
        this.control({
            'viewport button[action=backtoeformmain]': {
				click: this.backToMain
			},
			
			'eformmainview combobox[action=selectedform]': {
				change: this.generateeForm
			},	
			'eformmainview button[action=neweforms]': {
				click: this.neweFormClicked
			},
			'eformmainview button[action=pendingeforms]': {
				click: this.pendingeFormClicked
			},     
			'eformmainview button[action=addeform]': {
				click: this.addForm
			},
			'eformmainview button[action=editeform]': {
				click: this.editForm
			},
			'eformmainview button[action=deleteeform]': {
				click: this.deleteeForm
			},
			'eformmainview button[action=viewpathroute]': {
				click: this.viewRoutePath
			},
			'eformmainview button[action=routeeform]': {
				click: this.routeeForm
			},
			'eformmaindetailsview button[action=backtoeformmain]': {
				click: this.backToMain
			}, 
			
			'eformnewview button[action=backtomain]': {
				click: this.backToMain
			},
			'eformpendingview button[action=backtomain]': {
				click: this.backToMain
			},
			'eformnewview button[action=newopendetails]': {
				click: this.openNewDetails
			},
			'eformpendingview button[action=pendingopendetails]': {
				click: this.openPendingDetails
			},
			
			'eformnewdetailsview button[action=backtoneweforms]': {
				click: this.backToNeweForms
			},
			'eformpendingdetailsview button[action=backtopendingeforms]': {
				click: this.backToPendingeForms
			},
			'eformmaindetailsview button[action=submiteform]': {
				click: this.addNewFormDirect
			}, 
			'viewport > eformmainview': {
                render: this.onMainPanelRendered
            },
			 
			
        });
    },
	
	addNewFormDirect: function(btn) {
		var thisForm = btn.up('form');
		if(thisForm.getForm().isValid()){
			thisForm.getForm().submit({
				//waitMsg: 'Saving, please wait...',
				reset: true,
			  		failure: function(form, action){
			  			Ext.Msg.show({
			  				title: 'Technical problem.',
			  				msg: 'Our apology. We are having technical problems.',
			  				buttons: Ext.Msg.OK,
			  				icon: Ext.Msg.ERROR
			  			});
						console.log(action);
			  		},
			  		success: function(form, action){
			  			Ext.Msg.show({
			  				msg: 'Added successfully!',
			  				buttons: Ext.Msg.OK
			  			});
						var cardlayout = btn.up('viewport');
						var theMainGrid = cardlayout.down('eformmainview');
						var mainStore = theMainGrid.getStore();
						mainStore.load();
						
			  		}
			});	
		}
	},
	
	onMainPanelRendered: function(panelGrid) {
		
		console.log(panelGrid)
		//Ext.ss.eformmain.getInitialRecords(function(result) {
		//	console.log(result);
		//});  
		
		/*
		var columnT = Ext.create('Ext.grid.column.Column', {
			text: 'New column',
			filterable: true,
			dataIndex: 'NEWCOLUMN'
		});
		var columnT2 = Ext.create('Ext.grid.column.Column', {
			text: 'Address',
			filterable: true,
			dataIndex: 'NEWCOLUMN2'
		});
		 panelGrid.headerCt.insert(panelGrid.columns.length, columnT);  
		 panelGrid.headerCt.insert(panelGrid.columns.length, columnT2);  
         panelGrid.getView().refresh(); 
         */
		
		// This data can be pulled off a back-end database
		// Used to generate a model and a data grid
		
		
		/*
		
		var records = [{
		    data:{
		        "dataIndex":"FIRSTNAME",
		        "name":"First Name",
		        "type":"string"
		    }
		},{
		    data:{
		        "dataIndex":"LASTNAME",
		        "name":"Last Name",
		        "type":"string"
		    }
		},{
		    data:{
		        "dataIndex":"DATELASTUPDATE",
		        "name":"Date Update",
		        "type":"string"
		    }
		},{
		    data:{
		        "dataIndex":"PERSONNELIDNO",
		        "name":"PERSONNELIDNO",
		        "type":"string"
		    }
		}];

		// Lookup table (type => xtype)
		var type_lookup = new Object;
		type_lookup['int'] = 'numberfield';
		type_lookup['float'] = 'numberfield';
		type_lookup['string'] = 'textfield';
		type_lookup['date'] = 'datefield';
		type_lookup['boolean'] = 'checkbox';
		
		// Skeleton store
		var store_template = {
		    autoLoad: true,
		    autoSync: true,
		    remoteFilter: false,
			simpleSortMode: true,
			sorters: [{
	          	property: 'DATELASTUPDATE',
	          	direction: 'DESC'  
		    }],

		    pageSize: 100,
			autoSave: true,
			autoLoad: true,
			autoSync: true,
		    proxy: {
		        type: 'direct',
				
				paramOrder: ['page', 'start', 'limit', 'sort', 'filter'],
				api: {
			        read:    'Ext.ss.eformmain.ReadNow', 
			        create:  'Ext.ss.eformmain.ReadNow',  
			        update:  'Ext.ss.eformmain.ReadNow',
			        destroy: 'Ext.ss.eformmain.ReadNow'
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
		        },
		        writer: {
		            type: 'json'
		        }
		    }
		};
		
			
		// Skeleton grid (_PLUGINS_ & _STORE_, are placeholders)
		var grid_template = {
		    columnWidth: 1,
		    plugins: '_PLUGINS_',
		    height: '100%',
			multiSelect: true,
			autoScroll: true,
			clicksToEdit: 2,
			features: [{
				ftype: 'filters',
				encode: true, // json encode the filter query
				local: false, 
				filters: [{
					type: 'date',
					dataIndex: 'DATELASTUPDATE'
				}]
			}],
			bbar: '_BBAR_',  
			store: '_STORE_'
		}
		
		// Skeleton window (_ITEMS_ is a placeholder)
		
		
		// Generate a model dynamically, provide fields
		function modelFactory(name, fields) {
		    return Ext.define(name, {
		        extend: 'Ext.data.Model',
		        fields: fields
		    });
		}
		
		// Generate a dynamic store
		function storeFactory(name,template,model){
		    template.model = model;
		    eval(name+" = Ext.create('Ext.data.Store',"+Ext.encode(template)+");");
		}
		
		// Generate a dynamic grid, .. store name is appended as a string because otherwise, Ext.encode
		// will cause 'too much recursion' error (same for plugins)
		function gridFactory(name,template,store,plugins){
		    script =  name+" = Ext.create('Ext.grid.Panel', "+Ext.encode(template)+");";
			script = script.replace("\"_BBAR_\"", '[Ext.create("Ext.toolbar.Paging", {"store": "_STORE_", "displayInfo": true, "emptyMsg": "No topics to display"})]');
			script = script.replace(/\"_STORE_\"/g, store); 
			script = script.replace("\"_PLUGINS_\"", plugins);
		    eval(script);
			
			panelGrid.add(myGrid);
		}
		// Generate a dynamic window, .. items are appended as a string to avoid Ext.encode error
		function windowFactory(winName,winTemp,items){
		    script += winName+" = Ext.create('Ext.window.Window',"+Ext.encode(winTemp)+").show();";
		    script = script.replace("\"_ITEMS_\"", items);
		    eval(script);
		}
		
		// Generate a model, a store a grid and a window dynamically from a record list!
		function generateDynamicModel(records){
		    
		    fields = [{
		        name: 'id',
		        type: 'int',
		        useNull:true
		    }];
		
		    columns = [{
	            xtype: 'rownumberer',
	            width: 50,
	            sortable: false
		       }];
		
		    for (var i = 0; i < records.length; i++) {
		
		        fields[i+1] =  {
		            name: records[i].data.dataIndex,
		            type: records[i].data.type
		        };
		
		        columns[i+1] = {
		            text: records[i].data.name,
		            sortable: true,
					filterable: true,
		            dataIndex: records[i].data.dataIndex,
		            field:  {
		                xtype: type_lookup[records[i].data.type]
		            }
		        };
		    }
			
			//console.log(columns);
		
		    grid_template.columns = columns;
		
		    modelFactory('myModel',fields);
		    storeFactory('myStore',store_template,'myModel');
		    gridFactory('myGrid',grid_template,'myStore','[rowEditing]');
		    //windowFactory('myWindow',window_template,'[myGrid]');
		
		    // Direct access to the store created above 
			
		    myStore.load();
		}
		
		Ext.onReady(function(){
		    rowEditing = Ext.create('Ext.grid.plugin.CellEditing');
		    generateDynamicModel(records);
		});
		*/ 

	},
	
	backToNeweForms: function(btn) {
		var cardlayout = btn.up('viewport');
		cardlayout.getLayout().setActiveItem(2);
	},
	
	openNewDetails: function(btn) {
		var cardlayout = btn.up('viewport');
		cardlayout.getLayout().setActiveItem(3);
		
		var theForm = cardlayout.down('eformnewdetailsview');
		console.log(theForm);
		var tf = Ext.create('Ext.form.field.Text', {
			name: 'name',
			fieldLabel: 'Name',
			padding: '10 200 10 200'
		});
		var tf2 = Ext.create('Ext.form.field.Display', {
			name: 'asdsad',
			fieldLabel: 'My Favorite Girl',
			value: '<img src="https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcS77cebgaTB8vcMXVcCxD6GiXWCqh2hSlqgqPXqUuBis0zg8fk5FQ" width="200" height="200">',
			padding: '10 200 10 200'
		});
		theForm.add(tf); 
		theForm.add(tf2); 
		
	},
	
	backToPendingeForms: function(btn) {
		var cardlayout = btn.up('viewport');
		cardlayout.getLayout().setActiveItem(4);
	},
	
	openPendingDetails: function(btn) {
		var cardlayout = btn.up('viewport');
		cardlayout.getLayout().setActiveItem(5);
	},
	
	backToMain: function(btn) {
		var cardlayout = btn.up('viewport');
		cardlayout.getLayout().setActiveItem(0);
	},
	
	generateeForm: function(thiscomp, newVal) {
		var theMixCollection =thiscomp.getStore().query('eformmaincode', newVal);
		var theDisplay = theMixCollection.items[0].data.eformmainname;
		var newTotal = theMixCollection.items[0].data.eformmaintotalnew;
		var pendingTotal = theMixCollection.items[0].data.eformmaintotalpending;
		
		var theGrid = thiscomp.up('grid');
		var theNewButton = theGrid.down('button[action=neweforms]');
		var thePendingButton = theGrid.down('button[action=pendingeforms]');
		
		if(newTotal <= 1) {
			var withs = "";
		} else {
			var withs = "s";
		}
		
		if(pendingTotal <= 1) {
			var pwiths = "";
		} else {
			var pwiths = "s";
		}
		
		theNewButton.setText("<span style='background-color: red; border-radius: 12px; color: white;'><b>&nbsp;" + newTotal + "&nbsp;</b></span> New eForm" + withs);
		thePendingButton.setText("<span style='background-color: red; border-radius: 12px; color: white;'><b>&nbsp;" + pendingTotal + "&nbsp;</b></span> Pending eForm" + pwiths);
		console.log(newVal);
	},
	
	neweFormClicked: function(btn) {
		var cardlayout = btn.up('viewport');
		cardlayout.getLayout().setActiveItem(2);
		
	    
	},
	
	pendingeFormClicked: function(btn) {
		var cardlayout = btn.up('viewport');
		cardlayout.getLayout().setActiveItem(4);
	},
	
	addForm: function(btn) {
		var cardlayout = btn.up('viewport');
		
		var theMaineFormSelection = cardlayout.down('eformmainview combobox[action=selectedform]');
		
		if(theMaineFormSelection.value) {
			var	eformid = theMaineFormSelection.value;
		} else {
			alert('Please select an eForm to add!');
			return false;
		}
		
		
		var theMainForm = cardlayout.down('eformmaindetailsview');
		theMainForm.setTitle("Add eForm");
		cardlayout.getLayout().setActiveItem(1);
		
		theMainForm.getForm().load({
			params: {
				eformid: eformid
			}
		});
		
		
		
		var theFormButton = cardlayout.down('eformmaindetailsview button[action=saveeform]');
		theFormButton.setDisabled(true);
		
	},
	
	editForm: function(btn) {
		var cardlayout = btn.up('viewport');
		cardlayout.getLayout().setActiveItem(1);
		
		var theMainForm = cardlayout.down('eformmaindetailsview');
		theMainForm.setTitle("Edit eForm");
		
		var theFormButton = cardlayout.down('eformmaindetailsview button[action=saveeform]');
		theFormButton.setDisabled(false);
	},
	
	deleteeForm: function(btn) {
		var confirm = window.confirm('Are you sure you want to delete the selected eForm? \nNote: If routed and is pending, routing will be halted.');
		if (confirm) {
			var thisgrid = btn.up('grid');
			var selection = thisgrid.getView().getSelectionModel().getSelection();
			if (selection) {
				thisgrid.store.remove(selection); 
			}
		} 
	},
	
	viewRoutePath: function(btn) {
		var cardlayout = btn.up('viewport');
		cardlayout.getLayout().setActiveItem(7);
	},
	
	routeeForm: function(btn) {
		
		var thisgrid = btn.up('eformmainview');
		var selection = thisgrid.getView().getSelectionModel().getSelection();
		
		if (selection.length != 0) {
			if (selection.length == 1) {
				var eform = "eForm"
			} else {
				var eform = "eForms"
			}
			var action = window.confirm('Route selected ' + eform + '?\nNote: Only eForms with status "NEW" will be routed.');
			if(action) {
				var myMask = Ext.create('Ext.LoadMask',{
					target: thisgrid,
					msg: "Routing, please wait..."
				});
			    myMask.show();
				
				for (var cntr=0; cntr<selection.length; cntr++) {
					var eformid = selection[cntr].data.EFORMIDFK;
					var processid = selection[cntr].data.PROCESSIDFK;
					var eformtableid = selection[cntr].data.EFORMTABLEID;
					var status = selection[cntr].data.STATUS;
						Ext.ss.active.startRoute(eformid,processid,eformtableid, function(result,action) {
							console.log(result);
							console.log(action);
							 
							if(result == "success") {
								myMask.hide();
								thisgrid.getStore().load();
							} else {
								myMask.hide();
								Ext.Msg.show({
					  				title: 'Technical problem.',
					  				msg: 'Our apology. We are having technical problems', 
					  				buttons: Ext.Msg.OK,
					  				icon: Ext.Msg.ERROR
					  			});
							}
					    });
					
				}
		
			}
			
				
		} else {
			alert('No form selected. Please select an eForm to route.');
		}
		
		
		
	},
	 
});