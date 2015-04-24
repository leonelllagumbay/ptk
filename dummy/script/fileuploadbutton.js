 ', listeners: {
	render: function(b) {
		var cspanel = b.up('panel[title=Company Settings]');
		cspanel.add([{
			xtype: 'button',
			text: 'Add company logo or company banner',
			margin: '5 250 5 170',
			handler: function(c) {
				window.open('./myapps/fileuploader/',"Upload","height=200,width=350");
			}
		}]);
	}
}, emptyCls: '