Ext.define('Form.store.query.condOpStore', {
	extend: 'Ext.data.Store',
	model: 'Form.model.query.condOpModel',
	data: [{
		operatorname: '=',
		operatorcode: '='
	},{
		operatorname: '>',
		operatorcode: '>'
	},{
		operatorname: '<',
		operatorcode: '<'
	},{
		operatorname: '>=',
		operatorcode: '>='
	},{
		operatorname: '<=',
		operatorcode: '<='
	},{
		operatorname: '<>',
		operatorcode: '<>'
	},{
		operatorname: 'LIKE',
		operatorcode: 'LIKE'
	},{
		operatorname: 'NOT LIKE',
		operatorcode: 'NOT LIKE'
	},{
		operatorname: 'NOT',
		operatorcode: 'NOT'
	},{
		operatorname: 'IS',
		operatorcode: 'IS'
	},{
		operatorname: 'IS NOT',
		operatorcode: 'IS NOT'
	},{
		operatorname: 'EXISTS',
		operatorcode: 'EXISTS'
	},{
		operatorname: 'NOT EXISTS',
		operatorcode: 'NOT EXISTS'
	},{
		operatorname: 'BETWEEN',
		operatorcode: 'BETWEEN'
	},{
		operatorname: 'NOT BETWEEN',
		operatorcode: 'NOT BETWEEN'
	},{
		operatorname: 'IN',
		operatorcode: 'IN'
	},{
		operatorname: 'NOT IN',
		operatorcode: 'NOT IN'
	},{
		operatorname: 'ALL',
		operatorcode: 'ALL'
	},{
		operatorname: 'ANY',
		operatorcode: 'ANY'
	},{
		operatorname: 'SOME',
		operatorcode: 'SOME'
	}]	
});
