pmatch: function(val, field) {
	var origVal = Ext.ComponentQuery.query('textfield[name=G__GMFPEOPLE__FIRSTNAME]')[0].getValue();
	if(val == origVal) {
		return true;
	} else {
		 return false;
	}
},
pmatchText: 'Confirmation text is incorrect.'