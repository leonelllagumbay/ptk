Ext.application({
	requires: [
		'Ext.container.Viewport'
	],
	name: 'ApplicationOnline',
	controllers: [
		'main',
	],
	
	appFolder: 'app',
	
	launch: function(){
		
		Ext.create('Ext.container.Viewport', {
			layout: 'border',
			items: [{
				region: 'north',
				flex: .2,
				xytpe: 'container',
				margins: 5,
				html: '<img src="resource/images/mainicon/labs.png" width="100%" height="100%" />'
			},{
				region: 'west',
				flex: .3,
				margins: '0 5 0 5',
				layout: 'fit',
				items: [{
					xtype: 'mainwesttree',
					flex: 2
				}]

			},{
				region: 'center',
				layout: 'fit',
				items: [{
					xtype: 'mainmain',
					flex: 1
				}]
			},{
				title: 'Help',
				region: 'east',
				flex: .2,
				margins: '0 5 0 5',
				layout: {
					type: 'vbox',
					align: 'stretch'
				},
				items: [{
			        xtype: 'datepicker',
					height: 180,
			        //minDate: new Date(),
					showToday: false,
					//disabledCellCls: 'x-datepicker-active x-datepicker-today x-datepicker-cell x-datepicker-selected',
			        handler: function(picker, date) {
			            // do something with the selected date
					}
					
			    },{
					xtype: 'displayfield',
					flex: 1,
					value: 'a. Login \n b. Read \n c. Fill up \n d. Submit'
				}]
			},{
				region: 'south',
				flex: .1,
				margins: '5 5 5 5',
				xtype: 'container',
				html: 'Status 101 Status 101 Status 101 Status 101 Status 101 Status 101 '
			}]
		
		});
		
		
		
		
		
		
		
		
	}
	
});



