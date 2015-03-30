Ext.define('Form.view.chat.chatwin', { 
	extend: 'Ext.window.Window',
	alias: 'widget.chatwindow',
    title: 'Chat',
	resizable: false,
	closable: true,
	autoScroll: true,
    height: 240,
    width: 250,
    layout: {
		type: 'vbox',
		align: 'left'
	},
	initComponent: function() {
		 this.items = [{
			xtype: 'displayfield',
			width: '100%',
			autoScroll: true,
			//value: '<p><strong>Me: </strong> Response dg  dfg sdfg dfg dsfg sdfg sdfgdfgdf gsdfg sdfgsdfg sdfg sdfgsdf gd gdf gdfgdf dfsgd fgsd gsdf sdg sdfgsdf gsd Sample Response dg  dfg sdfg dfg dsfg sdfg sdfgdfgdf gsdfg sdfgsdfg sdfg sdfgsdf gd gdf gdfgdf dfsgd fgsd gsdf sdg sdfgsdf gsdSample Response dg  dfg sdfg dfg dsfg sdfg sdfgdfgdf gsdfg sdfgsdfg sdfg sdfgsdf gd gdf gdfgdf dfsgd fgsd gsdf sdg sdfgsdf gsdSample Response dg  dfg sdfg dfg dsfg sdfg sdfgdfgdf gsdfg sdfgsdfg sdfg sdfgsdf gd gdf gdfgdf dfsgd fgsd gsdf sdg sdfgsdf gsdSample Response dg  dfg sdfg dfg dsfg sdfg sdfgdfgdf gsdfg sdfgsdfg sdfg sdfgsdf gd gdf gdfgdf dfsgd fgsd gsdf sdg sdfgsdf gsdSample Response dg  dfg sdfg dfg dsfg sdfg sdfgdfgdf gsdfg sdfgsdfg sdfg sdfgsdf gd gdf gdfgdf dfsgd fgsd gsdf sdg sdfgsdf gsdSample Response dg  dfg sdfg dfg dsfg sdfg sdfgdfgdf gsdfg sdfgsdfg sdfg sdfgsdf gd gdf gdfgdf dfsgd fgsd gsdf sdg sdfgsdf gsdSample Response dg  dfg sdfg dfg dsfg sdfg sdfgdfgdf gsdfg sdfgsdfg sdfg sdfgsdf gd gdf gdfgdf dfsgd fgsd gsdf sdg sdfgsdf gsdSample Response dg  dfg sdfg dfg dsfg sdfg sdfgdfgdf gsdfg sdfgsdfg sdfg sdfgsdf gd gdf gdfgdf dfsgd fgsd gsdf sdg sdfgsdf gsdSample Response dg  dfg sdfg dfg dsfg sdfg sdfgdfgdf gsdfg sdfgsdfg sdfg sdfgsdf gd gdf gdfgdf dfsgd fgsd gsdf sdg sdfgsdf gsd</p>',
			flex: 4,
			name: 'displayresp',
			cls: 'field-margin'
		},{
			xtype: 'displayfield',
			width: '100%',
			flex: 1,
			name: 'typingtextonly',
			value: 'Typing',
			cls: 'field-margin'
		},{
			xtype: 'textfield',
			enableKeyEvents: true,
			width: '100%',
			flex: 1,
			emptyText: 'Enter text here...',
			name: 'responseonchat',
			cls: 'field-margin'
		}];
		
		this.callParent(arguments);
	}
		
});