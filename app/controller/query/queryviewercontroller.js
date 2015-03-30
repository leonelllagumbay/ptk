Ext.define('Form.controller.query.queryviewercontroller', {
    extend: 'Ext.app.Controller',
	views: [
        'query.queryviewerView',
        'query.queryviewerActualView'
    ],
	models: [
	    'query.managerModel'
	],
	stores: [
	    'query.queryViewerStore'
	],
	init: function() {
		console.log('init controller');
        this.control({
            
        	'queryviewerview button[action=view]': {  
        		click: 'viewQuery'
			},
			'queryvieweractualview button[action=back]': {  
        		click: 'backToQuery'
			}
		});
     },
     
     viewQuery: function(btn) {
    	 var centerR = Ext.ComponentQuery.query('viewport panel[region=center], viewport')[0];
		 centerR.getLayout().setActiveItem(1);
     },
     backToQuery: function(btn) {
    	 var centerR = Ext.ComponentQuery.query('viewport panel[region=center], viewport')[0];
		 centerR.getLayout().setActiveItem(0);
     }
});