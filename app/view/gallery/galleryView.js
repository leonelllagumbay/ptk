Ext.define('Form.view.gallery.galleryView', { 
	extend: 'Ext.form.Panel',
	alias: 'widget.galleryview',
	title: 'eGallery',
	width: '100%', 
	height: '100%',
	autoScroll: true,
	initComponent: function() {   
		this.callParent(arguments);
	}
});