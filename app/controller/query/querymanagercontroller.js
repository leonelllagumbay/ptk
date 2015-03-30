Ext.define('Form.controller.query.querymanagercontroller', {
    extend: 'Ext.app.Controller',
	views: [
        'query.querymanagerView',
        'query.querymanagerBuilderView',
        'query.querymanagerPreviewView',
        'query.queryManagerNewQueryForm'
    ],
	models: [
	    'query.managerModel'
	],
	stores: [
	    'query.managerStore'
	],
	init: function() {
		console.log('init controller');
        this.control({
            
        	'querymanagerview button[action=managequery]': {  
        		click: this.managerQueryNow
			},
			'querymanagerbuilderview button[action=back]': {  
        		click: this.backToQuery
			},
			'button[action=previewquery]': {  
        		click: this.queryPreview
			},
			'querymanagerpreviewview button[action=managequery]': {  
        		click: this.managerQueryNow
			},
			'querymanagerpreviewview button[action=querylist]': {  
        		click: this.backToQuery
			},
			'querymanagerview button[action=addquery]': {  
        		click: this.addQuery
			},
			'querymanagerview button[action=copyquery]': {  
        		click: this.copyQuery
			}, 
			'querymanagerview button[action=deletequery]': {  
        		click: this.deleteQuery
			},
			'window[alias=widget.qmnewqueryform] button[action=newquery]': {
				click: this.newQuery
			},
			'window[alias=widget.qmnewqueryform] button[action=newcancel]': {
				click: this.newCancel
			},
			'mainlistextra button[action=savequery]': {
				click: this.saveQuery
			}
		});
     },
     
     managerQueryNow: function(btn) {
    	 var dquerylistgrid = Ext.ComponentQuery.query('querymanagerview')[0];
    	 var selModel = dquerylistgrid.getSelectionModel().getSelection()[0];
    	 if(selModel) {
    		 console.log(selModel);
    		 var centerR = Ext.ComponentQuery.query('viewport panel[region=center], viewport')[0];
    		 centerR.getLayout().setActiveItem(1);
    		 var querycode = selModel.data.EQRYCODE;
    		 // For selected datasource
    		 var selectedItems = [
    		                      'selecteddatasource',
    		                      'selectedtable',
    		                      'selectedfield',
    		                      'selectedjoin',
    		                      'selectedcondition',
    		                      'selectedgroupby',
    		                      'selectedhaving',
    		                      'selectedorderby',
    		                     ];
    		 var dbsourceGrid = "";
    		 var dstore = "";
    		 for(var a in selectedItems) {
    			 dbsourceGrid = Ext.widget(selectedItems[a]);
        		 dstore = dbsourceGrid.getStore();
        		 dstore.load({
        			 params: {
        				 querycode: querycode
        			 }
        		 });
        		 dstore.proxy.extraParams.querycode = querycode;
    		 }
    		 
    		 // For the generated query
    		 var qryTextArea = Ext.ComponentQuery.query("generatedquery")[0];
    		 qryTextArea.getEl().mask("Loading...");
    		 Ext.ss.SelectedSource.getQuery(querycode,function(result) {
    			 qryTextArea.setValue(result.qry);
    			 qryTextArea.getEl().unmask();
    		 });
    		 
    	 } else {
    		 Ext.Msg.alert('','Please select a query first.');
    	 }
		 
     },
     backToQuery: function(btn) {
    	 var centerR = Ext.ComponentQuery.query('viewport panel[region=center], viewport')[0];
		 centerR.getLayout().setActiveItem(0);
     },
     queryPreview: function(btn) {
    	 var centerR = Ext.ComponentQuery.query('viewport panel[region=center], viewport')[0];
		 centerR.getLayout().setActiveItem(2);
     },
     addQuery: function(btn) {
    	 Ext.widget('qmnewqueryform').show();
     },
     newQuery: function(btn) {
    	 var dw = btn.up('window');
    	 var dname = dw.down('textfield[name=name]').getValue();
    	 var ddesc = dw.down('textfield[name=description]').getValue();
    	 var dquerylistgrid = Ext.ComponentQuery.query('querymanagerview')[0];
    	 var dstore = dquerylistgrid.getStore();
    	 dstore.add({
    		 EQRYNAME: dname, 
    		 EQRYDESCRIPTION: ddesc
    	 });
    	 
    	 btn.up('window').close();
    	 dstore.load();
     },
     newCancel: function(btn) {
    	 btn.up('window').close();
     },
     copyQuery: function(btn) {
    	 var dquerylistgrid = Ext.ComponentQuery.query('querymanagerview')[0];
    	 var selModel = dquerylistgrid.getSelectionModel().getSelection();
    	 if(selModel.length) {
	    	 var dstore = dquerylistgrid.getStore();
	    	 var qrycode = '';
	    	 for(a in selModel) qrycode += selModel[a].data.EQRYCODE + ',';
	    	 dstore.add({EQRYCODE: qrycode});
	    	 dstore.load();
    	 }
     },
     deleteQuery: function(btn) {
    	 var res = window.confirm("This operation will delete the selected query.\nAre you sure you want to continue?");
    	 if(res) {
    		 var dquerylistgrid = Ext.ComponentQuery.query('querymanagerview')[0];
        	 var selModel = dquerylistgrid.getSelectionModel().getSelection();
        	 var dstore = dquerylistgrid.getStore();
        	 for(a in selModel) dstore.remove(selModel[a]);
        	 dstore.load();
    	 }
     },
     saveQuery: function(btn) {
    	 var selectedItems = [
		                      'selecteddatasource',
		                      'selectedtable',
		                      'selectedfield',
		                      'selectedjoin',
		                      'selectedcondition',
		                      'selectedgroupby',
		                      'selectedhaving',
		                      'selectedorderby',
		                     ];
		 var dbsourceGrid;
		 var dstore;
		 var allData = {};
		 for(var a=0; a<selectedItems.length; a++) {
			 dbsourceGrid = Ext.widget(selectedItems[a]);
			 dstore = dbsourceGrid.getStore();
			 var recArray = [];
    		 var dataItems = dstore.data.items;
    		 console.log(dataItems);
    		 for(var b=0; b<dataItems.length; b++) {
    			 recArray[b] = dataItems[b].data;
    		 }
    		 allData[selectedItems[a]] = recArray;
		 }
		 var cuteQuery = Ext.ComponentQuery.query("generatedquery")[0].getValue();
		 allData["cuteQuery"] = cuteQuery;
		 var dquerylistgrid = Ext.ComponentQuery.query('querymanagerview')[0];
    	 var selModel = dquerylistgrid.getSelectionModel().getSelection()[0];
		 allData["querycode"] = selModel.data.EQRYCODE;
		 console.log(allData);
		 var qrybuilder = Ext.ComponentQuery.query('querymanagerbuilderview')[0]; 
		 qrybuilder.getEl().mask('Saving...');
		 Ext.ss.QueryManager.InsertQueryItems(allData,function(result) {
			console.log(result); 
			qrybuilder.getEl().unmask();
		 });
     }
});