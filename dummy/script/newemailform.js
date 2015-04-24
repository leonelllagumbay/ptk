',listeners: {
	render: function() {
		try {
		var theRouteB = Ext.ComponentQuery.query('button[text=Route]')[0];
		theRouteB.setText('Send');
		} catch(e) {}
	}
}, emptyCls: '