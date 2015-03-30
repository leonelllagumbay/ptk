Ext.define('Form.controller.navigator.navigatorController', {
    extend: 'Ext.app.Controller',
	
	views: [
        'navigator.accordionView',
        'navigator.chatWin'
    ],
    
	models: [
		'navigator.folderModel'
	],
	stores: [
		'navigator.folderStore'
	],
	
    init: function() {
		console.log('init controller');
        this.control({
            
			'accordionview tool[action=signout]': {
				click: this.SignOut
			},
			'accordionview tool[action=plsearch]': {
				click: this.SearchOut
			},
			'accordionview tool[action=refreshapp]': {
				click: this.RefreshApp
			}, 
			'accordionview tool[action=switchcompanyadmin]': {
				click: this.SwitchCompany
			}, 
			'accordionview tool[action=myibosesettings]': {
				click: this.goToMyIboseSettings
			},
			'accordionview': {
				render: this.accrdRendered
			},
			'accordionview datemenu[name=simpleCal]': {
				select: this.simpleCalSelect,
				afterrender: this.simpleCalRender,
				click: this.simpleCalClick
			},
			'accordionview textareafield[id=calnotes]': {
				blur: this.simpleCalBlurs 
			},
			'accordionview menu[name=myapps]': {
				afterrender: this.myAppsRender
			},
			'accordionview menu[name=myworklist]': {
				afterrender: this.myWorklistRender
			},
			'accordionview menu[name=mymessages]': {
				afterrender: this.myMessagesRender
			},
			'accordionview menu[name=myattendance]': {
				click: this.timeIn
			},
			'accordionview menu[name=myshortcut]': {
				afterrender: this.myShortcutRender,
				click: this.newShortCut
			},
			'accordionview menu[name=myshortcut] menu': {
				click: this.removeShortcut
			},
			'accordionview menu[name=mybookmark]': {
				afterrender: this.myBookmarkRender,
				click: this.newBookmark
			},
			'accordionview menu[name=mybookmark] menu': {
				click: this.removeBookmark
			},
			'accordionview menu[name=mynetwork]': {
				afterrender: this.myNetworkRender,
				click: this.myNetworkwasClicked				
			},
			'accordionview treepanel[name=myfolder]': {
				afterrender: this.myFolderRender
			},
			'accordionview treepanel[name=myfolder]': {
				containercontextmenu: this.myFolderRightClicked
			},
			'chatwin textareafield[name=responseonchat]': {
				keyup: this.chatTextAreaKeyUp,
				blur: this.chatTextAreaBlurs,
				focus: this.chatTextAreaFocused
			}
		});
    
	},
	
	goToMyIboseSettings: function(btn) {
		window.location.href = "./?bdg=MYIBOSE01052015";
	},
	
	removeShortcut: function(themenu,theitem) {
		var themenu = themenu.up('menu');
		themenu.getEl().mask('Removing...');
		Ext.nav.Navigator.removeShortCut(theitem.action,'SHORTCUT',function(resp) {
			themenu.getEl().unmask();
			if(resp == "success") {
				themenu.remove(theitem.action);
				return true;
			}
		});
	},
	
	removeBookmark: function(themenu,theitem) {
		var themenu = themenu.up('menu');
		themenu.getEl().mask('Removing...');
		Ext.nav.Navigator.removeShortCut(theitem.action,'BOOKMARK',function(resp) {
			themenu.getEl().unmask();
			if(resp == "success") {
				themenu.remove(theitem.action);
				return true;
			}
		});
	},
	
	newBookmark: function(themenu,theitem) {
		if(theitem.xtype == 'header') {
			themenu.remove('bookmarkname');
			themenu.remove('bookmarklink');
			themenu.remove('bookmarksave');
			themenu.remove('bookmarkcancel');
			return true;
		}
		if(theitem.xtype == 'textfield' || theitem.xtype == 'button') {
			return true;
		}
		if(theitem.action == 'newbookmark') {
			themenu.remove('bookmarkname');
			themenu.remove('bookmarklink');
			themenu.remove('bookmarksave');
			themenu.remove('bookmarkcancel');
			themenu.insert(1,[{
				xtype: 'textfield',
				id: 'bookmarkname',
				padding: '3 10 1 1',
				emptyText: 'Name'
			},{
				xtype: 'textfield',
				id: 'bookmarklink',
				padding: '3 10 1 1',
				emptyText: 'Link (http:// included)'
			},{
				xtype: 'button',
				text: 'Save',
				id: 'bookmarksave',
				handler: function() {
					var sname = Ext.getCmp('bookmarkname').getValue();
					var slink = Ext.getCmp('bookmarklink').getValue();
					if(sname.length > 0 && slink.length > 0 ) {
						themenu.getEl().mask('Saving...');
						Ext.nav.Navigator.saveShortCut(sname, slink,'BOOKMARK',function(resp) {
							themenu.getEl().unmask();
							if(resp == "success") {
								themenu.remove('bookmarkname');
								themenu.remove('bookmarklink');
								themenu.remove('bookmarksave');
								themenu.remove('bookmarkcancel');
								themenu.insert(1,[{
									text: sname,
							    	href: slink
								}]);
								return true;
							} else {
								Ext.Msg.alert('', 'There is a problem in saving the bookmark.');
							}
						});
					} else {
						Ext.Msg.alert('', 'Name and link are required fields.');
					}
				},
				margin: '3 10 1 30'
			},{
				xtype: 'button',
				text: 'Cancel',
				id: 'bookmarkcancel',
				handler: function() {
					themenu.remove('bookmarkname');
					themenu.remove('bookmarklink');
					themenu.remove('bookmarksave');
					themenu.remove('bookmarkcancel');
				},
				margin: '3 10 1 30'
			}]);
		} else {
			return true;
		}
	},
	
	newShortCut: function(themenu,theitem) {
		if(theitem.xtype == 'header') {
			themenu.remove('shortcutname');
			themenu.remove('shortcutlink');
			themenu.remove('shortcutsave');
			themenu.remove('shortcutcancel');
			return true;
		}
		if(theitem.xtype == 'textfield' || theitem.xtype == 'button') {
			return true;
		}
		if(theitem.action == 'newshortcut') {
			themenu.remove('shortcutname');
			themenu.remove('shortcutlink');
			themenu.remove('shortcutsave');
			themenu.remove('shortcutcancel');
			themenu.insert(1,[{
				xtype: 'textfield',
				id: 'shortcutname',
				padding: '3 10 1 1',
				emptyText: 'Name'
			},{
				xtype: 'textfield',
				id: 'shortcutlink',
				padding: '3 10 1 1',
				emptyText: 'Link'
			},{
				xtype: 'button',
				text: 'Save',
				id: 'shortcutsave',
				handler: function() {
					var sname = Ext.getCmp('shortcutname').getValue();
					var slink = Ext.getCmp('shortcutlink').getValue();
					if(sname.length > 0 && slink.length > 0 ) {
						themenu.getEl().mask('Saving...');
						Ext.nav.Navigator.saveShortCut(sname, slink,'SHORTCUT',function(resp) {
							themenu.getEl().unmask();
							if(resp == "success") {
								themenu.remove('shortcutname');
								themenu.remove('shortcutlink');
								themenu.remove('shortcutsave');
								themenu.remove('shortcutcancel');
								themenu.insert(1,[{
									text: sname,
							    	href: slink
								}]);
								return true;
							} else {
								Ext.Msg.alert('', 'There is a problem in saving the shortcut.');
							}
						});
					} else {
						Ext.Msg.alert('', 'Name and link are required fields.');
					}
				},
				margin: '3 10 1 30'
			},{
				xtype: 'button',
				text: 'Cancel',
				id: 'shortcutcancel',
				handler: function() {
					themenu.remove('shortcutname');
					themenu.remove('shortcutlink');
					themenu.remove('shortcutsave');
					themenu.remove('shortcutcancel');
				},
				margin: '3 10 1 30'
			}]);
		} else {
			return true;
		}
	},
	
	timeIn: function(themenu,theitem) {
		if(theitem.xtype == 'header') {
			themenu.remove('timeinid');
			themenu.remove('timeinsave');
			themenu.remove('timeincancel');
			return true;
		}
		if(theitem.xtype == 'datefield' || theitem.xtype == 'timefield' || theitem.xtype == 'button') {
			return true;
		}
		if(theitem.action == 'timein') {
			themenu.remove('timeinid');
			themenu.remove('timeinsave');
			themenu.remove('timeincancel');
			themenu.insert(1,[{
				xtype: 'timefield',
				id: 'timeinid',
				padding: '3 10 1 1'
			},{
				xtype: 'button',
				text: 'Save',
				id: 'timeinsave',
				handler: function() {
					var timeval = Ext.getCmp('timeinid').getValue();
					timeval = Ext.util.Format.date(timeval, 'H:i');
					if(timeval.length >= 5) {
						themenu.getEl().mask('Saving...');
						if (navigator.geolocation) {
					        var navi = navigator.geolocation.getCurrentPosition(function(position) {
					        	var lat = position.coords.latitude.toString();
					        	var longi = position.coords.longitude.toString();
					        	Ext.nav.Navigator.saveAttendance(timeval,'IN',lat,longi,function(resp) {
									themenu.getEl().unmask();
									themenu.remove('timeinsave');
									if(resp == "success") {
										return true;
									} else {
										Ext.Msg.alert('', 'There is a problem in saving the attendance.');
									}
								});
					        });
					        return true;
					    } else {
					        Ext.Msg.alert("Cannot save your attendance","Please accept geolocation in your browser to continue.");
					    	return false;
					    }
					} else {
						Ext.Msg.alert('', 'Please fill-up date and time correctly.');
					}
				},
				margin: '3 10 1 30'
			},{
				xtype: 'button',
				text: 'Cancel',
				id: 'timeincancel',
				handler: function() {
					themenu.remove('timeinid');
					themenu.remove('timeinsave');
					themenu.remove('timeincancel');
				},
				margin: '3 10 1 30'
			}]);
		} else if (theitem.action == 'timeout') {
			themenu.remove('timeinid');
			themenu.remove('timeinsave');
			themenu.remove('timeincancel');
			themenu.insert(2,[{
				xtype: 'timefield',
				id: 'timeinid',
				padding: '3 10 1 1'
			},{
				xtype: 'button',
				text: 'Save',
				id: 'timeinsave',
				handler: function() {
					var timeval = Ext.getCmp('timeinid').getValue();
					timeval = Ext.util.Format.date(timeval, 'H:i');
					if(timeval.length >= 5) {
						themenu.getEl().mask('Saving...');
						if (navigator.geolocation) {
					        var navi = navigator.geolocation.getCurrentPosition(function(position) {
					        	var lat = position.coords.latitude.toString();
					        	var longi = position.coords.longitude.toString();
					        	Ext.nav.Navigator.saveAttendance(timeval,'OUT',lat,longi,function(resp) {
									themenu.getEl().unmask();
									themenu.remove('timeinsave');
									if(resp == "success") {
										return true;
									} else {
										Ext.Msg.alert('', 'There is a problem in saving the attendance.');
									}
								});
					        });
					        return true;
					    } else {
					        Ext.Msg.alert("Cannot save your attendance","Please accept geolocation in your browser to continue.");
					    	return false;
					    }
					} else {
						Ext.Msg.alert('', 'Please fill-up date and time correctly.');
					}
				},
				margin: '3 10 1 30'
			},{
				xtype: 'button',
				text: 'Cancel',
				id: 'timeincancel',
				action: 'incancel',
				handler: function() {
					themenu.remove('timeinid');
					themenu.remove('timeinsave');
					themenu.remove('timeincancel');
				},
				margin: '3 10 1 30'
			}])
		}
	},
	
	chatTextAreaFocused: function(theComp) {
		var thiswin = theComp.up('window');
		if(typeof refInterval !== 'undefined') {
			//refinterval is defined
			if(typeof originalhtmltitle !== 'undefined') {
				document.title = originalhtmltitle;
			}
			clearInterval(refInterval);
			refInterval=undefined;
			thiswin.setBodyStyle("border","none 0px");
			var thiswin = theComp.up('window');
			var myData = {
				userid: GLOBAL_VARS_DIRECT.USERID,
				recipientuserid: thiswin.id,
				type: 'ihaveseenit',
				firstname: GLOBAL_VARS_DIRECT.FIRSTNAME,
				lastname: GLOBAL_VARS_DIRECT.LASTNAME,
				middlename: GLOBAL_VARS_DIRECT.MIDDLENAME,
				receiveddatetime: Ext.Date.format(new Date, "g:ia"),
				companycode: GLOBAL_VARS_DIRECT.COMPANYCODE
			};
			ws.publish("chat", myData);
		} else {
		}
		
		
		
		
	},
	
	chatTextAreaBlurs: function(theComp,theEventObj) {
		var thiswin = theComp.up('window');
		var myData = {
			userid: GLOBAL_VARS_DIRECT.USERID,
			recipientuserid: thiswin.id,
			type: 'iamnottypingnow',
			firstname: GLOBAL_VARS_DIRECT.FIRSTNAME,
			lastname: GLOBAL_VARS_DIRECT.LASTNAME,
			middlename: GLOBAL_VARS_DIRECT.MIDDLENAME,
			companycode: GLOBAL_VARS_DIRECT.COMPANYCODE
		};
		ws.publish("chat", myData);
	},
	
	chatTextAreaKeyUp: function(thiscomp,e) {
		var thevaluea = thiscomp.value;
		if(e.button == 12) {
			if (thevaluea.trim() == "") {
				return false;
			}
			var thiswin = thiscomp.up('window');
			thiscomp.setValue("");
			var myData = {
				userid: GLOBAL_VARS_DIRECT.USERID,
				recipientuserid: thiswin.id,
				type: 'ihaveamessageforyou',
				firstname: GLOBAL_VARS_DIRECT.FIRSTNAME,
				lastname: GLOBAL_VARS_DIRECT.LASTNAME,
				middlename: GLOBAL_VARS_DIRECT.MIDDLENAME,
				myprofilepic: GLOBAL_VARS_DIRECT.MYPROFILEPIC,
				mymessage: thevaluea,
				companycode: GLOBAL_VARS_DIRECT.COMPANYCODE
			};
			ws.publish("chat", myData);
		} else {
			var thiswin = thiscomp.up('window');
			var myData = {
				userid: GLOBAL_VARS_DIRECT.USERID,
				recipientuserid: thiswin.id,
				type: 'iamtypingnow',
				firstname: GLOBAL_VARS_DIRECT.FIRSTNAME,
				lastname: GLOBAL_VARS_DIRECT.LASTNAME,
				middlename: GLOBAL_VARS_DIRECT.MIDDLENAME,
				companycode: GLOBAL_VARS_DIRECT.COMPANYCODE
			};
			ws.publish("chat", myData);
		}
	},
	
	myNetworkwasClicked: function(themenu, theitem) {
		if(theitem.xtype == 'header') {
			return true;
		}
		var winexist = Ext.ComponentQuery.query('window[id='+ theitem.id + ']');
		if(winexist.length > 0) {
			return true;
		}
		var mychatwin = Ext.widget('chatwin');
		var cnt = Ext.ComponentQuery.query('window[alias=widget.chatwin]');
		mychatwin.id = theitem.id;
		mychatwin.setIcon(theitem.icon);
		mychatwin.setTitle(theitem.name);
		if(cnt.length < 5) {
			var currentW = mychatwin.x;
			mychatwin.setX(currentW*cnt.length);
		} else {
			mychatwin.setX(200);
			mychatwin.setY(200);
		}
		mychatwin.show();
	},
	
	myNetworkRender: function(themenu) {
		GLOBAL_MYNETWORK_MENU = themenu;
		originalhtmltitleStatic = document.title;
	},
	
	myFolderRender: function(themenu) {
		
	},
	
	myShortcutRender: function(themenu) {
		Ext.nav.Navigator.getMyShortcut(function(resp) {
			themenu.add(resp);
			return true;
		});
	},
	
	myBookmarkRender: function(themenu) {
		Ext.nav.Navigator.getMyBookmark(function(resp) {
			themenu.add(resp);
			return true;
		});
	},
	
	myMessagesRender: function(themenumsg) {
		themenumsg.removeAll();
		Ext.nav.Navigator.getMyMessages(function(resp) {
			themenumsg.add(resp);
			return true;
		});
	},
	
	myWorklistRender: function(themenu) {
		var curl = window.location.href;
		if(curl.search("MAINUSRAPPF5038527-9F22-9981-A084244087E398BD") < 0 && curl.search("SIMULATOR") < 0 ) {
			themenu.removeAll();
			Ext.nav.Navigator.getMyWorklist(function(resp) {
				themenu.add(resp);
				return true;
			});
		}
	},
	
	myWorklistRenderF: function(themenu) {
		var curl = window.location.href;
		if(curl.search("MAINUSRAPPF5038527-9F22-9981-A084244087E398BD") > 0 || curl.search("SIMULATOR") > 0 ) {
			themenu.removeAll();
			Ext.nav.Navigator.getMyWorklist(function(resp) {
				themenu.add(resp);
				return true;
			});
		}
	},
	
	
	RefreshApp: function(btn) {
		var themenu = Ext.ComponentQuery.query('menu[name=myapps]')[0];
		themenu.removeAll();
		this.myAppsRender(themenu);

		
		var themenuW = Ext.ComponentQuery.query('menu[name=myworklist]')[0];
		this.myWorklistRender(themenuW);
		
		var themenuW = Ext.ComponentQuery.query('menu[name=myshortcut]')[0];
		themenuW.removeAll();
		this.myShortcutRender(themenuW);
		
		var themenuW = Ext.ComponentQuery.query('menu[name=mybookmark]')[0];
		themenuW.removeAll();
		this.myBookmarkRender(themenuW);
		
		var themenuW = Ext.ComponentQuery.query('menu[name=mymessages]')[0];
		themenuW.removeAll();
		this.myMessagesRender(themenuW);
		
		//websocket publish open chat
		GLOBAL_MYNETWORK_MENU.removeAll();
		try {
			var myData = {
				userid: GLOBAL_VARS_DIRECT.USERID,
				type: 'whosecurrentlyloggedon',
				firstname: GLOBAL_VARS_DIRECT.FIRSTNAME,
				lastname: GLOBAL_VARS_DIRECT.LASTNAME,
				middlename: GLOBAL_VARS_DIRECT.MIDDLENAME,
				mymessage: GLOBAL_VARS_DIRECT.MYMESSAGE,
				myprofilepic: GLOBAL_VARS_DIRECT.MYPROFILEPIC,
				companycode: GLOBAL_VARS_DIRECT.COMPANYCODE
			};
			ws.publish("chat",myData);
		} catch(e) {
			console.log('chat error' + e);
		}
		
	},
	
	myAppsRender: function(themenu) {
		themenu.up('panel').setDisabled(true);
		Ext.nav.Navigator.getMyApps(function(resp) {
			themenu.add(resp);
			themenu.up('panel').setDisabled(false);
			return true;
		});
	},
	
	simpleCalBlurs: function(thisC) {
		var val = thisC.getValue();
		if(val.length > 0 && thisC.isDirty() && CALENDAR_CURRENT_NOTE != val) {
			var theTempDisp = Ext.ComponentQuery.query('panel displayfield[name=tempVal]')[0];
			var currentDateVal = theTempDisp.getValue();
			thisC.getEl().mask('Saving...'); 
			Ext.nav.Navigator.saveDateNotes(val,currentDateVal, function(res) {
    			try {
    				var theDateNoteDisp = Ext.ComponentQuery.query('panel textareafield[name=stickydatenote]')[0];
    				theDateNoteDisp.setVisible(false);
    				thisC.getEl().unmask(); 
    			} catch(e) {
    				console.log(e);
    				thisC.getEl().unmask(); 
    			}
    		});
		} else {
			var theDateNoteDisp = Ext.ComponentQuery.query('panel textareafield[name=stickydatenote]')[0];
    		theDateNoteDisp.setVisible(false);
		}
	},
	
	simpleCalSelect: function(thedate,thevalue) {
		var theDateNoteDisp = Ext.ComponentQuery.query('panel textareafield[name=stickydatenote]')[0];
		var theTempDisp = Ext.ComponentQuery.query('panel displayfield[name=tempVal]')[0];
		var formattedDate = Ext.Date.format(thevalue, "Y-m-d");
		theTempDisp.setValue(formattedDate);
		theDateNoteDisp.getEl().mask('Please wait...'); 
		Ext.nav.Navigator.getDateNotes(formattedDate, function(res) {
			try {
				theDateNoteDisp.setValue(res);
				CALENDAR_CURRENT_NOTE = res;
				theDateNoteDisp.setVisible(true);
				theDateNoteDisp.getEl().unmask(); 
			} catch(e) {
				console.log(e);
				theDateNoteDisp.getEl().unmask(); 
			}
		});
		
		return true;
		
	},
	
	simpleCalRender: function(thisCal) {
		var datePicker = thisCal.picker;
		var startDate = datePicker.cells.elements[0].title;
		var endDate = datePicker.cells.elements[41].title;
		Ext.nav.Navigator.getDatesToMarkArray(startDate, endDate, function(res) {
			try {
				for(a=0;a<res.length;a++) {
					for(b=0;b<42;b++) { 
						if(res[a] == datePicker.cells.elements[b].title) {
	    					datePicker.cells.elements[b].className = 'x-datepicker-today x-datepicker-active x-datepicker-cell';
	    				}
					}
				}
			} catch(e) {
				console.log(e);
			}
		});
	},
	
	simpleCalClick: function(menu) {
		var datePicker = menu.picker;
		var startDate = datePicker.cells.elements[0].title;
		var endDate = datePicker.cells.elements[41].title;
		Ext.nav.Navigator.getDatesToMarkArray(startDate, endDate, function(res) {
			try {
				for(a=0;a<res.length;a++) {
					for(b=0;b<42;b++) { 
						if(res[a] == datePicker.cells.elements[b].title) {
	    					datePicker.cells.elements[b].className = 'x-datepicker-today x-datepicker-active x-datepicker-cell';
	    				}
					}
				}
			} catch(e) {
				console.log(e);
			}
		});
	},
	
	accrdRendered: function(pan) {
		pan.setTitle('Welcome ' + GLOBAL_VARS_DIRECT.FIRSTNAME + '!');
		if(GLOBAL_VARS_DIRECT.USERID.toUpperCase() == "ADMIN") {
			pan.tools[5].setVisible(true);
		} else {
			pan.tools[5].setVisible(false);
		}
	},
	
	SignOut: function(thisBtn) {
		
		//websocket publish chat - closing out app session
		try {
			var myData = {
				userid: GLOBAL_VARS_DIRECT.USERID,
				type: 'iamoutnow',
				firstname: GLOBAL_VARS_DIRECT.FIRSTNAME,
				lastname: GLOBAL_VARS_DIRECT.LASTNAME,
				middlename: GLOBAL_VARS_DIRECT.MIDDLENAME,
				mymessage: GLOBAL_VARS_DIRECT.MYMESSAGE,
				myprofilepic: GLOBAL_VARS_DIRECT.MYPROFILEPIC,
				companycode: GLOBAL_VARS_DIRECT.COMPANYCODE
			};
			ws.publish("chat",myData);
		} catch(e) {
			console.log('chat log out error' + e);
		}
		
		Ext.Msg.alert('', '<b>Thank you for using iBOS/e!</b>', function(btn) {
			Ext.Ajax.request({
			    url: 'signout.cfm',
			    success: function(response){
			    	var newwinloc = window.location.href.split("?")[0];
			    	window.location.href = newwinloc;
			    }
			});
		});
		
	},
	
	SearchOut: function(thisBtn) {
		var theAccordion = thisBtn.up('panel');
		theAccordion.remove('srcht');
		theAccordion.insert(0, [{
			title: ' ',
			id: 'srcht',
			xtype: 'panel',
		    layout: {
		    	type: 'vbox',
		    	align: 'stretch'
		    },
		    closable: true,
		    items: [{
		    	xtype: 'textfield',
		    	padding: '10 5 27 5',
		    	emptyText: 'Type text to search...'
		    }]
		}]);
		
		theAccordion.doLayout();
	},
	
	SwitchCompany: function(thisBtn) {
		var theAccordion = thisBtn.up('panel');
		theAccordion.remove('swcpny');
		var companies = Ext.create('Ext.data.Store', {
		    fields: ['companyname', 'companycode'],
		    proxy: {
				type: 'direct',
				directFn: 'Ext.nav.Navigator.getCompany',
				reader: {
					root: 'topics',
					totalProperty: 'totalCount'
				}
			}
		});
		theAccordion.insert(0, [{
			title: ' ',
			xtype: 'panel',
			id: 'swcpny',
		    layout: {
		    	type: 'vbox',
		    	align: 'stretch'
		    },
		    closable: true,
		    items: [{
		    	xtype: 'combobox',
		    	padding: '10 5 27 5',
		    	store: companies,
		    	queryMode: 'remote',
			    displayField: 'companyname',
			    valueField: 'companycode',
			    pageSize: 25,
			    minChars: 1,
			    listeners: {
			    	select: function(thisc) {
			    		Ext.nav.Navigator.switchCompany(thisc.getValue(), function(res) {
							if(res == true) {
			    				window.location.reload();
			    			} else {
			    				console.log('failed');
			    				console.log(res);
			    			}
			    		});
			    	}
			    }
		    }]
		}]);
		
		theAccordion.doLayout();
	},
	
	myFolderRightClicked: function(thisview, rawevent, eOpts) {
		rawevent.stopEvent();
        Ext.create('Ext.menu.Menu', {
        	listeners: {
			    hide: function(dmenu) {
			        Ext.destroy(dmenu);
			    }
			},
            items : [{
                text : 'New folder',
                handler : function() {
                    console.log('add');
                }
            }]
        }).showAt(rawevent.getXY());


        return false;
	}
	 
});
