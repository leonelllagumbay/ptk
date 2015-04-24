Ext.require([
	'Ext.direct.*',
	'Ext.data.*',
	'Ext.grid.*'
]);
  
Ext.define('PersonalInfo', {
	extend: 'Ext.data.Model',
	fields: [
		'AuthorID',
		'FirstName',
		'LastName'
	]
});

Ext.onReady(function() {
	
  
	Ext.direct.Manager.addProvider(Ext.ss.APIDesc);   
	 
	
var dirStore = new Ext.data.DirectStore({
    //storeId: 'Authors',
	model: 'PersonalInfo',
	type: 'direct',
    api: {
        read: Ext.ss.Authors.GetAll,
        create: Ext.ss.Authors.add,
        update: Ext.ss.Authors.update,
        destroy: Ext.ss.Authors.destroy
    },
    paramsAsHash: false,
	remoteGroup: true,
	remoteFilter: true,
	remoteSort: true,
	simpleSortMode: false,
	sorters: [{
            property: 'dateofaccomplishment',
            direction: 'DESC'
    }],
	filters: [{
			property: 'nothinks'
	}],
	groupers: [{
		property: 'ID',
		direction: 'DESC'
	}],
	sortParam: 'sort',
	pageSize: 50,
	
	simpleGroupMode: true,
	groupParam: 'group',
    groupDirectionParam: 'dir',
	filterParam: 'filter',
	extraParams: {
		names: 'Leonell',
		lastname: 'Lagumbay'
	},
	paramOrder: ['page', 'start', 'limit', 'sort', 'filter', 'group'],
    autoSave: false,
	autoLoad: true
});

var rowEditing = Ext.create('Ext.grid.plugin.RowEditing', {
    clicksToMoveEditor: 1,
    autoCancel: false
});
// shorthand alias

var dirGrid = Ext.create('Ext.grid.Panel', {
  width: 400,
  height: 500,
  title: 'Ext.DirectStore Example',
  store: dirStore,
  plugins: [
	    rowEditing
	],
  clicksToEdit: 2,
  renderTo: Ext.getBody(),
  columns: [{
    header: 'AuthorID',
    dataIndex: 'AuthorID',
    width: 60
  },{
    header: 'First Name',
    dataIndex: 'FirstName',
    width: 150,
    editor: {
	  xtype: 'textfield',
      allowBlank: false
    }
  },{
    header: 'Last Name',
    dataIndex: 'LastName',
    width: 150,
    editor: {
	  xtype: 'textfield',
      allowBlank: false
    }
  }],
  viewConfig: {
    forceFit: true
  },
  tbar:[{
    text: 'New Author',
    handler: function(){
      var author = dirGrid.getStore().recordType;
      var a = new author({
        AuthorID: 0,
      });
      dirGrid.stopEditing();
      dirStore.insert(0,a);
      dirGrid.startEditing(0,1);
    }
  }],
  bbar:[{
    text: 'Save Changes',
    handler: function(){
        Ext.ss.Authors.add("Joe", "Make", function(result,response) {
	  	console.log(result);
	  })
    }
  }]
});



});
