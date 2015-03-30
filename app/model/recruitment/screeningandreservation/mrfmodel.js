Ext.define('Form.model.recruitment.screeningandreservation.mrfmodel', {
	extend: 'Ext.data.Model',
	fields: [
		'POSTEDBYIBOSE',
		'POSTEDTO',
		'REQUISITIONNO',
		'SPECTRAINING',
		'SKILLSREQ',
		'SEX',
		'REQUISITIONEDBY',
		'REPLACEMENTREASON',
		'REPORTINGTO',
		'REPLACEMENTOF',
		'RELIGION',
		'NATUREOFJOBVAC',
		'RANKCODE',
		'NATUREOFEMP',
		'NATIONALITY',
		'MARITALSTAT',
		{
			name: 'EFFECTIVE',
			type: 'date'
		},
		'EDUCATTAINMENT1',
		'EDUCATTAINMENT2',
		'EDUCATTAINMENT3',
		'EDUCATTAINMENT4',
		'EDUCATTAINMENT5',
		{
			name: 'AGE',
			type: 'number'
		},
		'BRIEFDESC',
		{
			name: 'DATELASTUPDATE',
			type: 'date'
		},
		{
			name: 'DATEREQUISITION',
			type: 'date'
		},
		{
			name: 'IFCONTRACTUAL',
			type: 'date'
		},
		{
			name: 'DATETO',
			type: 'date'
		},
		'DEGREEREQ',
		{
			name: 'DATENEEDED',
			type: 'date'
		},
		'DEPARTMENTCODEFK',
		'DIVISIONCODE',
		'B_DESCRIPTION',
		'STATUS',
		{
			name: 'REQUIREDNO',
			type: 'number'
		},
		'PROJECTCODE',
		'SOURCENAME',
		'EMAILNOW'
	]
});

