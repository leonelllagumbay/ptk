Ext.define('Form.model.recruitment.mrfstatus.model', {
	extend: 'Ext.data.Model',
	fields: [
		'A_GUID',
		'A_APPLICANTNUMBER',
		'A_FIRSTNAME',
		'A_LASTNAME',
		'A_SOURCE', 
		{
			name: 'A_APPLICATIONDATE',
			type: 'date' 
		}, 
		{
			name: 'A_RECDATECREATED',
			type: 'date' 
		}, 
		{
			name: 'B_EXAMSCHEDDATE',
			type: 'date' 
		},
		'B_STATUS',
		'B_APPROVED',
		'B_COMMENTS', 
		{
			name: 'C_INTERVIEWDATE',
			type: 'date' 
		},
		'C_INTERVIEWER',
		'C_STATUS',
		'C_COMMENTS',
		'C_FEEDBACKDATE',
		'C_APPROVED',  
		{
			name: 'E_DATEINVITE',
			type: 'date'
		}, 
		{
			name: 'E_DATEDECISION',
			type: 'date'
		}, 
		'E_STATUS',
		'E_COMMENTS',  
		{
			name: 'F_DATEDISCUSSED',
			type: 'date'
		}, 
		{
			name: 'F_DATERECEIVED',
			type: 'date'
		}, 
		'F_STATUS',
		'F_COMMENTS',
		'P_DATENEO',
		'P_DATEONBOARD',
		'G_REQUISITIONNO',  
		{
			name: 'G_DATEPRESCREEN',
			type: 'date'
		}, 
		{
			name: 'G_DATESENDOUT',
			type: 'date'
		}, 
		'H_CONTACTCELLNUMBER',
		'H_EMAILADDRESS',
		'I_REQUISITIONEDBY',
		'I_DIVISIONCODE',
		'I_DEPARTMENTCODE', 
		{
			name: 'I_DATEREQUESTED',
			type: 'date'
		},  
		{
			name: 'I_DATELASTUPDATE',
			type: 'date'
		},
		{
			name: 'I_DATEACTIONWASDONE',
			type: 'date'
		}, 
		{
			name: 'J_DATEACCOMPLISH',
			type: 'date'
		},
		{
			name: 'J_DATESIGNEDBYAPP',
			type: 'date'
		},
		'J_STATUS',
		'J_COMMENTS',
		{
			name: 'K_DATEACTUALINTERVIEW',
			type: 'date'
		},
		{
			name: 'K_INTERVIEWDATE',
			type: 'date'
		},
		'K_INTERVIEWER',
		'K_STATUS',
		'K_COMMENTS',
		{
			name: 'K_FEEDBACKDATE',
			type: 'date'
		}, 
		{
			name: 'L_DATEACTUALINTERVIEW',
			type: 'date'
		},
		{
			name: 'L_INTERVIEWDATE',
			type: 'date'
		},
		'L_INTERVIEWER',
		'L_STATUS',
		'L_COMMENTS', 
		{
			name: 'L_FEEDBACKDATE',
			type: 'date'
		}, 
		{
			name: 'M_DATEACTUALINTERVIEW',
			type: 'date'
		},
		{
			name: 'M_INTERVIEWDATE',
			type: 'date'
		},
		'M_INTERVIEWER',
		'M_STATUS',
		'M_COMMENTS', 
		{
			name: 'M_FEEDBACKDATE',
			type: 'date'
		},
		'Z_DESCRIPTION',
		{
			name: 'TATMRFPOST', 
			type: 'number'
		},{
			name: 'TATSOURCING', 
			type: 'number'
		},{
			name: 'TATPRESCREENINVITE', 
			type: 'number'
		},{
			name: 'TATEXAMHRINT', 
			type: 'number'
		},{
			name: 'TATSUMMARYSC', 
			type: 'number'
		},{
			name: 'TATHRFEEDBACK', 
			type: 'number'
		},{
			name: 'TATHDFD', 
			type: 'number'
		},{
			name: 'TATFD', 
			type: 'number'
		},{
			name: 'TATSUMMARYFD', 
			type: 'number'
		},{
			name: 'TATHDSD', 
			type: 'number'
		},{
			name: 'TATSD', 
			type: 'number'
		},{
			name: 'TATSUMMARYSD', 
			type: 'number'
		},{
			name: 'TATHDMD', 
			type: 'number'
		},{
			name: 'TATMD', 
			type: 'number'
		},{
			name: 'TATSUMMARYMD', 
			type: 'number'
		},{
			name: 'TATJOBOFFER', 
			type: 'number'
		},{
			name: 'TATSUMMARYJO', 
			type: 'number'
		},{
			name: 'TATREQ', 
			type: 'number'
		},{
			name: 'TATTOTAL', 
			type: 'number'
		},{
			name: 'TATCONTRACT',
			type: 'number'
		},{
			name: 'TOTALTATSOURCING',
			type: 'number'
		},{
			name: 'TOTALTATEXAMHRINT',
			type: 'number'
		},{
			name: 'TOTALTATSUMMARYSC',
			type: 'number'
		},{
			name: 'TOTALTATHRFEEDBACK',
			type: 'number'
		},{
			name: 'TOTALTATJOBOFFER',
			type: 'number'
		},{
			name: 'TOTALTATSUMMARYJO',
			type: 'number'
		},{
			name: 'TOTALTATREQ',
			type: 'number'
		},{
			name: 'TOTALTATTOTAL',
			type: 'number'
		},{
			name: 'TOTALTATPRESCREENINVITE',
			type: 'number'
		},{
			name: 'TOTALTATMRFPOST',
			type: 'number'
		},{
			name: 'TOTALTATCONTRACT',
			type: 'number'
		},{
			name: 'TOTALTATHDFD',
			type: 'number'
		},{
			name: 'TOTALTATFD',
			type: 'number'
		},{
			name: 'TOTALTATSUMMARYFD',
			type: 'number'
		},{
			name: 'TOTALTATHDSD',
			type: 'number'
		},{
			name: 'TOTALTATSD',
			type: 'number'
		},{
			name: 'TOTALTATSUMMARYSD',
			type: 'number'
		},{
			name: 'TOTALTATHDMD',
			type: 'number'
		},{
			name: 'TOTALTATMD',
			type: 'number'
		},{
			name: 'TOTALTATSUMMARYMD',
			type: 'number'
		}
	]
});

