', listeners: { 	
	render: function(thisT) { 		
		var pform = thisT.up('form'); 		
		pform.add([{ 			
			xtype: 'button', 			
			text: 'Generate the code', 			
			margin: '2 100 2 100', 			
			action: 'generatethecode', 			
			handler: function(dbtn) { 				
				pform.getEl().mask("Processing...");  	
				var fvals = pform.getForm().getValues();
				Ext.Ajax.request({ 			     					
					url: './data/form/generatecodetofile.cfm', 			     					
					params: fvals, 			     					
					success: function(response){ 			         						
						var text = response.responseText;  						
						pform.getEl().unmask(); 	 						
						console.log(response); 						
						Ext.Msg.show({
						     title: 'Info',
						     msg: 'Completed successfully!',
						     buttons: Ext.Msg.OK,
						     icon: Ext.Msg.INFO
						});
					} 			 				
				}); 			
			} 		
	  }]) 	
	} 
}, emptyCls: '