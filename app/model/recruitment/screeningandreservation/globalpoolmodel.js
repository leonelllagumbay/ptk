Ext.define('Form.model.recruitment.screeningandreservation.globalpoolmodel', {
	extend: 'Ext.data.Model',
	fields: [
		'A_REFERENCECODE',
		'A_FIRSTNAME',
		'A_LASTNAME',
		{
			name: 'A_APPLICATIONDATE',
			type: 'date'
		},
		'A_MIDDLENAME',
		'C_DESCRIPTION',
		'D_DESCRIPTION',
		{
			name: 'A_STARTINGSALARY',
			type: 'number'
		},
		{
			name: 'A_WORKEXPRATING',
			type: 'number'
		},
		{
			name: 'B_AGE',
			type: 'number'
		},
		'E_DESCRIPTION',
		'A_COMPANYCODE',
		'F_SCHOOLNAME',
		'I_DESCRIPTION',
		'A_COLLEGEISGRAD',
		'G_SCHOOLNAME',
		'J_DESCRIPTION',
		'A_POSTGRADISGRAD',
		'H_SCHOOLNAME',
		'K_DESCRIPTION',
		'A_VOCATIONALISGRAD',
		'B_SEX',
		'B_CIVILSTATUS',
		'B_CONTACTADDRESS',
		'B_CITIZENSHIP'		
	]
});

