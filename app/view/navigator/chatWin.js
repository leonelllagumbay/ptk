
Ext.define('Form.view.navigator.chatWin', { 
	extend: 'Ext.window.Window',
	alias: 'widget.chatwin',
	title: 'xxx yyy',
    width: 250,
    height: 350,
    resizable: true,
	closable: true,
	collapsible: true,
	constrain: true,
	maxHeight: 400,
	maxWidth: 500,
	minHeight: 240,
	minWidth: 250,
	region: 'south',
	x: 250,
	autoShow: true,
    defaults: {
    },
    layout: {
		type: 'vbox',
		align: 'left'
	},
    
	initComponent: function() {   
		
		this.items = [{
						xtype: 'panel',
						layout: 'vbox',
						width: '100%',
						autoScroll: true,
						padding: 3,
						flex: 15,
						name: 'chatpanel',
						items: []
					},{
						xtype: 'displayfield',
						width: '100%',
						height: 3,
						name: 'typingtextonly'
					},{
						xtype: 'textareafield',
						enableKeyEvents: true,
						margin: 3,
						width: '100%',
						height: 37,
						emptyText: 'Enter text here...',
						name: 'responseonchat'
					}],
		
		this.callParent(arguments);
		
	}
   
});

/*
listeners: {
	keyup: function(thiscomp,e) {
		var thevaluea = thiscomp.value;
		if(e.button == 12) {
			
			if (thevaluea.trim() == "") {
				return false;
			}
			var timenow = new Date();
			timenow = Ext.Date.format(timenow, "h:i:s a");
			thevalue = '<strong>Me: </strong>' + thevaluea + '<i>(' + timenow + ')</i>';
			var thiswin = this.up('window');
			
			
			//displayf.setValue(thevalue);
			thiscomp.setValue("");
			var myPanel = thiswin.down('panel');
			myPanel.add(new Ext.form.DisplayField({
                    value: thevalue,
					cls: 'field-margin',
					width: '95%'
                }));
			
			var d = myPanel.body.dom;
			myPanel.body.scroll("b", d.scrollHeight);
			
			var winid = thiswin.id.split('^^^');
			var recipientAndMe = winid[1] + '^^^' + winid[0];
			
			var theFullMsg = '<strong>' + winid[0] + ': </strong>' + thevaluea + '<i>(' + timenow + ')</i>';
			sayHello(theFullMsg, recipientAndMe, winid[0], thiswin.title);
		} else {
			var thiswin = this.up('window');
			var winid = thiswin.id.split('^^^');
			var recipientAndMe = winid[1] + '^^^' + winid[0];
			
			if((thevaluea.length%9) == 0 || thevaluea.length == 1) {
				sayTyping(recipientAndMe, winid[0], thiswin.title);
			}
			window.setTimeout(function(){myTimer(recipientAndMe)},15000);
		}
		
    }
}

*/