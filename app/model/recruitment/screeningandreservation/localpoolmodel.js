Ext.define('Form.model.recruitment.screeningandreservation.localpoolmodel', {
	extend: 'Ext.data.Model',
	fields: [
		'G_REQUISITIONNO',
		{
			name: 'G_DATEPRESCREEN',
			type: 'date'
		},
		'A_APPLICANTNUMBER',
		{
			name: 'G_DATESENDOUT',
			type: 'date'
		},
		'A_GUID',
		'A_RESERVED',
		'A_FIRSTNAME',
		'A_LASTNAME',
		'K_DESCRIPTION',
		'H_CONTACTCELLNUMBER',
		'A_SOURCE',
		'H_EMAILADDRESS',
		{
			name: 'A_APPLICATIONDATE',	
			type: 'date'
		},
	]
});

