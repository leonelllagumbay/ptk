', inputType: 'password', listeners: {
	blur: function(thisInput) {
		var pvalue = thisInput.getValue();
		if(pvalue.length > 4) {
			thisInput.getEl().mask('...');
			Ext.Ajax.request({
			    url: './myapps/data/form/convertToMD5.cfm',
			    params: {
			        pvalue: pvalue
			    },
			    success: function(response){
			        var text = response.responseText;
			        thisInput.setValue(text);
			        thisInput.getEl().unmask();
			    }
			});
		}
	}
}, emptyCls: '