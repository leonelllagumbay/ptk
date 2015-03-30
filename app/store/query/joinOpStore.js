Ext.define('Form.store.query.joinOpStore', {
	extend: 'Ext.data.Store',
	model: 'Form.model.query.joinOpModel',
	data: [{
		joinopname: '(Blank)',
		joinopcode: ' '
	},{
		joinopname: 'JOIN',
		joinopcode: 'JOIN'
	},{
		joinopname: 'INNER JOIN',
		joinopcode: 'INNER JOIN'
	},{
		joinopname: 'OUTER JOIN',
		joinopcode: 'OUTER JOIN'
	},{
		joinopname: 'NATURAL INNER JOIN',
		joinopcode: 'NATURAL JOIN'
	},{
		joinopname: 'OUTER JOIN',
		joinopcode: 'OUTER JOIN'
	},{
		joinopname: 'NATURAL OUTER JOIN',
		joinopcode: 'NATURAL OUTER JOIN'
	},{
		joinopname: 'LEFT OUTER JOIN',
		joinopcode: 'LEFT OUTER JOIN'
	},{
		joinopname: 'RIGHT OUTER JOIN',
		joinopcode: 'RIGHT OUTER JOIN'
	},{
		joinopname: 'FULL OUTER JOIN',
		joinopcode: 'FULL OUTER JOIN'
	},{
		joinopname: 'UNION JOIN',
		joinopcode: 'UNION JOIN'
	},{
		joinopname: 'CROSS JOIN',
		joinopcode: 'CROSS JOIN'
	}]	
});
