
Ext.define('Form.view.navigator.accordionView', { 
	extend: 'Ext.panel.Panel',
	alias: 'widget.accordionview',
	title: '',
    width: '100%',
    defaults: {
        // applied to each contained panel
        // bodyStyle: 'padding:15px'
    },
    layout: {
    	type: 'accordion',
        titleCollapse: true,
        animate: true,
        autoScroll: true,
        fill: true,
        hideCollapseTool: true,
        multi: true
    },
    
	initComponent: function() {   
		
		this.items = [{
			title: '<img height="20" width="30" src="../../../resource/image/tab/app.png"> <b>My Apps</b>',
	        collapsed: true,
	        xtype: 'menu',
	        name: 'myapps',
	        floating: false,
	        width: '100%',
	        bodyPadding: '15 1 10 1',
	        items: []
		},{
			title: '<img height="20" width="30" src="../../../resource/image/tab/worklist.png"> <b>My Worklist</b>',
	        xtype: 'menu',
	        name: 'myworklist',
	        floating: false,
	        width: '100%',
	        bodyPadding: '15 1 10 1',
	        items: []
		},{
		    title: '<img height="20" width="30" src="../../../resource/image/tab/calendar.png"> <b>My Calendar</b>',
		    xtype: 'panel',
		    layout: {
		    	type: 'vbox',
		    	align: 'stretch'
		    },
		    items: [{
		    	xtype: 'datemenu',
		    	name: 'simpleCal',
			    floating: false,
			    width: '100%'
		    },{
		    	xtype: 'textareafield',
		    	id: 'calnotes',
		    	padding: '0 10 10 10',
		    	name: 'stickydatenote',
		    	fieldCls: 'ctextarea',
		    	hidden: true,
		    	width: '100%',
		    	fieldStyle: {
			        backgroundColor: '#EEEE00'
			    },
		    	height: 87,
		    	value: ''
		    },{
		    	xtype: 'displayfield',
		    	name: 'tempVal',
		    	hidden: true,
		    	value: ''
		    }]
		    
		    
		},{
		    title: '<img height="20" width="30" src="../../../resource/image/tab/message.png"> <b>My Messages</b>',
		    xtype: 'menu',
		    name: 'mymessages',
		    floating: false,
	        width: '100%',
	        bodyPadding: '15 1 10 1',
	        collapsed: false,
		    items: []
		},{
		    title: '<img height="20" width="30" src="../../../resource/image/tab/attendance.png"> <b>My Attendance</b>',
		    xtype: 'menu',
		    name: 'myattendance',
		    floating: false,
	        width: '100%',
	        bodyPadding: '15 1 10 1',
	        collapsed: true,
		    items: [{
		    	text: 'Time In',
		    	action: 'timein'
		    },{
		    	text: 'Time Out',
		    	action: 'timeout'
		    }]
		},{
		    title: '<img height="20" width="30" src="../../../resource/image/tab/shortcut.png"> <b>My Shortcuts</b>',
		    xtype: 'menu',
		    name: 'myshortcut',
		    floating: false,
	        width: '100%',
	        bodyPadding: '15 1 10 1',
	        collapsed: true,
		    items: []
		},{
		    title: '<img height="20" width="30" src="../../../resource/image/tab/bookmark.png"> <b>My Bookmarks</b>',
		    xtype: 'menu',
		    name: 'mybookmark',
		    floating: false,
	        width: '100%',
	        bodyPadding: '15 1 10 1',
	        collapsed: true,
		    items: []
		},{
		    title: '<img height="20" width="30" src="../../../resource/image/tab/network.png"> <b>My Network</b>',
		    xtype: 'menu',
		    name: 'mynetwork',
		    floating: false,
	        width: '100%',
	        bodyPadding: '15 1 10 1',
	        collapsed: false,
		    items: []
		},{
		    title: '<img height="20" width="30" src="../../../resource/image/tab/folder.png"> <b>My Folders</b>',
		    xtype: 'treepanel',
		    name: 'myfolder',
		    width: 200,
		    height: 150,
		    //store: 'navigator.folderStore',
		    rootVisible: false
		}],
		this.tools = [{
				        action: 'signout',
				        itemId: 'signout',
				        type: 'signout',
				        cls:'abc-tool-signout',
				        tooltip: 'Sign out'
				    },{
				        type: 'search',
				        tooltip: 'Search',
				        action: 'plsearch'
				    },{
				        type: 'help',
				        tooltip: 'Help'
				    },{
				        type: 'gear',
				        tooltip: 'Settings',
				        action: 'myibosesettings'
				    },{
				        type: 'refresh',
				        tooltip: 'Refresh List',
				        action: 'refreshapp'
				    },{
				        type: 'refresh',
				        tooltip: 'Switch Company',
				        hidden: true,
				        action: 'switchcompanyadmin'
				    }],
		
		this.callParent(arguments);
		
	}
   
});