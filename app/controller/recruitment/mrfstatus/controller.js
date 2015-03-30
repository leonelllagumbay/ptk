Ext.define('Form.controller.recruitment.mrfstatus.controller', {
    extend: 'Ext.app.Controller',
	stores: [
		'recruitment.mrfstatus.store',
		'recruitment.mrfstatus.departmentstore', 
		'recruitment.mrfstatus.templatestore'
	],
	views: [
        'recruitment.mrfstatus.view',
		'recruitment.mrfstatus.emailwindow'
    ],
	models: [
		'recruitment.mrfstatus.model',
		'recruitment.mrfstatus.departmentmodel',  
		'recruitment.mrfstatus.templatemodel'
	],
	
    init: function() {
		console.log('init controller');
        this.control({
            'viewport > panel': {
                //afterrender: this.onPanelRendered
            },
			'mrfstatusview combobox[name=department]': {
				change: this.refreshgrid
			},
			'mrfstatusview splitbutton[name=menuprocess]': {
				//menuhide: this.hideshowrecord,
				click: this.hideshowrecord
			},
			'mrfstatusview button[action=sendemail]': {
                click: this.sendEmail
            },
			'emailwin combobox[name=emailtemplate]': {
				change: this.emailtemplatechange
			},
			'emailwin button[name=sendemailbutton]': {
				click: this.sendEmailNow  
			},
			'mrfstatusview button[action=exporttoexcel]': {
                click: this.exportToExcel
            }, 
			'mrfstatusview button[action=settings]': {
                click: this.opensettings
            },
			'mrfstatusview button[action=tatmax]': {
                click: this.displaymaxtat
            }
		
        });
    },
	
	displaymaxtat: function(button) {
		var win = button.up('grid');
		var store = win.getStore();
		
		var tatmax = store.data.items[0].data.TOTALTATMRFPOST;
		win.columns[10].setText('TAT (MRF to Posting) ' + tatmax);
		
		tatmax = store.data.items[0].data.TOTALTATSOURCING;
		win.columns[17].setText('TAT (Sourcing) ' + tatmax);
		
		tatmax = store.data.items[0].data.TOTALTATPRESCREENINVITE;
		win.columns[20].setText('TAT (Pre-screen to Invite) ' + tatmax);
		
		tatmax = store.data.items[0].data.TOTALTATEXAMHRINT;
		win.columns[25].setText('TAT (Exam to HR Interview) ' + tatmax);
		
		tatmax = store.data.items[0].data.TOTALTATSUMMARYSC;
		win.columns[26].setText('TAT Summary ' + tatmax);
		
		tatmax = store.data.items[0].data.TOTALTATHRFEEDBACK;
		win.columns[33].setText('TAT (HR Interview to Feedback) ' + tatmax);
		
		tatmax = store.data.items[0].data.TOTALTATHDFD;
		win.columns[37].setText('TAT (Feedback of HR Interview to Department Interview) ' + tatmax);
		
		tatmax = store.data.items[0].data.TOTALTATFD;
		win.columns[41].setText('TAT (First Department Interview Feedback) ' + tatmax);
		
		tatmax = store.data.items[0].data.TOTALTATSUMMARYFD;
		win.columns[42].setText('TAT (First Department Interview TAT Summary) ' + tatmax);
		
		tatmax = store.data.items[0].data.TOTALTATHDSD;
		win.columns[46].setText('TAT (Feedback of First to Second Department Interview) ' + tatmax);
		
		tatmax = store.data.items[0].data.TOTALTATSD;
		win.columns[50].setText('TAT (Second Department Interview Feedback) ' + tatmax);
		
		tatmax = store.data.items[0].data.TOTALTATSUMMARYSD;
		win.columns[51].setText('TAT (Second Department Interview TAT Summary) ' + tatmax);
		
		tatmax = store.data.items[0].data.TOTALTATHDMD;
		win.columns[55].setText('TAT (Second Department Interview to Final Interview) ' + tatmax);
		
		tatmax = store.data.items[0].data.TOTALTATMD;
		win.columns[59].setText('TAT (Final Interview Feedback/Hiring Decision) ' + tatmax);
		
		tatmax = store.data.items[0].data.TOTALTATSUMMARYMD;
		win.columns[60].setText('TAT (Final Interview TAT Summary) ' + tatmax);
		
		tatmax = store.data.items[0].data.TOTALTATJOBOFFER;
		win.columns[65].setText('TAT (Job Offer) ' + tatmax);
		
		tatmax = store.data.items[0].data.TOTALTATSUMMARYJO;
		win.columns[66].setText('TAT (Job Offer TAT Summary) ' + tatmax);
		
		tatmax = store.data.items[0].data.TOTALTATREQ;
		win.columns[71].setText('TAT (Pre-employment TAT Summary) ' + tatmax);
		
		tatmax = store.data.items[0].data.TOTALTATCONTRACT;
		win.columns[76].setText('TAT (Contract) ' + tatmax);
		
		tatmax = store.data.items[0].data.TOTALTATTOTAL;
		win.columns[79].setText('TAT (Total) ' + tatmax);
		
	},	
	
	opensettings: function(button) {
		window.open("./?bdg=RECRUITMENTSETTINGS2215E0A9AAAAEF7","_new","height=100%,width=100%,scrollbars=yes");
	},	
	
	hideshowrecord: function(sbutton, eOpts) {
		var menu0 = sbutton.menu.items.items[0].checked; //MRF Basic Information 
		var menu1 = sbutton.menu.items.items[1].checked; //Candidates 
		var menu2 = sbutton.menu.items.items[2].checked; //Initial Applicant Examination 
		var menu3 = sbutton.menu.items.items[3].checked; //HR Interview 
		var menu4 = sbutton.menu.items.items[4].checked; //Hiring Department Interview (First) 
		var menu5 = sbutton.menu.items.items[5].checked; //Hiring Department Interview (Second) 
		var menu6 = sbutton.menu.items.items[6].checked; //Hiring Department Interview (Final) 
		var menu7 = sbutton.menu.items.items[7].checked; //Job Offer 
		var menu8 = sbutton.menu.items.items[8].checked; //Pre-Employment Checklist 
		var menu9 = sbutton.menu.items.items[9].checked; //Onboarding Checklist 
		var menu10 = sbutton.menu.items.items[10].checked; //Onboarding Date 
		var menu11 = sbutton.menu.items.items[11].checked;  //All columns 
		
		var grid = sbutton.up('grid');
		Ext.suspendLayouts();
		
		if(menu11) {
			for (var i = 1; i < grid.columns.length; i++) {
				var column = grid.columns[i];
			    column.hidden = false;
			}
			Ext.resumeLayouts(true);
			var store = Ext.getStore('recruitment.mrfstatus.store');
			store.load();
			return true;
		} else {
			
		}
		
		if(menu0) {
			for (var i = 4; i < 11; i++) {
				var column = grid.columns[i];
			    column.hidden = false;
				column.locked = true;
			}
		} else {
			for (var i = 4; i < 11; i++) {
			    var column = grid.columns[i];
				column.hidden = true; 
				column.locked = true;
			}
		}
		
		if(menu1) {
			for (var i = 11; i < 21; i++) {
				var column = grid.columns[i];
			    column.hidden = false;
				column.locked = true;
			}
		} else {
			for (var i = 11; i < 21; i++) {
			    var column = grid.columns[i];
				column.hidden = true; 
				column.locked = true;
			}
		}
		
		if(menu2) {
			for (var i = 21; i < 27; i++) {
				var column = grid.columns[i];
			    column.hidden = false;
			}
		} else {
			for (var i = 21; i < 27; i++) {
			    var column = grid.columns[i];
				column.hidden = true; 
			}
		}
		
		if(menu3) {
			for (var i = 27; i < 34; i++) {
				var column = grid.columns[i];
			    column.hidden = false;
			}
		} else {
			for (var i = 27; i < 34; i++) {
			    var column = grid.columns[i];
				column.hidden = true; 
			}
		}
		
		if(menu4) {
			for (var i = 34; i < 43; i++) {
				var column = grid.columns[i];
			    column.hidden = false;
			}
		} else {
			for (var i = 34; i < 43; i++) {
			    var column = grid.columns[i];
				column.hidden = true; 
			}
		}
		
		if(menu5) {
			for (var i = 43; i < 52; i++) {
				var column = grid.columns[i];
			    column.hidden = false;
			}
		} else {
			for (var i = 43; i < 52; i++) {
			    var column = grid.columns[i];
				column.hidden = true; 
			}
		}
		
		if(menu6) {
			for (var i = 52; i < 61; i++) {
				var column = grid.columns[i];
			    column.hidden = false;
			}
		} else {
			for (var i = 52; i < 61; i++) {
			    var column = grid.columns[i];
				column.hidden = true; 
			}
		}
		
		if(menu7) {
			for (var i = 61; i < 67; i++) {
				var column = grid.columns[i];
			    column.hidden = false;
			}
		} else {
			for (var i = 61; i < 67; i++) {
			    var column = grid.columns[i];
				column.hidden = true; 
			}
		}
		
		if(menu8) {
			for (var i = 67; i < 72; i++) {
				var column = grid.columns[i];
			    column.hidden = false;
			}
		} else {
			for (var i = 67; i < 72; i++) {
			    var column = grid.columns[i];
				column.hidden = true; 
			}
		}
		
		if(menu9) {
			for (var i = 72; i < 77; i++) {
				var column = grid.columns[i];
			    column.hidden = false;
			}
		} else {
			for (var i = 72; i < 77; i++) {
			    var column = grid.columns[i];
				column.hidden = true; 
			}
		}
		
		if(menu10) {
			for (var i = 77; i < 79; i++) {
				var column = grid.columns[i];
			    column.hidden = false;
			}
		} else {
			for (var i = 77; i < 79; i++) {
			    var column = grid.columns[i];
				column.hidden = true; 
			}
		}
	
		Ext.resumeLayouts(true);
		var store = Ext.getStore('recruitment.mrfstatus.store');
		store.load();
		
	},
	
	refreshgrid: function(combobox) {
		var departmentcode = combobox.getValue();
		var store = Ext.getStore('recruitment.mrfstatus.store');
		store.proxy.extraParams.departmentcode = departmentcode;
		store.load({
			action: 'read',
			params: {
					departmentcode: departmentcode
				},
			start: 0
		});
	},
	
	sendEmailNow: function(button) {
		var win       = button.up('window');
		var subject   = win.down('textfield[name=subject]').getValue();
		var body      = win.down('htmleditor[name=body]').getValue();
		
		var gridpanel = Ext.ComponentQuery.query('mrfstatusview');
		var selectedRecord = gridpanel[0].getSelectionModel().getSelection();
		var column_text = '';
		var d_index     = '';
		var value       = '';
		
		for (var cnttb = 0; cnttb < selectedRecord.length; cnttb++) {
			
			for(var cnttc = 0; cnttc < gridpanel[0].columns.length; cnttc++) {
				column_text = gridpanel[0].columns[cnttc].text;
				d_index     = gridpanel[0].columns[cnttc].dataIndex;
				if(d_index.length == '') {
					continue;
				}
				value       = 'selectedRecord[cnttb].data.' + d_index;
				value       = eval(value);
				body        = body.replace('{'+column_text+'}', value);
				subject     = subject.replace('{'+column_text+'}', value);
			}
			
			Ext.ss.data.sendemail(selectedRecord[cnttb].data.H_EMAILADDRESS, subject, body, function(result){
		    
		    });
		}
			
		win.close();
	},
	
	emailtemplatechange: function(combo) {
		var win       = combo.up('window');
		var template = win.down('textfield[name=emailtemplate]').getValue();
		Ext.ss.lookup.getTemplatebody(template, function(result) {
			var subj = result.topics[0].subject;
			var body = result.topics[0].body;
			win.down('textfield[name=subject]').setValue(subj);
		    win.down('htmleditor[name=body]').setValue(body);
		})
		
		
	},
	
	sendEmail: function(button) {
		var grid       = button.up('panel');
		var selectedRecord = grid.getSelectionModel().getSelection();
		if(selectedRecord.length < 1) {
			Ext.Msg.show({
				title: 'No record selected!',
				msg: 'Please select a record.',
				buttons: Ext.Msg.OK,
				icon: Ext.Msg.WARNING
			});
			return true;
		}
		var emailv = Ext.widget('emailwin');
		var email = '';
		var comma = ','; 
		for (var cntt = 0; cntt < selectedRecord.length; cntt++) {
				email = email + selectedRecord[cntt].data.H_EMAILADDRESS;
				if(cntt != selectedRecord.length - 1 ) {
					email = email + comma;
				}
		}
		emailv.down('textfield[name=to]').setValue(email);
		emailv.show();
		
	},
	
	exportToExcel: function(button) {
		var win       = button.up('panel');
		var statusdisp  = win.down('displayfield[name=mrfdisp]');
		statusdisp.setValue('<h2>Exporting, please wait...</h2>');
		Ext.ss.data.gridtoexcel(function(result){
			
			if(result == "success") {
				statusdisp.setValue(' ');
				window.location.href = "./myapps/recruitment/mrfstatus/MRFStatusData.xls";
			} else {
				statusdisp.setValue(' ');
				Ext.Msg.show({
	  				title: 'Problem in exporting',
	  				msg: 'Please try again.',
	  				buttons: Ext.Msg.OK,
	  				icon: Ext.Msg.WARNING
	  			});
				return true;
			}
			
			
		});
	},

    onPanelRendered: function(gridcolumn) {
	var panel = gridcolumn.up('grid');
	var store = panel.getStore();
		var tatmax = store.data.items[0].data.TATMRFPOST;
		var htext = panel.columns[10].text;
		panel.columns[10].setText(htext + '  ' + tatmax);

    }
	
});