Ext.define('Form.controller.gallery.gallerycontroller', {
    extend: 'Ext.app.Controller',
	views: [
        'gallery.galleryView'
    ],
	models: [
	],
	stores: [
	],
	init: function() {
		console.log('init gallery controller');
        this.control({
            
			'galleryview': {  
			}
		});
     }	
});