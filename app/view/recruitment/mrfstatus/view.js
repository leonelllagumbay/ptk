Ext.define('Form.view.recruitment.mrfstatus.view', {     
	extend: 'Ext.grid.Panel',
	alias: 'widget.mrfstatusview', 
	width: '100%',
    title: 'MRF Status', 
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
	    this.store = 'recruitment.mrfstatus.store'; 
	    this.features = [{
			ftype: 'filters',
			encode: true, // json encode the filter query
			local: false, // defaults to false (remote filtering)
			filters: [{
				type: 'string',
				dataIndex: 'A_APPLICANTNUMBER'
			}]
		}];
		this.bbar = Ext.create('Ext.toolbar.Paging', {
				        store: 'recruitment.mrfstatus.store', 
				        displayInfo: true,
				        emptyMsg: "No topics to display"
				   });
		this.tbar = [{
				xtype: 'combobox',
				fieldLabel: 'Department',
				id: 'dptmntddd',
				name: 'department',
				editable: false,
				cls: 'field-margin',
				width: 320,
				queryMode: 'remote',
				store: 'recruitment.mrfstatus.departmentstore',
				displayField: 'departmentname',
				valueField: 'departmentcode'
		  	},{
		  		xtype: 'tbseparator'
		    },{
		  		xtype: 'splitbutton',
				text: 'Show',
				name: 'menuprocess',
		    	menu: {
		        id: 'view-type-menu',
		        items: [{
					xtype: 'menucheckitem',
		            text: 'MRF Basic Information',
					cls: 'white-color',
		            checked: false
		        },{
					xtype: 'menucheckitem',
					cls: 'is-color',
		            text: 'Candidates'
		        },{
					xtype: 'menucheckitem',
		            text: 'Initial Applicant Examination',
					cls: 'dh-color',
					checked: false
		        },{
					xtype: 'menucheckitem',
		            text: 'HR Interview',
					cls: 'sun-color',
					checked: false
		        },{
					xtype: 'menucheckitem',
		            text: 'Hiring Department Interview (First)',
					cls: 'globe-color',
					checked: false
		        },{
					xtype: 'menucheckitem',
		            text: 'Hiring Department Interview (Second)',
					cls: 'benefits-color',
					checked: false
		        },{
					xtype: 'menucheckitem',
		            text: 'Hiring Department Interview (Final)',
					cls: 'audit-color',
					checked: false
		        },{
					xtype: 'menucheckitem',
		            text: 'Job Offer',
					cls: 'auditb-color',
					checked: false
		        },{
					xtype: 'menucheckitem',
		            text: 'Pre-Employment Checklist',
					cls: 'it-color',
					checked: false
		        },{
					xtype: 'menucheckitem',
		            text: 'Contract',
					cls: 'acct-color',
					checked: false
		        },{
					xtype: 'menucheckitem',
		            text: 'Onboarding Checklist',
					cls: 'white-color',
					checked: false
		        },{
					xtype: 'menucheckitem',
					text: 'All Columns',
					checked: true
		        }]
		    }
		  },{
		  	xtype: 'tbseparator'
		  },{
		  	text: 'Send e-mail',
			action: 'sendemail'
		  },{
		  	xtype: 'tbseparator'
		  },{
		  	text: 'Display maximum TAT',
			action: 'tatmax'
		  },{
		  	xtype: 'tbseparator'
		  },{
		  	text: 'Settings',
			action: 'settings'
		  },{
		  	xtype: 'tbseparator'
		  },{
		  	text: 'Export to Excel',
			action: 'exporttoexcel'
		  },'->',
		  {
		  	xtype: 'displayfield',
		  	name: 'mrfdisp',
			value: ' '
		  }];
		  
		this.columns =  [{
            xtype: 'rownumberer',
			name: 'rownum',
			locked: true,
            width: 50,
            sortable: false
	       },{  
		    text: 'Requisition No.',
		    dataIndex: 'G_REQUISITIONNO',
			name: 'grequisition',
			locked: true,
			filterable: true,
			tdCls: 'white-color',
		    width: 140
		  },{  
		    text: 'First Name',
		    dataIndex: 'A_FIRSTNAME',
			filterable: true,
			locked: true,
		    width: 100
		  },{  
		    text: 'Last Name',
		    dataIndex: 'A_LASTNAME',
			filterable: true,
			locked: true,
		    width: 150
		  },{  
		    text: 'Position',
		    dataIndex: 'Z_DESCRIPTION',  
			filterable: true,
			tdCls: 'white-color',
		    width: 200
		  },{  
		    text: 'Hiring Department',
		    dataIndex: 'I_DEPARTMENTCODE',
			filterable: true,
			tdCls: 'white-color',
		    width: 200
		  },{  
		    text: 'Division',
		    dataIndex: 'I_DIVISIONCODE',
			filterable: true,
			tdCls: 'white-color',
		    width: 200
		  },{
		    text: 'MRF Date Received',
		    dataIndex: 'I_DATELASTUPDATE',
			tdCls: 'white-color',	
		    width: 150,
			renderer: Ext.util.Format.dateRenderer('n/j/Y'),
			filter: {
				type: 'date',
				format: 'Y-n-j'
			}
		  },{
		    text: 'Posting Date',
		    dataIndex: 'I_DATEACTIONWASDONE',
			tdCls: 'white-color',	
		    width: 150,
			renderer: Ext.util.Format.dateRenderer('n/j/Y'),
			filter: {
				type: 'date',
				format: 'Y-n-j'
			}
		  },{  
		    text: 'Requisitioner',
		    dataIndex: 'I_REQUISITIONEDBY',
			filterable: true,
			tdCls: 'white-color',
		    width: 200
		  },{  
		    text: 'TAT (MRF to Posting)',
		    dataIndex: 'TATMRFPOST',
			filterable: true,
			tdCls: 'white-color',
		    width: 200,
			renderer: function(value, metaData, record) {
				var maxtat = record.data.TOTALTATMRFPOST;
				if(value >= maxtat) {
					metaData.style = 'background-color: #FF0000;';
				}
				return value;
			}
		  },{  
		    text: 'Applicant Number',
		    dataIndex: 'A_APPLICANTNUMBER',
			filterable: true,
			tdCls: 'is-color',
		    width: 200 
		  },{  
		    text: 'Contact No.',
		    dataIndex: 'H_CONTACTCELLNUMBER',
			filterable: true,
			tdCls: 'is-color',
		    width: 200
		  },{  
		    text: 'e-mail Address',
		    dataIndex: 'H_EMAILADDRESS',
			filterable: true,
			tdCls: 'is-color',
		    width: 250
		  },{  
		    text: 'Source',
		    dataIndex: 'A_SOURCE',
			filterable: true,
			tdCls: 'is-color',		
		    width: 200
		  },{
		    text: 'Date of Application',
		    dataIndex: 'A_APPLICATIONDATE',
			tdCls: 'is-color',	
		    width: 150,
			renderer: Ext.util.Format.dateRenderer('n/j/Y'),
			filter: {
				type: 'date',
				format: 'Y-n-j'
			}
		  },{
		    text: 'Sourcing Date',
		    dataIndex: 'A_RECDATECREATED',
			tdCls: 'is-color',	
		    width: 150,
			renderer: Ext.util.Format.dateRenderer('n/j/Y'),
			filter: {
				type: 'date',
				format: 'Y-n-j'
			}
		  },{  
		    text: 'TAT (Sourcing)',
			tdCls: 'is-color',	
		    dataIndex: 'TATSOURCING',
			filterable: true,
		    width: 200,
			renderer: function(value, metaData, record) {
				var maxtat = record.data.TOTALTATSOURCING;
				if(value >= maxtat) {
					metaData.style = 'background-color: #FF0000;';
				}
				return value;
			}
		  },{
		    text: 'Date Pre-Screened',
		    dataIndex: 'G_DATEPRESCREEN',
			tdCls: 'is-color',	
		    width: 150,
			renderer: Ext.util.Format.dateRenderer('n/j/Y'),
			filter: {
				type: 'date',
				format: 'Y-n-j'
			}
		  },{
		    text: 'Date of Invite Send-out',
		    dataIndex: 'G_DATESENDOUT',
			tdCls: 'is-color',	
		    width: 150,
			renderer: Ext.util.Format.dateRenderer('n/j/Y'),
			filter: {
				type: 'date',
				format: 'Y-n-j'
			}
		  },{  
		    text: 'TAT (Pre-screen to Invite)',
			tdCls: 'is-color',	
		    dataIndex: 'TATPRESCREENINVITE',
			filterable: true,
		    width: 200,
			renderer: function(value, metaData, record) {
				var maxtat = record.data.TOTALTATPRESCREENINVITE;
				if(value >= maxtat) {
					metaData.style = 'background-color: #FF0000;';
				}
				return value;
			}
		  },{
		    text: 'Date of Exam',
		    dataIndex: 'B_EXAMSCHEDDATE',
			tdCls: 'dh-color',	
		    width: 150,
			renderer: Ext.util.Format.dateRenderer('n/j/Y'),
			filter: {
				type: 'date',
				format: 'Y-n-j'
			}
		  },{  
		    text: 'Status A',
		    dataIndex: 'B_STATUS',
			tdCls: 'dh-color',	
			filterable: true,
		    width: 200
		  },{  
		    text: 'Comments A',
		    dataIndex: 'B_COMMENTS',
			tdCls: 'dh-color',	
			filterable: true,
		    width: 200
		  },{  
		    text: 'Is Approved?',
		    dataIndex: 'B_APPROVED',
			tdCls: 'dh-color',	
			filterable: true,
		    width: 200
		  },{  
		    text: 'TAT (Exam to HR Interview)',
		    dataIndex: 'TATEXAMHRINT',
			filterable: true,
			tdCls: 'dh-color',	
		    width: 200,
			renderer: function(value, metaData, record) {
				var maxtat = record.data.TOTALTATEXAMHRINT;
				if(value >= maxtat) {
					metaData.style = 'background-color: #FF0000;';
				}
				return value;
			}
		  },{  
		    text: 'TAT Summary',
		    dataIndex: 'TATSUMMARYSC',
			filterable: true,
			tdCls: 'dh-color',	
		    width: 200,
			renderer: function(value, metaData, record) {
				var maxtat = record.data.TOTALTATSUMMARYSC;
				if(value >= maxtat) {
					metaData.style = 'background-color: #FF0000;';
				}
				return value;
			}
		  },{
		    text: 'Date of HR Interview',
		    dataIndex: 'C_INTERVIEWDATE',
		    width: 150,
			tdCls: 'sun-color',	
			renderer: Ext.util.Format.dateRenderer('n/j/Y'),
			filter: {
				type: 'date',
				format: 'Y-n-j'
			}
		  },{  
		    text: 'Interviewer B',
		    dataIndex: 'C_INTERVIEWER',
			filterable: true,
			tdCls: 'sun-color',	
		    width: 200
		  },{  
		    text: 'Status B',
		    dataIndex: 'C_STATUS',
			filterable: true,
			tdCls: 'sun-color',	
		    width: 200
		  },{  
		    text: 'Comments B',
		    dataIndex: 'C_COMMENTS',
			filterable: true,
			tdCls: 'sun-color',	
		    width: 200
		  },{
		    text: 'Date of Feedback',
		    dataIndex: 'C_FEEDBACKDATE',
		    width: 150,
			tdCls: 'sun-color',	
			renderer: Ext.util.Format.dateRenderer('n/j/Y'),
			filter: {
				type: 'date',
				format: 'Y-n-j'
			}
		  },{  
		    text: 'Is Approved?',
		    dataIndex: 'C_APPROVED',
			filterable: true,
			tdCls: 'sun-color',	
		    width: 200
		  },{  
		    text: 'TAT (HR Interview to Feedback)',
		    dataIndex: 'TATHRFEEDBACK',
			filterable: true,
			tdCls: 'sun-color',	
		    width: 210,
			renderer: function(value, metaData, record) {
				var maxtat = record.data.TOTALTATHRFEEDBACK;
				if(value >= maxtat) {
					metaData.style = 'background-color: #FF0000;';
				}
				return value;
			}
		  },{
		    text: 'Date of First Department Interview',
		    dataIndex: 'K_INTERVIEWDATE',
		    width: 200,
			tdCls: 'globe-color',	
			renderer: Ext.util.Format.dateRenderer('n/j/Y'),
			filter: {
				type: 'date',
				format: 'Y-n-j'
			}
		  },{
		    text: 'Date of Actual First Department Interview',
		    dataIndex: 'K_DATEACTUALINTERVIEW',
		    width: 220,
			tdCls: 'globe-color',
			renderer: Ext.util.Format.dateRenderer('n/j/Y'),
			filter: {
				type: 'date',
				format: 'Y-n-j'
			}
		  },{  
		    text: 'Interviewer C',
		    dataIndex: 'K_INTERVIEWER',
			filterable: true,
			tdCls: 'globe-color',
		    width: 200
		  },{  
		    text: 'TAT (Feedback of HR interview to First Department Interview)',
		    dataIndex: 'TATHDFD',
			filterable: true,
			tdCls: 'globe-color',
		    width: 350,
			renderer: function(value, metaData, record) {
				var maxtat = record.data.TOTALTATHDFD;
				if(value >= maxtat) {
					metaData.style = 'background-color: #FF0000;';
				}
				return value;
			}
		  },{  
		    text: 'Status C',
		    dataIndex: 'K_STATUS',
			filterable: true,
			tdCls: 'globe-color',
		    width: 200
		  },{  
		    text: 'Comments C',
		    dataIndex: 'K_COMMENTS',
			filterable: true,
			tdCls: 'globe-color',
		    width: 200
		  },{
		    text: 'Date of Feedback from Hiring Department',
		    dataIndex: 'K_FEEDBACKDATE',
		    width: 280,
			tdCls: 'globe-color',
			renderer: Ext.util.Format.dateRenderer('n/j/Y'),
			filter: {
				type: 'date',
				format: 'Y-n-j'
			}
		  },{  
		    text: 'TAT (First Department Interview Feedback)',
		    dataIndex: 'TATFD',
			filterable: true,
			tdCls: 'globe-color',
		    width: 300,
			renderer: function(value, metaData, record) {
				var maxtat = record.data.TOTALTATFD;
				if(value >= maxtat) {
					metaData.style = 'background-color: #FF0000;';
				}
				return value;
			}
		  },{  
		    text: 'TAT (First Department Interview TAT Summary)',
		    dataIndex: 'TATSUMMARYFD',
			filterable: true,
			tdCls: 'globe-color',
		    width: 300,
			renderer: function(value, metaData, record) {
				var maxtat = record.data.TOTALTATSUMMARYFD;
				if(value >= maxtat) {
					metaData.style = 'background-color: #FF0000;';
				}
				return value;
			}
		  },{
		    text: 'Date of 2nd Dept Interview',
		    dataIndex: 'L_INTERVIEWDATE',
		    width: 200,
			tdCls: 'benefits-color',
			renderer: Ext.util.Format.dateRenderer('n/j/Y'),
			filter: {
				type: 'date',
				format: 'Y-n-j'
			}
		  },{
		    text: 'Date of Actual 2nd Dept Interview',
		    dataIndex: 'L_DATEACTUALINTERVIEW',
		    width: 250,
			tdCls: 'benefits-color',
			renderer: Ext.util.Format.dateRenderer('n/j/Y'),
			filter: {
				type: 'date',
				format: 'Y-n-j'
			}
		  },{  
		    text: 'Interviewer D',
		    dataIndex: 'L_INTERVIEWER',
			filterable: true,
			tdCls: 'benefits-color',
		    width: 200
		  },{  
		    text: 'TAT (Feedback of First to Second Department Interview)',
		    dataIndex: 'TATHDSD',
			filterable: true,
			tdCls: 'benefits-color',
		    width: 360,
			renderer: function(value, metaData, record) {
				var maxtat = record.data.TOTALTATHDSD;
				if(value >= maxtat) {
					metaData.style = 'background-color: #FF0000;';
				}
				return value;
			}
		  },{  
		    text: 'Status D',
		    dataIndex: 'L_STATUS',
			filterable: true,
			tdCls: 'benefits-color',
		    width: 200
		  },{  
		    text: 'Comments D',
		    dataIndex: 'L_COMMENTS',
			tdCls: 'benefits-color',
			filterable: true,
		    width: 200
		  },{
		    text: 'Date of Feedback from Hiring Department',
		    dataIndex: 'L_FEEDBACKDATE',
		    width: 300,
			tdCls: 'benefits-color',
			renderer: Ext.util.Format.dateRenderer('n/j/Y'),
			filter: {
				type: 'date',
				format: 'Y-n-j'
			}
		  },{  
		    text: 'TAT (Second Department Interview Feedback)',
		    dataIndex: 'TATSD',
			filterable: true,
			tdCls: 'benefits-color',
		    width: 300,
			renderer: function(value, metaData, record) {
				var maxtat = record.data.TOTALTATSD;
				if(value >= maxtat) {
					metaData.style = 'background-color: #FF0000;';
				}
				return value;
			}
		  },{  
		    text: 'TAT (Second Department Interview TAT Summary)',
		    dataIndex: 'TATSUMMARYSD',
			filterable: true,
			tdCls: 'benefits-color',
		    width: 300,
			renderer: function(value, metaData, record) {
				var maxtat = record.data.TOTALTATSUMMARYSD;
				if(value >= maxtat) {
					metaData.style = 'background-color: #FF0000;';
				}
				return value;
			}
		  },{
		    text: 'Date of Final Interview',
		    dataIndex: 'M_INTERVIEWDATE',
		    width: 200,
			tdCls: 'audit-color',
			renderer: Ext.util.Format.dateRenderer('n/j/Y'),
			filter: {
				type: 'date',
				format: 'Y-n-j'
			}
		  },{
		    text: 'Date of Actual Final Interview',
		    dataIndex: 'M_DATEACTUALINTERVIEW',
		    width: 200,
			tdCls: 'audit-color',
			renderer: Ext.util.Format.dateRenderer('n/j/Y'),
			filter: {
				type: 'date',
				format: 'Y-n-j'
			}
		  },{  
		    text: 'Interviewer E',
		    dataIndex: 'M_INTERVIEWER',
			filterable: true,
			tdCls: 'audit-color',
		    width: 200
		  },{  
		    text: 'TAT (Second Department Interview to Final Interview)',
		    dataIndex: 'TATHDMD',
			filterable: true,
			tdCls: 'audit-color',
		    width: 300,
			renderer: function(value, metaData, record) {
				var maxtat = record.data.TOTALTATHDMD;
				if(value >= maxtat) {
					metaData.style = 'background-color: #FF0000;';
				}
				return value;
			}
		  },{  
		    text: 'Status E',
		    dataIndex: 'M_STATUS',
			filterable: true,
			tdCls: 'audit-color',
		    width: 200
		  },{  
		    text: 'Comments E',
		    dataIndex: 'M_COMMENTS',
			filterable: true,
			tdCls: 'audit-color',
		    width: 200
		  },{
		    text: 'Date of Final Interview Feedback',
		    dataIndex: 'M_FEEDBACKDATE',
		    width: 250,
			tdCls: 'audit-color',
			renderer: Ext.util.Format.dateRenderer('n/j/Y'),
			filter: {
				type: 'date',
				format: 'Y-n-j'
			}
		  },{  
		    text: 'TAT (Final Interview Feedback/Hiring Decision)',
		    dataIndex: 'TATMD',
			filterable: true,
			tdCls: 'audit-color',
		    width: 300,
			renderer: function(value, metaData, record) {
				var maxtat = record.data.TOTALTATMD;
				if(value >= maxtat) {
					metaData.style = 'background-color: #FF0000;';
				}
				return value;
			}
		  },{  
		    text: 'TAT (Final Interview TAT Summary)',
		    dataIndex: 'TATSUMMARYMD',
			filterable: true,
			tdCls: 'audit-color',
		    width: 250,
			renderer: function(value, metaData, record) {
				var maxtat = record.data.TOTALTATSUMMARYMD;
				if(value >= maxtat) {
					metaData.style = 'background-color: #FF0000;';
				}
				return value;
			}
		  },{
		    text: 'Date Presented Job Offer to Applicant',
		    dataIndex: 'E_DATEINVITE',
		    width: 250,
			tdCls: 'auditb-color',
			renderer: Ext.util.Format.dateRenderer('n/j/Y'),
			filter: {
				type: 'date',
				format: 'Y-n-j'
			}
		  },{
		    text: 'Date of Applicant\'s Decision',
		    dataIndex: 'E_DATEDECISION',
		    width: 250,
			tdCls: 'auditb-color',
			renderer: Ext.util.Format.dateRenderer('n/j/Y'),
			filter: {
				type: 'date',
				format: 'Y-n-j'
			}
		  },{  
		    text: 'Status F',
		    dataIndex: 'E_STATUS',
			filterable: true,
			tdCls: 'auditb-color',
		    width: 200
		  },{  
		    text: 'Comments F',
		    dataIndex: 'E_COMMENTS',
			filterable: true,
			tdCls: 'auditb-color',
		    width: 200
		  },{  
		    text: 'TAT (Job Offer)',
		    dataIndex: 'TATJOBOFFER',
			filterable: true,
			tdCls: 'auditb-color',
		    width: 200,
			renderer: function(value, metaData, record) {
				var maxtat = record.data.TOTALTATJOBOFFER;
				if(value >= maxtat) {
					metaData.style = 'background-color: #FF0000;';
				}
				return value;
			}
		  },{  
		    text: 'TAT (Job Offer TAT Summary)',
		    dataIndex: 'TATSUMMARYJO',
			filterable: true,
			tdCls: 'auditb-color',
		    width: 250,
			renderer: function(value, metaData, record) {
				var maxtat = record.data.TOTALTATSUMMARYJO;
				if(value >= maxtat) {
					metaData.style = 'background-color: #FF0000;';
				}
				return value;
			}
		  },{
		    text: 'Date Requirements was discussed to applicant',
		    dataIndex: 'F_DATEDISCUSSED',
		    width: 300,
			tdCls: 'it-color',
			renderer: Ext.util.Format.dateRenderer('n/j/Y'),
			filter: {
				type: 'date',
				format: 'Y-n-j'
			}
		  },{
		    text: 'Date Accomplished',
		    dataIndex: 'F_DATERECEIVED',
		    width: 200,
			tdCls: 'it-color',
			renderer: Ext.util.Format.dateRenderer('n/j/Y'),
			filter: {
				type: 'date',
				format: 'Y-n-j'
			}
		  },{  
		    text: 'Status G',
		    dataIndex: 'F_STATUS',
			filterable: true,
			tdCls: 'it-color',
		    width: 200
		  },{  
		    text: 'Comments G',
		    dataIndex: 'F_COMMENTS',
			filterable: true,
			tdCls: 'it-color',
		    width: 200
		  },{  
		    text: 'TAT (Pre-employment TAT Summary)',
		    dataIndex: 'TATREQ',
			filterable: true,
			tdCls: 'it-color',
		    width: 250,
			renderer: function(value, metaData, record) {
				var maxtat = record.data.TOTALTATREQ;
				if(value >= maxtat) {
					metaData.style = 'background-color: #FF0000;';
				}
				return value;
			}
		  },{
		    text: 'Date Accomplished',
		    dataIndex: 'J_DATEACCOMPLISH',
		    width: 200,
			tdCls: 'acct-color',
			renderer: Ext.util.Format.dateRenderer('n/j/Y'),
			filter: {
				type: 'date',
				format: 'Y-n-j'
			}
		  },{
		    text: 'Date Signed by Applicant',
		    dataIndex: 'J_DATESIGNEDBYAPP',
		    width: 200,
			tdCls: 'acct-color',
			renderer: Ext.util.Format.dateRenderer('n/j/Y'),
			filter: {
				type: 'date',
				format: 'Y-n-j'
			}
		  },{  
		    text: 'Status H',
		    dataIndex: 'J_STATUS',
			filterable: true,
			tdCls: 'acct-color',
		    width: 200
		  },{  
		    text: 'Comments H',
		    dataIndex: 'J_COMMENTS',
			filterable: true,
			tdCls: 'acct-color',
		    width: 200
		  },{  
		    text: 'TAT (Contract)',
		    dataIndex: 'TATCONTRACT',
			filterable: true,
			tdCls: 'acct-color',
		    width: 200,
			renderer: function(value, metaData, record) {
				var maxtat = record.data.TOTALTATCONTRACT;
				if(value >= maxtat) {
					metaData.style = 'background-color: #FF0000;';
				}
				return value;
			}
		  },{
		    text: 'NEO DATE', //New Employee Orientation
		    dataIndex: 'P_DATENEO',
		    width: 200,
			tdCls: 'white-color',
			renderer: Ext.util.Format.dateRenderer('n/j/Y'),
			filter: {
				type: 'date',
				format: 'Y-n-j'
			}
		  },{
		    text: 'On-Boarding Date',
		    dataIndex: 'P_DATEONBOARD',
		    width: 200,
			tdCls: 'white-color',
			renderer: Ext.util.Format.dateRenderer('n/j/Y'),
			filter: {
				type: 'date',
				format: 'Y-n-j'
			}
		  },{  
		    text: 'TAT (Total)',
		    dataIndex: 'TATTOTAL',
			filterable: true,
			tdCls: 'white-color',
		    width: 200,
			renderer: function(value, metaData, record) {
				var maxtat = record.data.TOTALTATTOTAL;
				if(value >= maxtat) {
					metaData.style = 'background-color: #FF0000;';
				}
				return value;
			}
		  }],
		
		
		this.callParent(arguments);
	}
});
