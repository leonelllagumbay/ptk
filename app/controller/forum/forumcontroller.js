Ext.define('Form.controller.forum.forumcontroller', {
    extend: 'Ext.app.Controller',
	views: [
        'forum.forumView',
        'forum.forumListGrid'
    ],
	models: [
		'forum.forumListModel'
	],
	stores: [
		'forum.forumListStore'
	],
	init: function() {
		
		var tableStore = this.getForumForumListStoreStore();
	    tableStore.on('load', this.otableStoreLoad);
		
		this.control({
            
			'forumlistgrid': {  
				select: this.forumCellWasSelected,
				render: this.gridRender
			},
			'forumview': {
				render: this.forumRender
			},
			'forumview button[action=sendcomment]': {  
				click: this.sentComment
			}
		});
     },
     
     forumRender: function(p) {
     	forumstartnumref = 0; //must be global variable
		p.body.on('scroll', function(e) {
			if((e.target.scrollHeight - e.target.scrollTop) < 700) {
				if(forumstartnumref != -1) {
				    var fg = Ext.ComponentQuery.query('forumlistgrid')[0];
			     	var selData = fg.getSelectionModel().getSelection()[0];
			     	var eforumlinkcode = selData.data.FORUMCODE;
			     	forumstartnumref += 31;
				    p.getEl().mask('Loading...');
				    Ext.forum.Forum.prepComments(eforumlinkcode,forumstartnumref, function(resp) {
				    	p.getEl().unmask();
				    	if(resp.length == 0) {
				    		forumstartnumref = -1;
				    		return true;
				    	}
				   		p.add(resp);
				   	});
				}
			}
		}, p);
		
	 },
     
     forumCellWasSelected: function(thisCell,rec) {
     	forumstartnumref = 0;
     	var fv = Ext.ComponentQuery.query('forumview')[0];
     	fv.getEl().mask('Loading...');
     	Ext.forum.Forum.loadMyForums(rec.data.FORUMCODE,0,function(resp) {
     		fv.getEl().unmask();
     		fv.removeAll();
     		fv.add(resp);
     	});
     	var thisnum = rec.data.UNREAD;
     	var mmsg = Ext.ComponentQuery.query('accordionview menu[name=mymessages] menuitem[name=forumstatus]')[0];
		var curnumofitem = mmsg.newlistno;
		var curnumofitem = curnumofitem - thisnum;
		if(curnumofitem < 1) {
			curnumofitem = 0;
		} 
		mmsg.newlistno = curnumofitem;
		if(curnumofitem == 0) {
			mmsg.setText("0 in eForums");
		} else {
			mmsg.setText("<span style='background-color: red; border-radius: 12px; color: white;'><b>&nbsp;" + curnumofitem + "&nbsp;</b></span> in eForums");
		}
		rec.data.UNREAD = 0;	
			
     },
     gridRender: function(dgrid,d) {
     	
     },
     otableStoreLoad: function(dstore) {
     	var fg = Ext.ComponentQuery.query('forumlistgrid')[0];
     	fg.getSelectionModel().select(0);
     },
     sentComment: function(dbtn) {
     	
     	var fg = Ext.ComponentQuery.query('forumlistgrid')[0];
     	var selData = fg.getSelectionModel().getSelection()[0];
     	var forumcode = selData.data.FORUMCODE;
     	var forumcompanycode = selData.data.COMPANYCODE;
     	var forumowner = selData.data.PERSONNELIDNO;
     	var forumnotify = selData.data.ALLOWEMAILNOTIF;
     	var forumdesc = selData.data.DESCRIPTION;
     	var owneremail = selData.data.EFORUMEMAIL;
     	var btncontainer = dbtn.up('container');
     	var htmled = btncontainer.down('htmleditor');
     	var commentval = htmled.getValue();
     	if(commentval.trim().length > 0) {
     		dbtn.setDisabled(true);
     		Ext.forum.Forum.saveMyComment(forumcode,forumcompanycode,commentval,forumowner,forumnotify, forumdesc, owneremail, function(resp) {
     			if(resp.issuccess == true) {
	     			dbtn.setDisabled(false);
	     			var myData = {
						userid: GLOBAL_VARS_DIRECT.USERID,
						recipientuserid: 'NA',
						recipientpid: forumowner,
						type: 'mymsgtoforum',
						firstname: GLOBAL_VARS_DIRECT.FIRSTNAME,
						lastname: GLOBAL_VARS_DIRECT.LASTNAME,
						middlename: GLOBAL_VARS_DIRECT.MIDDLENAME,
						myprofilepic: GLOBAL_VARS_DIRECT.MYPROFILEPIC,
						receiveddatetime: Ext.Date.format(new Date, "g:ia"),
						companycode: forumcompanycode,
						mymsg: commentval,
						forumcode: forumcode
					};
					ws.publish("chat", myData);
	     			htmled.setValue('');
	     		} else {
	     			Ext.Msg.alert('','There is a problem sending data. Please try again.');
	     		}
	     	});
     	} else {
     		htmled.setDirty();
     	}
     	
     	
     }
});