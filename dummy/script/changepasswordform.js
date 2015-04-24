', inputType: 'password', listeners: {
	render: function(thisC) {
		var thisForm = thisC.up('form');
		var theAddButton = thisForm.down('button[action=add]');
		theAddButton.setText("Change password");
		theAddButton.on({
			click: {
				fn: function(thisB) {
					thisForm.getEl().mask("Changing password");
					var currentpassword = Ext.ComponentQuery.query('textfield[name=G__GMFPEOPLE__GUID]')[0].getValue();
					var newpassword = Ext.ComponentQuery.query('textfield[name=G__GMFPEOPLE__FIRSTNAME]')[0].getValue();
					var confirmnewpassword = Ext.ComponentQuery.query('textfield[name=G__GMFPEOPLE__LASTNAME]')[0].getValue();
					Ext.Ajax.request({ 			    
						url: './myapps/data/form/changepassword.cfm', 			    
						params: { 		
							currentpass: currentpassword,
							newpass: newpassword,
							cnewpass: confirmnewpassword 		
						}, 			    
						success: function(response){ 			        
							var text = response.responseText; 
							thisForm.getEl().unmask(); 	
							if(text.trim() == "success") {
								thisForm.up('window').close();
							} else {
								Ext.Msg.alert('',text);
							}
						} 			
					});
					return false;
				}
			}
		});
	}
}, emptyCls: '

