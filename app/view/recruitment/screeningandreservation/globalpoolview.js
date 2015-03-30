var filters = {
        ftype: 'filters',
        encode: true, // json encode the filter query
        local: false,   // defaults to false (remote filtering)
	    filters: [{
            type: 'string',
            dataIndex: 'REFERENCECODE'
        }]
    };

Ext.define('Form.view.recruitment.screeningandreservation.globalpoolview', {     
	extend: 'Ext.grid.Panel',
	alias: 'widget.globalpool',     
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
	    emptyText: '<h1 style="margin:20px"></h1>'
	},
	
	initComponent: function() {     
	    this.plugins = [
			Ext.create('Ext.grid.plugin.CellEditing', {
			    clicksToEdit: 2
    	    })
			
		];
		this.store = 'recruitment.screeningandreservation.globalpoolstore';
		this.bbar = Ext.create('Ext.toolbar.Paging', {
				        store: 'recruitment.screeningandreservation.globalpoolstore', 
				        displayInfo: true,
				        emptyMsg: "No topics to display"
				   });
		this.tbar = [{
		  	text: 'Fetch Selected',
			action: 'fetch',
			cls: 'field-margin'
		  },{
		  	xtype: 'tbseparator'
		  },{
		  	text: 'View Selected',
			action: 'view',
			cls: 'field-margin'
		  },{
		  	xtype: 'tbseparator'
		  },{
		  	text: 'Release Selected',
			action: 'release',
			cls: 'field-margin'
		  },{
		  	xtype: 'tbseparator'
		  },{
		  	text: 'Export to Excel',
			action: 'toexcelglobal',
			cls: 'field-margin'
		  },'->',
		  {
		  	xtype: 'displayfield',
			name: 'gpdisp',
			value: ' '
		  }];
		  
		this.columns =  [{
            xtype: 'rownumberer',
			locked: true,
            width: 50,
            sortable: false
	       },{  
		    text: 'Company Code',
		    dataIndex: 'A_COMPANYCODE',
			locked: true,
			groupable: true,
		    width: 100
		  },{
		    text: 'Position First Priority',
		    dataIndex: 'C_DESCRIPTION',
			filterable: true,
		    width: 300
		  },{
		    text: 'Position Second Priority',
		    dataIndex: 'D_DESCRIPTION',
			filterable: true,
		    width: 300
		  },{
		    text: 'Position Third Priority',
		    dataIndex: 'E_DESCRIPTION',
		    filterable: true,
		    width: 300
		  },{
		    text: 'Expected Salary',
		    dataIndex: 'A_WORKEXPRATING',
		    width: 100,
			filterable: true
		  },{
		    text: 'Current Salary',
		    dataIndex: 'A_STARTINGSALARY',
		    width: 100,
			filterable: true
		  },{
		    text: 'Date of Application',
		    dataIndex: 'A_APPLICATIONDATE',
			editor: {
				xtype: 'datefield'
			},
		    width: 150,
			renderer: Ext.util.Format.dateRenderer('n/j/Y'),
			filter: {
				type: 'date',
				format: 'Y-n-j'
			}
		  },{
		    text: 'Reference Code',
		    dataIndex: 'A_REFERENCECODE',
		    width: 150,
			filterable: true
		  },{
		    text: 'Firstname',
		    dataIndex: 'A_FIRSTNAME',
		    width: 200,
			filterable: true
		  },{
		    text: 'Lastname',
		    dataIndex: 'A_LASTNAME',
		    width: 200,
			filterable: true
		  },{
		    text: 'Age',
		    dataIndex: 'B_AGE',
		    width: 50,
			filterable: true
		  },{
		    text: 'Gender',
		    dataIndex: 'B_SEX',
		    width: 50,
			filterable: true
		  },{
		    text: 'Civil Status',
		    dataIndex: 'B_CIVILSTATUS',
		    width: 70,
			filterable: true
		  },{
		    text: 'Citizenship',
		    dataIndex: 'B_CITIZENSHIP',
		    width: 70,
			filterable: true
		  },{
		    text: 'College School',
		    dataIndex: 'F_SCHOOLNAME',
		    width: 250,
			filterable: true
		  },{
		    text: 'Course',
		    dataIndex: 'I_DESCRIPTION',
			width: 300,
			filterable: true
		  },{
		    text: 'Is Graduate?',
		    dataIndex: 'A_COLLEGEISGRAD',
		    width: 80,
			filterable: true
		  },{
		    text: 'Post Graduate School',
		    dataIndex: 'G_SCHOOLNAME',
		    width: 250,
			filterable: true
		  },{
		    text: 'Course',
		    dataIndex: 'J_DESCRIPTION',
			width: 300,
			filterable: true
		  },{
		    text: 'Is Graduate?',
		    dataIndex: 'A_POSTGRADISGRAD',
		    width: 80,
			filterable: true
		  },{
		    text: 'Vocational School',
		    dataIndex: 'H_SCHOOLNAME',
		    width: 250,
			filterable: true
		  },{
		    text: 'Course',
		    dataIndex: 'K_DESCRIPTION',
			width: 300,
			filterable: true
		  },{
		    text: 'Is Graduate?',
		    dataIndex: 'A_VOCATIONALISGRAD',
		    width: 80,
			filterable: true
		  },{
		    text: 'Present Address',
		    dataIndex: 'B_CONTACTADDRESS',
		    width: 400,
			filterable: true
		  }]
		
		
		this.callParent(arguments);
	}
});
