Ext.define('Note.controller.note.notecontroller', {
    extend: 'Ext.app.Controller',
	
	views: [
        'note.noteMainView',
    ],
	models: [
		'note.noteMainModel',
	],
	stores: [
		'note.noteMainStore',
	],
	
    init: function() {
		console.log('init controller');
        this.control({
            
			'notemainview button[action=viewtables]': {  
				click: this.sampleFunction
			},
			 
        });
    
	},
	
	sampleFunction: function(btn) {
		alert('Ok');
		return true;
	},
 
});