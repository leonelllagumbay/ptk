
Ext.require([
    'Ext.window.MessageBox',
	'Ext.panel.Panel',
	'Ext.form.Panel',
    'Ext.tip.*'
]);




Ext.onReady(function(){
	


var numberonlystr = /[\d]/;
	Ext.apply(Ext.form.field.VTypes, {
	    numberonly:  function(v) {
	        return numberonlystr.test(v);
	    },
	    numberonlyText: 'Must be a numeric input.',
	    numberonlyMask: /[\d\.]/i
	});
	
Ext.apply(Ext.form.field.VTypes, {
	    filesizecheck:  function(v) {
			
			var posleng = Ext.get('filesizeid').getValue();
			var posleng    = parseInt(posleng); 
			if (posleng > 250000 || posleng < 0)
			{
            	return false;
			}
			else
			{
				return true;
			}
		},
	    filesizecheckText: 'File size must not exceed 250 Kb'
});

var sssformatSTR = /^\d{1,2}\-\d{1,7}\-\d{1}$/;
Ext.apply(Ext.form.field.VTypes, {
    sssformat:  function(v) {
        return sssformatSTR.test(v);
    },
    sssformatText: 'Please follow this format: XX-XXXXXXX-X',
    sssformatMask: /[\d\-]/i
});

var tinformatSTR = /^\d{1,3}\-\d{1,3}\-\d{1,3}$/;
Ext.apply(Ext.form.field.VTypes, {
    tinformat:  function(v) {
        return tinformatSTR.test(v);
    },
    tinformatText: 'Please follow this format: XXX-XXX-XXX',
    tinformatMask: /[\d\-]/i
});

var phformatSTR = /^\d{1,2}\-\d{1,9}\-\d{1}$/;
Ext.apply(Ext.form.field.VTypes, {
    phformat:  function(v) {
        return phformatSTR.test(v);
    },
    phformatText: 'Please follow this format: XX-XXXXXXXXX-X',
    phformatMask: /[\d\-]/i
});

var pagibigformatSTR = /^\d{1,4}\-\d{1,4}\-\d{1,4}$/;
Ext.apply(Ext.form.field.VTypes, {
    pagibigformat:  function(v) {
        return pagibigformatSTR.test(v);
    },
    pagibigformatText: 'Please follow this format: XXXX-XXXX-XXXX',
    pagibigformatMask: /[\d\-]/i
});




  function handleFileSelect(evt) {
  	
    var files = evt.target.files; // <!---FileList object--->

    <!--- Loop through the FileList and render image files as thumbnails.--->
    for (var i = 0, f; f = files[i]; i++) {

      <!--- Only process image files.--->
      if (!f.type.match('image.*')) {
        continue;
      }

	  document.getElementById('filesizeid').value = f.size;
	  
      var reader = new FileReader();

      <!--- Closure to capture the file information.--->
      reader.onload = (function(theFile) {
        return function(e) {
          <!--- Render thumbnail.--->
          var span = document.createElement('span');
          span.innerHTML = ['<img class="thumb" width="200" height="180" src="', e.target.result,
                            '" title="', escape(theFile.name), '"/>'].join('');
		  document.getElementById('list').innerHTML = '';
          document.getElementById('list').insertBefore(span, null);
        };
      })(f);

      <!--- Read in the image file as a data URL.--->
      reader.readAsDataURL(f);
    }
  }


Ext.define('Ext.form.field.Month', {
    extend:'Ext.form.field.Date',
    alias: 'widget.monthfield',
    requires: ['Ext.picker.Month'],
    alternateClassName: ['Ext.form.MonthField', 'Ext.form.Month'],
    selectMonth: null,
    createPicker: function() {
        var me = this,
            format = Ext.String.format;
        return Ext.create('Ext.picker.Month', {
            pickerField: me,
            ownerCt: me.ownerCt,
            renderTo: document.body,
            floating: true,
            hidden: true,
            focusOnShow: true,
            minDate: me.minValue,
            maxDate: me.maxValue,
            disabledDatesRE: me.disabledDatesRE,
            disabledDatesText: me.disabledDatesText,
            disabledDays: me.disabledDays,
            disabledDaysText: me.disabledDaysText,
            format: me.format,
            showToday: me.showToday,
            startDay: me.startDay,
            minText: format(me.minText, me.formatDate(me.minValue)),
            maxText: format(me.maxText, me.formatDate(me.maxValue)),
            listeners: { 
        select:        { scope: me,   fn: me.onSelect     }, 
        monthdblclick: { scope: me,   fn: me.onOKClick     },    
        yeardblclick:  { scope: me,   fn: me.onOKClick     },
        OkClick:       { scope: me,   fn: me.onOKClick     },    
        CancelClick:   { scope: me,   fn: me.onCancelClick }        
            },
            keyNavConfig: {
                esc: function() {
                    me.collapse();
                }
            }
        });
    },
    onCancelClick: function() {
        var me = this;    
    me.selectMonth = null;
        me.collapse();
    },
    onOKClick: function() {
        var me = this;    
    if( me.selectMonth ) {
               me.setValue(me.selectMonth);
            me.fireEvent('select', me, me.selectMonth);
    }
        me.collapse();
    },
    onSelect: function(m, d) {
        var me = this;    
    me.selectMonth = new Date(( d[0]+1 ) +'/1/'+d[1]);
    }
});  
	
	
	
	//for company lookup
	Ext.define('CompanyLK', {
		extend: 'Ext.data.Model',
		fields: [{
			name: 'companycode',
			type: 'string'
		},{
			name: 'companyname',
			type: 'string'
		}]
	});	
	//for department lookup
	Ext.define('DepartmentLK', {
		extend: 'Ext.data.Model',
		fields: [{
			name: 'departmentcode',
			type: 'string'
		},{
			name: 'departmentname',
			type: 'string'
		}]
	});	
	//for position
	Ext.define('PositionLK', {
		extend: 'Ext.data.Model',
		fields: [{
			name: 'positioncode',
			type: 'string'
		},{
			name: 'positionname',
			type: 'string'
		}]
	});	
	
	//for gender lookup
	Ext.define('genderLK', {
		extend: 'Ext.data.Model',
		fields: [{
			name: 'gendercode',
			type: 'string'
		},{
			name: 'gendername',
			type: 'string'
		}]
	});	
	
	//for civil status lookup
	Ext.define('civilstatusLK', {
		extend: 'Ext.data.Model',
		fields: [{
			name: 'civilstatuscode',
			type: 'string'
		},{
			name: 'civilstatusname',
			type: 'string'
		}]
	});	
	
	//for citizenship lookup
	Ext.define('citizenshipLK', {
		extend: 'Ext.data.Model',
		fields: [{
			name: 'citizenshipcode',
			type: 'string'
		},{
			name: 'citizenshipname',
			type: 'string'
		}]
	});	
	
	//for religion lookup
	Ext.define('religionLK', {
		extend: 'Ext.data.Model',
		fields: [{
			name: 'religioncode',
			type: 'string'
		},{
			name: 'religionname',
			type: 'string'
		}]
	});	
	
	//for school lookup
	Ext.define('schoolLK', {
		extend: 'Ext.data.Model',
		fields: [{
			name: 'schoolcode',
			type: 'string'
		},{
			name: 'schoolname',
			type: 'string'
		}]
	});	
	
	//for school field lookup
	Ext.define('fieldLK', {
		extend: 'Ext.data.Model',
		fields: [{
			name: 'fieldcode',
			type: 'string'
		},{
			name: 'fieldname',
			type: 'string'
		}]
	});	
	
	//for school course lookup
	Ext.define('courseLK', {
		extend: 'Ext.data.Model',
		fields: [{
			name: 'coursecode',
			type: 'string'
		},{
			name: 'coursename',
			type: 'string'
		}]
	});	
	
	//for govexam lookup
	Ext.define('govexamLK', {
		extend: 'Ext.data.Model',
		fields: [{
			name: 'govexamcode',
			type: 'string'
		},{
			name: 'govexamname',
			type: 'string'
		}]
	});	
	
	var govexamlk =	Ext.create('Ext.data.Store', {
							model: 'govexamLK',
							proxy: {
								type: 'ajax',
								url: '../../../data/lookup/govexam.cfm',
								reader: {
									type: 'json',
									root: 'govexamlk'
								}
							},
							autoLoad: true
					    });
	
	var courselk =	Ext.create('Ext.data.Store', {
							model: 'courseLK',
							proxy: {
								type: 'ajax',
								url: '../../../data/lookup/course.cfm',
								reader: {
									type: 'json',
									root: 'courselk'
								}
							},
							autoLoad: true
					    });
	
	var fieldlk =	Ext.create('Ext.data.Store', {
							model: 'fieldLK',
							proxy: {
								type: 'ajax',
								url: '../../../data/lookup/field.cfm',
								reader: {
									type: 'json',
									root: 'fieldlk'
								}
							},
							autoLoad: true
					    });
	
	var schoollk =	Ext.create('Ext.data.Store', {
							model: 'schoolLK',
							proxy: {
								type: 'ajax',
								url: '../../../data/lookup/school.cfm',
								reader: {
									type: 'json',
									root: 'schoollk'
								}
							},
							autoLoad: true
					    });
	
	var religionlk =	Ext.create('Ext.data.Store', {
							model: 'religionLK',
							proxy: {
								type: 'ajax',
								url: '../../../data/lookup/religion.cfm',
								reader: {
									type: 'json',
									root: 'religionlk'
								}
							},
							autoLoad: true
					    });
	
	var citizenshiplk =	Ext.create('Ext.data.Store', {
							model: 'citizenshipLK',
							proxy: {
								type: 'ajax',
								url: '../../../data/lookup/citizenship.cfm',
								reader: {
									type: 'json',
									root: 'citizenshiplk'
								}
							},
							autoLoad: true
					    });
	var genderlk =	Ext.create('Ext.data.Store', {
						model: 'genderLK',
						data: [{
							gendercode: 'M',
							gendername: 'Male'
						},{
							gendercode: 'F',
							gendername: 'Female'
						}]
					});  
					
	var civilstatuslk =	Ext.create('Ext.data.Store', {
							model: 'civilstatusLK',
							proxy: {
								type: 'ajax',
								url: '../../../data/lookup/civilstatus.cfm',
								reader: {
									type: 'json',
									root: 'civilstatuslk'
								}
							},
							autoLoad: true
					    });
				    
    var companylk =	Ext.create('Ext.data.Store', {
						model: 'CompanyLK',
						proxy: {
							type: 'ajax',
							url: '../../../data/lookup/companydsn.cfm',
							reader: {
								type: 'json',
								root: 'companylk'
							}
							
						},
						autoLoad: true
					    
				   });
    var departmentlk =	Ext.create('Ext.data.Store', {
						model: 'DepartmentLK',
						proxy: {
							type: 'ajax',
							url: '../../../data/lookup/department.cfm',
							reader: {
								type: 'json',
								root: 'departmentlk'
							}
							
						},
						autoLoad: true
					    
				   });
		
    var positionlk =	Ext.create('Ext.data.Store', {
							model: 'PositionLK',
							proxy: {
								type: 'ajax',
								url: '../../../data/lookup/position.cfm',
								reader: {
									type: 'json',
									root: 'positionlk'
								}
								
							},
							autoLoad: true
						    
					   });



	
var formExit =  Ext.create('Ext.form.Panel', {
  	title: 'iBOS/e Application Online Form',
	titleAlign: 'center',
    width: '100%',
    height: 5700,
    layout: {
        type: 'vbox',
        align: 'center'
    },
    renderTo: document.body,
    items: [{
		
		xtype: 'panel',
		width: '80%',
		flex: 6,
		layout: {
			type: 'vbox',
			align: 'center'
		},
		items: [{
			xtype: 'displayfield',
			value: '<h3>Filinvest Baseline Company</h3>',
			cls: 'field-margin-center',
			width: '100%',
			flex: 3,
		    name: 'companytitle'
		},{
			xtype: 'displayfield',
			value: '<h4>EMPLOYMENT APPLICATION FORM</h4>',
			cls: 'field-margin-center',
			width: '100%',
			flex: 5,
		    name: 'companysubtitle'
		},{
			xtype: 'panel',
			width: '100%',
			flex: 15,
			layout: {
				type: 'hbox',
				align: 'stretch'
			},
			items: [{
				xtype: 'displayfield',
				value: '<b>Instructions:</b>',
				cls: 'field-margin',
				flex: 3
			},{
				xtype: 'displayfield',
				value: '<b><p>Complete all items. If not applicable, please type "NA" or "0" for numbers.</p> <p>Please make sure that all information that you will provide to us are true, complete and not misleading in any way:</p></b>',
				width: 300,
				flex: 12
			},{
				xtype: 'panel',
				layout: 'fit',
				flex: 12,
				items: [{
					
					xtype: 'panel',
					layout: {
						type: 'vbox',
						align: 'center'
					},
					style: {
						border: 'none'
					},
					items: [{
						xtype: 'filefield',
						flex: 1,
						id: 'files',
						name: 'filename',
						fieldLabel: 'Photo (at most 250 Kb)',
						labelWidth: 150,
						width: 400,
				        msgTarget: 'side',
				        allowBlank: true,
				        anchor: '100%',
				        buttonText: 'Select photo...',
						listeners: {
							afterrender: function(evt, eOpts) {
								document.getElementById('files').addEventListener('change', handleFileSelect, false);
							}
						},
						vtype: 'filesizecheck',
						vtypeText: 'File size must not exceed 250 Kb'
					},{
						xtype: 'displayfield',
						id: 'list',
						flex: 6,
						value: '2 x 2 photo (at most 250 Kb)',
						width: '150',
						height: '150',
						name: 'myphotohere'  
					},{
						xtype: 'textfield',
						name: 'tempstoreforfilesize',
						hidden: true,
						id: 'filesizeid',
						flex: 1,
						value: ' '
					}]
					
					
				}]
			}]
		}]
	},{
		title: 'PERSONAL INFORMATION',
		xtype: 'panel',
		collapsible: true,
		width: '80%',
		flex: 9,
		layout: {
			type: 'vbox',
			align: 'center'
		},
		items: [{
			xtype: 'panel',
			width: '100%',
			layout: {
				type: 'hbox',
				align: 'left'
			},
			items: [{
				xtype: 'textfield',
				fieldLabel: 'Last name*',
				name: 'LASTNAME',
				allowBlank: false,
				maxLength: 30,
				cls: 'field-margin',
				labelAlign: 'top',
				flex: 2
			},{
				xtype: 'textfield',
				name: 'FIRSTNAME',
				fieldLabel: 'First name*',
				allowBlank: false,
				maxLength: 30,
				cls: 'field-margin',
				labelAlign: 'top',
				flex: 2
			},{
				xtype: 'textfield',
				name: 'MIDDLENAME',
				fieldLabel: 'Middle name*',
				allowBlank: false,
				maxLength: 30,
				cls: 'field-margin',
				labelAlign: 'top',
				flex: 2
			},{
				xtype: 'textfield',
				name: 'SUFFIX',
				fieldLabel: 'Suffix',
				maxLength: 10,
				cls: 'field-margin',
				labelAlign: 'top',
				flex: 1
			}]
		},{
			xtype: 'panel',
			width: '100%',
			layout: {
				type: 'hbox',
				align: 'left'
			},
			items: [{
				xtype: 'textfield',
				name: 'PRESENTADDRESSPOSTAL',
				allowBlank: false,
				maxLength: 250,
				fieldLabel: 'Present Address and Postal Code*',
				cls: 'field-margin',
				labelAlign: 'top',
				flex: 6
			},{
				xtype: 'radiofield',
				name: 'PRESENTADDRESSOWN',
				fieldLabel: 'Own',
				inputValue: 'Own',
				checked: true,
				cls: 'field-margin',
				labelAlign: 'top',
				flex: 1
			},{
				xtype: 'radiofield',
				name: 'PRESENTADDRESSOWN',
				fieldLabel: 'Living with relatives',
				inputValue: 'Living with relatives',
				cls: 'field-margin',
				labelAlign: 'top',
				flex: 2
			},{
				xtype: 'radiofield',
				name: 'PRESENTADDRESSOWN',
				fieldLabel: 'Rented',
				inputValue: 'Rented',
				cls: 'field-margin',
				labelAlign: 'top',
				flex: 1
			},{
				xtype: 'radiofield',
				name: 'PRESENTADDRESSOWN',
				fieldLabel: 'Others',
				inputValue: ' ',
				cls: 'field-margin',
				labelAlign: 'top',
				flex: 1
			},{
				xtype: 'textfield',
				name: 'PRESENTADDRESSOWN',
				fieldLabel: 'Others, specify',
				cls: 'field-margin',
				labelAlign: 'top',
				flex: 3
			}]
		},{
			xtype: 'panel',
			width: '100%',
			layout: {
				type: 'hbox',
				align: 'left'
			},
			items: [{
				xtype: 'textfield',
				name: 'PROVINCIALADDRESSPOSTAL',
				allowBlank: false,
				maxLength: 250,
				fieldLabel: 'Provincial Address and Postal Code*',
				cls: 'field-margin',
				labelAlign: 'top',
				flex: 6
			},{
				xtype: 'radiofield',
				name: 'PROVINCEADDRESSOWN',
				fieldLabel: 'Own',
				inputValue: 'Own',
				checked: true,
				cls: 'field-margin',
				labelAlign: 'top',
				flex: 1
			},{
				xtype: 'radiofield',
				name: 'PROVINCEADDRESSOWN',
				fieldLabel: 'Living with relatives',
				inputValue: 'Living with relatives',
				cls: 'field-margin',
				labelAlign: 'top',
				flex: 2
			},{
				xtype: 'radiofield',
				name: 'PROVINCEADDRESSOWN',
				fieldLabel: 'Rented',
				inputValue: 'Rented',
				cls: 'field-margin',
				labelAlign: 'top',
				flex: 1
			},{
				xtype: 'radiofield',
				name: 'PROVINCEADDRESSOWN',
				fieldLabel: 'Others',
				inputValue: ' ',
				cls: 'field-margin',
				labelAlign: 'top',
				flex: 1
			},{
				xtype: 'textfield',
				name: 'PROVINCEADDRESSOWN',
				fieldLabel: 'Others, specify',
				cls: 'field-margin',
				labelAlign: 'top',
				flex: 3
			}]
		},{
			xtype: 'panel',
			width: '100%',
			layout: {
				type: 'vbox',
				align: 'left'
			},
			items: [{
				xtype: 'textfield',
				fieldLabel: 'Cellphone Number*',
				name: 'CELLPHONENUMBER', 
				allowBlank: false,
				maxLength: 15,
				width: 300,
				cls: 'field-margin',
				vtype: 'numberonly',
				flex: 2
			},{
				xtype: 'textfield',
				name: 'LANDLINENUMBER',
				fieldLabel: 'Landline Number',
				vtype: 'numberonly',
				width: 300,
				cls: 'field-margin',
				flex: 2
			},{
				xtype: 'textfield',
				name: 'EMAILADDRESS',
				allowBlank: false,
				maxLength: 50,
				width: 300,
				fieldLabel: 'Email Address*',
				cls: 'field-margin',
				vtype: 'email',
				flex: 2
			}]
		},{
			xtype: 'panel',
			width: '100%',
			layout: {
				type: 'hbox',
				align: 'left'
			},
			items: [{
				xtype: 'datefield',
				fieldLabel: 'Date of Birth*',
				name: 'DATEOFBIRTH', 
				cls: 'field-margin',
				allowBlank: false,
				labelAlign: 'top',
				listeners: {
					change: function(field,value) {
								var d1=new Date(value);
								var d2=new Date();
								var milli=d2-d1;
								var milliPerYear=1000*60*60*24*365.26;
								var yearsApart=milli/milliPerYear;
								yearsApart = Math.floor(yearsApart);
								var formPanel = field.up('form');
								var form = formPanel.getForm();
								form.setValues([{
									id: 'aaggeeid',
									value: yearsApart
								}]);
							}
				},
				flex: 3
			},{
				xtype: 'textfield',
				name: 'PLACEOFBIRTH',
				allowBlank: false,
				maxLength: 100,
				fieldLabel: 'Place of Birth*',
				cls: 'field-margin',
				labelAlign: 'top',
				flex: 4
			},{
				xtype: 'numberfield',
				name: 'AGE',
				id: 'aaggeeid',
				fieldLabel: 'Age*',
				cls: 'field-margin',
				labelAlign: 'top',
				allowBlank: false,
				value: 0,
				minValue: 0,
				maxValue: 99,
				flex: 1
			},{
				xtype: 'combobox',
				editable: false,
				fieldLabel: 'Gender*',
				name: 'GENDER',
				allowBlank: false,
				labelAlign: 'top',
				cls: 'field-margin',
				queryMode: 'local',
				store: genderlk,
				displayField: 'gendername',
				valueField: 'gendercode',
				flex: 2
			},{
				xtype: 'combobox',
				editable: false,
				fieldLabel: 'Civil Status*',
				id: 'cciivviillstatusid',
				name: 'CIVILSTATUS',
				allowBlank: false,
				labelAlign: 'top',
				cls: 'field-margin',
				store: civilstatuslk,
				displayField: 'civilstatusname',
				valueField: 'civilstatuscode',
				listeners: {
					change: function(field, value) {
						var res = value.search(/^single/i);
						if(res > -1 ) {
							//allow spouse's field to allow blanks
							var spousepanel = Ext.getCmp('spouseididone');
							Ext.apply(spousepanel, {allowBlank: true}, {});
							var spousepanel = Ext.getCmp('spouseididtwo');
							Ext.apply(spousepanel, {allowBlank: true}, {});
							var spousepanel = Ext.getCmp('spouseididthree');
							Ext.apply(spousepanel, {allowBlank: true}, {});
							var spousepanel = Ext.getCmp('spouseididfour');
							Ext.apply(spousepanel, {allowBlank: true}, {});
						} else {
							var spousepanel = Ext.getCmp('spouseididone');
							Ext.apply(spousepanel, {allowBlank: false}, {});
							var spousepanel = Ext.getCmp('spouseididtwo');
							Ext.apply(spousepanel, {allowBlank: false}, {});
							var spousepanel = Ext.getCmp('spouseididthree');
							Ext.apply(spousepanel, {allowBlank: false}, {});
							var spousepanel = Ext.getCmp('spouseididfour');
							Ext.apply(spousepanel, {allowBlank: false}, {});
						}
					}
				},
				flex: 2
			},{
				xtype: 'combobox',
				editable: false,
				fieldLabel: 'Citizenship*',
				name: 'CITIZENSHIP',
				allowBlank: false,
				labelAlign: 'top',
				cls: 'field-margin',
				store: citizenshiplk,
				displayField: 'citizenshipname',
				valueField: 'citizenshipcode',
				flex: 3
			},{
				xtype: 'combobox',
				editable: false,
				fieldLabel: 'Religion',
				name: 'RELIGION',
				labelAlign: 'top',
				cls: 'field-margin',
				store: religionlk,
				displayField: 'religionname',
				valueField: 'religioncode',
				flex: 3
			}]
		},{
			xtype: 'panel',
			width: '100%',
			layout: {
				type: 'hbox',
				align: 'left'
			},
			items: [{
				xtype: 'textfield',
				fieldLabel: 'SSS No.*',
				name: 'SSSNUMBER', 
				cls: 'field-margin',
				labelAlign: 'top',
				allowBlank: false,
				vtype: 'sssformat',
				emptyText: 'XX-XXXXXXX-X',
				flex: 2
			},{
				xtype: 'textfield',
				name: 'TINNUMBER',
				fieldLabel: 'TIN*',
				cls: 'field-margin',
				labelAlign: 'top',
				allowBlank: false,
				vtype: 'tinformat',
				emptyText: 'XXX-XXX-XXX',
				flex: 2
			},{
				xtype: 'textfield',
				name: 'PHILHEALTHNUMBER',
				fieldLabel: 'PhilHealth No.*',
				cls: 'field-margin',
				labelAlign: 'top',
				allowBlank: false,
				vtype: 'phformat',
				emptyText: 'XX-XXXXXXXXX-X',
				flex: 2
			},{
				xtype: 'textfield',
				name: 'PAGIBIGNUMBER',
				fieldLabel: 'PAG-IBIG No.*',
				cls: 'field-margin',
				labelAlign: 'top',
				allowBlank: false,
				vtype: 'pagibigformat',
				emptyText: 'XXXX-XXXX-XXXX',
				flex: 2
			}]
		},{
			xtype: 'panel',
			width: '100%',
			layout: {
				type: 'vbox',
				align: 'left'
			},
			items: [{
				xtype: 'textfield',
				fieldLabel: 'Height',
				name: 'HEIGHT', 
				maxLength: 15,
				width: 300,
				cls: 'field-margin',
				flex: 2
			},{
				xtype: 'textfield',
				name: 'WEIGHT',
				fieldLabel: 'Weight',
				width: 300,
				cls: 'field-margin',
				maxLength: 15,
				flex: 2
			},{
				xtype: 'textfield',
				name: 'BLOODTYPE',
				fieldLabel: 'Blood Type',
				width: 300,
				cls: 'field-margin',
				maxLength: 2,
				flex: 2
			}]
		}]
	},{
		title: 'EMPLOYMENT INFORMATION',
		xtype: 'panel',
		width: '80%',
		flex: 10,
		collapsible: true,
		layout: {
			type: 'vbox',
			align: 'left'
		},
		items: [{
			xtype: 'displayfield',
			cls: 'field-margin',
			value: 'Positions Applied For:'
			
		},{
			xtype: 'panel',
			width: '100%',
			layout: {
				type: 'hbox',
				align: 'stretch'
			},
			items: [{
					fieldLabel: 'First Choice',
					allowBlank: false,
					editable: false,
					name: 'POSITIONFIRSTPRIORITY',
					xtype: 'combobox',
					cls: 'field-margin',
					labelAlign: 'top',
					width: 350,
					store: positionlk,
					displayField: 'positionname',
					valueField: 'positioncode'
			},{
					fieldLabel: 'First Choice Company',
					editable: false,
					allowBlank: false,
					name: 'COMPANYFIRSTPRIORITY',
					xtype: 'combobox',
					cls: 'field-margin',
					labelAlign: 'top',
					width: 350,
					store: companylk,
					displayField: 'companyname',
					valueField: 'companycode'
			}]
			
		},{
			xtype: 'container',
			width: '100%',
			layout: {
				type: 'hbox',
				align: 'stretch'
			},
			items: [{
					fieldLabel: 'Second Choice',
					name: 'POSITIONSECONDPRIORITY',
					xtype: 'combobox',
					cls: 'field-margin',
					labelAlign: 'top',
					width: 350,
					store: positionlk,
					displayField: 'positionname',
					valueField: 'positioncode'
			},{
					fieldLabel: 'Second Choice Company',
					name: 'COMPANYSECONDPRIORITY',
					xtype: 'combobox',
					cls: 'field-margin',
					labelAlign: 'top',
					width: 350,
					store: companylk,
					displayField: 'companyname',
					valueField: 'companycode'
			}]
			
		},{
			xtype: 'panel',
			width: '100%',
			layout: {
				type: 'hbox',
				align: 'stretch'
			},
			items: [{
					fieldLabel: 'Third Choice',
					name: 'POSITIONTHIRDPRIORITY',
					xtype: 'combobox',
					cls: 'field-margin',
					labelAlign: 'top',
					width: 350,
					store: positionlk,
					displayField: 'positionname',
					valueField: 'positioncode'
			},{
					fieldLabel: 'Third Choice Company',
					name: 'COMPANYTHIRDPRIORITY',
					xtype: 'combobox',
					cls: 'field-margin',
					labelAlign: 'top',
					width: 350,
					store: companylk,
					displayField: 'companyname',
					valueField: 'companycode'
			}]
			
		},{
			xtype: 'numberfield',
			name: 'EXPECTEDSALARY',
			cls: 'field-margin',
			fieldLabel: 'Expected Salary',
			value: 0,
			minValue: 0,
			maxValue: 1000000,
			width: 300
			
		},{
			xtype: 'numberfield',
			name: 'CURRENTSALARY',
			cls: 'field-margin',
			fieldLabel: 'Current Salary',
			value: 0,
			minValue: 0,
			maxValue: 1000000,
			width: 300
			
		},{
			xtype: 'displayfield',
			cls: 'field-margin',
			value: 'Previously Employed With Any Filinvest Offices?'
		},{
			xtype: 'radiofield',
			inputValue: 'N',
			checked: true,
			cls: 'field-margin',
			fieldLabel: 'No',
			name: 'PREVEMPLOYED'
		},{
			xtype: 'container',
			layout: {
				type: 'hbox',
				align: 'left'
			},
			items: [{
				xtype: 'radiofield',
				inputValue: 'Y',
				cls: 'field-margin',
				fieldLabel: 'Yes',
				name: 'PREVEMPLOYED',
				flex: 1
			},{
				xtype: 'monthfield',
				format: 'F Y',
				name: 'PREVEMPLOYEDFROM',
				cls: 'field-margin',
				labelAlign: 'top',
				fieldLabel: 'From',
				width: 200
			},{
				xtype: 'monthfield',
				format: 'F Y',
				name: 'PREVEMPLOYEDTO',
				cls: 'field-margin',
				labelAlign: 'top',
				fieldLabel: 'To',
				width: 200
			}]
		},{
			xtype: 'displayfield',
			cls: 'field-margin',
			value: 'Previously Applied Here?'
		},{
			xtype: 'radiofield',
			checked: true,
			inputValue: 'N',
			cls: 'field-margin',
			fieldLabel: 'No',
			name: 'PREVAPPLIED'
		},{
			xtype: 'container',
			layout: {
				type: 'hbox',
				align: 'left'
			},
			items: [{
				xtype: 'radiofield',
				inputValue: 'Y',
				cls: 'field-margin',
				fieldLabel: 'Yes',
				name: 'PREVAPPLIED',
				flex: 1
			},{
				xtype: 'monthfield',
				name: 'PREVAPPLIEDLAST',
				format: 'F Y',
				cls: 'field-margin',
				labelAlign: 'top',
				fieldLabel: 'Last',
				width: 200
			}]
		},{
			xtype: 'datefield',
			name: 'DATEAVAILEMP',
			cls: 'field-margin',
			fieldLabel: 'Date Available for Employment',
			width: 300
		}]
	},{
		title: 'FAMILY BACKGROUND',
		id: 'familybackgroundidid',
		collapsible: true,
		autoScroll: true,
		xtype: 'panel',
		width: '80%',
		flex: 11,
		layout: {
			type: 'vbox',
			align: 'stretch'
		},
		items: [{
			xtype: 'panel',
			width: '100%',
			layout: {
				type: 'hbox',
				align: 'left'
			},
			items: [{
				xtype: 'displayfield',
				flex: 6,
				value: '<b>Name</b>',
				cls: 'field-margin-center'
			},{
				xtype: 'displayfield',
				flex: 1,
				value: '<b>Age</b>',
				cls: 'field-margin-center'
			},{
				xtype: 'displayfield',
				flex: 3,
				value: '<b>Occupation</b>',
				cls: 'field-margin-center'
			},{
				xtype: 'displayfield',
				flex: 3,
				value: '<b>Company/School</b>',
				cls: 'field-margin-center'
			},{
				xtype: 'displayfield',
				flex: 3,
				value: '<b>Contact Number</b>',
				cls: 'field-margin-center'
			}]
		},{
			xtype: 'panel',
			width: '100%',
			layout: {
				type: 'hbox',
				align: 'left'
			},
			items: [{
				xtype: 'textfield',
				flex: 6,
				name: 'FATHERFULLNAME',
				fieldLabel: 'Father*',
				allowBlank: false,
				maxLength: 50,
				cls: 'field-margin'
			},{
				xtype: 'numberfield',
				flex: 1,
				name: 'FATHERAGE',
				cls: 'field-margin',
				allowBlank: false,
				value: 0,
				minValue: 0,
				maxValue: 99
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'FATHEROCCUPATION',
				allowBlank: false,
				maxLength: 50,
				cls: 'field-margin'
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'FATHERCOMPANY',
				allowBlank: false,
				maxLength: 50,
				cls: 'field-margin'
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'FATHERCONTACTNO',
				allowBlank: false,
				maxLength: 15,
				vtype: 'numberonly',
				cls: 'field-margin'
			}]
		},{
			xtype: 'panel',
			width: '100%',
			layout: {
				type: 'hbox',
				align: 'center'
			},
			items: [{
				xtype: 'textfield',
				flex: 6,
				name: 'MOTHERFULLNAME',
				allowBlank: false,
				maxLength: 50,
				fieldLabel: 'Mother*',
				cls: 'field-margin'
			},{
				xtype: 'numberfield',
				flex: 1,
				name: 'MOTHERAGE',
				cls: 'field-margin',
				allowBlank: false,
				value: 0,
				minValue: 0,
				maxValue: 99
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'MOTHEROCCUPATION',
				allowBlank: false,
				maxLength: 50,
				cls: 'field-margin'
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'MOTHERCOMPANY',
				allowBlank: false,
				maxLength: 50,
				cls: 'field-margin'
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'MOTHERCONTACTNO',
				allowBlank: false,
				maxLength: 15,
				vtype: 'numberonly',
				cls: 'field-margin'
			}]
		},{
			xtype: 'panel',
			id: 'spousepanelidid',
			width: '100%',
			layout: {
				type: 'hbox',
				align: 'center'
			},
			items: [{
				xtype: 'textfield',
				id: 'spouseididone',
				flex: 6,
				name: 'SPOUSEFULLNAME',
				fieldLabel: 'Spouse*',
				emptyText: '(if married)',
				allowBlank: false,
				maxLength: 50,
				cls: 'field-margin'
			},{
				xtype: 'numberfield',
				id: 'spouseididtwo',
				flex: 1,
				name: 'SPOUSEAGE',
				cls: 'field-margin',
				allowBlank: false,
				value: 0,
				minValue: 0,
				maxValue: 99
			},{
				xtype: 'textfield',
				id: 'spouseididthree',
				flex: 3,
				name: 'SPOUSEOCCUPATION',
				allowBlank: false,
				maxLength: 50,
				cls: 'field-margin'
			},{
				xtype: 'textfield',
				id: 'spouseididfour',
				flex: 3,
				name: 'SPOUSECOMPANY',
				allowBlank: false,
				maxLength: 50,
				cls: 'field-margin'
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'SPOUSECONTACTNO',
				maxLength: 15,
				vtype: 'numberonly',
				cls: 'field-margin'
			}]
		},{
			xtype: 'button',
			width: 300,
			id: 'buttonchildone',
			text: 'Add a child',
			handler: function() {
				 var childpanel = Ext.getCmp('childididone');
				     childpanel.setVisible(true); 
			     var buttonpanel = Ext.getCmp('buttonchildtwo');
				     buttonpanel.setVisible(true);  
				     this.setVisible(false);
	       }
		},{
			xtype: 'panel',
			id: 'childididone',
			hidden: true,
			layout: {
				type: 'hbox',
				align: 'stretch'
			},
			items: [{
				xtype: 'textfield',
				flex: 6,
				name: 'FIRSTCHILDFULLNAME',
				maxLength: 50,
				fieldLabel: 'Child 1',
				cls: 'field-margin'
			},{
				xtype: 'numberfield',
				flex: 1,
				name: 'FIRSTCHILDAGE',
				cls: 'field-margin',
				value: 0,
				minValue: 0,
				maxValue: 99
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'FIRSTCHILDOCCUPATION',
				maxLength: 50,
				cls: 'field-margin'
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'FIRSTCHILDCOMPANY',
				maxLength: 50,
				cls: 'field-margin'
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'FIRSTCHILDCONTACTNO',
				vtype: 'numberonly',
				maxLength: 15,
				cls: 'field-margin'
			}]
		},{
			xtype: 'button',
			hidden: true,
			id: 'buttonchildtwo',
			text: 'Add a second child',
			handler: function() {
				 var childpanel = Ext.getCmp('childididtwo');
				     childpanel.setVisible(true); 
			     var buttonpanel = Ext.getCmp('buttonchildthree');
				     buttonpanel.setVisible(true);  
				     this.setVisible(false);
	       }
		},{
			xtype: 'panel',
			id: 'childididtwo',
			hidden: true,
			layout: {
				type: 'hbox',
				align: 'stretch'
			},
			items: [{
				xtype: 'textfield',
				flex: 6,
				name: 'SECONDCHILDFULLNAME',
				fieldLabel: 'Child 2',
				maxLength: 50,
				cls: 'field-margin'
			},{
				xtype: 'numberfield',
				flex: 1,
				name: 'SECONDCHILDAGE',
				cls: 'field-margin',
				value: 0,
				minValue: 0,
				maxValue: 99
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'SECONDCHILDOCCUPATION',
				maxLength: 50,
				cls: 'field-margin'
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'SECONDCHILDCOMPANY',
				maxLength: 50,
				cls: 'field-margin'
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'SECONDCHILDCONTACTNO',
				vtype: 'numberonly',
				maxLength: 15,
				cls: 'field-margin'
			}]
		},{
			xtype: 'button',
			hidden: true,
			id: 'buttonchildthree',
			text: 'Add a 3rd child',
			handler: function() {
				 var childpanel = Ext.getCmp('childididthree');
				     childpanel.setVisible(true); 
			     var buttonpanel = Ext.getCmp('buttonchildfour');
				     buttonpanel.setVisible(true);  
				     this.setVisible(false);
	       }
		},{
			xtype: 'panel',
			id: 'childididthree',
			hidden: true,
			layout: {
				type: 'hbox',
				align: 'stretch'
			},
			items: [{
				xtype: 'textfield',
				flex: 6,
				name: 'THIRDCHILDFULLNAME',
				fieldLabel: 'Child 3',
				maxLength: 50,
				cls: 'field-margin'
			},{
				xtype: 'numberfield',
				flex: 1,
				name: 'THIRDCHILDAGE',
				cls: 'field-margin',
				value: 0,
				minValue: 0,
				maxValue: 99
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'THIRDCHILDOCCUPATION',
				maxLength: 50,
				cls: 'field-margin'
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'THIRDCHILDCOMPANY',
				maxLength: 50,
				cls: 'field-margin'
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'THIRDCHILDCONTACTNO',
				vtype: 'numberonly',
				maxLength: 15,
				cls: 'field-margin'
			}]
		},{
			xtype: 'button',
			hidden: true,
			id: 'buttonchildfour',
			text: 'Add a 4th child',
			handler: function() {
				 var childpanel = Ext.getCmp('childididfour');
				     childpanel.setVisible(true); 
			     var buttonpanel = Ext.getCmp('buttonchildfive');
				     buttonpanel.setVisible(true);  
				     this.setVisible(false);
	       }
		},{
			xtype: 'panel',
			id: 'childididfour',
			hidden: true,
			layout: {
				type: 'hbox',
				align: 'stretch'
			},
			items: [{
				xtype: 'textfield',
				flex: 6,
				name: 'FOURTHCHILDFULLNAME',
				maxLength: 50,
				fieldLabel: 'Child 4',
				cls: 'field-margin'
			},{
				xtype: 'numberfield',
				flex: 1,
				name: 'FOURTHCHILDAGE',
				cls: 'field-margin',
				value: 0,
				minValue: 0,
				maxValue: 99
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'FOURTHCHILDOCCUPATION',
				maxLength: 50,
				cls: 'field-margin'
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'FOURTHCHILDCOMPANY',
				maxLength: 50,
				cls: 'field-margin'
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'FOURTHCHILDCONTACTNO',
				vtype: 'numberonly',
				maxLength: 15,
				cls: 'field-margin'
			}]
		},{
			xtype: 'button',
			hidden: true,
			id: 'buttonchildfive',
			text: 'Add a 5th child',
			handler: function() {
				 var childpanel = Ext.getCmp('childididfive');
				     childpanel.setVisible(true); 
			     var buttonpanel = Ext.getCmp('buttonchildsix');
				     buttonpanel.setVisible(true);  
				     this.setVisible(false);
	       }
		},{
			xtype: 'panel',
			id: 'childididfive',
			hidden: true,
			layout: {
				type: 'hbox',
				align: 'stretch'
			},
			items: [{
				xtype: 'textfield',
				flex: 6,
				name: 'FIFTHCHILDFULLNAME',
				maxLength: 50,
				fieldLabel: 'Child 5',
				cls: 'field-margin'
			},{
				xtype: 'numberfield',
				flex: 1,
				name: 'FIFTHCHILDAGE',
				cls: 'field-margin',
				value: 0,
				minValue: 0,
				maxValue: 99
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'FIFTHCHILDOCCUPATION',
				maxLength: 50,
				cls: 'field-margin'
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'FIFTHCHILDCOMPANY',
				maxLength: 50,
				cls: 'field-margin'
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'FIFTHCHILDCONTACTNO',
				vtype: 'numberonly',
				maxLength: 15,
				cls: 'field-margin'
			}]
		},{
			xtype: 'button',
			hidden: true,
			id: 'buttonchildsix',
			text: 'Add even more children',
			handler: function() {
				this.setVisible(false);
				var childpanel = Ext.getCmp('childididsix');
				     childpanel.setVisible(true);  
				var childpanel = Ext.getCmp('childididseven');
				     childpanel.setVisible(true); 
				var childpanel = Ext.getCmp('childidideight');
				     childpanel.setVisible(true); 
			    var childpanel = Ext.getCmp('childididnine');
				     childpanel.setVisible(true); 
			    var childpanel = Ext.getCmp('childididten');
				     childpanel.setVisible(true); 
			    var childpanel = Ext.getCmp('childidideleven');
				     childpanel.setVisible(true); 
				var childpanel = Ext.getCmp('childididtwelve');
				     childpanel.setVisible(true); 
				var childpanel = Ext.getCmp('childididthirteen');
				     childpanel.setVisible(true); 
				var childpanel = Ext.getCmp('childididfourteen');
				     childpanel.setVisible(true); 
				var childpanel = Ext.getCmp('childididfifteen');
				     childpanel.setVisible(true); 
					 
				     
	       }
		},{
			xtype: 'panel',
			id: 'childididsix',
			hidden: true,
			layout: {
				type: 'hbox',
				align: 'stretch'
			},
			items: [{
				xtype: 'textfield',
				flex: 6,
				name: 'SIXTHCHILDFULLNAME',
				maxLength: 50,
				fieldLabel: 'Child 6',
				cls: 'field-margin'
			},{
				xtype: 'numberfield',
				flex: 1,
				name: 'SIXTHCHILDAGE',
				cls: 'field-margin',
				value: 0,
				minValue: 0,
				maxValue: 99
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'SIXTHCHILDOCCUPATION',
				maxLength: 50,
				cls: 'field-margin'
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'SIXTHCHILDCOMPANY',
				maxLength: 50,
				cls: 'field-margin'
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'SIXTHCHILDCONTACTNO',
				vtype: 'numberonly',
				maxLength: 15,
				cls: 'field-margin'
			}]
		},{
			xtype: 'panel',
			id: 'childididseven',
			hidden: true,
			layout: {
				type: 'hbox',
				align: 'stretch'
			},
			items: [{
				xtype: 'textfield',
				flex: 6,
				name: 'SEVENTHCHILDFULLNAME',
				maxLength: 50,
				fieldLabel: 'Child 7',
				cls: 'field-margin'
			},{
				xtype: 'numberfield',
				flex: 1,
				name: 'SEVENTHCHILDAGE',
				cls: 'field-margin',
				value: 0,
				minValue: 0,
				maxValue: 99
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'SEVENTHCHILDOCCUPATION',
				maxLength: 50,
				cls: 'field-margin'
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'SEVENTHCHILDCOMPANY',
				maxLength: 50,
				cls: 'field-margin'
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'SEVENTHCHILDCONTACTNO',
				vtype: 'numberonly',
				maxLength: 15,
				cls: 'field-margin'
			}]
		},{
			xtype: 'panel',
			id: 'childidideight',
			hidden: true,
			layout: {
				type: 'hbox',
				align: 'stretch'
			},
			items: [{
				xtype: 'textfield',
				flex: 6,
				name: 'EIGHTHCHILDFULLNAME',
				maxLength: 50,
				fieldLabel: 'Child 8',
				cls: 'field-margin'
			},{
				xtype: 'numberfield',
				flex: 1,
				name: 'EIGHTHCHILDAGE',
				cls: 'field-margin',
				value: 0,
				minValue: 0,
				maxValue: 99
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'EIGHTHCHILDOCCUPATION',
				maxLength: 50,
				cls: 'field-margin'
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'EIGHTHCHILDCOMPANY',
				maxLength: 50,
				cls: 'field-margin'
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'EIGHTHCHILDCONTACTNO',
				vtype: 'numberonly',
				maxLength: 15,
				cls: 'field-margin'
			}]
		},{
			xtype: 'panel',
			id: 'childididnine',
			hidden: true,
			layout: {
				type: 'hbox',
				align: 'stretch'
			},
			items: [{
				xtype: 'textfield',
				flex: 6,
				name: 'NINTHCHILDFULLNAME',
				maxLength: 50,
				fieldLabel: 'Child 9',
				cls: 'field-margin'
			},{
				xtype: 'numberfield',
				flex: 1,
				name: 'NINTHCHILDAGE',
				cls: 'field-margin',
				value: 0,
				minValue: 0,
				maxValue: 99
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'NINTHCHILDOCCUPATION',
				maxLength: 50,
				cls: 'field-margin'
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'NINTHCHILDCOMPANY',
				maxLength: 50,
				cls: 'field-margin'
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'NINTHCHILDCONTACTNO',
				vtype: 'numberonly',
				maxLength: 15,
				cls: 'field-margin'
			}]
		},{
			xtype: 'panel',
			id: 'childididten',
			hidden: true,
			layout: {
				type: 'hbox',
				align: 'stretch'
			},
			items: [{
				xtype: 'textfield',
				flex: 6,
				name: 'TENTHCHILDFULLNAME',
				maxLength: 50,
				fieldLabel: 'Child 10',
				cls: 'field-margin'
			},{
				xtype: 'numberfield',
				flex: 1,
				name: 'TENTHCHILDAGE',
				cls: 'field-margin',
				value: 0,
				minValue: 0,
				maxValue: 99
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'TENTHCHILDOCCUPATION',
				maxLength: 50,
				cls: 'field-margin'
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'TENTHCHILDCOMPANY',
				maxLength: 50,
				cls: 'field-margin'
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'TENTHCHILDCONTACTNO',
				vtype: 'numberonly',
				maxLength: 15,
				cls: 'field-margin'
			}]
		},{
			xtype: 'panel',
			id: 'childidideleven',
			hidden: true,
			layout: {
				type: 'hbox',
				align: 'stretch'
			},
			items: [{
				xtype: 'textfield',
				flex: 6,
				name: 'ELEVENTHCHILDFULLNAME',
				maxLength: 50,
				fieldLabel: 'Child 11',
				cls: 'field-margin'
			},{
				xtype: 'numberfield',
				flex: 1,
				name: 'ELEVENTHCHILDAGE',
				cls: 'field-margin',
				value: 0,
				minValue: 0,
				maxValue: 99
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'ELEVENTHCHILDOCCUPATION',
				maxLength: 50,
				cls: 'field-margin'
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'ELEVENTHCHILDCOMPANY',
				maxLength: 50,
				cls: 'field-margin'
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'ELEVENTHCHILDCONTACTNO',
				vtype: 'numberonly',
				maxLength: 15,
				cls: 'field-margin'
			}]
		},{
			xtype: 'panel',
			id: 'childididtwelve',
			hidden: true,
			layout: {
				type: 'hbox',
				align: 'stretch'
			},
			items: [{
				xtype: 'textfield',
				flex: 6,
				name: 'TWELVECHILDFULLNAME',
				maxLength: 50,
				fieldLabel: 'Child 12',
				cls: 'field-margin'
			},{
				xtype: 'numberfield',
				flex: 1,
				name: 'TWELVECHILDAGE',
				cls: 'field-margin',
				value: 0,
				minValue: 0,
				maxValue: 99
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'TWELVECHILDOCCUPATION',
				maxLength: 50,
				cls: 'field-margin'
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'TWELVECHILDCOMPANY',
				maxLength: 50,
				cls: 'field-margin'
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'TWELVECHILDCONTACTNO',
				vtype: 'numberonly',
				maxLength: 15,
				cls: 'field-margin'
			}]
		},{
			xtype: 'panel',
			id: 'childididthirteen',
			hidden: true,
			layout: {
				type: 'hbox',
				align: 'stretch'
			},
			items: [{
				xtype: 'textfield',
				flex: 6,
				name: 'THIRTEENTHCHILDFULLNAME',
				maxLength: 50,
				fieldLabel: 'Child 13',
				cls: 'field-margin'
			},{
				xtype: 'numberfield',
				flex: 1,
				name: 'THIRTEENTHCHILDAGE',
				cls: 'field-margin',
				value: 0,
				minValue: 0,
				maxValue: 99
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'THIRTEENTHCHILDOCCUPATION',
				maxLength: 50,
				cls: 'field-margin'
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'THIRTEENTHCHILDCOMPANY',
				maxLength: 50,
				cls: 'field-margin'
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'THIRTEENTHCHILDCONTACTNO',
				vtype: 'numberonly',
				maxLength: 15,
				cls: 'field-margin'
			}]
		},{
			xtype: 'panel',
			id: 'childididfourteen',
			hidden: true,
			layout: {
				type: 'hbox',
				align: 'stretch'
			},
			items: [{
				xtype: 'textfield',
				flex: 6,
				name: 'FOURTEENTHCHILDFULLNAME',
				maxLength: 50,
				fieldLabel: 'Child 14',
				cls: 'field-margin'
			},{
				xtype: 'numberfield',
				flex: 1,
				name: 'FOURTEENTHCHILDAGE',
				cls: 'field-margin',
				value: 0,
				minValue: 0,
				maxValue: 99
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'FOURTEENTHCHILDOCCUPATION',
				maxLength: 50,
				cls: 'field-margin'
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'FOURTEENTHCHILDCOMPANY',
				maxLength: 50,
				cls: 'field-margin'
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'FOURTEENTHCHILDCONTACTNO',
				vtype: 'numberonly',
				maxLength: 15,
				cls: 'field-margin'
			}]
		},{
			xtype: 'panel',
			id: 'childididfifteen',
			hidden: true,
			layout: {
				type: 'hbox',
				align: 'stretch'
			},
			items: [{
				xtype: 'textfield',
				flex: 6,
				name: 'FIFTEENTHCHILDFULLNAME',
				maxLength: 50,
				fieldLabel: 'Child 15',
				cls: 'field-margin'
			},{
				xtype: 'numberfield',
				flex: 1,
				name: 'FIFTEENTHCHILDAGE',
				cls: 'field-margin',
				value: 0,
				minValue: 0,
				maxValue: 99
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'FIFTEENTHCHILDOCCUPATION',
				maxLength: 50,
				cls: 'field-margin'
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'FIFTEENTHCHILDCOMPANY',
				maxLength: 50,
				cls: 'field-margin'
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'FIFTEENTHCHILDCONTACTNO',
				vtype: 'numberonly',
				maxLength: 15,
				cls: 'field-margin'
			}]
		},{
			xtype: 'button',
			id: 'buttonbroone',
			text: 'Add a brother or a sister',
			handler: function() {
				 var bropanel = Ext.getCmp('broididone');
					 bropanel.setVisible(true); 
				 var buttonpanel = Ext.getCmp('buttonbrotwo');
					 buttonpanel.setVisible(true);  
					 this.setVisible(false);
		   }
		},{
			xtype: 'panel',
			hidden: true,
			id: 'broididone',
			layout: {
				type: 'hbox',
				align: 'stretch'
			},
			items: [{
				xtype: 'textfield',
				flex: 6,
				name: 'FIRSTBROFULLNAME',
				maxLength: 50,
				fieldLabel: 'Brother/sister 1',
				cls: 'field-margin'
			},{
				xtype: 'numberfield',
				flex: 1,
				name: 'FIRSTBROAGE',
				cls: 'field-margin',
				value: 0,
				minValue: 0,
				maxValue: 99
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'FIRSTBROOCCUPATION',
				maxLength: 50,
				cls: 'field-margin'
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'FIRSTBROCOMPANY',
				maxLength: 50,
				cls: 'field-margin'
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'FIRSTBROCONTACTNO',
				vtype: 'numberonly',
				maxLength: 15,
				cls: 'field-margin'
			}]
		},{
			xtype: 'button',
			hidden: true,
			id: 'buttonbrotwo',
			text: 'Add a second brother or a sister',
			handler: function() {
				 var bropanel = Ext.getCmp('broididtwo');
				     bropanel.setVisible(true); 
			     var buttonpanel = Ext.getCmp('buttonbrothree');
				     buttonpanel.setVisible(true);  
				     this.setVisible(false);
	       }
		},{
			xtype: 'panel',
			id: 'broididtwo',
			hidden: true,
			layout: {
				type: 'hbox',
				align: 'stretch'
			},
			items: [{
				xtype: 'textfield',
				flex: 6,
				name: 'SECONDBROFULLNAME',
				maxLength: 50,
				fieldLabel: 'Brother/sister 2',
				cls: 'field-margin'
			},{
				xtype: 'numberfield',
				flex: 1,
				name: 'SECONDBROAGE',
				cls: 'field-margin',
				value: 0,
				minValue: 0,
				maxValue: 99
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'SECONDBROOCCUPATION',
				maxLength: 50,
				cls: 'field-margin'
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'SECONDBROCOMPANY',
				maxLength: 50,
				cls: 'field-margin'
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'SECONDBROCONTACTNO',
				vtype: 'numberonly',
				maxLength: 15,
				cls: 'field-margin'
			}]
		},{
			xtype: 'button',
			hidden: true,
			id: 'buttonbrothree',
			text: 'Add a 3rd brother or a sister',
			handler: function() {
				 var bropanel = Ext.getCmp('broididthree');
				     bropanel.setVisible(true); 
			     var buttonpanel = Ext.getCmp('buttonbrofour');
				     buttonpanel.setVisible(true);  
				     this.setVisible(false);
	       }
		},{
			xtype: 'panel',
			id: 'broididthree',
			hidden: true,
			layout: {
				type: 'hbox',
				align: 'stretch'
			},
			items: [{
				xtype: 'textfield',
				flex: 6,
				name: 'THIRDBROFULLNAME',
				maxLength: 50,
				fieldLabel: 'Brother/sister 3',
				cls: 'field-margin'
			},{
				xtype: 'numberfield',
				flex: 1,
				name: 'THIRDBROAGE',
				cls: 'field-margin',
				value: 0,
				minValue: 0,
				maxValue: 99
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'THIRDBROOCCUPATION',
				maxLength: 50,
				cls: 'field-margin'
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'THIRDBROCOMPANY',
				maxLength: 50,
				cls: 'field-margin'
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'THIRDBROCONTACTNO',
				vtype: 'numberonly',
				maxLength: 15,
				cls: 'field-margin'
			}]
		},{
			xtype: 'button',
			hidden: true,
			id: 'buttonbrofour',
			text: 'Add a 4th brother or a sister',
			handler: function() {
				 var bropanel = Ext.getCmp('broididfour');
				     bropanel.setVisible(true); 
			     var buttonpanel = Ext.getCmp('buttonbrofive');
				     buttonpanel.setVisible(true);  
				     this.setVisible(false);
	       }
		},{
			xtype: 'panel',
			id: 'broididfour',
			hidden: true,
			layout: {
				type: 'hbox',
				align: 'stretch'
			},
			items: [{
				xtype: 'textfield',
				flex: 6,
				name: 'FOURTHBROFULLNAME',
				maxLength: 50,
				fieldLabel: 'Brother/sister 4',
				cls: 'field-margin'
			},{
				xtype: 'numberfield',
				flex: 1,
				name: 'FOURTHBROAGE',
				cls: 'field-margin',
				value: 0,
				minValue: 0,
				maxValue: 99
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'FOURTHBROOCCUPATION',
				maxLength: 50,
				cls: 'field-margin'
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'FOURTHBROCOMPANY',
				maxLength: 50,
				cls: 'field-margin'
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'FOURTHBROCONTACTNO',
				vtype: 'numberonly',
				maxLength: 15,
				cls: 'field-margin'
			}]
		},{
			xtype: 'button',
			hidden: true,
			id: 'buttonbrofive',
			text: 'Add a 5th brother or a sister',
			handler: function() {
				 var bropanel = Ext.getCmp('broididfive');
				     bropanel.setVisible(true); 
			     var buttonpanel = Ext.getCmp('buttonbrosix');
				     buttonpanel.setVisible(true);  
				     this.setVisible(false);
	       }
		},{
			xtype: 'panel',
			id: 'broididfive',
			hidden: true,
			layout: {
				type: 'hbox',
				align: 'stretch'
			},
			items: [{
				xtype: 'textfield',
				flex: 6,
				name: 'FIFTHBROFULLNAME',
				maxLength: 50,
				fieldLabel: 'Brother/sister 5',
				cls: 'field-margin'
			},{
				xtype: 'numberfield',
				flex: 1,
				name: 'FIFTHBROAGE',
				cls: 'field-margin',
				value: 0,
				minValue: 0,
				maxValue: 99
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'FIFTHBROOCCUPATION',
				maxLength: 50,
				cls: 'field-margin'
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'FIFTHBROCOMPANY',
				maxLength: 50,
				cls: 'field-margin'
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'FIFTHBROCONTACTNO',
				vtype: 'numberonly',
				maxLength: 15,
				cls: 'field-margin'
			}]
		},{
			xtype: 'button',
			hidden: true,
			id: 'buttonbrosix',
			text: 'Add even more brothers or a sisters',
			handler: function() {
				this.setVisible(false);
				 var bropanel = Ext.getCmp('broididsix');
				     bropanel.setVisible(true); 
			     var bropanel = Ext.getCmp('broididseven');
				     bropanel.setVisible(true); 
				var bropanel = Ext.getCmp('broidideight');
				     bropanel.setVisible(true); 
			    var bropanel = Ext.getCmp('broididnine');
				     bropanel.setVisible(true); 
			    var bropanel = Ext.getCmp('broididten');
				     bropanel.setVisible(true); 
			    var bropanel = Ext.getCmp('broidideleven');
				     bropanel.setVisible(true); 
				var bropanel = Ext.getCmp('broididtwelve');
				     bropanel.setVisible(true); 
				var bropanel = Ext.getCmp('broididthirteen');
				     bropanel.setVisible(true); 
				var bropanel = Ext.getCmp('broididfourteen');
				     bropanel.setVisible(true); 
				var bropanel = Ext.getCmp('broididfifteen');
				     bropanel.setVisible(true); 
				     
	       }
		},{
			xtype: 'panel',
			id: 'broididsix',
			hidden: true,
			layout: {
				type: 'hbox',
				align: 'stretch'
			},
			items: [{
				xtype: 'textfield',
				flex: 6,
				name: 'SIXTHBROFULLNAME',
				maxLength: 50,
				fieldLabel: 'Brother/sister 6',
				cls: 'field-margin'
			},{
				xtype: 'numberfield',
				flex: 1,
				name: 'SIXTHBROAGE',
				cls: 'field-margin',
				value: 0,
				minValue: 0,
				maxValue: 99
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'SIXTHBROOCCUPATION',
				maxLength: 50,
				cls: 'field-margin'
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'SIXTHBROCOMPANY',
				maxLength: 50,
				cls: 'field-margin'
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'SIXTHBROCONTACTNO',
				vtype: 'numberonly',
				maxLength: 15,
				cls: 'field-margin'
			}]
		},{
			xtype: 'panel',
			id: 'broididseven',
			hidden: true,
			layout: {
				type: 'hbox',
				align: 'stretch'
			},
			items: [{
				xtype: 'textfield',
				flex: 6,
				name: 'SEVENTHBROFULLNAME',
				maxLength: 50,
				fieldLabel: 'Brother/sister 7',
				cls: 'field-margin'
			},{
				xtype: 'numberfield',
				flex: 1,
				name: 'SEVENTHBROAGE',
				cls: 'field-margin',
				value: 0,
				minValue: 0,
				maxValue: 99
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'SEVENTHBROOCCUPATION',
				maxLength: 50,
				cls: 'field-margin'
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'SEVENTHBROCOMPANY',
				maxLength: 50,
				cls: 'field-margin'
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'SEVENTHBROCONTACTNO',
				vtype: 'numberonly',
				maxLength: 15,
				cls: 'field-margin'
			}]
		},{
			xtype: 'panel',
			id: 'broidideight',
			hidden: true,
			layout: {
				type: 'hbox',
				align: 'stretch'
			},
			items: [{
				xtype: 'textfield',
				flex: 6,
				name: 'EIGHTHBROFULLNAME',
				maxLength: 50,
				fieldLabel: 'Brother/sister 8',
				cls: 'field-margin'
			},{
				xtype: 'numberfield',
				flex: 1,
				name: 'EIGHTHBROAGE',
				cls: 'field-margin',
				value: 0,
				minValue: 0,
				maxValue: 99
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'EIGHTHBROOCCUPATION',
				maxLength: 50,
				cls: 'field-margin'
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'EIGHTHBROCOMPANY',
				maxLength: 50,
				cls: 'field-margin'
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'EIGHTHBROCONTACTNO',
				vtype: 'numberonly',
				maxLength: 15,
				cls: 'field-margin'
			}]
		},{
			xtype: 'panel',
			id: 'broididnine',
			hidden: true,
			layout: {
				type: 'hbox',
				align: 'stretch'
			},
			items: [{
				xtype: 'textfield',
				flex: 6,
				name: 'NINTHBROFULLNAME',
				maxLength: 50,
				fieldLabel: 'Brother/sister 9',
				cls: 'field-margin'
			},{
				xtype: 'numberfield',
				flex: 1,
				name: 'NINTHBROAGE',
				cls: 'field-margin',
				value: 0,
				minValue: 0,
				maxValue: 99
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'NINTHBROOCCUPATION',
				maxLength: 50,
				cls: 'field-margin'
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'NINTHBROCOMPANY',
				maxLength: 50,
				cls: 'field-margin'
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'NINTHBROCONTACTNO',
				vtype: 'numberonly',
				maxLength: 15,
				cls: 'field-margin'
			}]
		},{
			xtype: 'panel',
			id: 'broididten',
			hidden: true,
			layout: {
				type: 'hbox',
				align: 'stretch'
			},
			items: [{
				xtype: 'textfield',
				flex: 6,
				name: 'TENTHBROFULLNAME',
				maxLength: 50,
				fieldLabel: 'Brother/sister 10',
				cls: 'field-margin'
			},{
				xtype: 'numberfield',
				flex: 1,
				name: 'TENTHBROAGE',
				cls: 'field-margin',
				value: 0,
				minValue: 0,
				maxValue: 99
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'TENTHBROOCCUPATION',
				maxLength: 50,
				cls: 'field-margin'
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'TENTHBROCOMPANY',
				maxLength: 50,
				cls: 'field-margin'
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'TENTHBROCONTACTNO',
				vtype: 'numberonly',
				maxLength: 15,
				cls: 'field-margin'
			}]
		},{
			xtype: 'panel',
			id: 'broidideleven',
			hidden: true,
			layout: {
				type: 'hbox',
				align: 'stretch'
			},
			items: [{
				xtype: 'textfield',
				flex: 6,
				name: 'ELEVENTHBROFULLNAME',
				maxLength: 50,
				fieldLabel: 'Brother/sister 11',
				cls: 'field-margin'
			},{
				xtype: 'numberfield',
				flex: 1,
				name: 'ELEVENTHBROAGE',
				cls: 'field-margin',
				value: 0,
				minValue: 0,
				maxValue: 99
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'ELEVENTHBROOCCUPATION',
				maxLength: 50,
				cls: 'field-margin'
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'ELEVENTHBROCOMPANY',
				maxLength: 50,
				cls: 'field-margin'
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'ELEVENTHBROCONTACTNO',
				vtype: 'numberonly',
				maxLength: 15,
				cls: 'field-margin'
			}]
		},{
			xtype: 'panel',
			id: 'broididtwelve',
			hidden: true,
			layout: {
				type: 'hbox',
				align: 'stretch'
			},
			items: [{
				xtype: 'textfield',
				flex: 6,
				name: 'TWELVEBROFULLNAME',
				maxLength: 50,
				fieldLabel: 'Brother/sister 12',
				cls: 'field-margin'
			},{
				xtype: 'numberfield',
				flex: 1,
				name: 'TWELVEBROAGE',
				cls: 'field-margin',
				value: 0,
				minValue: 0,
				maxValue: 99
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'TWELVEBROOCCUPATION',
				maxLength: 50,
				cls: 'field-margin'
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'TWELVEBROCOMPANY',
				maxLength: 50,
				cls: 'field-margin'
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'TWELVEBROCONTACTNO',
				vtype: 'numberonly',
				maxLength: 15,
				cls: 'field-margin'
			}]
		},{
			xtype: 'panel',
			id: 'broididthirteen',
			hidden: true,
			layout: {
				type: 'hbox',
				align: 'stretch'
			},
			items: [{
				xtype: 'textfield',
				flex: 6,
				name: 'THIRTEENTHBROFULLNAME',
				maxLength: 50,
				fieldLabel: 'Brother/sister 13',
				cls: 'field-margin'
			},{
				xtype: 'numberfield',
				flex: 1,
				name: 'THIRTEENTHBROAGE',
				cls: 'field-margin',
				value: 0,
				minValue: 0,
				maxValue: 99
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'THIRTEENTHBROOCCUPATION',
				maxLength: 50,
				cls: 'field-margin'
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'THIRTEENTHBROCOMPANY',
				maxLength: 50,
				cls: 'field-margin'
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'THIRTEENTHBROCONTACTNO',
				vtype: 'numberonly',
				maxLength: 15,
				cls: 'field-margin'
			}]
		},{
			xtype: 'panel',
			id: 'broididfourteen',
			hidden: true,
			layout: {
				type: 'hbox',
				align: 'stretch'
			},
			items: [{
				xtype: 'textfield',
				flex: 6,
				name: 'FOURTEENTHBROFULLNAME',
				maxLength: 50,
				fieldLabel: 'Brother/sister 14',
				cls: 'field-margin'
			},{
				xtype: 'numberfield',
				flex: 1,
				name: 'FOURTEENTHBROAGE',
				cls: 'field-margin',
				value: 0,
				minValue: 0,
				maxValue: 99
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'FOURTEENTHBROOCCUPATION',
				maxLength: 50,
				cls: 'field-margin'
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'FOURTEENTHBROCOMPANY',
				maxLength: 50,
				cls: 'field-margin'
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'FOURTEENTHBROCONTACTNO',
				vtype: 'numberonly',
				maxLength: 15,
				cls: 'field-margin'
			}]
		},{
			xtype: 'panel',
			id: 'broididfifteen',
			hidden: true,
			layout: {
				type: 'hbox',
				align: 'stretch'
			},
			items: [{
				xtype: 'textfield',
				flex: 6,
				name: 'FIFTEENTHBROFULLNAME',
				maxLength: 50,
				fieldLabel: 'Brother/sister 15',
				cls: 'field-margin'
			},{
				xtype: 'numberfield',
				flex: 1,
				name: 'FIFTEENTHBROAGE',
				cls: 'field-margin',
				value: 0,
				minValue: 0,
				maxValue: 99
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'FIFTEENTHBROOCCUPATION',
				maxLength: 50,
				cls: 'field-margin'
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'FIFTEENTHBROCOMPANY',
				maxLength: 50,
				cls: 'field-margin'
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'FIFTEENTHBROCONTACTNO',
				vtype: 'numberonly',
				maxLength: 15,
				cls: 'field-margin'
			}]
		},{
			xtype: 'displayfield',
			cls: 'field-margin',
			value: 'In case of emergency, please notify:'
		},{
			xtype: 'panel',
			width: '100%',
			layout: {
				type: 'vbox',
				align: 'left'
			},
			items: [{
				xtype: 'textfield',
				cls: 'field-margin',
				name: 'INCASEEMERNAME',
				allowBlank: false,
				maxLength: 100,
				fieldLabel: 'Name*',
				width: 400
			},{
				xtype: 'textfield',
				cls: 'field-margin',
				name: 'INCASEEMERRELATION',
				allowBlank: false,
				maxLength: 30,
				fieldLabel: 'Relationship*',
				width: 400
			},{
				xtype: 'textfield',
				cls: 'field-margin',
				name: 'INCASEEMERCELLNUM',
				vtype: 'numberonly',
				allowBlank: false,
				maxLength: 15,
				fieldLabel: 'Cellphone Number*',
				width: 400
			},{
				xtype: 'textfield',
				cls: 'field-margin',
				name: 'INCASEEMERTELNUM',
				vtype: 'numberonly',
				allowBlank: false,
				maxLength: 15,
				fieldLabel: 'Telephone Number*',
				width: 400
			}]
		},{
			xtype: 'displayfield',
			cls: 'field-margin',
			value: 'Relatives/Friends Working in Filinvest Group:'
		},{
			xtype: 'panel',
			layout: {
				type: 'hbox',
				align: 'stretch'
			},
			items: [{
				xtype: 'displayfield',
				cls: 'field-margin-center',
				flex: 1,
				value: '<b>Name</b>'
			},{
				xtype: 'displayfield',
				cls: 'field-margin-center',
				flex: 1,
				value: '<b>Company\'s Name/Occupation</b>'
			},{
				xtype: 'displayfield',
				cls: 'field-margin-center',
				flex: 1,
				value: '<b>Degree of Afinity</b>'
			}]
		},{
			xtype: 'panel',
			layout: {
				type: 'hbox',
				align: 'stretch'
			},
			items: [{
				xtype: 'textfield',
				cls: 'field-margin',
				name: 'RELWORKINNAMEONE',
				maxLength: 40,
				flex: 1
			},{
				xtype: 'textfield',
				cls: 'field-margin',
				name: 'RELWORKINCOMPONE',
				maxLength: 50,
				flex: 1
			},{
				xtype: 'textfield',
				cls: 'field-margin',
				name: 'RELWORKINAFINITYONE',
				maxLength: 50,
				flex: 1
			}]
		},{
			xtype: 'panel',
			layout: {
				type: 'hbox',
				align: 'stretch'
			},
			items: [{
				xtype: 'textfield',
				cls: 'field-margin',
				name: 'RELWORKINNAMETWO',
				maxLength: 40,
				flex: 1
			},{
				xtype: 'textfield',
				cls: 'field-margin',
				name: 'RELWORKINCOMPTWO',
				maxLength: 50,
				flex: 1
			},{
				xtype: 'textfield',
				cls: 'field-margin',
				name: 'RELWORKINAFINITYTWO',
				maxLength: 50,
				flex: 1
			}]
		},{
			xtype: 'panel',
			layout: {
				type: 'hbox',
				align: 'stretch'
			},
			items: [{
				xtype: 'textfield',
				cls: 'field-margin',
				name: 'RELWORKINNAMETHREE',
				maxLength: 40,
				flex: 1
			},{
				xtype: 'textfield',
				cls: 'field-margin',
				name: 'RELWORKINCOMPTHREE',
				maxLength: 50,
				flex: 1
			},{
				xtype: 'textfield',
				cls: 'field-margin',
				name: 'RELWORKINAFINITYTHREE',
				maxLength: 50,
				flex: 1
			}]
		}]
	},{
		title: 'EDUCATIONAL BACKGROUND',
		xtype: 'panel',
		width: '80%',
		flex: 5,
		collapsible: true,
		layout: {
			type: 'vbox',
			align: 'left'
		},
		items: [{
			xtype: 'panel',
			width: '100%',
			layout: {
				type: 'hbox',
				align: 'stretch'
			},
			items: [{
				xtype: 'displayfield',
				cls: 'field-margin-center',
				value: '<b>Name of School</b>',
				flex: 7  
			},{
				xtype: 'displayfield',
				cls: 'field-margin-center',
				value: '<b>Field of Study</b>',
				flex: 5
			},{
				xtype: 'displayfield',
				cls: 'field-margin-center',
				value: '<b>Course</b>',
				flex: 5
			},{
				xtype: 'displayfield',
				cls: 'field-margin-center',
				value: '<b>Graduate?</b>',
				flex: 3
			},{
				xtype: 'displayfield',
				cls: 'field-margin-center',
				value: '<b>From</b>',
				flex: 3
			},{
				xtype: 'displayfield',
				cls: 'field-margin-center',
				value: '<b>To</b>',
				flex: 3
			},{
				xtype: 'displayfield',
				cls: 'field-margin-center',
				value: '<b>Honors/Awards</b>',
				flex: 4
			}]
		},{
			xtype: 'panel',
			width: '100%',
			layout: {
				type: 'hbox',
				align: 'left'
			},
			items: [{
				xtype: 'combobox',
				cls: 'field-margin',
				fieldLabel: 'Post Graduate*',
				labelAlign: 'top',
				minChars: 1,
				name: 'POSTGRADSCHOOL',
				allowBlank: false,
				maxLength: 100,
				store: schoollk,
				displayField: 'schoolname',
				valueField: 'schoolcode',
				flex: 7  
			},{
				xtype: 'combobox',
				cls: 'field-margin',
				name: 'POSTGRADFIELD',
				allowBlank: false,
				editable: false,
				maxLength: 100,
				fieldLabel: '*',
				labelAlign: 'top',
				store: fieldlk,
				displayField: 'fieldname',
				valueField: 'fieldcode',
				flex: 5
			},{
				xtype: 'combobox',
				cls: 'field-margin',
				fieldLabel: '*',
				labelAlign: 'top',
				minChars: 1,
				name: 'POSTGRADCOURSE',
				allowBlank: false,
				maxLength: 100,
				store: courselk,
				displayField: 'coursename',
				valueField: 'coursecode',
				flex: 5
			},{
				xtype: 'container',
				flex: 3,
				layout: {
					type: 'hbox',
					align: 'stretch'
				},
				items: [{
					xtype: 'radiofield',
					name: 'POSTGRADISGRAD',
					inputValue: 'Y',
					flex: 1,
					style: {
						marginLeft: 20
					},
					labelAlign: 'top',
					fieldLabel: 'Yes'
				},{
					xtype: 'radiofield',
					name: 'POSTGRADISGRAD',
					inputValue: 'N',
					flex: 1,
					labelAlign: 'top',
					fieldLabel: 'No'
				}]
			},{
				xtype: 'monthfield',
				format: 'F Y',
				cls: 'field-margin',
				name: 'POSTGRADFROM',
				fieldLabel: ' ',
				labelAlign: 'top',
				flex: 3
			},{
				xtype: 'monthfield',
				format: 'F Y',
				cls: 'field-margin',
				fieldLabel: ' ',
				labelAlign: 'top',
				name: 'POSTGRADTO',
				flex: 3
			},{
				xtype: 'textfield',
				cls: 'field-margin',
				fieldLabel: ' ',
				labelAlign: 'top',
				maxLength: 200,
				name: 'POSTGRADHONORS',
				flex: 4
			}]
		},{
			xtype: 'panel',
			width: '100%',
			layout: {
				type: 'hbox',
				align: 'left'
			},
			items: [{
				xtype: 'combobox',
				cls: 'field-margin',
				fieldLabel: 'College*',
				labelAlign: 'top',
				minChars: 1,
				name: 'COLLEGESCHOOL',
				allowBlank: false,
				maxLength: 100,
				store: schoollk,
				displayField: 'schoolname',
				valueField: 'schoolcode',
				flex: 7  
			},{
				xtype: 'combobox',
				cls: 'field-margin',
				name: 'COLLEGEFIELD',
				allowBlank: false,
				editable: false,
				maxLength: 100,
				fieldLabel: '*',
				labelAlign: 'top',
				store: fieldlk,
				displayField: 'fieldname',
				valueField: 'fieldcode',
				flex: 5
			},{
				xtype: 'combobox',
				cls: 'field-margin',
				fieldLabel: '*',
				labelAlign: 'top',
				minChars: 1,
				name: 'COLLEGECOURSE',
				allowBlank: false,
				maxLength: 100,
				store: courselk,
				displayField: 'coursename',
				valueField: 'coursecode',
				flex: 5
			},{
				xtype: 'container',
				flex: 3,
				layout: {
					type: 'hbox',
					align: 'stretch'
				},
				items: [{
					xtype: 'radiofield',
					name: 'COLLEGEISGRAD',
					inputValue: 'Y',
					flex: 1,
					style: {
						marginLeft: 20
					},
					labelAlign: 'top',
					fieldLabel: 'Yes'
				},{
					xtype: 'radiofield',
					name: 'COLLEGEISGRAD',
					inputValue: 'N',
					flex: 1,
					labelAlign: 'top',
					fieldLabel: 'No'
				}]
			},{
				xtype: 'monthfield',
				format: 'F Y',
				cls: 'field-margin',
				name: 'COLLEGEFROM',
				fieldLabel: ' ',
				labelAlign: 'top',
				flex: 3
			},{
				xtype: 'monthfield',
				format: 'F Y',
				cls: 'field-margin',
				fieldLabel: ' ',
				labelAlign: 'top',
				name: 'COLLEGETO',
				flex: 3
			},{
				xtype: 'textfield',
				cls: 'field-margin',
				fieldLabel: ' ',
				labelAlign: 'top',
				name: 'COLLEGEHONORS',
				maxLength: 200,
				flex: 4
			}]
		},{
			xtype: 'panel',
			width: '100%',
			layout: {
				type: 'hbox',
				align: 'left'
			},
			items: [{
				xtype: 'combobox',
				cls: 'field-margin',
				fieldLabel: 'Vocational',
				labelAlign: 'top',
				minChars: 1,
				name: 'VOCATIONALSCHOOL',
				maxLength: 100,
				store: schoollk,
				displayField: 'schoolname',
				valueField: 'schoolcode',
				flex: 7  
			},{
				xtype: 'combobox',
				cls: 'field-margin',
				name: 'VOCATIONALFIELD',
				editable: false,
				maxLength: 100,
				fieldLabel: ' ',
				labelAlign: 'top',
				store: fieldlk,
				displayField: 'fieldname',
				valueField: 'fieldcode',
				flex: 5
			},{
				xtype: 'combobox',
				cls: 'field-margin',
				fieldLabel: ' ',
				labelAlign: 'top',
				minChars: 1,
				name: 'VOCATIONALCOURSE',
				maxLength: 100,
				store: courselk,
				displayField: 'coursename',
				valueField: 'coursecode',
				flex: 5
			},{
				xtype: 'container',
				flex: 3,
				layout: {
					type: 'hbox',
					align: 'stretch'
				},
				items: [{
					xtype: 'radiofield',
					name: 'VOCATIONALISGRAD',
					inputValue: 'Y',
					flex: 1,
					style: {
						marginLeft: 20
					},
					labelAlign: 'top',
					fieldLabel: 'Yes'
				},{
					xtype: 'radiofield',
					name: 'VOCATIONALISGRAD',
					inputValue: 'N',
					flex: 1,
					labelAlign: 'top',
					fieldLabel: 'No'
				}]
			},{
				xtype: 'monthfield',
				format: 'F Y',
				cls: 'field-margin',
				name: 'VOCATIONALFROM',
				fieldLabel: ' ',
				labelAlign: 'top',
				flex: 3
			},{
				xtype: 'monthfield',
				format: 'F Y',
				cls: 'field-margin',
				fieldLabel: ' ',
				labelAlign: 'top',
				name: 'VOCATIONALTO',
				flex: 3
			},{
				xtype: 'textfield',
				cls: 'field-margin',
				fieldLabel: ' ',
				labelAlign: 'top',
				name: 'VOCATIONALHONORS',
				maxLength: 200,
				flex: 4
			}]
		},{
			xtype: 'panel',
			width: '100%',
			layout: {
				type: 'hbox',
				align: 'left'
			},
			items: [{
				xtype: 'combobox',
				cls: 'field-margin',
				fieldLabel: 'Secondary',
				labelAlign: 'top',
				minChars: 1,
				name: 'SECONDARYSCHOOL',
				maxLength: 100,
				store: schoollk,
				displayField: 'schoolname',
				valueField: 'schoolcode',
				flex: 7  
			},{
				xtype: 'combobox',
				cls: 'field-margin',
				name: 'SECONDARYFIELD',
				editable: false,
				maxLength: 100,
				fieldLabel: ' ',
				labelAlign: 'top',
				store: fieldlk,
				displayField: 'fieldname',
				valueField: 'fieldcode',
				flex: 5
			},{
				xtype: 'combobox',
				cls: 'field-margin',
				fieldLabel: ' ',
				labelAlign: 'top',
				minChars: 1,
				name: 'SECONDARYCOURSE',
				maxLength: 100,
				store: courselk,
				displayField: 'coursename',
				valueField: 'coursecode',
				flex: 5
			},{
				xtype: 'container',
				flex: 3,
				layout: {
					type: 'hbox',
					align: 'stretch'
				},
				items: [{
					xtype: 'radiofield',
					name: 'SECONDARYISGRAD',
					inputValue: 'Y',
					flex: 1,
					style: {
						marginLeft: 20
					},
					labelAlign: 'top',
					fieldLabel: 'Yes'
				},{
					xtype: 'radiofield',
					name: 'SECONDARYISGRAD',
					inputValue: 'N',
					flex: 1,
					labelAlign: 'top',
					fieldLabel: 'No'
				}]
			},{
				xtype: 'monthfield',
				format: 'F Y',
				cls: 'field-margin',
				name: 'SECONDARYFROM',
				fieldLabel: ' ',
				labelAlign: 'top',
				flex: 3
			},{
				xtype: 'monthfield',
				format: 'F Y',
				cls: 'field-margin',
				fieldLabel: ' ',
				labelAlign: 'top',
				name: 'SECONDARYTO',
				flex: 3
			},{
				xtype: 'textfield',
				cls: 'field-margin',
				fieldLabel: ' ',
				labelAlign: 'top',
				name: 'SECONDARYHONORS',
				maxLength: 200,
				flex: 4
			}]
		}] 
	},{
		title: 'EXTRA CURRICULAR',
		xtype: 'panel',
		width: '80%',
		collapsible: true,
		flex: 4,
		layout: {
			type: 'vbox',
			align: 'center'
		},
		items: [{
			xtype: 'panel',
			width: '100%',
			layout: {
				type: 'hbox',
				align: 'stretch'
			},
			items: [{
				xtype: 'displayfield',
				cls: 'field-margin-center',
				value: '<b>Name of Organization</b>',
				flex: 1
			},{
				xtype: 'displayfield',
				cls: 'field-margin-center',
				value: '<b>Inclusive Dates</b>',
				flex: 1
			},{
				xtype: 'displayfield',
				cls: 'field-margin-center',
				value: '<b>Highest Position Held</b>',
				flex: 1
			}]
			
		},{
			xtype: 'button',
			id: 'trainingseminarone',
			text: 'Add extra curricular',
			handler: function() {
				 var bropanel = Ext.getCmp('xtraorgone');
					 bropanel.setVisible(true); 
				 var buttonpanel = Ext.getCmp('trainingseminartwo');
					 buttonpanel.setVisible(true);  
					 this.setVisible(false);
		   }
		},{
			xtype: 'panel',
			hidden: true,
			id: 'xtraorgone',
			width: '100%',
			layout: {
				type: 'hbox',
				align: 'stretch'
			},
			items: [{
				xtype: 'textfield',
				cls: 'field-margin',
				name: 'FIRSTEXTRAORGNAME',
				maxLength: 100,
				flex: 1
			},{
				xtype: 'container',
				flex: 1,
				layout: {
					type: 'hbox',
					align: 'stretch'
				},
				items: [{
					xtype: 'monthfield',
				    format: 'F Y',
					cls: 'field-margin',
					name: 'FIRSTEXTRAORGIDATE',
					emptyText: 'From',
					flex: 1
				},{
					xtype: 'monthfield',
				    format: 'F Y',
					cls: 'field-margin',
					name: 'FIRSTEXTRAORGIDATE',
					emptyText: 'To',
					flex: 1
				}]
			},{
				xtype: 'textfield',
				cls: 'field-margin',
				name: 'FIRSTEXTRAORGHIGHPOSHELD',
				maxLength: 50,
				flex: 1
			}]
			
		},{
			xtype: 'button',
			id: 'trainingseminartwo',
			hidden: true,
			text: 'Add extra curricular',
			handler: function() {
				 var bropanel = Ext.getCmp('xtraorgtwo');
					 bropanel.setVisible(true); 
				 var buttonpanel = Ext.getCmp('trainingseminarthree');
					 buttonpanel.setVisible(true);  
					 this.setVisible(false);
		   }
		},{
			xtype: 'panel',
			hidden: true,
			id: 'xtraorgtwo',
			width: '100%',
			layout: {
				type: 'hbox',
				align: 'stretch'
			},
			items: [{
				xtype: 'textfield',
				cls: 'field-margin',
				name: 'SECONDEXTRAORGNAME',
				maxLength: 100,
				flex: 1
			},{
				xtype: 'container',
				flex: 1,
				layout: {
					type: 'hbox',
					align: 'stretch'
				},
				items: [{
					xtype: 'monthfield',
				    format: 'F Y',
					cls: 'field-margin',
					name: 'SECONDEXTRAORGIDATE',
					emptyText: 'From',
					flex: 1
				},{
					xtype: 'monthfield',
				    format: 'F Y',
					cls: 'field-margin',
					name: 'SECONDEXTRAORGIDATE',
					emptyText: 'To',
					flex: 1
				}]
			},{
				xtype: 'textfield',
				cls: 'field-margin',
				name: 'SECONDEXTRAORGHIGHPOSHELD',
				maxLength: 50,
				flex: 1
			}]
			
		},{
			xtype: 'button',
			id: 'trainingseminarthree',
			hidden: true,
			text: 'Add extra curricular',
			handler: function() {
				 var bropanel = Ext.getCmp('xtraorgthree');
					 bropanel.setVisible(true); 
				 var buttonpanel = Ext.getCmp('trainingseminarfour');
					 buttonpanel.setVisible(true);  
					 this.setVisible(false);
		   }
		},{
			xtype: 'panel',
			hidden: true,
			id: 'xtraorgthree',
			width: '100%',
			layout: {
				type: 'hbox',
				align: 'stretch'
			},
			items: [{
				xtype: 'textfield',
				cls: 'field-margin',
				name: 'THIRDEXTRAORGNAME',
				maxLength: 100,
				flex: 1
			},{
				xtype: 'container',
				flex: 1,
				layout: {
					type: 'hbox',
					align: 'stretch'
				},
				items: [{
					xtype: 'monthfield',
				    format: 'F Y',
					cls: 'field-margin',
					name: 'THIRDEXTRAORGIDATE',
					emptyText: 'From',
					flex: 1
				},{
					xtype: 'monthfield',
				    format: 'F Y',
					cls: 'field-margin',
					name: 'THIRDEXTRAORGIDATE',
					emptyText: 'To',
					flex: 1
				}]
			},{
				xtype: 'textfield',
				cls: 'field-margin',
				name: 'THIRDEXTRAORGHIGHPOSHELD',
				maxLength: 50,
				flex: 1
			}]
			
		},{
			xtype: 'button',
			id: 'trainingseminarfour',
			hidden: true,
			text: 'Add extra curricular',
			handler: function() {
				 var bropanel = Ext.getCmp('xtraorgfour');
					 bropanel.setVisible(true); 
				 var buttonpanel = Ext.getCmp('trainingseminarfive');
					 buttonpanel.setVisible(true);  
					 this.setVisible(false);
		   }
		},{
			xtype: 'panel',
			hidden: true,
			id: 'xtraorgfour',
			width: '100%',
			layout: {
				type: 'hbox',
				align: 'stretch'
			},
			items: [{
				xtype: 'textfield',
				cls: 'field-margin',
				name: 'FOURTHEXTRAORGNAME',
				maxLength: 100,
				flex: 1
			},{
				xtype: 'container',
				flex: 1,
				layout: {
					type: 'hbox',
					align: 'stretch'
				},
				items: [{
					xtype: 'monthfield',
				    format: 'F Y',
					cls: 'field-margin',
					name: 'FOURTHEXTRAORGIDATE',
					emptyText: 'From',
					flex: 1
				},{
					xtype: 'monthfield',
				    format: 'F Y',
					cls: 'field-margin',
					name: 'FOURTHEXTRAORGIDATE',
					emptyText: 'To',
					flex: 1
				}]
			},{
				xtype: 'textfield',
				cls: 'field-margin',
				name: 'FOURTHEXTRAORGHIGHPOSHELD',
				maxLength: 50,
				flex: 1
			}]
			
		},{
			xtype: 'button',
			id: 'trainingseminarfive',
			hidden: true,
			text: 'Add',
			handler: function() {
				 var bropanel = Ext.getCmp('xtraorgfive');
					 bropanel.setVisible(true);  
					 this.setVisible(false);
		   }
		},{
			xtype: 'panel',
			hidden: true,
			id: 'xtraorgfive',
			width: '100%',
			layout: {
				type: 'hbox',
				align: 'stretch'
			},
			items: [{
				xtype: 'textfield',
				cls: 'field-margin',
				name: 'FIFTHEXTRAORGNAME',
				maxLength: 100,
				flex: 1
			},{
				xtype: 'container',
				flex: 1,
				layout: {
					type: 'hbox',
					align: 'stretch'
				},
				items: [{
					xtype: 'monthfield',
				    format: 'F Y',
					cls: 'field-margin',
					name: 'FIFTHEXTRAORGIDATE',
					emptyText: 'From',
					flex: 1
				},{
					xtype: 'monthfield',
				    format: 'F Y',
					cls: 'field-margin',
					name: 'FIFTHEXTRAORGIDATE',
					emptyText: 'To',
					flex: 1
				}]
			},{
				xtype: 'textfield',
				cls: 'field-margin',
				name: 'FIFTHEXTRAORGHIGHPOSHELD',
				maxLength: 50,
				flex: 1
			}]
			
		}]
	},{
		title: 'ADDITIONAL INFORMATION',
		xtype: 'panel',
		width: '80%',
		flex: 5,
		collapsible: true,
		layout: {
			type: 'vbox',
			align: 'center'
		},
		items: [{
			xtype: 'panel',
			width: '100%',
			layout: {
				type: 'hbox',
				align: 'stretch'
			},
			items: [{
				xtype: 'displayfield',
				cls: 'field-margin-center',
				value: '<b>Government/Licensure Exam Passed</b>',
				flex: 1
			},{
				xtype: 'displayfield',
				cls: 'field-margin-center',
				value: '<b>Date Taken</b>',
				flex: 1
			},{
				xtype: 'displayfield',
				cls: 'field-margin-center',
				value: '<b>Rating</b>',
				flex: 1
			}]
			
		},{
			xtype: 'button',
			id: 'trainingseminarseven',
			text: 'Add',
			handler: function() {
				 var bropanel = Ext.getCmp('xtraorgseven');
					 bropanel.setVisible(true); 
				 var buttonpanel = Ext.getCmp('trainingseminareight');
					 buttonpanel.setVisible(true);  
					 this.setVisible(false);
		   }
		},{
			xtype: 'panel',
			hidden: true,
			id: 'xtraorgseven',
			width: '100%',
			layout: {
				type: 'hbox',
				align: 'stretch'
			},
			items: [{
				xtype: 'combobox',
				cls: 'field-margin',
				name: 'FIRSTGOVEXAMPASSED',
				maxLength: 100,
				editable: false,
				store: govexamlk,
				displayField: 'govexamname',
				valueField: 'govexamcode',
				flex: 1
			},{
				
				xtype: 'monthfield',
				format: 'F Y',
				cls: 'field-margin',
				name: 'FIRSTGOVEXAMDATE',
				flex: 1
				
			},{
				xtype: 'textfield',
				cls: 'field-margin',
				name: 'FIRSTGOVEXAMRATING',
				maxLength: 50,
				flex: 1
			}]
			
		},{
			xtype: 'button',
			id: 'trainingseminareight',
			hidden: true,
			text: 'Add',
			handler: function() {
				 var bropanel = Ext.getCmp('xtraorgeight');
					 bropanel.setVisible(true); 
				 var buttonpanel = Ext.getCmp('trainingseminarnine');
					 buttonpanel.setVisible(true);  
					 this.setVisible(false);
		   }
		},{
			xtype: 'panel',
			hidden: true,
			id: 'xtraorgeight',
			width: '100%',
			layout: {
				type: 'hbox',
				align: 'stretch'
			},
			items: [{
				xtype: 'combobox',
				cls: 'field-margin',
				name: 'SECONDGOVEXAMPASSED',
				maxLength: 100,
				editable: false,
				store: govexamlk,
				displayField: 'govexamname',
				valueField: 'govexamcode',
				flex: 1
			},{
				
				xtype: 'monthfield',
				format: 'F Y',
				cls: 'field-margin',
				name: 'SECONDGOVEXAMDATE',
				flex: 1
				
			},{
				xtype: 'textfield',
				cls: 'field-margin',
				name: 'SECONDGOVEXAMRATING',
				maxLength: 50,
				flex: 1
			}]
		},{
			xtype: 'button',
			id: 'trainingseminarnine',
			hidden: true,
			text: 'Add',
			handler: function() {
				 var bropanel = Ext.getCmp('xtraorgnine');
					 bropanel.setVisible(true); 
				 var buttonpanel = Ext.getCmp('trainingseminarten');
					 buttonpanel.setVisible(true);  
					 this.setVisible(false);
		   }
		},{
			xtype: 'panel',
			hidden: true,
			id: 'xtraorgnine',
			width: '100%',
			layout: {
				type: 'hbox',
				align: 'stretch'
			},
			items: [{
				xtype: 'combobox',
				cls: 'field-margin',
				name: 'THIRDGOVEXAMPASSED',
				maxLength: 100,
				editable: false,
				store: govexamlk,
				displayField: 'govexamname',
				valueField: 'govexamcode',
				flex: 1
			},{
				
				xtype: 'monthfield',
				format: 'F Y',
				cls: 'field-margin',
				name: 'THIRDGOVEXAMDATE',
				flex: 1
				
			},{
				xtype: 'textfield',
				cls: 'field-margin',
				name: 'THIRDGOVEXAMRATING',
				maxLength: 50,
				flex: 1
			}]
		},{
			xtype: 'button',
			id: 'trainingseminarten',
			hidden: true,
			text: 'Add',
			handler: function() {
				 var bropanel = Ext.getCmp('xtraorgten');
					 bropanel.setVisible(true); 
					 this.setVisible(false);
		   }
		},{
			xtype: 'panel',
			hidden: true,
			id: 'xtraorgten',
			width: '100%',
			layout: {
				type: 'hbox',
				align: 'stretch'
			},
			items: [{
				xtype: 'combobox',
				cls: 'field-margin',
				name: 'FOURTHGOVEXAMPASSED',
				maxLength: 100,
				editable: false,
				store: govexamlk,
				displayField: 'govexamname',
				valueField: 'govexamcode',
				flex: 1
			},{
				
				xtype: 'monthfield',
				format: 'F Y',
				cls: 'field-margin',
				name: 'FOURTHGOVEXAMDATE',
				flex: 1
				
			},{
				xtype: 'textfield',
				cls: 'field-margin',
				name: 'FOURTHGOVEXAMRATING',
				maxLength: 50,
				flex: 1
			}]
			
		},{
			xtype: 'textfield',
			cls: 'field-margin',
			name: 'BOARDEXAMRESULT',
			fieldLabel: 'Board Exam Results and Ratings',
			maxLength: 200,
			labelWidth: 300,
			width: 600
		},{
			xtype: 'textfield',
			cls: 'field-margin',
			name: 'LICENSECERT',
			fieldLabel: 'License and Certification of Present Profession',
			maxLength: 200,
			labelWidth: 300,
			width: 600
		},{
			xtype: 'textfield',
			cls: 'field-margin',
			name: 'LANGUAGESPOKEN',
			fieldLabel: 'Languages and Dialects Spoken/Written',
			maxLength: 50,
			labelWidth: 300,
			width: 600
		}]
	},{
		title: 'TRAININGS AND SEMINARS',
		xtype: 'panel',
		collapsible: true,
		width: '80%',
		flex: 5,
		layout: {
			type: 'vbox',
			align: 'center'
		},
		items: [{
			xtype: 'panel',
			width: '100%',
			layout: {
				type: 'hbox',
				align: 'stretch'
			},
			items: [{
				xtype: 'displayfield',
				cls: 'field-margin-center',
				value: '<b>Topic</b>',
				flex: 1
			},{
				xtype: 'displayfield',
				cls: 'field-margin-center',
				value: '<b>Date</b>',
				flex: 1
			},{
				xtype: 'displayfield',
				cls: 'field-margin-center',
				value: '<b>Organizer</b>',
				flex: 1
			}]
			
		},{
			xtype: 'button',
			id: 'trainingseminartwelve',
			text: 'Add',
			handler: function() {
				 var bropanel = Ext.getCmp('xtraorgtwelve');
					 bropanel.setVisible(true); 
				 var buttonpanel = Ext.getCmp('trainingseminarthirteen');
					 buttonpanel.setVisible(true);  
					 this.setVisible(false);
		   }
		},{
			xtype: 'panel',
			hidden: true,
			id: 'xtraorgtwelve',
			width: '100%',
			layout: {
				type: 'hbox',
				align: 'stretch'
			},
			items: [{
				xtype: 'textfield',
				cls: 'field-margin',
				name: 'FIRSTSEMINARTOPIC',
				maxLength: 100,
				flex: 1
			},{
				
				xtype: 'monthfield',
				format: 'F Y',
				cls: 'field-margin',
				name: 'FIRSTSEMINARDATE',
				flex: 1
				
			},{
				xtype: 'textfield',
				cls: 'field-margin',
				name: 'FIRSTSEMINARORGANIZER',
				maxLength: 50,
				flex: 1
			}]
			
		},{
			xtype: 'button',
			id: 'trainingseminarthirteen',
			hidden: true,
			text: 'Add',
			handler: function() {
				 var bropanel = Ext.getCmp('xtraorgthirteen');
					 bropanel.setVisible(true); 
				 var buttonpanel = Ext.getCmp('trainingseminarfourteen');
					 buttonpanel.setVisible(true);  
					 this.setVisible(false);
		   }
		},{
			xtype: 'panel',
			hidden: true,
			id: 'xtraorgthirteen',
			width: '100%',
			layout: {
				type: 'hbox',
				align: 'stretch'
			},
			items: [{
				xtype: 'textfield',
				cls: 'field-margin',
				name: 'SECONDSEMINARTOPIC',
				maxLength: 100,
				flex: 1
			},{
				xtype: 'monthfield',
				format: 'F Y',
				cls: 'field-margin',
				name: 'SECONDSEMINARDATE',
				flex: 1
			},{
				xtype: 'textfield',
				cls: 'field-margin',
				name: 'SECONDSEMINARORGANIZER',
				maxLength: 50,
				flex: 1
			}]
		},{
			xtype: 'button',
			id: 'trainingseminarfourteen',
			hidden: true,
			text: 'Add',
			handler: function() {
				 var bropanel = Ext.getCmp('xtraorgfourteen');
					 bropanel.setVisible(true); 
				 var buttonpanel = Ext.getCmp('trainingseminarfifteen');
					 buttonpanel.setVisible(true);  
					 this.setVisible(false);
		   }
		},{
			xtype: 'panel',
			hidden: true,
			id: 'xtraorgfourteen',
			width: '100%',
			layout: {
				type: 'hbox',
				align: 'stretch'
			},
			items: [{
				xtype: 'textfield',
				cls: 'field-margin',
				name: 'THIRDSEMINARTOPIC',
				maxLength: 100,
				flex: 1
			},{
				xtype: 'monthfield',
				format: 'F Y',
				cls: 'field-margin',
				name: 'THIRDSEMINARDATE',
				flex: 1
			},{
				xtype: 'textfield',
				cls: 'field-margin',
				name: 'THIRDSEMINARORGANIZER',
				maxLength: 50,
				flex: 1
			}]
		},{
			xtype: 'button',
			id: 'trainingseminarfifteen',
			hidden: true,
			text: 'Add',
			handler: function() {
				 var bropanel = Ext.getCmp('xtraorgfifteen');
					 bropanel.setVisible(true); 
				 var buttonpanel = Ext.getCmp('trainingseminarsixteen');
					 buttonpanel.setVisible(true);  
					 this.setVisible(false);
		   }
		},{
			xtype: 'panel',
			hidden: true,
			id: 'xtraorgfifteen',
			width: '100%',
			layout: {
				type: 'hbox',
				align: 'stretch'
			},
			items: [{
				xtype: 'textfield',
				cls: 'field-margin',
				name: 'FOURTHSEMINARTOPIC',
				maxLength: 100,
				flex: 1
			},{
				xtype: 'monthfield',
				format: 'F Y',
				cls: 'field-margin',
				name: 'FOURTHSEMINARDATE',
				flex: 1
			},{
				xtype: 'textfield',
				cls: 'field-margin',
				name: 'FOURTHSEMINARORGANIZER',
				maxLength: 50,
				flex: 1
			}]
		},{
			xtype: 'button',
			id: 'trainingseminarsixteen',
			hidden: true,
			text: 'Add',
			handler: function() {
				 var bropanel = Ext.getCmp('xtraorgsixteen');
					 bropanel.setVisible(true); 
				 var buttonpanel = Ext.getCmp('trainingseminarseventeen');
					 buttonpanel.setVisible(true);  
					 this.setVisible(false);
		   }
		},{
			xtype: 'panel',
			hidden: true,
			id: 'xtraorgsixteen',
			width: '100%',
			layout: {
				type: 'hbox',
				align: 'stretch'
			},
			items: [{
				xtype: 'textfield',
				cls: 'field-margin',
				name: 'FIFTHSEMINARTOPIC',
				maxLength: 100,
				flex: 1
			},{
				xtype: 'monthfield',
				format: 'F Y',
				cls: 'field-margin',
				name: 'FIFTHSEMINARDATE',
				flex: 1
			},{
				xtype: 'textfield',
				cls: 'field-margin',
				name: 'FIFTHSEMINARORGANIZER',
				maxLength: 50,
				flex: 1
			}]
		},{
			xtype: 'button',
			id: 'trainingseminarseventeen',
			hidden: true,
			text: 'Add',
			handler: function() {
				 var bropanel = Ext.getCmp('xtraorgseventeen');
					 bropanel.setVisible(true);  
					 this.setVisible(false);
		   }
		},{
			xtype: 'panel',
			hidden: true,
			id: 'xtraorgseventeen',
			width: '100%',
			layout: {
				type: 'hbox',
				align: 'stretch'
			},
			items: [{
				xtype: 'textfield',
				cls: 'field-margin',
				name: 'SIXTHSEMINARTOPIC',
				maxLength: 100,
				flex: 1
			},{
				xtype: 'monthfield',
				format: 'F Y',
				cls: 'field-margin',
				name: 'SIXTHSEMINARDATE',
				flex: 1
			},{
				xtype: 'textfield',
				cls: 'field-margin',
				name: 'SIXTHSEMINARORGANIZER',
				maxLength: 50,
				flex: 1
			}]
		}]
	},{
		title: 'EMPLOYMENT HISTORY',
		autoScroll: true,
		collapsible: true,
		xtype: 'panel',
		width: '80%',
		flex: 8,
		layout: {
			type: 'vbox',
			align: 'center'
		},
		items: [{
			xtype: 'displayfield',
			value: 'Fill-up the following legibly. Start from the most recent employment.',
			cls: 'field-margin'
		},{
			xtype: 'panel',
			id: 'employmenthistoryone',
			width: '100%',
			layout: {
				type: 'hbox',
				align: 'left'
			},
			items: [{
				xtype: 'container',
				flex: 1,
				layout: {
					type: 'vbox',
					align: 'left'
				},
				items: [{
					xtype: 'textfield',
					cls: 'field-margin',
					width: 400,
					fieldLabel: 'Company Name',
					maxLength: 50,
					name: 'FIRSTEMPHISTORYNAME'
				},{
					xtype: 'textfield',
					width: 400,
					cls: 'field-margin',
					fieldLabel: 'Company Address',
					maxLength: 100,
					name: 'FIRSTEMPHISTORYADDRESS'
				},{
					xtype: 'textfield',
					width: 400,
					cls: 'field-margin',
					fieldLabel: 'Last Position Held',
					maxLength: 50,
					name: 'FIRSTEMPHISTORYLASTPOS'
				},{
					xtype: 'textareafield',
					width: 400,
					cls: 'field-margin',
					fieldLabel: 'Reason/s for leaving',
					maxLength: 255,
					name: 'FIRSTEMPHISTORYLEAVEREASONS'
				}]
			},{
				xtype: 'container',
				flex: 1,
				layout: {
					type: 'vbox',
					align: 'left'
				},
				items: [{
					xtype: 'monthfield',
				    format: 'F Y',
					cls: 'field-margin',
					fieldLabel: 'Date Employed',
					width: 400,
					name: 'FIRSTEMPHISTORYDATEEMP'
				},{
					xtype: 'monthfield',
				    format: 'F Y',
					width: 400,
					cls: 'field-margin',
					fieldLabel: 'Date Separated',
					name: 'FIRSTEMPHISTORYDATESEP'
					
				},{
					xtype: 'numberfield',
					width: 400,
					cls: 'field-margin',
					fieldLabel: 'Initial Salary',
					name: 'FIRSTEMPHISTORYINISALARY',
					allowBlank: false,
					value: 0,
					minValue: 0,
					maxValue: 1000000
				},{
					xtype: 'numberfield',
					width: 400,
					cls: 'field-margin',
					fieldLabel: 'Last Salary',
					name: 'FIRSTEMPHISTORYLASTSALARY',
					allowBlank: false,
					value: 0,
					minValue: 0,
					maxValue: 1000000
				},{
					xtype: 'textfield',
					width: 400,
					cls: 'field-margin',
					fieldLabel: 'Immediate Superior',
					maxLength: 30,
					name: 'FIRSTEMPHISTORYSUPERIOR'
				},{
					xtype: 'textfield',
					width: 400,
					cls: 'field-margin',
					fieldLabel: 'Position',
					maxLength: 50,
					name: 'FIRSTEMPHISTORYPOSITION'
				},{
					xtype: 'textfield',
					width: 400,
					cls: 'field-margin',
					fieldLabel: 'Contact Number',
					vtype: 'numberonly',
					maxLength: 15,
					name: 'FIRSTEMPHISTORYCONTACTNO'
				}]
			}]
			
		},{
			xtype: 'button',
			id: 'ehistoryone',
			text: 'Add employment history',
			handler: function() {
				 var bropanel = Ext.getCmp('employmenthistorytwo');
					 bropanel.setVisible(true); 
				 var buttonpanel = Ext.getCmp('ehistorytwo');
					 buttonpanel.setVisible(true);  
					 this.setVisible(false);  
		   }
		},{
			xtype: 'panel',
			hidden: true,
			id: 'employmenthistorytwo',
			width: '100%',
			layout: {
				type: 'hbox',
				align: 'left'
			},
			items: [{
				xtype: 'container',
				flex: 1,
				layout: {
					type: 'vbox',
					align: 'left'
				},
				items: [{
					xtype: 'textfield',
					cls: 'field-margin',
					width: 400,
					fieldLabel: 'Company Name',
					maxLength: 50,
					name: 'SECONDEMPHISTORYNAME'
				},{
					xtype: 'textfield',
					width: 400,
					cls: 'field-margin',
					fieldLabel: 'Company Address',
					maxLength: 100,
					name: 'SECONDEMPHISTORYADDRESS'
				},{
					xtype: 'textfield',
					width: 400,
					cls: 'field-margin',
					fieldLabel: 'Last Position Held',
					maxLength: 50,
					name: 'SECONDEMPHISTORYLASTPOS'
				},{
					xtype: 'textareafield',
					width: 400,
					cls: 'field-margin',
					fieldLabel: 'Reason/s for leaving',
					maxLength: 255,
					name: 'SECONDEMPHISTORYLEAVEREASONS'
				}]
			},{
				xtype: 'container',
				flex: 1,
				layout: {
					type: 'vbox',
					align: 'left'
				},
				items: [{
					xtype: 'monthfield',
				    format: 'F Y',
					cls: 'field-margin',
					fieldLabel: 'Date Employed',
					width: 400,
					name: 'SECONDEMPHISTORYDATEEMP'
				},{
					xtype: 'monthfield',
				    format: 'F Y',
					width: 400,
					cls: 'field-margin',
					fieldLabel: 'Date Separated',
					name: 'SECONDEMPHISTORYDATESEP'
				},{
					xtype: 'numberfield',
					width: 400,
					cls: 'field-margin',
					fieldLabel: 'Initial Salary',
					name: 'SECONDEMPHISTORYINISALARY',
					allowBlank: false,
					value: 0,
					minValue: 0,
					maxValue: 1000000
				},{
					xtype: 'numberfield',
					width: 400,
					cls: 'field-margin',
					fieldLabel: 'Last Salary',
					name: 'SECONDEMPHISTORYLASTSALARY',
					allowBlank: false,
					value: 0,
					minValue: 0,
					maxValue: 1000000
				},{
					xtype: 'textfield',
					width: 400,
					cls: 'field-margin',
					fieldLabel: 'Immediate Superior',
					maxLength: 30,
					name: 'SECONDEMPHISTORYSUPERIOR'
				},{
					xtype: 'textfield',
					width: 400,
					cls: 'field-margin',
					fieldLabel: 'Position',
					maxLength: 50,
					name: 'SECONDEMPHISTORYPOSITION'
				},{
					xtype: 'textfield',
					width: 400,
					cls: 'field-margin',
					fieldLabel: 'Contact Number',
					vtype: 'numberonly',
					maxLength: 15,
					name: 'SECONDEMPHISTORYCONTACTNO'
				}]
			}]
			
		},{
			xtype: 'button',
			hidden: true,
			id: 'ehistorytwo',
			text: 'Add employment history',
			handler: function() {
				 var bropanel = Ext.getCmp('employmenthistorythree');
					 bropanel.setVisible(true); 
				 var buttonpanel = Ext.getCmp('ehistorythree');
					 buttonpanel.setVisible(true);  
					 this.setVisible(false);  
		   }
		},{
			xtype: 'panel',
			hidden: true,
			id: 'employmenthistorythree',
			width: '100%',
			layout: {
				type: 'hbox',
				align: 'left'
			},
			items: [{
				xtype: 'container',
				flex: 1,
				layout: {
					type: 'vbox',
					align: 'left'
				},
				items: [{
					xtype: 'textfield',
					cls: 'field-margin',
					width: 400,
					fieldLabel: 'Company Name',
					maxLength: 50,
					name: 'THIRDEMPHISTORYNAME'
				},{
					xtype: 'textfield',
					width: 400,
					cls: 'field-margin',
					fieldLabel: 'Company Address',
					maxLength: 100,
					name: 'THIRDEMPHISTORYADDRESS'
				},{
					xtype: 'textfield',
					width: 400,
					cls: 'field-margin',
					fieldLabel: 'Last Position Held',
					maxLength: 50,
					name: 'THIRDEMPHISTORYLASTPOS'
				},{
					xtype: 'textareafield',
					width: 400,
					cls: 'field-margin',
					fieldLabel: 'Reason/s for leaving',
					maxLength: 255,
					name: 'THIRDEMPHISTORYLEAVEREASONS'
				}]
			},{
				xtype: 'container',
				flex: 1,
				layout: {
					type: 'vbox',
					align: 'left'
				},
				items: [{
					xtype: 'monthfield',
				    format: 'F Y',
					cls: 'field-margin',
					fieldLabel: 'Date Employed',
					width: 400,
					name: 'THIRDEMPHISTORYDATEEMP'
				},{
					xtype: 'monthfield',
				    format: 'F Y',
					width: 400,
					cls: 'field-margin',
					fieldLabel: 'Date Separated',
					name: 'THIRDEMPHISTORYDATESEP'
				},{
					xtype: 'numberfield',
					width: 400,
					cls: 'field-margin',
					fieldLabel: 'Initial Salary',
					name: 'THIRDEMPHISTORYINISALARY',
					allowBlank: false,
					value: 0,
					minValue: 0,
					maxValue: 1000000
				},{
					xtype: 'numberfield',
					width: 400,
					cls: 'field-margin',
					fieldLabel: 'Last Salary',
					name: 'THIRDEMPHISTORYLASTSALARY',
					allowBlank: false,
					value: 0,
					minValue: 0,
					maxValue: 1000000
				},{
					xtype: 'textfield',
					width: 400,
					cls: 'field-margin',
					fieldLabel: 'Immediate Superior',
					maxLength: 30,
					name: 'THIRDEMPHISTORYSUPERIOR'
				},{
					xtype: 'textfield',
					width: 400,
					cls: 'field-margin',
					fieldLabel: 'Position',
					maxLength: 50,
					name: 'THIRDEMPHISTORYPOSITION'
				},{
					xtype: 'textfield',
					width: 400,
					cls: 'field-margin',
					fieldLabel: 'Contact Number',
					vtype: 'numberonly',
					maxLength: 15,
					name: 'THIRDEMPHISTORYCONTACTNO'
				}]
			}]
			
		},{
			xtype: 'button',
			hidden: true,
			id: 'ehistorythree',
			text: 'Add employment history',
			handler: function() {
				 var bropanel = Ext.getCmp('employmenthistoryfour');
					 bropanel.setVisible(true); 
				 var buttonpanel = Ext.getCmp('ehistoryfour');
					 buttonpanel.setVisible(true);  
					 this.setVisible(false);  
		   }
		},{
			xtype: 'panel',
			hidden: true,
			id: 'employmenthistoryfour',
			width: '100%',
			layout: {
				type: 'hbox',
				align: 'left'
			},
			items: [{
				xtype: 'container',
				flex: 1,
				layout: {
					type: 'vbox',
					align: 'left'
				},
				items: [{
					xtype: 'textfield',
					cls: 'field-margin',
					width: 400,
					fieldLabel: 'Company Name',
					maxLength: 50,
					name: 'FOURTHEMPHISTORYNAME'
				},{
					xtype: 'textfield',
					width: 400,
					cls: 'field-margin',
					fieldLabel: 'Company Address',
					maxLength: 100,
					name: 'FOURTHEMPHISTORYADDRESS'
				},{
					xtype: 'textfield',
					width: 400,
					cls: 'field-margin',
					fieldLabel: 'Last Position Held',
					maxLength: 50,
					name: 'FOURTHEMPHISTORYLASTPOS'
				},{
					xtype: 'textareafield',
					width: 400,
					cls: 'field-margin',
					fieldLabel: 'Reason/s for leaving',
					maxLength: 255,
					name: 'FOURTHEMPHISTORYLEAVEREASONS'
				}]
			},{
				xtype: 'container',
				flex: 1,
				layout: {
					type: 'vbox',
					align: 'left'
				},
				items: [{
					xtype: 'monthfield',
				    format: 'F Y',
					cls: 'field-margin',
					fieldLabel: 'Date Employed',
					width: 400,
					name: 'FOURTHEMPHISTORYDATEEMP'
				},{
					xtype: 'monthfield',
				    format: 'F Y',
					width: 400,
					cls: 'field-margin',
					fieldLabel: 'Date Separated',
					name: 'FOURTHEMPHISTORYDATESEP'
				},{
					xtype: 'numberfield',
					width: 400,
					cls: 'field-margin',
					fieldLabel: 'Initial Salary',
					name: 'FOURTHEMPHISTORYINISALARY',
					allowBlank: false,
					value: 0,
					minValue: 0,
					maxValue: 1000000
				},{
					xtype: 'numberfield',
					width: 400,
					cls: 'field-margin',
					fieldLabel: 'Last Salary',
					name: 'FOURTHEMPHISTORYLASTSALARY',
					allowBlank: false,
					value: 0,
					minValue: 0,
					maxValue: 1000000
				},{
					xtype: 'textfield',
					width: 400,
					cls: 'field-margin',
					fieldLabel: 'Immediate Superior',
					maxLength: 30,
					name: 'FOURTHEMPHISTORYSUPERIOR'
				},{
					xtype: 'textfield',
					width: 400,
					cls: 'field-margin',
					fieldLabel: 'Position',
					maxLength: 50,
					name: 'FOURTHEMPHISTORYPOSITION'
				},{
					xtype: 'textfield',
					width: 400,
					cls: 'field-margin',
					fieldLabel: 'Contact Number',
					vtype: 'numberonly',
					maxLength: 15,
					name: 'FOURTHEMPHISTORYCONTACTNO'
				}]
			}]
			
		},{
			xtype: 'button',
			hidden: true,
			id: 'ehistoryfour',
			text: 'Add employment history',
			handler: function() {
				 var bropanel = Ext.getCmp('employmenthistoryfive');
					 bropanel.setVisible(true); 
					 this.setVisible(false);  
		   }
		},{
			xtype: 'panel',
			hidden: true,
			id: 'employmenthistoryfive',
			width: '100%',
			layout: {
				type: 'hbox',
				align: 'left'
			},
			items: [{
				xtype: 'container',
				flex: 1,
				layout: {
					type: 'vbox',
					align: 'left'
				},
				items: [{
					xtype: 'textfield',
					cls: 'field-margin',
					width: 400,
					fieldLabel: 'Company Name',
					maxLength: 50,
					name: 'FIFTHEMPHISTORYNAME'
				},{
					xtype: 'textfield',
					width: 400,
					cls: 'field-margin',
					fieldLabel: 'Company Address',
					maxLength: 100,
					name: 'FIFTHEMPHISTORYADDRESS'
				},{
					xtype: 'textfield',
					width: 400,
					cls: 'field-margin',
					fieldLabel: 'Last Position Held',
					maxLength: 50,
					name: 'FIFTHEMPHISTORYLASTPOS'
				},{
					xtype: 'textareafield',
					width: 400,
					cls: 'field-margin',
					fieldLabel: 'Reason/s for leaving',
					maxLength: 255,
					name: 'FIFTHEMPHISTORYLEAVEREASONS'
				}]
			},{
				xtype: 'container',
				flex: 1,
				layout: {
					type: 'vbox',
					align: 'left'
				},
				items: [{
					xtype: 'monthfield',
				    format: 'F Y',
					cls: 'field-margin',
					fieldLabel: 'Date Employed',
					width: 400,
					name: 'FIFTHEMPHISTORYDATEEMP'
				},{
					xtype: 'monthfield',
				    format: 'F Y',
					width: 400,
					cls: 'field-margin',
					fieldLabel: 'Date Separated',
					name: 'FIFTHEMPHISTORYDATESEP'
				},{
					xtype: 'numberfield',
					width: 400,
					cls: 'field-margin',
					fieldLabel: 'Initial Salary',
					name: 'FIFTHEMPHISTORYINISALARY',
					allowBlank: false,
					value: 0,
					minValue: 0,
					maxValue: 1000000
				},{
					xtype: 'numberfield',
					width: 400,
					cls: 'field-margin',
					fieldLabel: 'Last Salary',
					name: 'FIFTHEMPHISTORYLASTSALARY',
					allowBlank: false,
					value: 0,
					minValue: 0,
					maxValue: 1000000
				},{
					xtype: 'textfield',
					width: 400,
					cls: 'field-margin',
					fieldLabel: 'Immediate Superior',
					maxLength: 30,
					name: 'FIFTHEMPHISTORYSUPERIOR'
				},{
					xtype: 'textfield',
					width: 400,
					cls: 'field-margin',
					fieldLabel: 'Position',
					maxLength: 50,
					name: 'FIFTHEMPHISTORYPOSITION'
				},{
					xtype: 'textfield',
					width: 400,
					cls: 'field-margin',
					fieldLabel: 'Contact Number',
					vtype: 'numberonly',
					maxLength: 15,
					name: 'FIFTHEMPHISTORYCONTACTNO'
				}]
			}]
			
		}]
	},{
		title: 'SPECIAL SKILLS',
		xtype: 'panel',
		collapsible: true,
		width: '80%',
		flex: 4,
		layout: {
			type: 'vbox',
			align: 'center'
		},
		items: [{
			xtype: 'panel',
			width: '100%',
			layout: {
				type: 'hbox',
				align: 'stretch'
			},
			items: [{
				xtype: 'displayfield',
				cls: 'field-margin-center',
				value: '<b>Equipment/Machines/Computer Software you are familiar with:</b>',
				flex: 6
			},{
				xtype: 'displayfield',
				cls: 'field-margin-center',
				value: '<b>Years of Experience</b>',
				flex: 1
			},{
				xtype: 'displayfield',
				cls: 'field-margin-center',
				value: '<b>Level of Expertise/Remarks</b>',
				flex: 3
			}]
			
		},{
			xtype: 'panel',
			width: '100%',
			layout: {
				type: 'hbox',
				align: 'stretch'
			},
			items: [{
				xtype: 'textfield',
				cls: 'field-margin',
				name: 'SPECIALSKILLSONE',
				maxLength: 255,
				flex: 6
			},{
				
				xtype: 'numberfield',
				value: 0,
				minValue: 0,
				maxValue: 99,
				cls: 'field-margin',
				name: 'SPECIALSKILLSYEARSPONE',
				flex: 1
				
			},{
				xtype: 'textfield',
				cls: 'field-margin',
				name: 'SPECIALSKILLSLEVELONE',
				maxLength: 35,
				flex: 3
			}]
			
		},{
			xtype: 'panel',
			width: '100%',
			layout: {
				type: 'hbox',
				align: 'stretch'
			},
			items: [{
				xtype: 'textfield',
				cls: 'field-margin',
				name: 'SPECIALSKILLSTWO',
				maxLength: 255,
				flex: 6
			},{
				
				xtype: 'numberfield',
				value: 0,
				minValue: 0,
				maxValue: 99,
				cls: 'field-margin',
				name: 'SPECIALSKILLSYEARSPTWO',
				flex: 1
				
			},{
				xtype: 'textfield',
				cls: 'field-margin',
				name: 'SPECIALSKILLSLEVELTWO',
				maxLength: 35,
				flex: 3
			}]
			
		},{
			xtype: 'panel',
			width: '100%',
			layout: {
				type: 'hbox',
				align: 'stretch'
			},
			items: [{
				xtype: 'textfield',
				cls: 'field-margin',
				name: 'SPECIALSKILLSTHREE',
				maxLength: 255,
				flex: 6
			},{
				
				xtype: 'numberfield',
				value: 0,
				minValue: 0,
				maxValue: 99,
				cls: 'field-margin',
				name: 'SPECIALSKILLSYEARSPTHREE',
				flex: 1
				
			},{
				xtype: 'textfield',
				cls: 'field-margin',
				name: 'SPECIALSKILLSLEVELTHREE',
				maxLength: 35,
				flex: 3
			}]
			
		},{
			xtype: 'panel',
			width: '100%',
			layout: {
				type: 'hbox',
				align: 'stretch'
			},
			items: [{
				xtype: 'textfield',
				cls: 'field-margin',
				name: 'SPECIALSKILLSFOUR',
				maxLength: 255,
				flex: 6
			},{
				
				xtype: 'numberfield',
				value: 0,
				minValue: 0,
				maxValue: 99,
				cls: 'field-margin',
				name: 'SPECIALSKILLSYEARSPFOUR',
				flex: 1
				
			},{
				xtype: 'textfield',
				cls: 'field-margin',
				name: 'SPECIALSKILLSLEVELFOUR',
				maxLength: 35,
				flex: 3
			}]
			
		},{
			xtype: 'panel',
			width: '100%',
			layout: {
				type: 'hbox',
				align: 'stretch'
			},
			items: [{
				xtype: 'textfield',
				cls: 'field-margin',
				name: 'SPECIALSKILLSFIVE',
				maxLength: 255,
				flex: 6
			},{
				
				xtype: 'numberfield',
				value: 0,
				minValue: 0,
				maxValue: 99,
				cls: 'field-margin',
				name: 'SPECIALSKILLSYEARSPFIVE',
				flex: 1
				
			},{
				xtype: 'textfield',
				cls: 'field-margin',
				name: 'SPECIALSKILLSLEVELFIVE',
				maxLength: 35,
				flex: 3
			}]
			
		}]
	},{
		title: 'SOURCE',
		xtype: 'panel',
		collapsible: true,
		width: '80%',
		flex: 5,
		layout: {
			type: 'vbox',
			align: 'left'
		},
		items: [{
			xtype: 'displayfield',
			cls: 'field-margin',
			value: 'How did you come to know about this job opening?'
		},{
			xtype: 'radiofield',
			checked: true,
			inputValue: 'Company Career Site',
			fieldLabel: 'Company Career Site',
			cls: 'field-margin',
			name: 'SOURCEEMPLOYMENT'
		},{
			xtype: 'radiofield',
			inputValue: 'JobStreet.com',
			fieldLabel: 'JobStreet.com',
			cls: 'field-margin',
			name: 'SOURCEEMPLOYMENT'
		},{
			xtype: 'radiofield',
			inputValue: 'Walk-in',
			fieldLabel: 'Walk-in',
			cls: 'field-margin',
			name: 'SOURCEEMPLOYMENT'
		},{
			xtype: 'container',
			layout: {
				type: 'hbox',
				align: 'left'
			},
			items: [{
				xtype: 'radiofield',
				inputValue: 'Jobfair',
				fieldLabel: 'Jobfair',
				cls: 'field-margin',
				name: 'SOURCEEMPLOYMENT'
			},{
				xtype: 'textfield',
				fieldLabel: 'Where',
				maxLength: 100,
				style: {
					marginLeft: 25,
					marginTop: 5
				},
				name: 'SOURCEJOBFAIRWHERE'
			},{
				xtype: 'monthfield',
				format: 'F Y',
				fieldLabel: 'Date',
				style: {
					marginLeft: 25,
					marginTop: 5
				},
				name: 'SOURCEJOBFAIRDATE'
			}]
		},{
			xtype: 'container',
			layout: {
				type: 'hbox',
				align: 'left'
			},
			items: [{
				xtype: 'radiofield',
				inputValue: 'Referral',
				fieldLabel: 'Referral',
				cls: 'field-margin',
				name: 'SOURCEEMPLOYMENT'
			},{
				xtype: 'textfield',
				maxLength: 30,
				fieldLabel: 'Referred by',
				style: {
					marginLeft: 25,
					marginTop: 5
				},
				name: 'SOURCEREFERREDBY'
			}]
		},{
			xtype: 'container',
			layout: {
				type: 'hbox',
				align: 'left'
			},
			items: [{
				xtype: 'radiofield',
				inputValue: 'Other',
				fieldLabel: 'Other',
				cls: 'field-margin',
				name: 'SOURCEEMPLOYMENT'
			},{
				xtype: 'textfield',
				maxLength: 50,
				fieldLabel: 'Specify',
				style: {
					marginLeft: 25,
					marginTop: 5
				},
				name: 'SOURCEOTHERVALUE'
			}]
		}]
	},{
		title: 'REFERENCES',
		xtype: 'panel',
		width: '80%',
		collapsible: true,
		flex: 3,
		layout: {
			type: 'vbox',
			align: 'center'
		},
		items: [{
			xtype: 'panel',
			width: '100%',
			layout: {
				type: 'hbox',
				align: 'stretch'
			},
			items: [{
				xtype: 'displayfield',
				cls: 'field-margin-center',
				value: '<b>Name*</b>',
				flex: 2
			},{
				xtype: 'displayfield',
				cls: 'field-margin-center',
				value: '<b>Occupation*</b>',
				flex: 2
			},{
				xtype: 'displayfield',
				cls: 'field-margin-center',
				value: '<b>Company*</b>',
				flex: 2
			},{
				xtype: 'displayfield',
				cls: 'field-margin-center',
				value: '<b>Contact Number*</b>',
				flex: 1
			}]
			
		},{
			xtype: 'panel',
			width: '100%',
			layout: {
				type: 'hbox',
				align: 'stretch'
			},
			items: [{
				xtype: 'textfield',
				cls: 'field-margin',
				name: 'REFERENCENAME1',
				allowBlank: false,
				maxLength: 50,
				flex: 2
			},{
				xtype: 'textfield',
				cls: 'field-margin',
				name: 'REFERENCEOCCUPATION1',
				allowBlank: false,
				maxLength: 50,
				flex: 2
			},{
				xtype: 'textfield',
				cls: 'field-margin',
				name: 'REFERENCECOMPANY1',
				allowBlank: false,
				maxLength: 50,
				flex: 2
			},{
				xtype: 'textfield',
				cls: 'field-margin',
				name: 'REFERENCECONTACT1',
				vtype: 'numberonly',
				allowBlank: false,
				maxLength: 50,
				flex: 1
			}]
		},{
			xtype: 'panel',
			width: '100%',
			layout: {
				type: 'hbox',
				align: 'stretch'
			},
			items: [{
				xtype: 'textfield',
				cls: 'field-margin',
				name: 'REFERENCENAME2',
				allowBlank: false,
				maxLength: 50,
				flex: 2
			},{
				xtype: 'textfield',
				cls: 'field-margin',
				name: 'REFERENCEOCCUPATION2',
				allowBlank: false,
				maxLength: 50,
				flex: 2
			},{
				xtype: 'textfield',
				cls: 'field-margin',
				name: 'REFERENCECOMPANY2',
				allowBlank: false,
				maxLength: 50,
				flex: 2
			},{
				xtype: 'textfield',
				cls: 'field-margin',
				name: 'REFERENCECONTACT2',
				vtype: 'numberonly',
				allowBlank: false,
				maxLength: 50,
				flex: 1
			}]
		},{
			xtype: 'panel',
			width: '100%',
			layout: {
				type: 'hbox',
				align: 'stretch'
			},
			items: [{
				xtype: 'textfield',
				cls: 'field-margin',
				name: 'REFERENCENAME3',
				allowBlank: false,
				maxLength: 50,
				flex: 2
			},{
				xtype: 'textfield',
				cls: 'field-margin',
				name: 'REFERENCEOCCUPATION3',
				allowBlank: false,
				maxLength: 50,
				flex: 2
			},{
				xtype: 'textfield',
				cls: 'field-margin',
				name: 'REFERENCECOMPANY3',
				allowBlank: false,
				maxLength: 50,
				flex: 2
			},{
				xtype: 'textfield',
				cls: 'field-margin',
				name: 'REFERENCECONTACT3',
				vtype: 'numberonly',
				allowBlank: false,
				maxLength: 50,
				flex: 1
			}]
		}]
	},{
		title: 'OTHER DETAILS',
		xtype: 'panel',
		width: '80%',
		collapsible: true,
		flex: 7,
		layout: {
			type: 'vbox',
			align: 'center'
		},
		items: [{
			xtype: 'panel',
			width: '100%',
			layout: {
				type: 'hbox',
				align: 'stretch'
			},
			items: [{
				xtype: 'displayfield',
				cls: 'field-margin',
				value: 'Do you have any physical defects?',
				flex: 5
			},{
				xtype: 'radiofield',
				cls: 'field-margin',
				inputValue: 'Y',
				labelAlign: 'top',
				fieldLabel: 'Yes',
				name: 'HASPHYSICALDEFFECTS',
				flex: 1
			},{
				xtype: 'radiofield',
				cls: 'field-margin',
				inputValue: 'N',
				labelAlign: 'top',
				fieldLabel: 'No',
				name: 'HASPHYSICALDEFFECTS',
				flex: 1
			},{
				xtype: 'textfield',
				cls: 'field-margin',
				name: 'HASPHYSICALDEFFECTSNATURE',
				maxLength: 100,
				emptyText: 'If so, state nature',
				flex: 5
			}]
			
		},{
			xtype: 'panel',
			width: '100%',
			layout: {
				type: 'hbox',
				align: 'stretch'
			},
			items: [{
				xtype: 'displayfield',
				cls: 'field-margin',
				value: 'Have you ever had any operation or serious illness?',
				flex: 5
			},{
				xtype: 'radiofield',
				cls: 'field-margin',
				inputValue: 'Y',
				labelAlign: 'top',
				fieldLabel: 'Yes',
				name: 'HASOPILLNESS',
				flex: 1
			},{
				xtype: 'radiofield',
				cls: 'field-margin',
				inputValue: 'N',
				labelAlign: 'top',
				fieldLabel: 'No',
				name: 'HASOPILLNESS',
				flex: 1
			},{
				xtype: 'textfield',
				cls: 'field-margin',
				name: 'HASOPILLNESSNATURE',
				maxLength: 100,
				emptyText: 'If so, state nature',
				flex: 5
			}]
			
		},{
			xtype: 'panel',
			width: '100%',
			layout: {
				type: 'hbox',
				align: 'stretch'
			},
			items: [{
				xtype: 'displayfield',
				cls: 'field-margin',
				value: 'Are you sensitive to any drug/medicine the company should be aware of in case of emergency?',
				flex: 5
			},{
				xtype: 'radiofield',
				cls: 'field-margin',
				inputValue: 'Y',
				labelAlign: 'top',
				fieldLabel: 'Yes',
				name: 'HASDRUGSENSITIVE',
				flex: 1
			},{
				xtype: 'radiofield',
				cls: 'field-margin',
				inputValue: 'N',
				labelAlign: 'top',
				fieldLabel: 'No',
				name: 'HASDRUGSENSITIVE',
				flex: 1
			},{
				xtype: 'textfield',
				cls: 'field-margin',
				name: 'HASDRUGSENSITIVENATURE',
				maxLength: 100,
				emptyText: 'If so, state nature',
				flex: 5
			}]
			
		},{
			xtype: 'panel',
			width: '100%',
			layout: {
				type: 'hbox',
				align: 'stretch'
			},
			items: [{
				xtype: 'displayfield',
				cls: 'field-margin',
				value: 'Are you engaged in the use and trade of dangerous drugs?',
				flex: 5
			},{
				xtype: 'radiofield',
				cls: 'field-margin',
				inputValue: 'Y',
				labelAlign: 'top',
				fieldLabel: 'Yes',
				name: 'HASENGAGEDRUGS',
				flex: 1
			},{
				xtype: 'radiofield',
				cls: 'field-margin',
				inputValue: 'N',
				labelAlign: 'top',
				fieldLabel: 'No',
				name: 'HASENGAGEDRUGS',
				flex: 1
			},{
				xtype: 'textfield',
				cls: 'field-margin',
				name: 'HASENGAGEDRUGSNATURE',
				maxLength: 100,
				emptyText: 'If so, state nature',
				flex: 5
			}]
			
		},{
			xtype: 'panel',
			width: '100%',
			layout: {
				type: 'hbox',
				align: 'stretch'
			},
			items: [{
				xtype: 'displayfield',
				cls: 'field-margin',
				value: 'Are you involved in other business?',
				flex: 5
			},{
				xtype: 'radiofield',
				cls: 'field-margin',
				inputValue: 'Y',
				labelAlign: 'top',
				fieldLabel: 'Yes',
				name: 'HASINVOLVEBUSI',
				flex: 1
			},{
				xtype: 'radiofield',
				cls: 'field-margin',
				inputValue: 'N',
				labelAlign: 'top',
				fieldLabel: 'No',
				name: 'HASINVOLVEBUSI',
				flex: 1
			},{
				xtype: 'textfield',
				cls: 'field-margin',
				name: 'HASINVOLVEBUSINATURE',
				maxLength: 100,
				emptyText: 'If so, state nature',
				flex: 5
			}]
			
		},{
			xtype: 'panel',
			width: '100%',
			layout: {
				type: 'hbox',
				align: 'stretch'
			},
			items: [{
				xtype: 'displayfield',
				cls: 'field-margin',
				value: 'Have you ever been dismissed or suspended in any of your employment?',
				flex: 5
			},{
				xtype: 'radiofield',
				cls: 'field-margin',
				inputValue: 'Y',
				labelAlign: 'top',
				fieldLabel: 'Yes',
				name: 'HASSUSPENDED',
				flex: 1
			},{
				xtype: 'radiofield',
				cls: 'field-margin',
				inputValue: 'N',
				labelAlign: 'top',
				fieldLabel: 'No',
				name: 'HASSUSPENDED',
				flex: 1
			},{
				xtype: 'textfield',
				cls: 'field-margin',
				name: 'HASSUSPENDEDNATURE',
				maxLength: 100,
				emptyText: 'If so, state nature',
				flex: 5
			}]
			
		},{
			xtype: 'panel',
			width: '100%',
			layout: {
				type: 'hbox',
				align: 'stretch'
			},
			items: [{
				xtype: 'displayfield',
				cls: 'field-margin',
				value: 'Have you ever been convicted in any administrative, civil or criminal case (other than a minor traffic violation)?',
				flex: 5
			},{
				xtype: 'radiofield',
				cls: 'field-margin',
				inputValue: 'Y',
				labelAlign: 'top',
				fieldLabel: 'Yes',
				name: 'HASCRIMINAL',
				flex: 1
			},{
				xtype: 'radiofield',
				cls: 'field-margin',
				inputValue: 'N',
				labelAlign: 'top',
				fieldLabel: 'No',
				name: 'HASCRIMINAL',
				flex: 1
			},{
				xtype: 'textfield',
				cls: 'field-margin',
				name: 'HASCRIMINALNATURE',
				maxLength: 100,
				emptyText: 'If so, state nature',
				flex: 5
			}]
			
		}]
	},{
		xtype: 'panel',
		width: '80%',
		flex: 4,
		layout: {
			type: 'vbox',
			align: 'left'
		},
		items: [{
			xtype: 'container',
			layout: {
				type: 'hbox',
				align: 'left'
			},
			items: [{
				xtype: 'displayfield',
				flex: 1,
				width: 500,
				cls: 'field-margin',
				border: 2,
				style: {
				    borderStyle: 'solid'
				},
				value: 'I attest to the fact that all the answers given by me are true and correct to the best of my knowledge and ability. I recognize that any omission or misrepresentation in the foregoing answers and data on this application or any other document used to secure my employment can be grounds for rejection of my application or termination of my employment with the company.'
			},{
				flex: 1,
				xtype: 'container',
				layout: {
					type: 'vbox',
					align: 'left'
				},
				items: [{
					xtype: 'radiofield',
					fieldLabel: 'I agree',
					checked: true,
					style: {
						marginLeft: 40,
						marginTop: 10
					},
					name: 'agree'
				},{
					xtype: 'radiofield',
					fieldLabel: 'I do not agree',
					style: {
						marginLeft: 40,
						marginTop: 10
					},
					name: 'agree'
				}]
			}]
		},{
			xtype: 'displayfield',
			id: 'thecaptchaa',
			height: 130,
			value: ' '
		},{
			xtype: 'textfield',
			maxLength: 20,
			fieldLabel: 'Type the characters above (no spaces)',
			cls: 'field-margin',
			labelWidth: 260,
			name: 'capchaval',
			id: 'capchachavalddd'
		}]
	}],
	buttons: [{
		
		text: 'Submit Form',
		handler: function() {
		  if (formExit.getForm().isValid()) {
		  	formExit.submit({
		  		url: '../../../app/controller/clearance/exitinterview/submit.cfm',
		  		reset: true,
		  		method: 'POST',
		  		waitMsg: 'Submitting Exit Interview form...Please wait...',
		  		failure: function(form, action){
		  			
					
					//check if the result of the error is due to session time-out
					//if true prompt using a window to sign in again...
					Ext.Ajax.request({
					    url: '../../../app/controller/clearance/exitinterview/submit.cfm',
					    success: function(response){
					        var text = response.responseText;
							var findresult = text.indexOf('src="login.js"');
							if(findresult >= 0) {
								
								showLoginWin();
								
								
							} else {
								Ext.Msg.show({
					  				title: 'Failed to submit',
					  				msg: 'There is a problem in submitting the exit interview form.' + text,
					  				buttons: Ext.Msg.OK,
					  				icon: Ext.Msg.ERROR
					  			});
							}
							
					    }
					});
					
		  		},
		  		success: function(form, action){
		  			Ext.Msg.alert('Status', 'Form submitted successfully. Your reference number is: \n' + action.result.form[0].detail);
		  		}
		  	});
		  } else {
		  	        Ext.Msg.show({
		  				title: 'Invalid field value',
		  				msg: 'Please provide correct values for the fields.',
		  				buttons: Ext.Msg.OK,
		  				icon: Ext.Msg.WARNING
		  			});
		  }
		}
	}]
		
	});
        



});
   	
		
		
	