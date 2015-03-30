Ext.define('Form.controller.recruitment.jobposting.controller', {
    extend: 'Ext.app.Controller',
	stores: [
		'recruitment.jobposting.store',
		'recruitment.jobposting.poststore',
		'recruitment.jobposting.departmentstore'  
	],
	views: [
        'recruitment.jobposting.view'
    ],
	models: [
		'recruitment.jobposting.model',
		'recruitment.jobposting.postmodel',
		'recruitment.jobposting.departmentmodel'  
	],
	
    init: function() {
		console.log('init controller');
        this.control({
            'viewport > panel': {
                render: this.onPanelRendered
            },
			'jobposting button[action=post]': {
                click: this.postnow
            },
			'jobposting button[action=exporttoexcel]': {
                click: this.exportToExcel
            },
			'jobposting combobox[name=department]': {
				change: this.refreshgrid
			}
		
        });
    },
	
	refreshgrid: function(combobox) {
		var departmentcode = combobox.getValue();
		var store = Ext.getStore('recruitment.jobposting.store');
		store.proxy.extraParams.departmentcode = departmentcode;
		store.load({
			action: 'read',
			params: {
					departmentcode: departmentcode
				},
			start: 0
		});
	},
	
	postnow: function(button) {
		
		var win       = button.up('panel');
		var grid      = win.down('grid');
		var statusdisp  = win.down('displayfield');
		
		
		var selectedRecord = grid.getSelectionModel().getSelection();
		
		
				if(selectedRecord.length < 1) {
					statusdisp.setValue('Please select a record first.');
					Ext.Msg.show({
		  				title: 'No record selected!',
		  				msg: 'Please select a record.',
		  				buttons: Ext.Msg.OK,
		  				icon: Ext.Msg.WARNING
		  			});
					return true;
				}
		var requisitionno = '';
		var combobox  = win.down('combobox[name=posttype]');
		var type      = combobox.getValue();
		
		
		
		//post it here
		if (type) {
			var myMask = new Ext.LoadMask(grid, {msg:"Posting, please wait..."});
            myMask.show();
			for (var cntt = 0; cntt < selectedRecord.length; cntt++) {
				requisitionno = selectedRecord[cntt].data.REQUISITIONNO;
				Ext.jp.data.post(requisitionno, type, function(result){
					var themsg = 'Requisition No :' + result.topics[0].requisitionno + ' ,Type: ' + result.topics[0].type;
					statusdisp.setValue(themsg);
					myMask.hide();
					var store = Ext.getStore('recruitment.jobposting.store');
			        store.load();
				});
			}
			return true;
		} else {
			statusdisp.setValue('Please select a post type first.');
			Ext.Msg.show({
  				title: 'No post type selected!',
  				msg: 'Please select a post type.',
  				buttons: Ext.Msg.OK,
  				icon: Ext.Msg.WARNING
  			});
			return true;
		}
	},
	
	exportToExcel: function(button) {
		var win       = button.up('panel');
		var statusdisp  = win.down('displayfield');
		statusdisp.setValue('Exporting, please wait...');
		Ext.jp.data.gridtoexcel(function(result){
			
			if(result == "success") {
				statusdisp.setValue(' ');
				window.location.href = "./myapps/recruitment/jobposting/JobPostingData.xls";
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