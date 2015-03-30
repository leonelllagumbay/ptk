var filters = {
        ftype: 'filters',
        encode: true, 
        local: false,  
	    filters: [{
            type: 'string',
            dataIndex: 'G.REQUISITIONNO'
        }]
    };


Ext.define('Form.view.recruitment.screeningandreservation.localpoolview', {     
	extend: 'Ext.grid.Panel',
	alias: 'widget.localpool',    
	width: '100%', 
    features: [filters],  
    multiSelect: true,
    clicksToEdit: 2,
	selModel: {
		    pruneRemoved: false
	},
	viewConfig: {
	    forceFit: false,
		trackOver: false,
	    emptyText: '<h1 style="margin:20px">No matching results</h1>'
	},
	
	
	initComponent: function() {     
	    this.plugins = [
			Ext.create('Ext.grid.plugin.CellEditing', {
			    clicksToEdit: 2
    	    })
			
		];
		this.store = 'recruitment.screeningandreservation.localpoolstore';
		this.bbar = Ext.create('Ext.toolbar.Paging', {
				        store: 'recruitment.screeningandreservation.localpoolstore', 
				        displayInfo: true,
				        emptyMsg: "No topics to display"
				   });
		this.tbar = [{
		  	text: 'Revert Selected',
			cls: 'field-margin',
			action: 'revert'
		  },{
		  	xtype: 'tbseparator'
		  },{
		  	text: 'View Selected',
			cls: 'field-margin',
			action: 'viewlocal'
		  },{
		  	xtype: 'tbseparator'
		  },{
		  	text: 'Reserve Selected',
			cls: 'field-margin',
			action: 'reservesel'
		  },{
		  	xtype: 'tbseparator'
		  },{
		  	text: 'Unreserve Selected',
			cls: 'field-margin',
			action: 'unreservesel'
		  },{
		  	xtype: 'tbseparator'
		  },{
		  	text: 'Send e-mail',
			cls: 'field-margin',
			action: 'sendemail'
		  },{
		  	xtype: 'tbseparator'
		  },{
		  	text: 'Export to Excel',
			cls: 'field-margin',
			action: 'toexcellocal'
		  },'->',
		  {
		  	xtype: 'displayfield',
			name: 'localpooldisplay',
			id: 'localpooldispddd',
			value: ' '
		  }];
		 
		this.columns =  [{
            xtype: 'rownumberer',
			locked: true,
            width: 50,
            sortable: false
	       },{  
		    xtype: 'checkcolumn',
		    text: 'Reserved',
		    dataIndex: 'A_RESERVED',
			filterable: true,
		    width: 80
		  },{
		    text: 'Requisition Number',
		    dataIndex: 'G_REQUISITIONNO',
			editor: 'textfield',
		    width: 170
		  },{
		    text: 'Position',
		    dataIndex: 'K_DESCRIPTION',
			editor: 'textfield',
			filterable: true,
		    width: 300
		  },{
		    text: 'First Name',
		    dataIndex: 'A_FIRSTNAME',
			editor: 'textfield',
		    width: 200,
			filterable: true
		  },{
		    text: 'Last Name',
		    dataIndex: 'A_LASTNAME',
			editor: 'textfield',
		    width: 150,
			filterable: true
		  },{
		    text: 'Applicant Number',
		    dataIndex: 'A_APPLICANTNUMBER',
			editor: 'textfield',
		    width: 200,
			filterable: true
		  },{
		    text: 'Contact Number',
		    dataIndex: 'H_CONTACTCELLNUMBER',
			editor: 'textfield',
		    width: 100,
			filterable: true
		  },{
		    text: 'e-mail Address',
		    dataIndex: 'H_EMAILADDRESS',
			editor: 'textfield',
		    width: 200,
			filterable: true
		  },{
		    text: 'Source',
		    dataIndex: 'A_SOURCE',
			editor: 'textfield',
		    width: 120,
			filterable: true
		  },{
		    text: 'Date of Application',
		    dataIndex: 'A_APPLICATIONDATE',
			editor: {
				xtype: 'datefield'
			},
		    width: 120,
			renderer: Ext.util.Format.dateRenderer('n/j/Y'),
			filter: {
				type: 'date',
				format: 'Y-n-j'
			}
		  },{
		    text: 'Date Pre-Screen',
		    dataIndex: 'G_DATEPRESCREEN',
			editor: {
				xtype: 'datefield'
			},
		    width: 120,
			renderer: Ext.util.Format.dateRenderer('n/j/Y'),
			filter: {
				type: 'date',
				format: 'Y-n-j'
			}
		  },{
		    text: 'Date of Invite Send Out',
		    dataIndex: 'G_DATESENDOUT',
			editor: {
				xtype: 'datefield'
			},
		    width: 140,
			renderer: Ext.util.Format.dateRenderer('n/j/Y'),
			filter: {
				type: 'date',
				format: 'Y-n-j'
			}
		  },{
		    text: 'GUID',
		    dataIndex: 'A_GUID',
			hidden: true
		  }]
		
		this.callParent(arguments);
	}
});
