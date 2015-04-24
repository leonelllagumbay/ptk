pmatch: function(val, field) {
	var origVal = Ext.ComponentQuery.query('textfield[name=G__GMFPEOPLE__FIRSTNAME]')[0].getValue();
	if(val == origVal) {
		return true;
	} else {
		 return false;
	}
},
pmatchText: 'Confirmation text is incorrect.'

', inputType: 'password', listeners: {
	render: function(thisC) {
		var thisForm = thisC.up('form');
		var theAddButton = thisForm.down('button[action=add]');
		theAddButton.setText("Change password");
		theAddButton.on({
			click: {
				fn: function(thisB) {
					alert('You clicked me!');
					thisForm.getEl().mask("Changing password");
					return false;
				}
			}
		});
	}
}, emptyCls: '


