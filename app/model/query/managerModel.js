Ext.define('Form.model.query.managerModel', {
	extend: 'Ext.data.Model',
	fields: [{
		name: 'EQRYCODE',
		type: 'string'
	},{
		name: 'EQRYNAME',
		type: 'string'
	},{
		name: 'EQRYDESCRIPTION',
		type: 'string'
	},{
		name: 'EQRYAUTHOR',
		type: 'string'
	},{
		name: 'EQRYBODY',
		type: 'string'
	},{
		name: 'RECDATECREATED',
		type: 'date'
	},{
		name: 'DATELASTUPDATE',
		type: 'date'
	}]
})