Ext.define('Form.controller.recruitment.screeningandreservation.controller', {
    extend: 'Ext.app.Controller',
	stores: [
		'recruitment.screeningandreservation.globalpoolstore',
		'recruitment.screeningandreservation.positionstore',
		'recruitment.screeningandreservation.departmentstore',
		'recruitment.screeningandreservation.mrfstore',
		'recruitment.screeningandreservation.localpoolstore',
		'recruitment.screeningandreservation.templatestore'
	],
	views: [
        'recruitment.screeningandreservation.globalpoolview',
		'recruitment.screeningandreservation.mrfview',
		'recruitment.screeningandreservation.localpoolview',
		'recruitment.screeningandreservation.emailwindow'
    ],
	models: [
		'recruitment.screeningandreservation.globalpoolmodel',
		'recruitment.screeningandreservation.positionmodel',
		'recruitment.screeningandreservation.departmentmodel',
		'recruitment.screeningandreservation.mrfmodel',
		'recruitment.screeningandreservation.localpoolmodel',
		'recruitment.screeningandreservation.templatemodel'
	],
	
    init: function() {
		console.log('init controller');
        this.control({
            //'viewport > panel': {
              //  render: this.onPanelRendered
            //},
			'globalpool button[action=fetch]': {
                click: this.fetch
            },
			'globalpool button[action=view]': {
                click: this.viewrecords
            },
			'globalpool button[action=release]': {
                click: this.release
            },
			'globalpool button[action=toexcelglobal]': {
                click: this.exportToExcel
            },
			'mrfdataview combobox[name=department]': {
				change: this.refreshgrid
			},
			'mrfdataview': {
				select: this.mrfselect
			},
			'localpool button[action=revert]': {
                click: this.revert
            },
			'localpool checkcolumn': {
				checkchange: this.reserve
			},
			'localpool button[action=reservesel]': {
				click: this.reservesel
			},
			'localpool button[action=unreservesel]': {
				click: this.unreservesel
			},
			'localpool button[action=viewlocal]': {
                click: this.viewlocalrecords
            },
			'localpool button[action=toexcellocal]': {
                click: this.exportToExcelLocal
            },
			'localpool button[action=sendemail]': {
                click: this.sendEmail
            },
			'emailwin combobox[name=emailtemplate]': {
				change: this.emailtemplatechange
			},
			'emailwin button[name=sendemailbutton]': {
				click: this.sendEmailNow  
			}
		
        });
    },
	
	sendEmailNow: function(button) {
		var win       = button.up('window');
		var subject   = win.down('textfield[name=subject]').getValue();
		var body      = win.down('htmleditor[name=body]').getValue();
		
		var gridpanel = Ext.ComponentQuery.query('localpool');
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
		        console.log(result);
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
	
	viewlocalrecords: function(button) {
		var win       = button.up('panel');
		var grid      = win.down('grid'); 
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
		var guuid = '';
		var comma = '~'; 
		for (var cntt = 0; cntt < selectedRecord.length; cntt++) {
				guuid = guuid + selectedRecord[cntt].data.A_GUID + comma;
		}
		window.open('./myapps/recruitment/screeningandreservation/viewlocalresume.cfm?guuid=' + guuid, "_blank", "fullscreen=yes");   
		return true;
	},
	
	reserve: function(thiss, rowIndex, checked, eOpts ) {
		var grid       = thiss.up('panel');
		var record     = grid.getSelectionModel().getSelection()[0];
		var requisitionno = Ext.getCmp('mrfdisppp').getValue();
		
		if(requisitionno.length < 3) {
			Ext.Msg.show({
  				title: 'No MRF selected!',
  				msg: 'Please select an MRF.',
  				buttons: Ext.Msg.OK,
  				icon: Ext.Msg.WARNING
  			});
			return true;
		}
		
		var applicantnumber = record.data.A_APPLICANTNUMBER;
		if(record.length < 1) {
			Ext.Msg.show({
				title: 'No record selected!',
				msg: 'Please select a record.',
				buttons: Ext.Msg.OK,
				icon: Ext.Msg.WARNING
			});
			return true;
		}
		if (checked) {
			Ext.ss.data.reserve(applicantnumber, requisitionno, function(result){
				record.commit();
			});
		} else {
			Ext.ss.data.unreserve(applicantnumber, function(result){
				record.commit();
			});
		}
	},
	
	reservesel: function(button) {
		var grid       = button.up('panel');
		var record     = grid.getSelectionModel().getSelection();
		var requisitionno = Ext.getCmp('mrfdisppp').getValue();
		
		if(requisitionno.length < 3) {
			Ext.Msg.show({
  				title: 'No MRF selected!',
  				msg: 'Please select an MRF.',
  				buttons: Ext.Msg.OK,
  				icon: Ext.Msg.WARNING
  			});
			return true;
		}
		
		if(record.length < 1) {
			Ext.Msg.show({
				title: 'No record selected!',
				msg: 'Please select a record.',
				buttons: Ext.Msg.OK,
				icon: Ext.Msg.WARNING
			});
			return true;
		}
		var myMask = new Ext.LoadMask(grid, {msg:"Reserving, please wait..."});
        myMask.show();
		var appnum = '';
		var comma = '~';
		for (var cntt = 0; cntt < record.length; cntt++) {
			var ischeck =  record[cntt].data.A_RESERVED;
			if (ischeck == '0') {
				appnum = appnum + record[cntt].data.A_APPLICANTNUMBER + comma;
			}
		}
		Ext.ss.data.reserve(appnum, requisitionno, function(result){
			console.log(result);
			myMask.hide();
			var store = Ext.getStore('recruitment.screeningandreservation.localpoolstore');
			store.load();
		});
		
	},
	
	unreservesel: function(button) {
		var grid       = button.up('panel');
		var record     = grid.getSelectionModel().getSelection();
		if(record.length < 1) {
			Ext.Msg.show({
  				title: 'No record selected!',
  				msg: 'Please select a record.',
  				buttons: Ext.Msg.OK,
  				icon: Ext.Msg.WARNING
  			});
			return true;
		}
		var myMask = new Ext.LoadMask(grid, {msg:"Unreserving, please wait..."});
        myMask.show();
		var appnum = '';
		var comma = '~';
		for (var cntt = 0; cntt < record.length; cntt++) {
			var ischeck =  record[cntt].data.A_RESERVED;
			if (ischeck == '1') {
				appnum = appnum + record[cntt].data.A_APPLICANTNUMBER + comma;
			}
		}
		Ext.ss.data.unreserve(appnum, function(result){
			myMask.hide();
			var store = Ext.getStore('recruitment.screeningandreservation.localpoolstore');
			store.load();
		});
	},
	
	revert: function(button) {
		
		var btn = confirm('You are reverting an applicant that has processed records. Would you like to continue?');
		if(!btn) {
			return false;
		}
		/*
		Ext.Msg.show({
		     title:'Revert?',
		     msg: 'You are reverting an applicant that has processed records. Would you like to continue?',
		     buttons: Ext.Msg.YESNOCANCEL,
		     icon: Ext.Msg.QUESTION,
			 fn: function(btn) {
			 	if(btn != 'yes') {
					var btn = btn;
				}
			 }
		});
		*/
		
		var win       = button.up('panel');
		var grid      = win.down('grid'); 
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
		var myMask = new Ext.LoadMask(grid, {msg:"Reverting, please wait..."});
        myMask.show();		
		var guidd = '';
		var comma = '~';
		
			for (var cntt = 0; cntt < selectedRecord.length; cntt++) {
				guidd = guidd + selectedRecord[cntt].data.A_GUID + comma;
			}
				Ext.ss.revert.revert(guidd, function(result){
					console.log(result);
					myMask.hide();	
					var store = Ext.getStore('recruitment.screeningandreservation.localpoolstore');
						store.load();
					var storeb = Ext.getStore('recruitment.screeningandreservation.globalpoolstore');
						storeb.load();
				});
			
			return true;
	},
	
	mrfselect: function(thiss, record, index, eOpts) {
		var departmentcode = record.data.DEPARTMENTCODE;
		var requisitionno  = record.data.REQUISITIONNO;
		
		var dispcomp = Ext.getCmp('localpooldispddd'); //Please other technique to get to local view disp than using Ext.getCmp
		var dispthis = Ext.getCmp('mrfdisppp');
		dispcomp.setValue('<h2>' + requisitionno + '</h2>');
		dispthis.setValue(requisitionno); //without h2 prefix and suffix 
		var store = Ext.getStore('recruitment.screeningandreservation.localpoolstore');
		store.proxy.extraParams.requisitionno = requisitionno;
		store.load({
			action: 'read',
			params: {
					requisitionno: requisitionno
				},
			start: 0
		});
		//var lview = Ext.widget('localpool'); 
		

	},

	refreshgrid: function(combobox) {
		var departmentcode = combobox.getValue();
		var store = Ext.getStore('recruitment.screeningandreservation.mrfstore');
		store.proxy.extraParams.departmentcode = departmentcode;
		store.load({
			action: 'read',
			params: {
					departmentcode: departmentcode
				},
			start: 0
		});
	},
	
	release: function(button) {
		
		var btn = confirm('You are releasing an applicant. Would you like to continue?');
		if(!btn) {
			return false;
		}
		
		var win       = button.up('panel');
		var grid      = win.down('grid'); 
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
					
		var referencecode = '';
		var comma = '~'; 
		for (var cntt = 0; cntt < selectedRecord.length; cntt++) {
			if(selectedRecord[cntt].data.A_COMPANYCODE.length != "") 
			{
				referencecode = referencecode + selectedRecord[cntt].data.A_REFERENCECODE + comma;
			}
		}
		if(referencecode.length != "")
		{
			var myMask = new Ext.LoadMask(grid, {msg:"Releasing, please wait..."});
        	myMask.show();
			Ext.ss.data.release(referencecode, function(result){
				myMask.hide();	
				var store = Ext.getStore('recruitment.screeningandreservation.globalpoolstore');
				store.load();
			});
		}
	},
	
	viewrecords: function(button) {
		var win       = button.up('panel');
		var grid      = win.down('grid'); 
		
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
		var referencecode = '';
		var comma = '~'; 
		for (var cntt = 0; cntt < selectedRecord.length; cntt++) {
				referencecode = referencecode + selectedRecord[cntt].data.A_REFERENCECODE + comma;
		}
		window.open('./myapps/recruitment/screeningandreservation/viewgrgpool.cfm?refnum=' + referencecode, "_blank", "fullscreen=yes");   
		return true;
	},
	
	fetch: function(button) {
		var win       = button.up('panel');
		var grid      = win.down('grid'); 
		
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
		var myMask = new Ext.LoadMask(grid, {msg:"Fetching, please wait..."});
        myMask.show();	
		var referencecode = '';
		var comma = '~';
		
		for (var cntt = 0; cntt < selectedRecord.length; cntt++) {
			referencecode = referencecode + selectedRecord[cntt].data.A_REFERENCECODE + comma;
		}
			Ext.ss.globalpool.fetch(referencecode, function(result){
				console.log(result);
				myMask.hide();	
				var store = Ext.getStore('recruitment.screeningandreservation.globalpoolstore');
					store.load();
				var storeb = Ext.getStore('recruitment.screeningandreservation.localpoolstore');
					storeb.load();
			});
		return true;
	},
	
	exportToExcel: function(button) {
		var win       = button.up('panel');
		var statusdisp  = win.down('displayfield[name=gpdisp]');
		statusdisp.setValue('<h2>Exporting, please wait...</h2>');
		Ext.ss.data.gridtoexcel(function(result){
			
			if(result == "success") {
				statusdisp.setValue(' ');
				window.location.href = "./myapps/recruitment/screeningandreservation/Globalpooldata.xls"; 
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

	exportToExcelLocal: function(button) {
		var win       = button.up('panel');
		var statusdisp  = win.down('displayfield[name=localpooldisplay]');
		statusdisp.setValue('<h2>Exporting, please wait...</h2>');
		Ext.ss.data.gridtoexcellocal(function(result){
			
			if(result == "success") {
				statusdisp.setValue(' ');
				window.location.href = "./myapps/recruitment/screeningandreservation/Localpooldata.xls"; 
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

    onPanelRendered: function() {
        console.log('The panel was rendered');
    }
	
});