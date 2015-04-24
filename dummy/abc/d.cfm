<!doctype>
<html>
	<title>ABC</title>
	<head>
		
	</head>
	<body>
		<!---<cffile 
		    action = "copy"
		    destination = "#expandpath('./javas.js')#" 
		    source = "#expandpath('./j.js')#" 
		    attributes = "normal"
		    mode = "777">--->
		    
		 <!---<cffile 
		    action = "copy"
		    destination = "#expandpath('./e/Application.cfc')#" 
		    source = "#expandpath('./Application.cfc')#" 
		    attributes = "normal"
		    mode = "777">--->
		    
<cfset thecontent = "
\\Leonell Lagumbay \\n\\r
Ext.onReady(function() { \n
	Ext.define('Ext.data.Model', {
		fields: [
			'Name',
			{
			  name: 'Date Last Update',
			  type: 'string'
			},
			'Age'
		]
	});
	
	Ext.define('Ext.data.Store', {
		api: {
			read: 'Ext.ss.data.getAll',
			create: 'Ext.ss.data.createNow',
			update: 'Ext.data.updateNow',
			destroy: 'Ext.data.deleteMe'
		}
	});
	
	Ext.create('Ext.form.Panel', {
		title: 'My form Panel',
		layout: 'fit',
		items: [{
			xtype: 'textfield',
			name: 'Name',
			fieldLabel: 'Name'
		}]
	})
	
});

">
		    
		<cffile 
		    action = "write" 
		    file = "#expandpath('./mytable.cfc')#"
		    output = "<cfcomponent> 
						<cfproperty name='Age' persistent='true'>
						<cfproperty name='Model' >
				     </cfcomponent>"
		    addnewline = "true"
		    attributes = "normal" 
		    mode = "777">
		
		
		<h1>asdfjkl;</h1>
		
	</body>
</html>