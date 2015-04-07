Ext.define('Form.controller.query.querydefinitioncontroller', {
    extend: 'Ext.app.Controller',
	views: [
        'query.querydefinitionView',
        'query.querydefinitionQueryDetailsView',
        'query.querydefinitionQueryDetailsChart',
        'query.querydefinitionQueryDetailsFeature',
        'query.querydefinitionQueryDetailsPlugin',
        'query.querydefinitionColumnListView',
        'query.querydefinitionColumnDetailsView',
        'query.querydefinitionPreviewView'
    ],
	models: [
	    'query.managerModel'
	],
	stores: [
	    'query.queryDefinitionStore',
	    'query.queryDefinitionColumnListStore',
	    'query.outputType',
	    'query.featureStore',
	    'query.pluginStore',
	    'query.yesno'
	],
	init: function() {
		console.log('init controller');
        this.control({
            
        	'button[action=previewquery]': {  
        		click: this.queryPreview
			},
			'button[action=querylist]': {  
        		click: this.queryList
			},
			'querydefinitionpreviewview button[action=querylist]': {  
        		click: this.queryList
			},
			'querydefinitionpreviewview button[action=querydetails]': {  
        		click: this.queryDetails
			},
			'querydefinitionpreviewview button[action=querycolumnlist]': {  
        		click: this.queryColumnList
			},
			'querydefinitionpreviewview button[action=querycolumndefinition]': {  
        		click: this.queryColumnDefinition
			},
			'querydefinitioncolumndetailsview button[action=querycolumndefinition]': {  
        		click: this.queryColumnList
			},
			'querydefinitionview button[action=editdetails]': {  
        		click: this.queryDetails
			},
			'querydefinitionview button[action=showcolumns]': {  
        		click: this.queryColumnListFirst
			},
			'querydefinitioncolumnlistview button[action=columndefinition]': {  
        		click: this.queryColumnDefinition
			},
			'querydefinitioncolumndetailsview button[action=querycolumnlist]': {  
        		click: this.queryColumnList
			},
			'querydefinitionquerydetailsview button[action=save]': {
				click: this.saveQueryDetails
			},
			'querydefinitionquerydetailsview button[action=cancel]': {
				click: this.queryList
			},
			'querydefinitioncolumndetailsview button[action=save]': {
				click: this.saveColumnDetails
			},
			'querydefinitioncolumndetailsview button[action=cancel]': {
				click: this.queryColumnList
			}
		});
     },
     
     saveQueryDetails: function(btn) {
    	var dform = btn.up('form').getForm();
    	if(dform.isValid()) {
    		dform.submit({
				waitMsg: 'Submitting...',
				timeout: 300000,
				reset: true,
			  		//Failure see app-wide error handler
			  		success: function(form, action){
			  			Ext.Msg.show({
			  				msg: 'Done!',
			  				buttons: Ext.Msg.OK
			  			});
					}
			});	
    	} else {
    		alert('Form has invalid value(s).');
    	}
     },
     
     saveColumnDetails: function(btn) {
     	var dform = btn.up('form').getForm();
     	if(dform.isValid()) {
     		dform.submit({
 				waitMsg: 'Sending, please wait...',
 				timeout: 300000,
 				reset: true,
 			  		//Failure see app-wide error handler
 			  		success: function(form, action){
 			  			Ext.Msg.show({
 			  				msg: 'Done!',
 			  				buttons: Ext.Msg.OK
 			  			});
 					}
 			});	
     	} else {
     		alert('Form has invalid value(s).');
     	}
      },
     
     queryPreview: function(btn) {
    	 var qryGrid = Ext.ComponentQuery.query('querydefinitionview')[0];
		 var querycode = qryGrid.getSelectionModel().getSelection()[0];
		 if(querycode) {
			 var qdetails = Ext.ComponentQuery.query('querydefinitionpreviewview')[0];
			 qdetails.setTitle("eQuery Definition Preview - " + querycode.data.EQRYNAME);
			 Ext.qd.Preview.generateOutput(querycode.data.EQRYCODE,function(resp) {
					console.log(resp); 
					qdetails.removeAll();
					var dmodel, dstore, dview, dcontroller, dapp;
					// For models
					for(var a = 0; a<resp.model.length; a++) {
						dmodel = resp.model[a];
						eval(dmodel);
					}
					
					// For stores
					for(var a = 0; a<resp.store.length; a++) {
						dstore = resp.store[a];
						eval(dstore);
					}
					
					// For views
					for(var a = 0; a<resp.view.length; a++) {
						dview = resp.view[a];
						eval(dview);
					}
					
					// For controllers
					for(var a = 0; a<resp.controller.length; a++) {
						dcontroller = resp.controller[a];
						eval(dcontroller);
					}
					
					// For apps
					for(var a = 0; a<resp.app.length; a++) {
						dapp = resp.app[a];
						eval(dapp);
					}
					
			 });
			 
			 var centerR = Ext.ComponentQuery.query('viewport panel[region=center], viewport')[0];
			 centerR.getLayout().setActiveItem(4);
		 } else {
			 alert("No item to preview.");
		 }
     },
     queryList: function(btn) {
    	 var centerR = Ext.ComponentQuery.query('viewport panel[region=center], viewport')[0];
		 centerR.getLayout().setActiveItem(0);
     },
     queryDetails: function(btn) {
    	 var qryGrid = Ext.ComponentQuery.query('querydefinitionview')[0];
		 var querycode = qryGrid.getSelectionModel().getSelection()[0];
		 if(querycode) {
			 var qdetails = Ext.ComponentQuery.query('querydefinitionquerydetailsview')[0];
			 qdetails.setTitle("Query Details - " + querycode.data.EQRYNAME);
			 var dform = qdetails.getForm();
			 dform.reset();
			 dform.load({
				 params: {
					 querycode: querycode.data.EQRYCODE
				 }
			 });
			 var centerR = Ext.ComponentQuery.query('viewport panel[region=center], viewport')[0];
			 centerR.getLayout().setActiveItem(1);
		 } else {
			 alert("No item to edit.");
		 }
     },
     
     queryColumnListFirst: function(btn) {
    	 
		 var qryGrid = Ext.ComponentQuery.query('querydefinitionview')[0];
		 var querycode = qryGrid.getSelectionModel().getSelection()[0];
		 if(querycode) {
			 console.log(querycode);
			 querycode = querycode.data.EQRYCODE;
			 var clistStore = Ext.ComponentQuery.query('querydefinitioncolumnlistview')[0].getStore();
			 // clistStore.removeAll(); // remove
			 // clistStore.currentPage = 1; // back to page one -> resolves unreachable page
			 clistStore.load({
				 params: {
					 querycodefk: querycode
				 }
			 });
			 clistStore.proxy.extraParams.querycodefk = querycode;
			 var centerR = Ext.ComponentQuery.query('viewport panel[region=center], viewport')[0];
			 centerR.getLayout().setActiveItem(2);
		 } else {
			 alert("No reference query selected.");
		 }
     },
     queryColumnList: function(btn) {
    	 var centerR = Ext.ComponentQuery.query('viewport panel[region=center], viewport')[0];
		 centerR.getLayout().setActiveItem(2);
     },
     queryColumnDefinition: function(btn) {
    	 var qryGrid = Ext.ComponentQuery.query('querydefinitioncolumnlistview')[0];
		 var fieldcode = qryGrid.getSelectionModel().getSelection()[0];
		 if(fieldcode) {
			 var dform = Ext.ComponentQuery.query('querydefinitioncolumndetailsview')[0].getForm();
			 dform.reset();
			 dform.load({
				 params: {
					 fieldcode: fieldcode.data.EVIEWFIELDCODE
				 }
			 });
			 var centerR = Ext.ComponentQuery.query('viewport panel[region=center], viewport')[0];
			 centerR.getLayout().setActiveItem(3);
		 } else {
			 alert("No item to edit.");
		 }
     }
});