', listeners: {
	render: function(thisT) {
		var pform = thisT.up('form');
		pform.down('button[text=Add]').hide();
		pform.add([{
			xtype: 'button',
			text: 'Evaluate',
			margin: '2 100 2 100',
			action: 'evaluateonly',
			handler: function(dbtn) {
				var dscript = pform.down('textareafield').getValue();
				pform.getEl().mask("Processing..."); 
				Ext.Ajax.request({ 			    
					url: './data/base/console.cfm', 			    
					params: { 		
						dscript: dscript 		
					}, 			    
					success: function(response){ 			        
						var text = response.responseText; 
						pform.getEl().unmask(); 	
						console.log(response);
						window.open("./data/output/iboseconsole.cfm","_blank", "fullscreen=yes");
					} 			
				});
			}
		}])
	}
}, emptyCls: '