Ext.define('cfbose.view.main.main', {
	extend: 'Ext.tab.Panel',
	alias: 'widget.mainmain',
	
	initComponent: function() {
		
		this.items = [{
                title: 'eBoard - News and Events',
                html: "My content was added during construction."
            },{
                title: 'My Messages - Ajax Tab 1',
				icon: "http://localhost:8501/test10/cfbose/resource/images/mainicon/labs.png",
				closable: true,
                loader: {
                    url: 'http://localhost:8501/test10/cfbose/dummy/tabtest.html',
                    contentType: 'html',
                    loadMask: true 
                },
                listeners: {
                    activate: function(tab) {
						
                        tab.loader.load();
                    }
                }
            },{
                title: 'My Networks',
                loader: {
                    url: 'http://localhost:8501/test10/cfbose/dummy/tabtest.html',
                    contentType: 'html',
                    autoLoad: true,
                    params: 'foo=123&bar=abc'
                }
            },{
                title: 'eCalendar - Work From Home',
                listeners: {
                    activate: function(tab){
                        setTimeout(function() {
                            alert(tab.title + ' was activated.');
                        }, 1);
                    }
                },
                html: "I am tab 4's content. I also have an event listener attached."
            },{
                title: 'Disabled Tab',
                disabled: true,
                html: "Can't see me cause I'm disabled"
            },{
				title: 'Leonell A. Lagumbay 1'
			},{
				title: 'Leonell A. Lagumbay 2'
			},{
				title: 'Leonell A. Lagumbay 3'
			},{
				title: 'Leonell A. Lagumbay 4'
			},{
				title: 'Leonell A. Lagumbay 5'
			},{
				title: 'Leonell A. Lagumbay 6'
			},{
				title: 'Leonell A. Lagumbay 7'
			},{
				title: 'Leonell A. Lagumbay 8'
			},{
				title: 'Leonell A. Lagumbay 9'
			}];
		
		
		this.callParent(arguments);
	}
});