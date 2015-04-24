<html>
	
<head>
    <title>HTML 5 local storage samle</title>
	<link rel="stylesheet" type="text/css" href="../../scripts/extjs/resources/css/ext-all.css">
    <script type="text/javascript" src="../../scripts/extjs/ext-dev.js"></script>

<script type="text/javascript">
	Ext.onReady(function() {
		Ext.define('Search', {
		    fields: ['id', 'query'],
		    extend: 'Ext.data.Model',
		    proxy: {
		        type: 'localstorage',
		        id  : 'twitter-Searches'
		    }
		});
		
		
		//our Store automatically picks up the LocalStorageProxy defined on the Search model
		var store = Ext.create('Ext.data.Store', {
		    model: "Search"
		});
		
		//loads any existing Search data from localStorage
		store.load();
		
		var theJSONdata = store.data.items[0].data.query;
		theJSONdata = Ext.JSON.decode(theJSONdata);
		console.log(theJSONdata);
		
		store.removeAll(); //removes current data or this operation is a simple overwrite
		//now add some Searches
		var dataObj = {
			firstname: 'Leonell',
			lastname: 'Lagumbay',
			middlename: 'Adizas'
		};
		var dataString = Ext.JSON.encode(dataObj);
		
		store.add({query: dataString});
		
		//finally, save our Search data to localStorage
		store.sync();
		
		console.log(store);
		
		alert('this is ready');
		
		var task = {
		  run: function(args){
		      //console.log(args);
		  },
		  interval: 1000 //1 second
		}
		
		Ext.TaskManager.start(task);
		
		
	});
</script>
	
</head>
<body>
	<div id="clock" ></div>

</body>

</html>
