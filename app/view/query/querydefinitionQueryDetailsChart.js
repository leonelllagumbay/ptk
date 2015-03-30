Ext.define('Form.view.query.querydefinitionQueryDetailsChart', { 
	extend: 'Ext.form.FieldSet',
	alias: 'widget.querydefinitionquerydetailschart',
	title: 'Chart Details',
	collapsible: true,
	autoScroll: true,
	initComponent: function() {  
		
		this.defaults = {
				xtype: 'textfield',
				labelWidth: 150,
				padding: 5,
				width: 400
		};
		this.items = [{
			name: 'CHARTLABEL',
			fieldLabel: 'Label',
			xtype: 'textareafield',
			maxLength: 60,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "Object with the following properties:\n\ndisplay : String - Specifies the presence and position of the labels.\n\nstackedDisplay : String - The type of label we want to display as a summary on a stacked bar or a stacked column. If set to 'total', the total amount of all the stacked values is displayed on top of the column. If set to 'balances', the total amount of the positive values is displayed on top of the column and the total amount of the negative values is displayed at the bottom.\n\ncolor : String - The color of the label text.\n\ncontrast : Boolean - True to render the label in contrasting color with the backround of a column in a Bar chart or of a slice in a Pie chart.\n\nfield : String|String[] - The name(s) of the field(s) to be displayed in the labels.\n\nminMargin : Number - Specifies the minimum distance from a label to the origin of the visualization.\n\nfont : String - The font used for the labels.\n\norientation : String - Either \"horizontal\" or \"vertical\".\n\nrenderer : Function"
		            });
		        }
		    }
		},{
			name: 'BOXFILL',
			fieldLabel: 'Box fill',
			maxLength: 10,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "Fill style for the legend box\nDefaults to: '#FFF'"
		            });
		        }
		    }
		},{
			name: 'BOXSTROKE',
			fieldLabel: 'Box stroke',
			maxLength: 10,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "Style of the stroke for the legend box\nDefaults to: '#000'"
		            });
		        }
		    }
		},{
			name: 'BOXSTROKEWIDTH',
			fieldLabel: 'Box stroke width',
			width: 200,
			maxLength: 2,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "Width of the stroke for the legend box\nDefaults to: 1"
		            });
		        }
		    }
		},{
			name: 'BOXZINDEX',
			fieldLabel: 'Box z-index',
			xtype: 'numberfield',
			width: 250,
			maxValue: 999,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "Sets the z-index for the legend. Defaults to 100.\nDefaults to: 100"
		            });
		        }
		    }
		},{
			name: 'ITEMSPACING',
			fieldLabel: 'Item spacing',
			xtype: 'numberfield',
			width: 250,
			maxValue: 999,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "Sets the z-index for the legend. Defaults to 100.\nDefaults to: 100"
		            });
		        }
		    }
		},{
			name: 'LABELCOLOR',
			fieldLabel: 'Label color',
			maxLength: 10,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "Color to be used for the legend labels, eg '#000'\nDefaults to: '#000'"
		            });
		        }
		    }
		},{
			name: 'LABELFONT',
			fieldLabel: 'Label font',
			maxLength: 50,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "Font to be used for the legend labels, eg '12px Helvetica'\nDefaults to: '12px Helvetica, sans-serif'"
		            });
		        }
		    }
		},{
			name: 'PADDING',
			fieldLabel: 'Padding',
			xtype: 'numberfield',
			width: 250,
			maxValue: 999,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "Amount of padding between the legend box's border and its items\nDefaults to: 5"
		            });
		        }
		    }
		},{
			fieldLabel: 'Position',
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "Amount of padding between the legend box's border and its items\nDefaults to: 5"
		            });
		        }
		    },
		    xtype: 'radiogroup',
			columns: 4,
		    items: [{
		    	boxLabel: 'left',
		    	name: 'LEGENDPOSITION',
			    inputValue: 'left'
		    },{
		    	boxLabel: 'right',
		    	name: 'LEGENDPOSITION',
			    inputValue: 'right'
		    },{
		    	boxLabel: 'top',
		    	name: 'LEGENDPOSITION',
			    inputValue: 'top'
		    },{
		    	boxLabel: 'bottom',
		    	name: 'LEGENDPOSITION',
			    inputValue: 'bottom'
		    }]
		},{
			name: 'CHARTUPDATE',
			fieldLabel: 'Update',
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "If set to true the legend will be refreshed when the chart is. This is useful to update the legend items if series are added/removed/updated from the chart. Default is true.\nDefaults to: true"
		            });
		        }
		    },
		    xtype: 'combobox',
			queryMode: 'local',
			store: 'query.yesno', 
			displayField: 'yesnoname',
			valueField: 'yesnocode',
			width: 300
		},{
			name: 'VISIBLE',
			fieldLabel: 'Visible',
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "Whether or not the legend should be displayed.\nDefaults to: true"
		            });
		        }
		    },
		    xtype: 'combobox',
			queryMode: 'local',
			store: 'query.yesno', 
			displayField: 'yesnoname',
			valueField: 'yesnocode',
			width: 300
		},{
			name: 'X',
			fieldLabel: 'X',
			xtype: 'numberfield',
			maxValue: 9999,
			width: 250,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "X-position of the legend box. Used directly if position is set to \"float\", otherwise it will be calculated dynamically.\nDefaults to: 0"
		            });
		        }
		    }
		},{
			name: 'Y',
			fieldLabel: 'Y',
			xtype: 'numberfield',
			maxValue: 9999,
			width: 250,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "Y-position of the legend box. Used directly if position is set to \"float\", otherwise it will be calculated dynamically.\nDefaults to: 0"
		            });
		        }
		    }
		},{
			name: 'ALLOWFUNCTIONS',
			fieldLabel: 'Allow functions',
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "Configure as true if the addAll function should add function references to the collection."
		            });
		        }
		    },
		    xtype: 'combobox',
			queryMode: 'local',
			store: 'query.yesno', 
			displayField: 'yesnoname',
			valueField: 'yesnocode',
			width: 300
		},{
			fieldLabel: 'Default sort direction',
			maxLength: 4,
			xtype: 'radiogroup',
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "The default sort direction to use if one is not specified.\nDefaults to: \"ASC\""
		            });
		        }
		    },
			columns: 4,
		    items: [{
		    	boxLabel: 'ASC',
		    	name: 'DEFAULTSORTDIRECTION',
			    inputValue: 'ASC'
		    },{
		    	boxLabel: 'DESC',
		    	name: 'DEFAULTSORTDIRECTION',
			    inputValue: 'DESC'
		    }]
			
		},{
			name: 'LEGENDITEMLISTENERS',
			fieldLabel: 'Legen item listeners',
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "A config object containing one or more event handlers to be added to this object during initialization. This should be a valid listeners config object as specified in the addListener example for attaching multiple handlers at once."
		            });
		        }
		    }
		},{
			name: 'SORTROOT',
			fieldLabel: 'Sort root',
			maxLength: 50,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "The property in each item that contains the data to sort."
		            });
		        }
		    }
		},{
			name: 'SORTERS',
			fieldLabel: 'Sorters',
			maxLength: 100,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "The initial set of Sorters.\n\nExt.util.Sorter[]/Object[]"
		            });
		        }
		    }
		},{
			name: 'MASK',
			fieldLabel: 'Mask',
			maxLength: 15,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "Enables selecting a region on chart. True to enable any selection, 'horizontal' or 'vertical' to restrict the selection to X or Y axis.\n\nThe mask in itself will do nothing but fire 'select' event. See Ext.chart.Mask for example."
		            });
		        }
		    },
		    xtype: 'combobox',
			queryMode: 'local',
			store: 'query.yesno', 
			displayField: 'yesnoname',
			valueField: 'yesnocode',
			width: 300
		},{
			name: 'AXISADJUSTEND',
			fieldLabel: 'Adjust end',
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "Whether to adjust the label at the end of the axis.\nDefaults to: true"
		            });
		        }
		    },
		    xtype: 'combobox',
			queryMode: 'local',
			store: 'query.yesno', 
			displayField: 'yesnoname',
			valueField: 'yesnocode',
			width: 300
		},{
			name: 'AXISDASHSIZE',
			fieldLabel: 'Dash size',
			maxValue: 999,
			xtype: 'numberfield',
			width: 250,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "The size of the dash marker. Default's 3.\nDefaults to: 3"
		            });
		        }
		    }
		},{
			name: 'AXISFIELDS',
			fieldLabel: 'Fields',
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "The fields of model to bind to this axis.\n\nFor example if you have a data set of lap times per car, each having the fields: 'carName', 'avgSpeed', 'maxSpeed'. Then you might want to show the data on chart with ['carName'] on Name axis and ['avgSpeed', 'maxSpeed'] on Speed axis."
		            });
		        }
		    }
		},{
			name: 'AXISGRID',
			fieldLabel: 'Grid',
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "The grid configuration enables you to set a background grid for an axis. If set to true on a vertical axis, vertical lines will be drawn. If set to true on a horizontal axis, horizontal lines will be drawn. If both are set, a proper grid with horizontal and vertical lines will be drawn.\n\nYou can set specific options for the grid configuration for odd and/or even lines/rows. Since the rows being drawn are rectangle sprites, you can set to an odd or even property all styles that apply to Ext.draw.Sprite. For more information on all the style properties you can set please take a look at Ext.draw.Sprite. Some useful style properties are opacity, fill, stroke, stroke-width, etc.\n\nThe possible values for a grid option are then true, false, or an object with { odd, even } properties where each property contains a sprite style descriptor object that is defined in Ext.draw.Sprite."
		            });
		        }
		    }
		},{
			name: 'AXISHIDDEN',
			fieldLabel: 'Hidden',
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "true to hide the axis.\nDefaults to: false"
		            });
		        }
		    },
		    xtype: 'combobox',
			queryMode: 'local',
			store: 'query.yesno', 
			displayField: 'yesnoname',
			valueField: 'yesnocode',
			width: 300
		},{
			name: 'AXISLABEL',
			fieldLabel: 'Axis Label',
			maxLength: 60,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "The config for chart label."
		            });
		        }
		    }
		},{
			name: 'AXISLENGTH',
			fieldLabel: 'Length',
			maxValue: 999,
			xtype: 'numberfield',
			width: 250,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "Offset axis position. Default's 0.\nDefaults to: 0"
		            });
		        }
		    }
		},{
			name: 'AXISMAJORTICKSTEPS',
			fieldLabel: 'Major tick steps',
			maxValue: 999,
			xtype: 'numberfield',
			width: 250,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "If minimum and maximum are specified it forces the number of major ticks to the specified value. If a number of major ticks is forced, it wont search for pretty numbers at the ticks."
		            });
		        }
		    }
		},{
			name: 'AXISMINORTICKSTEPS',
			fieldLabel: 'Minor tick steps',
			maxValue: 999,
			xtype: 'numberfield',
			width: 250,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "The number of small ticks between two major ticks. Default is zero."
		            });
		        }
		    }
		},{
			fieldLabel: 'Axis position',
			maxLength: 10,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "Where to set the axis. Available options are left, bottom, right, top. Default's bottom.\nDefaults to: 'bottom'"
		            });
		        }
		    },
		    xtype: 'radiogroup',
			columns: 4,
		    items: [{
		    	boxLabel: 'left',
		    	name: 'AXISPOSITION',
			    inputValue: 'left'
		    },{
		    	boxLabel: 'right',
		    	name: 'AXISPOSITION',
			    inputValue: 'right'
		    },{
		    	boxLabel: 'top',
		    	name: 'AXISPOSITION',
			    inputValue: 'top'
		    },{
		    	boxLabel: 'bottom',
		    	name: 'AXISPOSITION',
			    inputValue: 'bottom'
		    }]
		},{
			name: 'AXISTITLE',
			fieldLabel: 'Axis title',
			maxLength: 50,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "The title for the Axis"
		            });
		        }
		    }
		},{
			name: 'AXISWIDTH',
			fieldLabel: 'Axis width',
			maxValue: 999,
			xtype: 'numberfield',
			width: 250,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "Offset axis width. Default's 0.\nDefaults to: 0"
		            });
		        }
		    }
		},{
			name: 'AXISCALCULATECATEGORYCOUNT',
			fieldLabel: 'Calculate category count',
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "Indicates whether or not to calculate the number of categories (ticks and labels) when there is not enough room to display all labels on the axis. If set to true, the axis will determine the number of categories to plot. If not, all categories will be plotted.\nDefaults to: false"
		            });
		        }
		    },
		    xtype: 'combobox',
			queryMode: 'local',
			store: 'query.yesno', 
			displayField: 'yesnoname',
			valueField: 'yesnocode',
			width: 300
		},{
			name: 'AXISCATEGORYNAMES',
			fieldLabel: 'Category names',
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "A list of category names to display along this axis."
		            });
		        }
		    }
		},{
			name: 'AXISMARGIN',
			fieldLabel: 'Axis margin',
			maxValue: 999,
			xtype: 'numberfield',
			width: 250,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "The offset positioning of the tick marks and labels in pixels.\nDefaults to: 10"
		            });
		        }
		    }
		},{
			name: 'AXISADJUSTMAXIMUMBYMAJORUNIT',
			fieldLabel: 'Adjust maximum by major unit',
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "Indicates whether to extend maximum beyond data's maximum to the nearest majorUnit.\nDefaults to: false"
		            });
		        }
		    },
		    xtype: 'combobox',
			queryMode: 'local',
			store: 'query.yesno', 
			displayField: 'yesnoname',
			valueField: 'yesnocode',
			width: 300
		},{
			name: 'AXISADJUSTMINIMUMBYMAJORUNIT',
			fieldLabel: 'Adjust minimum by major unit',
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "Indicates whether to extend the minimum beyond data's minimum to the nearest majorUnit.\nDefaults to: false"
		            });
		        }
		    },
		    xtype: 'combobox',
			queryMode: 'local',
			store: 'query.yesno', 
			displayField: 'yesnoname',
			valueField: 'yesnocode',
			width: 300
		},{
			name: 'AXISCONSTRAIN',
			fieldLabel: 'Constrain',
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "If true, the values of the chart will be rendered only if they belong between minimum and maximum. If false, all values of the chart will be rendered, regardless of whether they belong between minimum and maximum or not. Default's true if maximum and minimum is specified. It is ignored for stacked charts.\nDefaults to: true"
		            });
		        }
		    },
		    xtype: 'combobox',
			queryMode: 'local',
			store: 'query.yesno', 
			displayField: 'yesnoname',
			valueField: 'yesnocode',
			width: 300
		},{
			name: 'AXISDECIMALS',
			fieldLabel: 'Decimals',
			maxValue: 999,
			xtype: 'numberfield',
			width: 250,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "The number of decimals to round the value to.\nDefaults to: 2"
		            });
		        }
		    }
		},{
			name: 'AXISMAXIMUM',
			fieldLabel: 'Maximum',
			maxValue: 9999999,
			xtype: 'numberfield',
			width: 250,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "The maximum value drawn by the axis. If not set explicitly, the axis maximum will be calculated automatically. It is ignored for stacked charts."
		            });
		        }
		    }
		},{
			name: 'AXISMINIMUM',
			fieldLabel: 'Minimum',
			maxValue: 9999999,
			xtype: 'numberfield',
			width: 250,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "The minimum value drawn by the axis. If not set explicitly, the axis minimum will be calculated automatically. It is ignored for stacked charts."
		            });
		        }
		    }
		},{
			name: 'AXISDATEFORMAT',
			fieldLabel: 'Date format',
			maxLength: 30,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "Indicates the format the date will be rendered on. For example: 'M d' will render the dates as 'Jan 30', etc. For a list of possible format strings see Date\nDefaults to: false"
		            });
		        }
		    }
		},{
			name: 'AXISFROMDATE',
			fieldLabel: 'From date',
			xtype: 'datefield',
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "The starting date for the time axis.\nDefaults to: false"
		            });
		        }
		    }
		},{
			name: 'AXISSTEP',
			fieldLabel: 'Step',
			maxLength: 50,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "An array with two components: The first is the unit of the step (day, month, year, etc). The second one is a number. If the number is an integer, it represents the number of units for the step ([Ext.Date.DAY, 2] means \"Every other day\"). If the number is a fraction, it represents the number of steps per unit ([Ext.Date.DAY, 1/2] means \"Twice a day\"). If the unit is the month, the steps may be adjusted depending on the month. For instance [Ext.Date.MONTH, 1/3], which means \"Three times a month\", generates steps on the 1st, the 10th and the 20th of every month regardless of whether a month has 28 days or 31 days. The steps are generated as follows: - [Ext.Date.MONTH, n]: on the current date every 'n' months, maxed to the number of days in the month. - [Ext.Date.MONTH, 1/2]: on the 1st and 15th of every month. - [Ext.Date.MONTH, 1/3]: on the 1st, 10th and 20th of every month. - [Ext.Date.MONTH, 1/4]: on the 1st, 8th, 15th and 22nd of every month."
		            });
		        }
		    }
		},{
			name: 'AXISTODATE',
			fieldLabel: 'To date',
			xtype: 'datefield',
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "The ending date for the time axis.\nDefaults to: false"
		            });
		        }
		    }
		},{
			name: 'AXISEXTRA',
			fieldLabel: 'Axis extra',
			xtype: 'textareafield',
			width: 500
		},{
			name: 'SERIESAXIS',
			fieldLabel: 'Series axis',
			maxLength: 6,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "The position of the axis to bind the values to. Possible values are 'left', 'bottom', 'top' and 'right'. You must explicitly set this value to bind the values of the line series to the ones in the axis, otherwise a relative scale will be used. For example, if you're using a Scatter or Line series and you'd like to have the values in the chart relative to the bottom and left axes then axis should be ['left', 'bottom'].\nDefaults to: 'left'"
		            });
		        }
		    }
		},{
			name: 'SERIESHIGHLIGHT',
			fieldLabel: 'Highlight',
			maxLength: 30,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "If set to true it will highlight the markers or the series when hovering with the mouse. This parameter can also be an object with the same style properties you would apply to a Ext.draw.Sprite to apply custom styles to markers and series."
		            });
		        }
		    }
		},{
			name: 'SERIESLABEL',
			fieldLabel: 'Series Label',
			maxLength: 30,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "See chart label"
		            });
		        }
		    }
		},{
			name: 'SERIESLISTENERS',
			fieldLabel: 'Series listeners',
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "An (optional) object with event callbacks. All event callbacks get the target item as first parameter. The callback functions are:\n\nitemclick\nitemmouseover\nitemmouseout\nitemmousedown\nitemmouseup"
		            });
		        }
		    }
		},{
			name: 'SERIESRENDERER',
			fieldLabel: 'Renderer',
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "A function that can be overridden to set custom styling properties to each rendered element. Passes in (sprite, record, attributes, index, store) to the function."
		            });
		        }
		    }
		},{
			name: 'SERIESSHADOWATTRIBUTES',
			fieldLabel: 'Shadow attributes',
			maxLength: 150,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "An array with shadow attributes"
		            });
		        }
		    }
		},{
			name: 'SERIESSHOWINLEGEND',
			fieldLabel: 'Show in legend',
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "Whether to show this series in the legend.\nDefaults to: true"
		            });
		        }
		    },
		    xtype: 'combobox',
			queryMode: 'local',
			store: 'query.yesno', 
			displayField: 'yesnoname',
			valueField: 'yesnocode',
			width: 300
		},{
			name: 'SERIESSTYLE',
			fieldLabel: 'Series style',
			maxLength: 250,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "Append styling properties to this object for it to override theme properties.\nDefaults to: {}"
		            });
		        }
		    }
		},{
			name: 'SERIESTIPS',
			fieldLabel: 'Tips',
			maxLength: 200,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "Add tooltips to the visualization's markers. The options for the tips are the same configuration used with Ext.tip.ToolTip. For example:\ntips: {\ntrackMouse: true,\nwidth: 140,\nheight: 28,\nrenderer: function(storeItem, item) {\nthis.setTitle(storeItem.get('name') + ': ' + storeItem.get('data1') + ' views');\n}\n},"
		            });
		        }
		    }
		},{
			name: 'SERIESTITLE',
			fieldLabel: 'Series title',
			maxLength: 50,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "The human-readable name of the series."
		            });
		        }
		    }
		},{
			name: 'SERIESTYPE',
			fieldLabel: 'Series type',
			maxLength: 20,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "End Definitions\nThe type of series. Set in subclasses.\n\nDefaults to: 'area'"
		            });
		        }
		    }
		},{
			name: 'SERIESXFIELD',
			fieldLabel: 'Series x field',
			maxLength: 50,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "The name of the data Model field corresponding to the x-axis value."
		            });
		        }
		    }
		},{
			name: 'SERIESYFIELD',
			fieldLabel: 'Series y field',
			maxLength: 50,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "The name(s) of the data Model field(s) corresponding to the y-axis value(s)."
		            });
		        }
		    }
		},{
			name: 'SERIESCOLUMN',
			fieldLabel: 'Series column',
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "Whether to set the visualization as column chart or horizontal bar chart.\nDefaults to: true"
		            });
		        }
		    },
		    xtype: 'combobox',
			queryMode: 'local',
			store: 'query.yesno', 
			displayField: 'yesnoname',
			valueField: 'yesnocode',
			width: 300
		},{
			name: 'SERIESGROUPGUTTER',
			fieldLabel: 'Group gutter',
			xtype: 'numberfield',
			width: 250,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "The gutter space between groups of bars, as a percentage of the bar width\nDefaults to: 38.2"
		            });
		        }
		    }
		},{
			name: 'SERIESGUTTER',
			fieldLabel: 'Gutter',
			xtype: 'numberfield',
			width: 250,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "The gutter space between single bars, as a percentage of the bar width\nDefaults to: 38.2"
		            });
		        }
		    }
		},{
			name: 'SERIESSTACKED',
			fieldLabel: 'Stacked',
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "If set to true then bars for multiple yField values will be rendered stacked on top of one another. Otherwise, they will be rendered side-by-side. Defaults to false."
		            });
		        }
		    },
		    xtype: 'combobox',
			queryMode: 'local',
			store: 'query.yesno', 
			displayField: 'yesnoname',
			valueField: 'yesnocode',
			width: 300
		},{
			name: 'SERIESXPADDING',
			fieldLabel: 'X padding',
			maxLength: 25,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "Padding between the left/right axes and the bars. The possible values are a number (the number of pixels for both left and right padding) or an object with { left, right } properties.\n\nDefaults to: 10"
		            });
		        }
		    }
		},{
			name: 'SERIESYPADDING',
			fieldLabel: 'Y padding',
			maxLength: 25,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "Padding between the top/bottom axes and the bars. The possible values are a number (the number of pixels for both top and bottom padding) or an object with { top, bottom } properties.\n\nDefaults to: 0"
		            });
		        }
		    }
		},{
			name: 'SERIESANGLEFIELD',
			fieldLabel: 'Angle field',
			maxLength: 25,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "The store record field name to be used for the pie angles. The values bound to this field name must be positive real numbers.\nDefaults to: false"
		            });
		        }
		    }
		},{
			name: 'SERIESDONUT',
			fieldLabel: 'Donut',
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "Use the entire disk or just a fraction of it for the gauge. Default's false.\nDefaults to: false"
		            });
		        }
		    },
		    xtype: 'combobox',
			queryMode: 'local',
			store: 'query.yesno', 
			displayField: 'yesnoname',
			valueField: 'yesnocode',
			width: 300
		},{
			name: 'SERIESHIGHLIGHTDURATION',
			fieldLabel: 'Highlight duration',
			maxValue: 9999,
			xtype: 'numberfield',
			width: 250,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "The duration for the pie slice highlight effect.\nDefaults to: 150"
		            });
		        }
		    }
		},{
			name: 'SERIESNEEDLE',
			fieldLabel: 'Needle',
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "Use the Gauge Series as an area series or add a needle to it. Default's false.\nDefaults to: false"
		            });
		        }
		    },
		    xtype: 'combobox',
			queryMode: 'local',
			store: 'query.yesno', 
			displayField: 'yesnoname',
			valueField: 'yesnocode',
			width: 300
		},{
			name: 'SERIESFILL',
			fieldLabel: 'Fill',
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "If true, the area below the line will be filled in using the eefill and opacity config properties. Defaults to false.\nDefaults to: false"
		            });
		        }
		    },
		    xtype: 'combobox',
			queryMode: 'local',
			store: 'query.yesno', 
			displayField: 'yesnoname',
			valueField: 'yesnocode',
			width: 300
		},{
			name: 'SERIESMARKERCONFIG',
			fieldLabel: 'Marker config',
			maxLength: 100,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "The display style for the markers. Only used if showMarkers is true. The markerConfig is a configuration object containing the same set of properties defined in the Sprite class. For example, if we were to set red circles as markers to the line series we could pass the object:\n\nmarkerConfig: {\ntype: 'circle',\nradius: 4,\n'fill': '#f00'\n}\n\nDefaults to: {}"
		            });
		        }
		    }
		},{
			name: 'SERIESSELECTIONTOLERANCE',
			fieldLabel: 'Selection tolerance',
			maxValue: 999,
			xtype: 'numberfield',
			width: 250,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "The offset distance from the cursor position to the line series to trigger events (then used for highlighting series, etc).\nDefaults to: 20"
		            });
		        }
		    }
		},{
			name: 'SERIESSHOWMARKERS',
			fieldLabel: 'Show markers',
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "Whether markers should be displayed at the data points along the line. If true, then the markerConfig config item will determine the markers' styling.\nDefaults to: true"
		            });
		        }
		    },
		    xtype: 'combobox',
			queryMode: 'local',
			store: 'query.yesno', 
			displayField: 'yesnoname',
			valueField: 'yesnocode',
			width: 300
		},{
			name: 'SERIESSMOOTH',
			fieldLabel: 'Smooth',
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "If set to true or a non-zero number, the line will be smoothed/rounded around its points; otherwise straight line segments will be drawn.\nA numeric value is interpreted as a divisor of the horizontal distance between consecutive points in the line; larger numbers result in sharper curves while smaller numbers result in smoother curves.\nIf set to true then a default numeric value of 3 will be used. Defaults to false.\nDefaults to: false"
		            });
		        }
		    },
		    xtype: 'combobox',
			queryMode: 'local',
			store: 'query.yesno', 
			displayField: 'yesnoname',
			valueField: 'yesnocode',
			width: 300
		},{
			name: 'SERIESCOLORSET',
			fieldLabel: 'Color set',
			maxLength: 250,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "An array of color values which will be used, in order, as the pie slice fill colors."
		            });
		        }
		    }
		},{
			name: 'SERIESFIELD',
			fieldLabel: 'Series field',
			maxLength: 50,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "An array of color values which will be used, in order, as the pie slice fill colors."
		            });
		        }
		    }
		},{
			name: 'SERIESLENGTHFIELD',
			fieldLabel: 'Length field',
			maxLength: 50,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "The store record field name to be used for the pie slice lengths. The values bound to this field name must be positive real numbers.Defaults to: false"
		            });
		        }
		    }
		},{
			name: 'SERIESEXTRA',
			fieldLabel: 'Series extra properties',
			xtype: 'textareafield',
			width: 700
		},{
			name: 'CHARTEXTRA',
			fieldLabel: 'Chart extra properties',
			xtype: 'textareafield',
			width: 700
		}];
		this.callParent(arguments);
	}
});