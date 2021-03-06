var filters = {
        ftype: 'filters',
        encode: true, // json encode the filter query
        local: false,   // defaults to false (remote filtering)
	    filters: [{
            type: 'string',
            dataIndex: 'POSTEDBYIBOSE'
        }]
    };


Ext.define('Form.view.recruitment.jobposting.view', {     
	extend: 'Ext.grid.Panel',
	alias: 'widget.jobposting', 
	width: '100%',
    title: 'Job Posting',
    features: [filters],  
    multiSelect: true,
    clicksToEdit: 2,
	selModel: {
		    pruneRemoved: false
	},
	//verticalScroller: {
	   // xtype: 'paginggridscroller'
	  //}, 
	viewConfig: {
	    forceFit: false,
		trackOver: false,
	    emptyText: '<h1 style="margin:20px"> </h1>'
	  },
	 
	
	initComponent: function() {     
	    this.plugins = [
			Ext.create('Ext.grid.plugin.CellEditing', {
			    clicksToEdit: 2
    	    })
			
		];
		this.store = 'recruitment.jobposting.store';
		this.bbar = Ext.create('Ext.toolbar.Paging', {
				        store: 'recruitment.jobposting.store', 
				        displayInfo: true,
				        emptyMsg: "No topics to display"
				   });
		this.tbar = [{
			xtype: 'combobox',
			fieldLabel: 'Department',
			labelAlign: 'right',
			id: 'dptmntddd',
			name: 'department',
			editable: false,
			cls: 'field-margin',
			width: 320,
			queryMode: 'remote',
			store: 'recruitment.jobposting.departmentstore',
			displayField: 'departmentname',
			valueField: 'departmentcode'
		},{
		  	xtype: 'tbseparator'
		  },{
		  	xtype: 'combobox',
			fieldLabel: 'Post to',
			labelAlign: 'right',
			name: 'posttype',
			cls: 'field-margin',
			editable: false,
			width: 320,
			queryMode: 'local',
			store: 'recruitment.jobposting.poststore',
			displayField: 'postname',
			valueField: 'postcode'
		  },{
		  	xtype: 'tbseparator'
		  },{
		  	text: 'Post',
			action: 'post'
		  },{
		  	xtype: 'tbseparator'
		  },{
		  	text: 'Export to Excel',
			action: 'exporttoexcel'
		  },'->',
		  {
		  	xtype: 'displayfield',
			value: ' '
		  }];
		  
		this.columns =  [{
            xtype: 'rownumberer',
			locked: true,
            width: 50,
            sortable: false
	       },{  
		    header: 'Posted',
		    dataIndex: 'POSTEDBYIBOSE',
			locked: true,
			groupable: true,
			editor: {
				xtype: 'textfield'
			},
		    width: 50
		  },{
		    header: 'Requisition Number',
		    dataIndex: 'REQUISITIONNO',
			filterable: true,
		    width: 180
		  },{
		    header: 'Posted To',
		    dataIndex: 'POSTEDTO',
			filterable: true,
		    width: 200
		  },{
		    header: 'Department',
		    dataIndex: 'DEPARTMENTCODEFK',
		    width: 200,
			filterable: true
		  },{
		    header: 'Requested Position',
		    dataIndex: 'B_DESCRIPTION',
		    width: 250,
			filterable: true
		  },{
		    header: 'Date Needed',
		    dataIndex: 'DATENEEDED',
			editor: {
				xtype: 'datefield'
			},
		    width: 100,
			renderer: Ext.util.Format.dateRenderer('n/j/Y'),
			filter: {
				type: 'date',
				format: 'Y-n-j'
			}
		  },{
		    header: 'Number Needed',
		    dataIndex: 'REQUIREDNO',
		    width: 100,
			filterable: true
		  },{
		    header: 'Rank',
		    dataIndex: 'RANKCODE',
		    width: 250,
			filterable: true
		  },{
		    header: 'Reporting to',
		    dataIndex: 'REPORTINGTO',
		    width: 200,
			filterable: true
		  },{
		    header: 'Division',
		    dataIndex: 'DIVISIONCODE',
		    width: 200,
			filterable: true
		  },{
		    header: 'Project(s)',
		    dataIndex: 'PROJECTCODE',
		    width: 300,
			filterable: true
		  },{
		    header: 'Nature of Job Vacancy',
		    dataIndex: 'NATUREOFJOBVAC',
		    width: 200,
			filterable: true
		  },{
		    header: 'Replacement of (if replacement)',
		    dataIndex: 'REPLACEMENTOF',
		    width: 200,
			filterable: true
		  },{
		    header: 'Reason for replacement',
		    dataIndex: 'REPLACEMENTREASON',
		    width: 200,
			filterable: true
		  },{
		    header: 'Effective',
		    dataIndex: 'EFFECTIVE',
			renderer: Ext.util.Format.dateRenderer('n/j/Y'),
		    width: 200,
			filter: {
				type: 'date',
				format: 'Y-n-j'
			}
		  },{
		    header: 'Nature of Employment',
		    dataIndex: 'NATUREOFEMP',
		    width: 250,
			filterable: true
		  },{
		    header: 'Date From if contractual',
		    dataIndex: 'IFCONTRACTUAL',
			renderer: Ext.util.Format.dateRenderer('n/j/Y'),
		    width: 150,
			filter: {
				type: 'date',
				format: 'Y-n-j'
			}
		  },{
		    header: 'Date To if contractual',
			renderer: Ext.util.Format.dateRenderer('n/j/Y'),
		    dataIndex: 'DATETO',
		    width: 150,
			filter: {
				type: 'date',
				format: 'Y-n-j'
			}
		  },{
		    header: 'Requesitioned by',
		    dataIndex: 'REQUISITIONEDBY',
		    width: 200,
			filterable: true
		  },{
		    header: 'Date Requisition',
		    dataIndex: 'DATEREQUISITION',
			renderer: Ext.util.Format.dateRenderer('n/j/Y'),
		    width: 100,
			filter: {
				type: 'date',
				format: 'Y-n-j'
			}
		  },{
		    header: 'Brief Description of Duties',
		    dataIndex: 'BRIEFDESC',
		    width: 400,
			filterable: true
		  },{
		    header: 'Skill and experience',
		    dataIndex: 'SKILLSREQ',
		    width: 400,
			filterable: true
		  },{
		    header: 'High School Graduate',
		    dataIndex: 'EDUCATTAINMENT1',
		    width: 400,
			filterable: true
		  },{
		    header: 'Associate Degree Grad',
		    dataIndex: 'EDUCATTAINMENT2',
		    width: 400,
			filterable: true
		  },{
		    header: 'Tech or Vocational Course',
		    dataIndex: 'EDUCATTAINMENT3',
		    width: 400,
			filterable: true
		  },{
		    header: 'College Grad',
		    dataIndex: 'EDUCATTAINMENT4',
		    width: 400,
			filterable: true
		  },{
		    header: 'Master Degree Holder',
		    dataIndex: 'EDUCATTAINMENT5',
		    width: 400,
			filterable: true
		  },{
		    header: 'Degree Required',
		    dataIndex: 'DEGREEREQ',
		    width: 200,
			filterable: true
		  },{
		    header: 'Marital Status',
		    dataIndex: 'MARITALSTAT',
		    width: 100,
			filterable: true
		  },{
		    header: 'Age Preference',
		    dataIndex: 'AGE',
		    width: 100,
			filterable: true
		  },{
		    header: 'Sexual Preference',
		    dataIndex: 'SEX',
		    width: 100,
			filterable: true
		  },{
		    header: 'Date Created',
		    dataIndex: 'DATELASTUPDATE',
			renderer: Ext.util.Format.dateRenderer('n/j/Y'),
		    width: 100,
			filter: {
				type: 'date',
				format: 'Y-n-j'
			}
		  },{
		    header: 'Nationality',
		    dataIndex: 'NATIONALITY',
		    width: 100,
			filterable: true
		  },{
		    header: 'Religion',
		    dataIndex: 'RELIGION',
		    width: 150,
			filterable: true
		  },{
		    header: 'Status',
		    dataIndex: 'STATUS',
		    width: 100,
			filterable: true
		  },{
		    header: 'Source Name',
		    dataIndex: 'SOURCENAME',
		    width: 100,
			filterable: true
		  }],
		
		
		this.callParent(arguments);
	}
});
