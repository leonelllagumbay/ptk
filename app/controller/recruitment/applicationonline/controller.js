Ext.define('OnlineApplication.controller.recruitment.applicationonline.controller', {
    extend: 'Ext.app.Controller',  
	stores: [
		'recruitment.applicationonline.companystore', 
		'recruitment.applicationonline.positionstore',
		'recruitment.applicationonline.genderstore',
		'recruitment.applicationonline.civilstatusstore',
		'recruitment.applicationonline.citizenshipstore',
		'recruitment.applicationonline.religionstore',
		'recruitment.applicationonline.schoolstore',
		'recruitment.applicationonline.schoolfieldstore',
		'recruitment.applicationonline.schoolcoursestore',
		'recruitment.applicationonline.govexamstore',
		'recruitment.applicationonline.specialskillstore'
	],
	views: [
       'recruitment.applicationonline.instructionView',
       'recruitment.applicationonline.personalInfoView',
       'recruitment.applicationonline.employmentInfoView',
       'recruitment.applicationonline.familyBackgroundView',
       'recruitment.applicationonline.educationalBackgroundView',
       'recruitment.applicationonline.extraCurricularView',
       'recruitment.applicationonline.additionalInfoView',
       'recruitment.applicationonline.trainingsAndSeminarView',
       'recruitment.applicationonline.employmentHistoryView',
       'recruitment.applicationonline.specialSkillsView',
       'recruitment.applicationonline.sourceView',
       'recruitment.applicationonline.referencesView',
       'recruitment.applicationonline.otherDetailsView',
       'recruitment.applicationonline.footerView',
       'recruitment.applicationonline.view',
       'recruitment.applicationonline.monthField'
    ],
	models: [
		'recruitment.applicationonline.companymodel', 
		'recruitment.applicationonline.positionmodel',
		'recruitment.applicationonline.gendermodel',
		'recruitment.applicationonline.civilstatusmodel',
		'recruitment.applicationonline.citizenshipmodel',
		'recruitment.applicationonline.religionmodel',
		'recruitment.applicationonline.schoolmodel',
		'recruitment.applicationonline.schoolfieldmodel',
		'recruitment.applicationonline.schoolcoursemodel',
		'recruitment.applicationonline.govexammodel'
	],
	
    init: function() {
		console.log('init controller');  
		Ext.apply(Ext.form.field.VTypes, {
		    numberonly:  function(v) {
		    	var numberonlystr = /[\d]/;
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
		
		Ext.apply(Ext.form.field.VTypes, {
			    captcha:  function(v) {
					var captchaorig = Ext.getCmp('chapchacontenttent').getValue();
					var captchatype = Ext.getCmp('capchachavalddd').getValue();
					if(captchaorig != captchatype) {
						return false;
					} else {
						return true;
					}
				},
			    captchaText: 'Wrong captcha. Type the characters above again.'
		});
		
		
		Ext.apply(Ext.form.field.VTypes, {
		    sssformat:  function(v) {
		    	var sssformatSTR = /^\d{1,2}\-\d{1,7}\-\d{1}$|^0$/;
		        return sssformatSTR.test(v);
		    },
		    sssformatText: 'Please follow this format: XX-XXXXXXX-X',
		    sssformatMask: /[\d\-]/i
		});
		
		
		Ext.apply(Ext.form.field.VTypes, {
		    tinformat:  function(v) {
		    	var tinformatSTR = /^\d{1,3}\-\d{1,3}\-\d{1,3}$|^0$/;
		        return tinformatSTR.test(v);
		    },
		    tinformatText: 'Please follow this format: XXX-XXX-XXX',
		    tinformatMask: /[\d\-]/i
		});
		
		
		Ext.apply(Ext.form.field.VTypes, {
		    phformat:  function(v) {
		    	var phformatSTR = /^\d{1,2}\-\d{1,9}\-\d{1}$|^0$/;
		        return phformatSTR.test(v);
		    },
		    phformatText: 'Please follow this format: XX-XXXXXXXXX-X',
		    phformatMask: /[\d\-]/i
		});
		
		
		Ext.apply(Ext.form.field.VTypes, {
		    pagibigformat:  function(v) {
		    	var pagibigformatSTR = /^\d{1,4}\-\d{1,4}\-\d{1,4}$|^0$/;
		        return pagibigformatSTR.test(v);
		    },
		    pagibigformatText: 'Please follow this format: XXXX-XXXX-XXXX',
		    pagibigformatMask: /[\d\-]/i
		});
        this.control({
            'footerview button[action=submitonlineapp]': {
            	click: this.submitApp
            },
            'employmentinfoview radiofield[action=yesiapplied]': {
            	change: this.preappliedChanged
            },
            'employmentinfoview radiofield[action=yesprevapplied]': {
            	change: this.preappliedFBCChanged
            },
            'familybackgroundview button[action=addchild]': {
            	click: this.addChild
            },
            'educationalbackgroundview button[action=addschool]': {
            	click: this.addSchool
            },
            'familybackgroundview button[action=addsibling]': {
            	click: this.addSibling
            },
            'additionalinfoview button[action=trainingseminarseven]': {
            	click: this.addLicense
            },
            'extracurricularview button[action=trainingseminarone]': {
            	click: this.addCurricular
            }, 
            'employmenthistoryview button[action=ehistoryone]': {
            	click: this.addEmpHistory
            },
            'specialskillsview button[action=specialskills]': {
            	click: this.addSkills
            },
            'sourceview radiofield[action=online]': {
            	change: this.onlineChanged
            },
            'sourceview radiofield[action=jobfair]': {
            	change: this.jobfairChanged
            },
            'sourceview radiofield[action=referral]': {
            	change: this.referralChanged
            },
            'sourceview radiofield[action=other]': {
            	change: this.otherChanged
            }, 
            'footerview displayfield[name=mycaptcha]': {
            	render: this.loadChapa
            },
            'footerview button[action=regeneratecaptcha]': {
            	click: this.reChapa
            },
            'trainingsandseminarview button[action=trainingseminartwelve]': {
            	click: this.addTrainings
            },
		//control initialization here...
        });
    },
    
    reChapa: function(btn) {
    	var b = btn.up('form').down('displayfield[name=mycaptcha]');
    	this.loadChapa(b);
    },
    
    loadChapa: function(b) {
    	b.getEl().mask('Loading captcha...');
    	Ext.ss.lookup.getCaptcha(function(r) {
    		b.setValue(r.captchalink);
    		console.log(r.captchastring);
    		b.up('form').down('textfield[name=chapchacontenttent]').setValue(r.captchastring);
    		b.getEl().unmask();
    	});
    },
    
    addTrainings: function(dbtn) { 
    	var eduComp = dbtn.up('trainingsandseminarview');
    	if(typeof eduComp.currentCount === 'undefined') {
    		eduComp.currentCount = 0;
    	} else {
    		if(eduComp.currentCount == 5) {
    			dbtn.setVisible(false);
    		} else {
    			eduComp.currentCount += 1;
    		}
    	}
    	
    	eduComp.insert(1,[{
			xtype: 'container',
			width: '100%',
			layout: {
				type: 'hbox',
				align: 'stretch'
			},
			items: [{
				xtype: 'textfield',
				cls: 'field-margin',
				name: 'SEMINARTOPIC',
				value: ' ',
				maxLength: 100,
				flex: 1
			},{
				
				xtype: 'monthfield',
				format: 'F Y',
				cls: 'field-margin',
				value: ' ',
				name: 'SEMINARDATE',
				flex: 1
				
			},{
				xtype: 'textfield',
				cls: 'field-margin',
				name: 'SEMINARORGANIZER',
				value: ' ',
				maxLength: 50,
				flex: 1
			}]
			
		}]);
    },
    
    addSkills: function(dbtn) {
    	var eduComp = dbtn.up('specialskillsview');
    	if(typeof eduComp.currentCount === 'undefined') {
    		eduComp.currentCount = 0;
    	} else {
    		if(eduComp.currentCount == 7) {
    			dbtn.setVisible(false);
    		} else {
    			eduComp.currentCount += 1;
    		}
    	}
    	
    	eduComp.insert(2,[{
			xtype: 'container',
			width: '100%',
			layout: {
				type: 'hbox',
				align: 'stretch'
			},
			items: [{
				xtype: 'textfield',
				cls: 'field-margin',
				name: 'SPECIALSKILLS',
				value: ' ',
				maxLength: 255,
				flex: 6
			},{
				xtype: 'numberfield',
				value: 0,
				minValue: 0,
				maxValue: 99,
				cls: 'field-margin',
				name: 'SPECIALSKILLSYEARSP',
				hidden: true,
				flex: 1
			},{
				xtype: 'combobox',
				cls: 'field-margin',
				name: 'SPECIALSKILLSLEVEL',
				maxLength: 35,
				value: ' ',
				store: 'recruitment.applicationonline.specialskillstore',
				displayField: 'skillname',
				valueField: 'skillcode',
				flex: 3
			}]
		}]);
    	
    },
    
    addEmpHistory: function(dbtn) {
    	var eduComp = dbtn.up('employmenthistoryview');
    	if(typeof eduComp.currentCount === 'undefined') {
    		eduComp.currentCount = 0;
    	} else {
    		if(eduComp.currentCount == 4) {
    			dbtn.setVisible(false);
    		} else {
    			eduComp.currentCount += 1;
    		}
    	}
    	
    	eduComp.insert(1,[{
			xtype: 'panel',
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
					value: ' ',
					maxLength: 50,
					name: 'EMPHISTORYNAME'
				},{
					xtype: 'textfield',
					width: 400,
					cls: 'field-margin',
					fieldLabel: 'Company Address',
					value: ' ',
					maxLength: 100,
					name: 'EMPHISTORYADDRESS'
				},{
					xtype: 'textfield',
					width: 400,
					cls: 'field-margin',
					fieldLabel: 'Contact Information',
					maxLength: 100,
					value: ' ',
					name: 'EMPHISTORYCONTACTINFO'
				},{  
					xtype: 'textfield',
					width: 400,
					cls: 'field-margin',
					fieldLabel: 'Last Position Held',
					maxLength: 50,
					value: ' ',
					name: 'EMPHISTORYLASTPOS'
				},{
					xtype: 'textareafield',
					width: 400,
					cls: 'field-margin',
					fieldLabel: 'Major Accomplishments',
					maxLength: 255,
					value: ' ',
					name: 'EMPHISTORYACCOMPLISHMENT'
				},{
					xtype: 'textareafield',
					width: 400,
					cls: 'field-margin',
					fieldLabel: 'Reason/s for leaving',
					maxLength: 255,
					value: ' ',
					name: 'EMPHISTORYLEAVEREASONS'
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
					value: ' ',
					fieldLabel: 'Date Employed',
					width: 400,
					name: 'EMPHISTORYDATEEMP'
				},{
					xtype: 'monthfield',
				    format: 'F Y',
					width: 400,
					cls: 'field-margin',
					value: ' ',
					fieldLabel: 'Date Separated',
					name: 'EMPHISTORYDATESEP'
					
				},{
					xtype: 'numberfield',
					width: 400,
					cls: 'field-margin',
					fieldLabel: 'Initial Salary',
					name: 'EMPHISTORYINISALARY',
					allowBlank: false,
					value: 0,
					hidden: true,
					minValue: 0,
					maxValue: 1000000
				},{
					xtype: 'numberfield',
					width: 400,
					cls: 'field-margin',
					fieldLabel: 'Last Salary',
					name: 'EMPHISTORYLASTSALARY',
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
					value: ' ',
					name: 'EMPHISTORYSUPERIOR'
				},{
					xtype: 'textfield',
					width: 400,
					cls: 'field-margin',
					fieldLabel: 'Position',
					maxLength: 50,
					value: ' ',
					name: 'EMPHISTORYPOSITION'
				},{
					xtype: 'textfield',
					width: 400,
					cls: 'field-margin',
					fieldLabel: 'Contact Number',
					value: '0',
					vtype: 'numberonly',
					maxLength: 15,
					name: 'EMPHISTORYCONTACTNO'
				}]
			}]
		}]);
    	
    },
    
    addCurricular: function(dbtn) {
    	var eduComp = dbtn.up('extracurricularview');
    	if(typeof eduComp.currentCount === 'undefined') {
    		eduComp.currentCount = 0;
    	} else {
    		if(eduComp.currentCount == 4) {
    			dbtn.setVisible(false);
    		} else {
    			eduComp.currentCount += 1;
    		}
    	}
    	
    	eduComp.insert(1,[{
			xtype: 'container',
			width: '100%',
			layout: {
				type: 'hbox',
				align: 'stretch'
			},
			items: [{
				xtype: 'textfield',
				cls: 'field-margin',
				name: 'EXTRAORGNAME',
				value: ' ',
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
					name: 'EXTRAORGIDATE',
					value: ' ',
					emptyText: 'From',
					flex: 1
				},{
					xtype: 'monthfield',
				    format: 'F Y',
					cls: 'field-margin',
					name: 'EXTRAORGIDATE2',
					value: ' ',
					emptyText: 'To',
					flex: 1
				}]
			},{
				xtype: 'textfield',
				cls: 'field-margin',
				name: 'EXTRAORGHIGHPOSHELD',
				value: ' ',
				maxLength: 50,
				flex: 1
			}]
			
		}]);
    	
    },
    
    addLicense: function(dbtn) {
    	var eduComp = dbtn.up('additionalinfoview');
    	if(typeof eduComp.currentCount === 'undefined') {
    		eduComp.currentCount = 0;
    	} else {
    		if(eduComp.currentCount == 5) {
    			dbtn.setVisible(false);
    		} else {
    			eduComp.currentCount += 1;
    		}
    	}
    	
    	eduComp.insert(1,[{
			xtype: 'container',
			width: '100%',
			layout: {
				type: 'hbox',
				align: 'stretch'
			},
			items: [{
				xtype: 'combobox',
				cls: 'field-margin',
				name: 'GOVEXAMPASSED',
				value: ' ',
				maxLength: 100,
				editable: false,
				store: 'recruitment.applicationonline.govexamstore',
				displayField: 'govexamname',
				valueField: 'govexamcode',
				flex: 1
			},{
				
				xtype: 'monthfield',
				format: 'F Y',
				cls: 'field-margin',
				value: ' ',
				name: 'GOVEXAMDATE',
				flex: 1
				
			},{
				xtype: 'textfield',
				cls: 'field-margin',
				name: 'GOVEXAMRATING',
				value: ' ',
				maxLength: 50,
				flex: 1
			}]
			
		}]);
    	
    },
    
    addChild: function(dbtn) {
    	var eduComp = dbtn.up('familybackgroundview');
    	if(typeof eduComp.currentCount === 'undefined') {
    		eduComp.currentCount = 0;
    	} else {
    		if(eduComp.currentCount == 30) {
    			dbtn.setVisible(false);
    		} else {
    			eduComp.currentCount += 1;
    		}
    	}
    	
    	eduComp.insert(6,[{
			xtype: 'container',
			layout: {
				type: 'hbox',
				align: 'stretch'
			},
			items: [{
				xtype: 'checkboxfield',
				name: 'CHILDDECEASED',
				uncheckedValue: 'N',
				hidden: true
			},{
				xtype: 'textfield',
				flex: 5,
				name: 'CHILDFULLNAME',
				value: ' ',
				maxLength: 50,
				fieldLabel: 'Child',
				cls: 'field-margin'
			},{
				xtype: 'numberfield',
				flex: 1,
				name: 'CHILDAGE',
				cls: 'field-margin',
				value: 0,
				minValue: 0,
				maxValue: 99
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'CHILDOCCUPATION',
				value: ' ',
				maxLength: 50,
				cls: 'field-margin'
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'CHILDCOMPANY',
				value: ' ',
				maxLength: 50,
				cls: 'field-margin'
			},{
				xtype: 'textfield',
				flex: 2,
				name: 'CHILDCONTACTNO',
				value: '0',
				vtype: 'numberonly',
				maxLength: 15,
				cls: 'field-margin'
			},{
				xtype: 'datefield',
				flex: 2,
				name: 'CHILDBIRTHDAY',
				value: ' ',
				allowBlank: true,
				cls: 'field-margin'
			}]
		}]);
    	
    },
    
    addSibling: function(dbtn) {
    	var eduComp = dbtn.up('familybackgroundview');
    	if(typeof eduComp.currentCount === 'undefined') {
    		eduComp.currentCount = 0;
    	} else {
    		if(eduComp.currentCount == 30) {
    			dbtn.setVisible(false);
    		} else {
    			eduComp.currentCount += 1;
    		}
    	}
    	
    	eduComp.insert(6,[{
			xtype: 'container',
			layout: {
				type: 'hbox',
				align: 'stretch'
			},
			items: [{
				xtype: 'checkboxfield',
				name: 'BRODECEASED',
				uncheckedValue: 'N',
				hidden: true
			},{
				xtype: 'textfield',
				flex: 5,
				name: 'SIBLINGFULLNAME',
				value: ' ',
				maxLength: 50,
				fieldLabel: 'Sibling',
				cls: 'field-margin'
			},{
				xtype: 'numberfield',
				flex: 1,
				name: 'SIBLINGAGE',
				cls: 'field-margin',
				value: 0,
				minValue: 0,
				maxValue: 99
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'SIBLINGOCCUPATION',
				maxLength: 50,
				value: ' ',
				cls: 'field-margin'
			},{
				xtype: 'textfield',
				flex: 3,
				name: 'SIBLINGCOMPANY',
				value: ' ',
				maxLength: 50,
				cls: 'field-margin'
			},{
				xtype: 'textfield',
				flex: 2,
				name: 'SIBLINGCONTACTNO',
				value: '0',
				vtype: 'numberonly',
				maxLength: 15,
				cls: 'field-margin'
			},{
				xtype: 'datefield',
				flex: 2,
				name: 'SIBLINGBIRTHDAY',
				value: ' ',
				allowBlank: true,
				cls: 'field-margin'
			}]
		}]);
    	
    },
    
    addSchool: function(dbtn) {
    	var eduComp = dbtn.up('educationalbackgroundview');
    	if(typeof eduComp.currentCount === 'undefined') {
    		eduComp.currentCount = 0;
    	} else {
    		if(eduComp.currentCount == 5) {
    			dbtn.setVisible(false);
    		} else {
    			eduComp.currentCount += 1;
    		}
    	}
    	var ccount = eduComp.currentCount + 2;
    	eduComp.insert(3,[{
			xtype: 'container',
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
				store: 'recruitment.applicationonline.schoolstore',
				displayField: 'schoolname',
				valueField: 'schoolcode',
				pageSize: 20,
				flex: 7  
			},{
				xtype: 'combobox',
				cls: 'field-margin',
				name: 'COLLEGEFIELD',
				maxLength: 100,
				fieldLabel: '*',
				labelAlign: 'top',
				store: 'recruitment.applicationonline.schoolfieldstore',
				displayField: 'fieldname',
				valueField: 'fieldcode',
				minChars: 1,
				forceSelection: true,
				hidden: true,
				pageSize: 20,
				flex: 5
			},{
				xtype: 'textfield',
				cls: 'field-margin',
				name: 'COLLEGELOCATION',
				allowBlank: false,
				maxLength: 100,
				fieldLabel: '*',
				labelAlign: 'top',
				flex: 3
			},{
				xtype: 'combobox',
				cls: 'field-margin',
				fieldLabel: '*',
				labelAlign: 'top',
				minChars: 1,
				name: 'COLLEGECOURSE',
				allowBlank: false,
				maxLength: 100,
				store: 'recruitment.applicationonline.schoolcoursestore',
				displayField: 'coursename',
				valueField: 'coursecode',
				pageSize: 20,
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
					name: 'COLLEGEISGRAD' + ccount,
					inputValue: 'Y',
					flex: 1,
					style: {
						marginLeft: 20
					},
					labelAlign: 'top',
					fieldLabel: 'Yes'
				},{
					xtype: 'radiofield',
					name: 'COLLEGEISGRAD' + ccount,
					inputValue: 'N',
					checked: true,
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
				flex: 6
			}]
		}]);
    },
    preappliedChanged: function(rad,val) {
    	var pladateComp = Ext.ComponentQuery.query('datefield[name=PREVAPPLIEDLAST]')[0];
    	if(val) {
	    	Ext.apply(pladateComp, {allowBlank: false}, {});
	    	pladateComp.setVisible(true);
    	} else {
    		Ext.apply(pladateComp, {allowBlank: true}, {});
    		pladateComp.setVisible(false);
    	}
    },
    
    onlineChanged: function(rad,val) {
    	var pladateComp = Ext.ComponentQuery.query('textfield[name=WEBSITE]')[0];
    	if(val) {
	    	Ext.apply(pladateComp, {allowBlank: false}, {});
	    	pladateComp.setVisible(true);
    	} else {
    		Ext.apply(pladateComp, {allowBlank: true}, {});
    		pladateComp.setVisible(false);
    	}
    },
    
    jobfairChanged: function(rad,val) {
    	var pladateComp = Ext.ComponentQuery.query('textfield[name=SOURCEJOBFAIRWHERE]')[0];
    	if(val) {
	    	Ext.apply(pladateComp, {allowBlank: false}, {});
	    	pladateComp.setVisible(true);
    	} else {
    		Ext.apply(pladateComp, {allowBlank: true}, {});
    		pladateComp.setVisible(false);
    	}
    	var pladateComp = Ext.ComponentQuery.query('datefield[name=SOURCEJOBFAIRDATE]')[0];
    	if(val) {
	    	Ext.apply(pladateComp, {allowBlank: false}, {});
	    	pladateComp.setVisible(true);
    	} else {
    		Ext.apply(pladateComp, {allowBlank: true}, {});
    		pladateComp.setVisible(false);
    	}
    	
    	
    },
    
    referralChanged: function(rad,val) {
    	var pladateComp = Ext.ComponentQuery.query('textfield[name=SOURCEREFERREDBY]')[0];
    	if(val) {
	    	Ext.apply(pladateComp, {allowBlank: false}, {});
	    	pladateComp.setVisible(true);
    	} else {
    		Ext.apply(pladateComp, {allowBlank: true}, {});
    		pladateComp.setVisible(false);
    	}
    },
    
    otherChanged: function(rad,val) {
    	var pladateComp = Ext.ComponentQuery.query('textfield[name=SOURCEOTHERVALUE]')[0];
    	if(val) {
	    	Ext.apply(pladateComp, {allowBlank: false}, {});
	    	pladateComp.setVisible(true);
    	} else {
    		Ext.apply(pladateComp, {allowBlank: true}, {});
    		pladateComp.setVisible(false);
    	}
    },
    
    
    preappliedFBCChanged: function(rad,val) {
    	var paFromComp = Ext.ComponentQuery.query('datefield[name=PREVEMPLOYEDFROM]')[0];
    	var paToComp = Ext.ComponentQuery.query('datefield[name=PREVEMPLOYEDTO]')[0];
    	if(val) {
	    	Ext.apply(paFromComp, {allowBlank: false}, {});
	    	paFromComp.setVisible(true);
	    	Ext.apply(paToComp, {allowBlank: false}, {});
	    	paToComp.setVisible(true);
    	} else {
    		Ext.apply(paFromComp, {allowBlank: true}, {});
	    	paFromComp.setVisible(false);
	    	Ext.apply(paToComp, {allowBlank: true}, {});
	    	paToComp.setVisible(false);
    	}
    },
    submitApp: function(btn) {
        
    	var formExit = btn.up('form');
        if (formExit.getForm().isValid()) {
        	
	  	formExit.submit({
	  		url: '../application/submitapplication.cfm',
			submitEmptyText: false,
	  		reset: true,
	  		method: 'POST',
	  		waitMsg: 'Submitting Application Online Form. Please wait...',
	  		failure: function(form, action){
	  			Ext.Msg.show({
	  				title: 'Technical problem.',
	  				msg: 'Maybe the cause of this problem is: a) you already have a pending application or \n b) you submitted the form with duplicate values or \n c) there is a system problem.\n Please correct the values you entered in the form.',
	  				buttons: Ext.Msg.OK,
	  				icon: Ext.Msg.WARNING
	  			});
				console.log(action.response.ResponseText);
	  		},
	  		success: function(form, action){
	  			Ext.create('Ext.window.Window', {
				    title: 'Status',
					closable: true,
				    height: 300,
				    width: 400,
				    layout: 'fit',
				    html: '<h1>' + action.result.form[0].detail + '</h1>'  
				}).show();
	  		}
	  	});
	  } else {
	  	        Ext.Msg.show({
	  				title: 'Invalid field value',
	  				msg: 'Please provide correct value for each field.',
	  				buttons: Ext.Msg.OK,
	  				icon: Ext.Msg.WARNING
	  			});
	  }
	  
    }
	
});