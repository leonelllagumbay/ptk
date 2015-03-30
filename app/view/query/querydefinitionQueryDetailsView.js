Ext.define('Form.view.query.querydefinitionQueryDetailsView', { 
	extend: 'Ext.form.Panel',
	alias: 'widget.querydefinitionquerydetailsview',
	title: 'Query Details',
	width: '100%', 
	height: '100%',
	autoScroll: true,
	initComponent: function() {  
		this.tbar = [{
		  	text: 'Query List',
			action: 'querylist'
		  },{
		  	text: 'Preview',
			action: 'previewquery'
	    }];
		
		this.defaults = {
				xtype: 'textfield',
				labelWidth: 150,
				margin: '10 10 0 50',
				padding: 7,
				width: '100%'
		};
		
		this.items = [{
			xtype: 'fieldset',
			columnWidth: 0.5,
			title: 'Basic config',
			collapsible: true,
			layout: 'anchor',
			defaults: {
				xtype: 'textfield',
				labelWidth: 150,
				padding: 5,
				width: 400
			},
			items: [{
				name: 'EQRYCODE',
				xtype: 'hiddenfield',
				allowBlank: true
			},{
				name: 'OUTPUTTYPE',
				fieldLabel: 'Output type',
				xtype: 'combobox',
				queryMode: 'local',
				store: 'query.outputType', 
				displayField: 'outputtypename',
				valueField: 'outputtypecode',
				forceSelection: true,
				editable: false,
				allowBlank: false,
				value: 'grid'
			},{
				name: 'QRYTITLE',
				xtype: 'textfield',
				fieldLabel: 'Title',
				maxLength: 100,
				allowBlank: false,
				width: 700
			},{
				name: 'FEATURES',
				fieldLabel: 'Features',
				xtype: 'combobox',
				width: 700,
				queryMode: 'local',
				store: 'query.featureStore', 
				displayField: 'featurename',
				valueField: 'featurecode'
			},{
				name: 'PLUGINS',
				fieldLabel: 'Plugins',
				xtype: 'combobox',
				width: 700,
				queryMode: 'local',
				store: 'query.pluginStore', 
				displayField: 'pluginname',
				valueField: 'plugincode'
			}]
		},{
			xtype: 'querydefinitionquerydetailsfeature'
		},{
			xtype: 'querydefinitionquerydetailsplugin'
		},{
			xtype: 'fieldset',
			title: 'Dimension',
			collapsible: true,
			layout: 'anchor',
			defaults: {
				xtype: 'textfield',
				labelWidth: 150,
				padding: 5,
				width: 400
			},
			items: [{
				name: 'ANCHORSIZE',
				fieldLabel: 'Anchor size',
				maxLength: 30,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "Defines the anchoring size of container. Either a number to define the width of the container or an object with width and height fields."
			            });
			        }
			    }
			},{
				name: 'COLUMNWIDTH',
				fieldLabel: 'Column width ( no. or % of column layout )',
				maxLength: 5,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "Defines the column width inside column layout."
			            });
			        }
			    }
			},{
				name: 'WIDTH',
				fieldLabel: 'Width ( The width of this component in pixels )',
				xtype: 'numberfield',
				width: 250,
				maxValue: 99999
			},{
				name: 'HEIGHT',
				fieldLabel: 'Height ( The height of this component in pixels )',
				xtype: 'numberfield',
				width: 250,
				maxValue: 99999
			},{
				name: 'MAXHEIGHT',
				fieldLabel: 'Max height',
				xtype: 'numberfield',
				width: 250,
				maxValue: 99999
			},{
				name: 'MAXWIDTH',
				fieldLabel: 'Max width',
				xtype: 'numberfield',
				width: 250,
				maxValue: 99999
			},{
				name: 'MINHEIGHT',
				fieldLabel: 'Minimum height',
				xtype: 'numberfield',
				width: 250,
				maxValue: 9999
			},{
				name: 'MINWIDTH',
				fieldLabel: 'Minimum width',
				xtype: 'numberfield',
				width: 250,
				maxValue: 9999
			},{
				name: 'MINBUTTONWIDTH',
				fieldLabel: 'Minimum button width',
				xtype: 'numberfield',
				width: 250,
				maxValue: 9999,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "Minimum width of all footer toolbar buttons in pixels."
			            });
			        }
			    }
			}]
		},{
			xtype: 'fieldset',
			columnWidth: 0.5,
			title: 'Basic style',
			collapsible: true,
			layout: 'anchor',
			defaults: {
				xtype: 'textfield',
				labelWidth: 150,
				padding: 5,
				width: 400
			},
			items: [{
				name: 'MARGIN',
				fieldLabel: 'Margin',
				maxLength: 15,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "Specifies the margin for this component. The margin can be a single numeric value to apply to all sides or it can be a CSS style specification for each style, for example: '10 5 3 10' (top, right, bottom, left)."
			            });
			        }
			    }
			},{
				name: 'PADDING',
				fieldLabel: 'Padding (same with margin value format)',
				maxLength: 15,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "Specifies the padding for this component. The padding can be a single numeric value to apply to all sides or it can be a CSS style specification for each style, for example: '10 5 3 10' (top, right, bottom, left)."
			            });
			        }
			    }
			},{
				name: 'BORDER',
				fieldLabel: 'Border',
				maxLength: 11,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "Specifies the border size for this component. The border can be a single numeric value to apply to all sides or it can be a CSS style specification for each style, for example: '10 5 3 10' (top, right, bottom, left)."
			            });
			        }
			    }
			},{
				name: 'BODYBORDER',
				fieldLabel: 'Body Border',
				xtype: 'combobox',
				queryMode: 'local',
				store: 'query.yesno', 
				displayField: 'yesnoname',
				valueField: 'yesnocode',
				width: 300,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "A shortcut to add or remove the border on the body of a panel. In the classic theme this only applies to a panel which has the frame configuration set to true"
			            });
			        }
			    }
			},{
				name: 'BODYPADDING',
				fieldLabel: 'Body padding',
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "A shortcut for setting a padding style on the body element. ex. 5 or 4 2 1 2)"
			            });
			        }
			    },
				maxLength: 15
			},{
				name: 'BODYSTYLE',
				fieldLabel: 'Body style',
				maxLength: 50,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "Custom CSS styles to be applied to the panel's body element, which can be supplied as a valid CSS style string, an object containing style property name/value pairs or a function that returns such a string or object. For example, these two formats are interpreted to be equivalent:\n\nbodyStyle: 'background:#ffc; padding:10px;'\n\nbodyStyle: {\n background: '#ffc',\n padding: '10px'\n}"
			            });
			        }
			    }
			},{
				name: 'SHADOW',
				fieldLabel: 'Shadow',
				xtype: 'combobox',
				queryMode: 'local',
				store: 'query.yesno', 
				displayField: 'yesnoname',
				valueField: 'yesnocode',
				width: 300,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "Specifies whether the floating component should be given a shadow. Set to true to automatically create an Ext.Shadow, or a string indicating the shadow's display Ext.Shadow.mode. Set to false to disable the shadow."
			            });
			        }
			    }
			},{
				name: 'SHADOWOFFSET',
				fieldLabel: 'Shadow offset (Number of pixels to offset the shadow.)',
				xtype: 'numberfield',
				width: 250,
				maxValue: 500
			},{
				name: 'STYLE',
				fieldLabel: 'Style',
				maxLength: 255,
				width: 700,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "A custom style specification to be applied to this component's Element.\n\n{\n width: '95%',\n marginBottom: '10px'\n}"
			            });
			        }
			    }
			},{
				name: 'QRYUI',
				fieldLabel: 'UI',
				maxLength: 20,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "A UI style for a component. Defaults to: 'default'"
			            });
			        }
			    }
			}]
		},{
			xtype: 'fieldset',
			columnWidth: 0.5,
			title: 'Behavior',
			collapsible: true,
			layout: 'anchor',
			defaults: {
				xtype: 'textfield',
				labelWidth: 150,
				padding: 5,
				width: 400
			},
			items: [{
				name: 'AUTOSCROLL',
				fieldLabel: 'Auto scroll',
				xtype: 'combobox',
				queryMode: 'local',
				store: 'query.yesno', 
				displayField: 'yesnoname',
				valueField: 'yesnocode',
				width: 300,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "true to use overflow:'auto' on the components layout element and show scroll bars automatically when necessary, false to clip any overflowing content. This should not be combined with overflowX or overflowY. Defaults to: false"
			            });
			        }
			    }
			},{
				name: 'AUTODESTROY',
				fieldLabel: 'Auto destroy',
				xtype: 'combobox',
				queryMode: 'local',
				store: 'query.yesno', 
				displayField: 'yesnoname',
				valueField: 'yesnocode',
				width: 300,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "If true the container will automatically destroy any contained component that is removed from it, else destruction must be handled manually. Defaults to: true"
			            });
			        }
			    }
			},{
				name: 'AUTORENDER',
				fieldLabel: 'Auto render',
				xtype: 'combobox',
				queryMode: 'local',
				store: 'query.yesno', 
				displayField: 'yesnoname',
				valueField: 'yesnocode',
				width: 300,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "This config is intended mainly for non-floating Components which may or may not be shown. Instead of using renderTo in the configuration, and rendering upon construction, this allows a Component to render itself upon first show. If floating is true, the value of this config is omitted as if it is true.\nSpecify as true to have this Component render to the document body upon first show.\nSpecify as an element, or the ID of an element to have this Component render to a specific element upon first show.\nDefaults to: false"
			            });
			        }
			    }
			},{
				name: 'AUTOSHOW',
				fieldLabel: 'Auto show',
				xtype: 'combobox',
				queryMode: 'local',
				store: 'query.yesno', 
				displayField: 'yesnoname',
				valueField: 'yesnocode',
				width: 300,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "true to automatically show the component upon creation. This config option may only be used for floating components or components that use autoRender. Defaults to: false"
			            });
			        }
			    }
			},{
				name: 'CLOSABLE',
				fieldLabel: 'Closable',
				xtype: 'combobox',
				queryMode: 'local',
				store: 'query.yesno', 
				displayField: 'yesnoname',
				valueField: 'yesnocode',
				width: 300,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "True to display the 'close' tool button and allow the user to close the window, false to hide the button and disallow closing the window. Defaults to: false"
			            });
			        }
			    }
			},{
				name: 'COLLAPSIBLE',
				fieldLabel: 'Collapsible',
				xtype: 'combobox',
				queryMode: 'local',
				store: 'query.yesno', 
				displayField: 'yesnoname',
				valueField: 'yesnocode',
				width: 300,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "True to make the panel collapsible and have an expand/collapse toggle Tool added into the header tool button area. False to keep the panel sized either statically, or by an owning layout manager, with no toggle Tool. When a panel is used in a border layout, the floatable option can influence the behavior of collapsing."
			            });
			        }
			    }
			},{
				name: 'DRAGGABLE',
				fieldLabel: 'draggable',
				maxLength: 30,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "Specify as true to make a floating Component draggable using the Component's encapsulating element as the drag handle."
			            });
			        }
			    }
			},{
				name: 'RESIZABLE',
				fieldLabel: 'Resizable',
				maxLength: 50,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "Specify as true to apply a Resizer to this Component after rendering."
			            });
			        }
			    }
			},{
				name: 'FLOATABLE',
				fieldLabel: 'Floatable',
				xtype: 'combobox',
				queryMode: 'local',
				store: 'query.yesno', 
				displayField: 'yesnoname',
				valueField: 'yesnocode',
				width: 300,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "Important: This config is only effective for collapsible Panels which are direct child items of a border layout.\ntrue to allow clicking a collapsed Panel's placeholder to display the Panel floated above the layout, false to force the user to fully expand a collapsed region by clicking the expand button to see it again.\nDefaults to true."
			            });
			        }
			    }
			},{
				name: 'TOFRONTONSHOW',
				fieldLabel: 'To front on show',
				xtype: 'combobox',
				queryMode: 'local',
				store: 'query.yesno', 
				displayField: 'yesnoname',
				valueField: 'yesnocode',
				width: 300,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "True to automatically call toFront when the show method is called on an already visible, floating component. Defaults to: true"
			            });
			        }
			    }
			},{
				name: 'PLACEHOLDER',
				maxLength: 50,
				fieldLabel: 'Placeholder',
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "Important: This config is only effective for collapsible Panels which are direct child items of a border layout when not using the 'header' collapseMode.\n\nOptional. A Component (or config object for a Component) to show in place of this Panel when this Panel is collapsed by a border layout. Defaults to a generated Header containing a Tool to re-expand the Panel."
			            });
			        }
			    }
			},{
				name: 'SAVEDELAY',
				fieldLabel: 'Save delay',
				xtype: 'numberfield',
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "A buffer to be applied if many state events are fired within a short period."
			            });
			        }
			    },
			    width: 250,
			    maxValue: 1000
			}]
		},{
			xtype: 'fieldset',
			columnWidth: 0.5,
			title: 'Mode',
			collapsible: true,
			layout: 'anchor',
			defaults: {
				xtype: 'textfield',
				labelWidth: 150,
				padding: 5,
				width: 400
			},
			items: [{
				name: 'COLLAPSEDFIRST',
				fieldLabel: 'Collapsed first',
				xtype: 'combobox',
				queryMode: 'local',
				store: 'query.yesno', 
				displayField: 'yesnoname',
				valueField: 'yesnocode',
				width: 300,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "true to make sure the collapse/expand toggle button always renders first (to the left of) any other tools in the panel's title bar, false to render it last. Defaults to: true"
			            });
			        }
			    }
			},{
				name: 'COLLAPSED',
				fieldLabel: 'Collapsed',
				xtype: 'combobox',
				queryMode: 'local',
				store: 'query.yesno', 
				displayField: 'yesnoname',
				valueField: 'yesnocode',
				width: 300,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "True to automatically call toFront when the show method is called on an already visible, floating component. Defaults to: true"
			            });
			        }
			    }
			},{
				name: 'DISABLED',
				fieldLabel: 'Disabled',
				xtype: 'combobox',
				queryMode: 'local',
				store: 'query.yesno', 
				displayField: 'yesnoname',
				valueField: 'yesnocode',
				width: 300,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "True to disable the field. Disabled Fields will not be submitted. Defaults to: false"
			            });
			        }
			    }
			},{
				name: 'ALLOWDESELECT',
				fieldLabel: 'Allow deselect',
				xtype: 'combobox',
				queryMode: 'local',
				store: 'query.yesno', 
				displayField: 'yesnoname',
				valueField: 'yesnocode',
				width: 300,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "True to allow deselecting a record. Defaults to: false"
			            });
			        }
			    }
			},{
				name: 'ANIMCOLLAPSE',
				fieldLabel: 'Anim collapse',
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "true to animate the transition when the panel is collapsed, false to skip the animation (defaults to true if the Ext.fx.Anim class is available, otherwise false). May also be specified as the animation duration in milliseconds."
			            });
			        }
			    }
			},{
				fieldLabel: 'Collapsed direction',
				xtype: 'radiogroup',
				width: 500,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "The direction to collapse the Panel when the toggle button is clicked. Defaults to the headerPosition"
			            });
			        }
			    },
			    columns: 4,
			    items: [{
			    	boxLabel: 'Top',
			    	name: 'COLLAPSEDIRECTION',
				    inputValue: 'top'
			    },{
			    	boxLabel: 'Bottom',
			    	name: 'COLLAPSEDIRECTION',
				    inputValue: 'bottom'
			    },{
			    	boxLabel: 'Left',
			    	name: 'COLLAPSEDIRECTION',
				    inputValue: 'left'
			    },{
			    	boxLabel: 'Right',
			    	name: 'COLLAPSEDIRECTION',
				    inputValue: 'right'
			    }]
			},{
				name: 'COLLAPSEMODE',
				fieldLabel: 'Collapse mode',
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "Important: this config is only effective for collapsible Panels which are direct child items of a border layout.\n\nWhen not a direct child item of a border layout, then the Panel's header remains visible, and the body is collapsed to zero dimensions. If the Panel has no header, then a new header (orientated correctly depending on the collapseDirection) will be inserted to show a the title and a re- expand tool.\n\nWhen a child item of a border layout, this config has three possible values:\n\n- undefined - When collapsed, a placeholder Header is injected into the layout to represent the Panel and to provide a UI with a Tool to allow the user to re-expand the Panel\n- \"header\" - The Panel collapses to leave its header visible as when not inside a border layout.\n- \"mini\" - The Panel collapses without a visible header."
			            });
			        }
			    }
			},{
				name: 'DISABLESELECTION',
				fieldLabel: 'Disable selection',
				xtype: 'combobox',
				queryMode: 'local',
				store: 'query.yesno', 
				displayField: 'yesnoname',
				valueField: 'yesnocode',
				width: 300,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "True to disable selection model. Defaults to: false"
			            });
			        }
			    }
			},{
				name: 'FIXED',
				fieldLabel: 'Fixed',
				xtype: 'combobox',
				queryMode: 'local',
				store: 'query.yesno', 
				displayField: 'yesnoname',
				valueField: 'yesnocode',
				width: 300,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "Configure as true to have this Component fixed at its X, Y coordinates in the browser viewport, immune to scrolling the document.\nIE6 and IE7, 8 and 9 quirks do not support position: fixed\nDefaults to: false"
			            });
			        }
			    }
			},{
				name: 'FLOATING',
				fieldLabel: 'Floating',
				xtype: 'combobox',
				queryMode: 'local',
				store: 'query.yesno', 
				displayField: 'yesnoname',
				valueField: 'yesnocode',
				width: 300,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "Specify as true to float the Component outside of the document flow using CSS absolute positioning.\n\nComponents such as Windows and Menus are floating by default.\n\nFloating Components that are programatically rendered will register themselves with the global ZIndexManager"
			            });
			        }
			    }
			},{
				fieldLabel: 'Resize handles',
				xtype: 'radiogroup',
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "Only applies when resizable = true."
			            });
			        }
			    },
			    width: 500,
			    columns: 3,
			    items: [{
			    	boxLabel: 'north',
			    	name: 'RESIZEHANDLES',
				    inputValue: 'n'
			    },{
			    	boxLabel: 'south',
			    	name: 'RESIZEHANDLES',
				    inputValue: 's'
			    },{
			    	boxLabel: 'east',
			    	name: 'RESIZEHANDLES',
				    inputValue: 'e'
			    },{
			    	boxLabel: 'west',
			    	name: 'RESIZEHANDLES',
				    inputValue: 'w'
			    },,{
			    	boxLabel: 'northwest',
			    	name: 'RESIZEHANDLES',
				    inputValue: 'nw'
			    },{
			    	boxLabel: 'southwest',
			    	name: 'RESIZEHANDLES',
				    inputValue: 'sw'
			    },{
			    	boxLabel: 'southeast',
			    	name: 'RESIZEHANDLES',
				    inputValue: 'se'
			    },{
			    	boxLabel: 'northeast',
			    	name: 'RESIZEHANDLES',
				    inputValue: 'ne'
			    },{
			    	boxLabel: 'all',
			    	name: 'RESIZEHANDLES',
				    inputValue: 'all'
			    }]
			},{
				name: 'TITLECOLLAPSE',
				fieldLabel: 'Title collapse',
				xtype: 'combobox',
				queryMode: 'local',
				store: 'query.yesno', 
				displayField: 'yesnoname',
				valueField: 'yesnocode',
				width: 300,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "true to allow expanding and collapsing the panel (when collapsible = true) by clicking anywhere in the header bar, false) to allow it only by clicking to tool button). When a panel is used in a border layout, the floatable option can influence the behavior of collapsing."
			            });
			        }
			    }
			},{
				name: 'HIDDEN',
				fieldLabel: 'Hidden (true to hide the component)',
				xtype: 'combobox',
				queryMode: 'local',
				store: 'query.yesno', 
				displayField: 'yesnoname',
				valueField: 'yesnocode',
				width: 300
			},{
				name: 'HIDECOLLAPSETOOL',
				fieldLabel: 'Hide collapse tool',
				xtype: 'combobox',
				queryMode: 'local',
				store: 'query.yesno', 
				displayField: 'yesnoname',
				valueField: 'yesnocode',
				width: 300,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "true to hide the expand/collapse toggle button when collapsible == true, false to display it. Defaults to: false"
			            });
			        }
			    }
			},{
				name: 'HIDEHEADER',
				fieldLabel: 'Hide headers (True to hide column headers)',
				xtype: 'combobox',
				queryMode: 'local',
				store: 'query.yesno', 
				displayField: 'yesnoname',
				valueField: 'yesnocode',
				width: 300
			},{
				fieldLabel: 'Hide mode',
				xtype: 'radiogroup',
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "A String which specifies how this Component's encapsulating DOM element will be hidden. Values may be:\n\n'display' : The Component will be hidden using the display: none style.\n'visibility' : The Component will be hidden using the visibility: hidden style.\n'offsets' : The Component will be hidden by absolutely positioning it out of the visible area of the document. This is useful when a hidden Component must maintain measurable dimensions. Hiding using display results in a Component having zero dimensions."
			            });
			        }
			    },
			    width: 500,
			    columns: 3,
			    items: [{
			    	boxLabel: 'display',
			    	name: 'HIDEMODE',
				    inputValue: 'display'
			    },{
			    	boxLabel: 'visibility',
			    	name: 'HIDEMODE',
				    inputValue: 'visibility'
			    },{
			    	boxLabel: 'offsets',
			    	name: 'HIDEMODE',
				    inputValue: 'offsets'
			    }]
			},{
				name: 'ROWLINES',
				fieldLabel: 'Row lines (False to remove row line styling)',
				xtype: 'combobox',
				queryMode: 'local',
				store: 'query.yesno', 
				displayField: 'yesnoname',
				valueField: 'yesnocode',
				width: 300
			},{
				name: 'SIMPLEDRAG',
				fieldLabel: 'Simple drag',
				xtype: 'combobox',
				queryMode: 'local',
				store: 'query.yesno', 
				displayField: 'yesnoname',
				valueField: 'yesnocode',
				width: 300,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "When draggable is true, Specify this as true to cause the draggable config to work the same as it does in Window. This Panel just becomes movable. No DragDrop instances receive any notifications."
			            });
			        }
			    }
			},{
				name: 'ENABLECOLUMNHIDE',
				fieldLabel: 'Enable column hide (False to disable column hiding within this grid)',
				xtype: 'combobox',
				queryMode: 'local',
				store: 'query.yesno', 
				displayField: 'yesnoname',
				valueField: 'yesnocode',
				width: 300
			},{
				name: 'ENABLECOLUMNMOVE',
				fieldLabel: 'Enable column move (False to disable column dragging within this grid)',
				xtype: 'combobox',
				queryMode: 'local',
				store: 'query.yesno', 
				displayField: 'yesnoname',
				valueField: 'yesnocode',
				width: 300
			},{
				name: 'ENABLECOLUMNRESIZE',
				fieldLabel: 'Enable column resize (False to disable column resizing within this grid)',
				xtype: 'combobox',
				queryMode: 'local',
				store: 'query.yesno', 
				displayField: 'yesnoname',
				valueField: 'yesnocode',
				width: 300
			},{
				name: 'ENABLELOCKING',
				fieldLabel: 'Enable locking',
				xtype: 'combobox',
				queryMode: 'local',
				store: 'query.yesno', 
				displayField: 'yesnoname',
				valueField: 'yesnocode',
				width: 300,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "Configure as true to enable locking support for this grid. Alternatively, locking will also be automatically enabled if any of the columns in the columns configuration contain a locked config option.\n\nA locking grid is processed in a special way. The configuration options are cloned and two grids are created to be the locked (left) side and the normal (right) side. This Panel becomes merely a container which arranges both in an HBox layout.\n\nDefaults to false"
			            });
			        }
			    }
			},{
				name: 'PLACEHOLDERCOLLAPSEHIDEMODE',
				fieldLabel: 'Placeholder collapse hide mode',
				xtype: 'numberfield',
				width: 250,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "The mode for hiding collapsed panels when using collapseMode \"placeholder\""
			            });
			        }
			    }
			},{
				name: 'OVERLAPHEADER',
				fieldLabel: 'Overlap header',
				xtype: 'combobox',
				queryMode: 'local',
				store: 'query.yesno', 
				displayField: 'yesnoname',
				valueField: 'yesnocode',
				width: 300,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "True to overlap the header in a panel over the framing of the panel itself. This is needed when frame:true (and is done automatically for you). Otherwise it is undefined. If you manually add rounded corners to a panel header which does not have frame:true, this will need to be set to true."
			            });
			        }
			    }
			},{
				name: 'MANAGEHEIGHT',
				fieldLabel: 'Manage height',
				xtype: 'combobox',
				queryMode: 'local',
				store: 'query.yesno', 
				displayField: 'yesnoname',
				valueField: 'yesnocode',
				width: 300,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "When true, the dock component layout writes height information to the panel's DOM elements based on its shrink wrap height calculation. This ensures that the browser respects the calculated height. When false, the dock component layout will not write heights on the panel or its body element. In some simple layout cases, not writing the heights to the DOM may be desired because this allows the browser to respond to direct DOM manipulations (like animations). Defaults to true."
			            });
			        }
			    }
			},{
				name: 'SYNCROWHEIGHT',
				fieldLabel: 'Sync row height',
				xtype: 'combobox',
				queryMode: 'local',
				store: 'query.yesno', 
				displayField: 'yesnoname',
				valueField: 'yesnocode',
				width: 300,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "Synchronize rowHeight between the normal and locked grid view. This is turned on by default. If your grid is guaranteed to have rows of all the same height, you should set this to false to optimize performance. Defaults to: true"
			            });
			        }
			    }
			}]
		},{
			xtype: 'fieldset',
			columnWidth: 0.5,
			title: 'Position',
			collapsible: true,
			layout: 'anchor',
			defaults: {
				xtype: 'textfield',
				labelWidth: 150,
				padding: 5,
				width: 400
			},
			items: [{
				fieldLabel: 'Title align',
				xtype: 'radiogroup',
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "The alignment of the title text within the available space between the icon and the tools."
			            });
			        }
			    },
			    columns: 3,
			    items: [{
			    	boxLabel: 'left',
			    	name: 'TITLEALIGN',
				    inputValue: 'left'
			    },{
			    	boxLabel: 'right',
			    	name: 'TITLEALIGN',
				    inputValue: 'right'
			    },{
			    	boxLabel: 'center',
			    	name: 'TITLEALIGN',
				    inputValue: 'center'
			    }]
			},{
				fieldLabel: 'Button align',
				xtype: 'radiogroup',
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "The alignment of any buttons added to this panel. Valid values are 'right', 'left' and 'center' (defaults to 'right' for buttons/fbar, 'left' for other toolbar types).\n\nNOTE: The prefered way to specify toolbars is to use the dockedItems config. Instead of buttonAlign you would add the layout: { pack: 'start' | 'center' | 'end' } option to the dockedItem config."
			            });
			        }
			    },
			    columns: 3,
			    items: [{
			    	boxLabel: 'left',
			    	name: 'BUTTONALIGN',
				    inputValue: 'left'
			    },{
			    	boxLabel: 'right',
			    	name: 'BUTTONALIGN',
				    inputValue: 'right'
			    },{
			    	boxLabel: 'center',
			    	name: 'BUTTONALIGN',
				    inputValue: 'center'
			    }]
			},{
				fieldLabel: 'Header position',
				width: 500,
				xtype: 'radiogroup',
				columns: 4,
			    items: [{
			    	boxLabel: 'left',
			    	name: 'HEADERPOSITION',
				    inputValue: 'left'
			    },{
			    	boxLabel: 'right',
			    	name: 'HEADERPOSITION',
				    inputValue: 'right'
			    },{
			    	boxLabel: 'top',
			    	name: 'HEADERPOSITION',
				    inputValue: 'top'
			    },{
			    	boxLabel: 'bottom',
			    	name: 'HEADERPOSITION',
				    inputValue: 'bottom'
			    }]
			},{
				fieldLabel: 'Region',
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "Defines the region inside border layout.\n\nnorth - Positions component at top.\nsouth - Positions component at bottom.\neast - Positions component at right.\nwest - Positions component at left.\ncenter - Positions component at the remaining space. There must be a component with region: \"center\" in every border layout."
			            });
			        }
			    },
				xtype: 'radiogroup',
				columns: 2,
			    items: [{
			    	boxLabel: 'north',
			    	name: 'REGION',
				    inputValue: 'north'
			    },{
			    	boxLabel: 'south ',
			    	name: 'REGION',
				    inputValue: 'south '
			    },{
			    	boxLabel: 'east',
			    	name: 'REGION',
				    inputValue: 'east'
			    },{
			    	boxLabel: 'west',
			    	name: 'REGION',
				    inputValue: 'west'
			    },{
			    	boxLabel: 'center',
			    	name: 'REGION',
				    inputValue: 'center'
			    },{
			    	boxLabel: 'none',
			    	name: 'REGION',
				    inputValue: ''
			    }]
			},{
				fieldLabel: 'Scroll',
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "Defines the region inside border layout.\n\nnorth - Positions component at top.\nsouth - Positions component at bottom.\neast - Positions component at right.\nwest - Positions component at left.\ncenter - Positions component at the remaining space. There must be a component with region: \"center\" in every border layout."
			            });
			        }
			    },
				xtype: 'radiogroup',
				columns: 2,
			    items: [{
			    	boxLabel: 'horizontal',
			    	name: 'SCROLL',
				    inputValue: 'horizontal'
			    },{
			    	boxLabel: 'vertical ',
			    	name: 'SCROLL',
				    inputValue: 'vertical '
			    },{
			    	boxLabel: 'both',
			    	name: 'SCROLL',
				    inputValue: 'true'
			    },{
			    	boxLabel: 'none',
			    	name: 'SCROLL',
				    inputValue: 'false'
			    }]
			},{
				name: 'OVERFLOWX',
				fieldLabel: 'Overflow x',
				maxLength: 7,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "Possible values are: * 'auto' to enable automatic horizontal scrollbar (overflow-x: 'auto'). * 'scroll' to always enable horizontal scrollbar (overflow-x: 'scroll'). The default is overflow-x: 'hidden'. This should not be combined with autoScroll."
			            });
			        }
			    }
			},{
				name: 'OVERFLOWY',
				fieldLabel: 'Overflow y',
				maxLength: 7,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "Possible values are: * 'auto' to enable automatic vertical scrollbar (overflow-y: 'auto'). * 'scroll' to always enable vertical scrollbar (overflow-y: 'scroll'). The default is overflow-y: 'hidden'. This should not be combined with autoScroll."
			            });
			        }
			    }
			}] 
		},{
			xtype: 'fieldset',
			columnWidth: 0.5,
			title: 'Column',
			collapsible: true,
			layout: 'anchor',
			defaults: {
				xtype: 'textfield',
				labelWidth: 150,
				padding: 5,
				width: 400
			},
			items: [{
				name: 'EMPTYTEXT',
				fieldLabel: 'Empty text',
				maxLength: 100,
				width: 500,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "Default text (html tags are accepted) to display in the Panel body when the Store is empty. When specified, and the Store is empty, the text will be rendered inside a DIV with the CSS class \"x-grid-empty\"."
			            });
			        }
			    }
			},{
				name: 'COLUMNLINES',
				fieldLabel: 'Column lines (Adds column line styling)',
				xtype: 'combobox',
				queryMode: 'local',
				store: 'query.yesno', 
				displayField: 'yesnoname',
				valueField: 'yesnocode',
				width: 300
			},{
				name: 'QRYCONSTRAIN',
				fieldLabel: 'Constrain',
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "True to constrain the panel within its containing element, false to allow it to fall outside of its containing element. By default floating components such as Windows will be rendered to document.body. To render and constrain the window within another element specify renderTo. Optionally the header only can be constrained using constrainHeader.\nDefault to false."
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
				name: 'CONSTRAINHEADER',
				fieldLabel: 'Constrain header',
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "True to constrain the panel header within its containing element (allowing the panel body to fall outside of its containing element) or false to allow the header to fall outside its containing element. Optionally the entire panel can be constrained using constrain.\nDefault to false."
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
				name: 'QRYCONSTRAINTO',
				fieldLabel: 'Constrain to',
				maxLength: 35,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "A Region (or an element from which a Region measurement will be read) which is used to constrain the component. Only applies when the component is floating."
			            });
			        }
			    }
			},{
				name: 'CONSTRAINTINSETS',
				fieldLabel: 'Constraint insets',
				maxLength: 20,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "An object or a string (in TRBL order) specifying insets from the configured constrain region within which this component must be constrained when positioning or sizing. example:\n\nconstraintInsets: '10 10 10 10' \/\/ Constrain with 10px insets from parent"
			            });
			        }
			    }
			},{
				name: 'FRAME',
				fieldLabel: 'Frame (True to apply a frame to the panel. Default: false)',
				xtype: 'combobox',
				queryMode: 'local',
				store: 'query.yesno', 
				displayField: 'yesnoname',
				valueField: 'yesnocode',
				width: 300
			},{
				name: 'FRAMEHEADER',
				fieldLabel: 'Frame header',
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "True to apply a frame to the panel panels header (if 'frame' is true). Defaults to true."
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
				name: 'GLYPH',
				fieldLabel: 'Glyph',
				maxLength: 30,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "A numeric unicode character code to use as the icon for the panel header. The default font-family for glyphs can be set globally using Ext.setGlyphFontFamily(). Alternatively, this config option accepts a string with the charCode and font-family separated by the @ symbol. For example '65@My Font Family'."
			            });
			        }
			    },
			},{
				name: 'HEADER',
				fieldLabel: 'Header',
				maxLength: 200,
				width: 700,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "Pass as false to prevent a Header from being created and shown.\n\nPass as a config object (optionally containing an xtype) to custom-configure this Panel's header."
			            });
			        }
			    },
			},{
				name: 'ITEMS',
				fieldLabel: 'Items',
				width: 700,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "A single item, or an array of child Components to be added to this container"
			            });
			        }
			    }
			},{
				name: 'DOCKEDITEMS',
				fieldLabel: 'Docked items',
				maxLength: 100,
				width: 500,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "A component or series of components to be added as docked items to this panel. The docked items can be docked to either the top, right, left or bottom of a panel. This is typically used for things like toolbars or tab bars"
			            });
			        }
			    }
			},{
				name: 'ITEMID',
				fieldLabel: 'Item id',
				maxLength: 50,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "An itemId can be used as an alternative way to get a reference to a component when no object reference is available. Instead of using an id with Ext.getCmp, use itemId with Ext.container.Container.getComponent which will retrieve itemId's or id's. Since itemId's are an index to the container's internal MixedCollection, the itemId is scoped locally to the container -- avoiding potential conflicts with Ext.ComponentManager which requires a unique id."
			            });
			        }
			    }
			},{
				name: 'SEALEDCOLUMNS',
				fieldLabel: 'Sealed columns',
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "True to constrain column dragging so that a column cannot be dragged in or out of it's current group. Only relevant while enableColumnMove is enabled. Defaults to false."
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
				name: 'SELMODEL',
				fieldLabel: 'Selection Model',
				maxLength: 50,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "A selection model instance or config object. In latter case the selType config option determines to which type of selection model this config is applied."
			            });
			        }
			    }
			},{
				name: 'SELTYPE',
				fieldLabel: 'Selection type',
				maxLength: 20,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "An xtype of selection model to use. Defaults to 'rowmodel'. This is used to create selection model if just a config object or nothing at all given in selModel config.\nDefaults to: 'rowmodel'"
			            });
			        }
			    }
			},{
				name: 'SHRINKWRAP',
				fieldLabel: 'Shrink wrap',
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "In CSS terms, shrink-wrap width is analogous to an inline-block element as opposed to a block-level element. Some container layouts always shrink-wrap their children, effectively ignoring this property.\nDefaults to 2.\n\n0: Neither width nor height depend on content. This is equivalent to false.\n1: Width depends on content (shrink wraps), but height does not.\n2: Height depends on content (shrink wraps), but width does not. The default.\n3: Both width and height depend on content (shrink wrap). This is equivalent to true."
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
				name: 'SHRINKWRAPDOCK',
				fieldLabel: 'Shrink wrap dock',
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "Allows for this panel to include the dockedItems when trying to determine the overall size of the panel. This option is only applicable when this panel is also shrink wrapping in the same dimensions. See Ext.AbstractComponent.shrinkWrap for an explanation of the configuration options.\nDefaults to false."
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
				name: 'SORTABLECOLUMNS',
				fieldLabel: 'Sortable columns',
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "False to disable column sorting via clicking the header and via the Sorting menu items.\nDefaults to true."
			            });
			        }
			    },
			    xtype: 'combobox',
				queryMode: 'local',
				store: 'query.yesno', 
				displayField: 'yesnoname',
				valueField: 'yesnocode',
				width: 300
			}]
		},{
			xtype: 'fieldset',
			columnWidth: 0.5,
			title: 'Data',
			collapsible: true,
			layout: 'anchor',
			defaults: {
				xtype: 'textfield',
				labelWidth: 150,
				padding: 5,
				width: 400
			},
			items: [{
				name: 'TPL',
				fieldLabel: 'Template',
				maxLength: 100,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "An Ext.Template, Ext.XTemplate or an array of strings to form an Ext.XTemplate. Used in conjunction with the data and tplWriteMode configurations."
			            });
			        }
			    }
			},{
				name: 'QRYDATA',
				fieldLabel: 'Data',
				xtype: 'textareafield',
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "The initial set of data to apply to the tpl to update the content area of the Component."
			            });
			        }
			    },
			    width: 750
			},{
				name: 'TPLWRITEMODE',
				fieldLabel: 'Template write mode',
				maxLength: 20,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "The Ext.(X)Template method to use when updating the content area of the Component. See Ext.XTemplate.overwrite for information on default mode.\nDefaults to: 'overwrite'"
			            });
			        }
			    }
			},{
				name: 'CONTENTEL',
				fieldLabel: 'Content Element',
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "Specify an existing HTML element, or the id of an existing HTML element to use as the content for this component.\n\nThis config option is used to take an existing HTML element and place it in the layout element of a new component (it simply moves the specified DOM element after the Component is rendered to use as the content.\n\nNotes:\nThe specified HTML element is appended to the layout element of the component after any configured HTML has been inserted, and so the document will not contain this element at the time the render event is fired.\nThe specified HTML element used will not participate in any layout scheme that the Component may use. It is just HTML. Layouts operate on child items.\n\nAdd either the x-hidden or the x-hide-display CSS class to prevent a brief flicker of the content before it is rendered to the panel."
			            });
			        }
			    }
			},{
				name: 'RENDERDATA',
				fieldLabel: 'Render data',
				xtype: 'textareafield',
				maxLength: 30,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "The data used by renderTpl in addition to the following property values of the component:\n\nid\nui\nuiCls\nbaseCls\ncomponentCls\nframe"
			            });
			        }
			    }
			},{
				name: 'SCROLLDELTA',
				fieldLabel: 'Scroll delta',
				xtype: 'numberfield',
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "Number of pixels to scroll when scrolling the locked section with mousewheel.\nDefaults to: 40"
			            });
			        }
			    }
			},{
				name: 'HTML',
				fieldLabel: 'Html',
				width: 750,
				xtype: 'textareafield',
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "An HTML fragment, or a DomHelper specification to use as the layout element content. The HTML content is added after the component is rendered, so the document will not contain this HTML at the time the render event is fired. This content is inserted into the body before any configured contentEl is appended."
			            });
			        }
			    }
			},{
				name: 'VERTICALSCROLLER',
				fieldLabel: 'Vertical scroller',
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "A config object to be used when configuring the scroll monitor to control refreshing of data in an \"infinite grid\".\nConfigurations of this object allow fine tuning of data caching which can improve performance and usability of the infinite grid."
			            });
			        }
			    }
			}]
		},{
			xtype: 'fieldset',
			columnWidth: 0.5,
			title: 'Tools and Toolbar',
			collapsible: true,
			layout: 'anchor',
			defaults: {
				xtype: 'textfield',
				labelWidth: 150,
				padding: 5,
				width: 400
			},
			items: [{
				name: 'TBAR',
				fieldLabel: 'Top bar',
				maxLength: 100,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "Convenience config. Short for 'Top Bar'.\n\ntbar: [\n { xtype: 'button', text: 'Button 1' }\n]\n\nis equivalent to\n\ndockedItems: [{\n xtype: 'toolbar',\n dock: 'top',\n items: [\n  { xtype: 'button', text: 'Button 1' }\n]\n}]"
			            });
			        }
			    }
			},{
				name: 'RBAR',
				fieldLabel: 'Right bar',
				maxLength: 100
				
			},{
				name: 'BBAR',
				fieldLabel: 'Bottom bar',
				maxLength: 100
			},{
				name: 'LBAR',
				fieldLabel: 'Left bar',
				maxLength: 100
			},{
				name: 'FBAR',
				fieldLabel: 'Footer bar',
				maxLength: 100
			},{
				name: 'TOOLS',
				fieldLabel: 'Tools',
				maxLength: 200,
				xtype: 'textareafield',
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "An array of Ext.panel.Tool configs/instances to be added to the header tool area. The tools are stored as child components of the header container. They can be accessed using down and {query}, as well as the other component methods. The toggle tool is automatically created if collapsible is set to true.\n\nNote that, apart from the toggle tool which is provided when a panel is collapsible, these tools only provide the visual button. Any required functionality must be provided by adding handlers that implement the necessary behavior."
			            });
			        }
			    }
			},{
				name: 'BUTTONS',
				fieldLabel: 'Buttons',
				maxLength: 100,
				xtype: 'textareafield',
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "Convenience config used for adding buttons docked to the bottom of the panel. This is a synonym for the fbar config."
			            });
			        }
			    }
			},{
				name: 'ICON',
				fieldLabel: 'Icon',
				maxLength: 100,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "Path to image for an icon in the header. Used for displaying an icon to the left of a title."
			            });
			        }
			    }
			}]
		},{
			xtype: 'fieldset',
			columnWidth: 0.5,
			title: 'Action',
			collapsible: true,
			layout: 'anchor',
			defaults: {
				xtype: 'textfield',
				labelWidth: 150,
				padding: 5,
				width: 400
			},
			items: [{
				name: 'ACTIVEITEM',
				fieldLabel: 'Active Item',
				maxLength: 30,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "A string component id or the numeric index of the component that should be initially activated within the container's layout on render. For example, activeItem: 'item-1' or activeItem: 0 (index 0 = the first item in the container's collection). activeItem only applies to layout styles that can display items one at a time (like Ext.layout.container.Card and Ext.layout.container.Fit)."
			            });
			        }
			    }
			},{
				name: 'CLOSEACTION',
				fieldLabel: 'Close action',
				maxLength: 7,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "The action to take when the close header tool is clicked:\n\n'destroy' : remove the window from the DOM and destroy it and all descendant Components. The window will not be available to be redisplayed via the show method.\n'hide' : hide the window by setting visibility to hidden and applying negative offsets. The window will be available to be redisplayed via the show method.\n\nNote: This behavior has changed! setting does affect the close method which will invoke the approriate closeAction.\n\nDefaults to 'destroy'"
			            });
			        }
			    }
			},{
				name: 'BUBBLEEVENTS',
				fieldLabel: 'Bubble events',
				maxLength: 50,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "An array of events that, when fired, should be bubbled to any parent container. See Ext.util.Observable.enableBubble."
			            });
			        }
			    }
			},{
				name: 'DEFERROWRENDER',
				fieldLabel: 'Defer row render',
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "Defaults to true to enable deferred row rendering.\n\nThis allows the View to execute a refresh quickly, with the expensive update of the row structure deferred so that layouts with GridPanels appear, and lay out more quickly."
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
				name: 'DETACHONREMOVE',
				fieldLabel: 'Detach on remove',
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "True to move any component to the detachedBody when the component is removed from this container. This option is only applicable when the component is not destroyed while being removed, see autoDestroy and remove. If this option is set to false, the DOM of the component will remain in the current place until it is explicitly moved.\n\nDefaults to true"
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
				name: 'FOCUSONTOFRONT',
				fieldLabel: 'Focus on to front',
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "Specifies whether the floated component should be automatically focused when it is brought to the front.\n\nDefaults to true"
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
				name: 'FORCEFIT',
				fieldLabel: 'Force fit',
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "True to force the columns to fit into the available width. Headers are first sized according to configuration, whether that be a specific width, or flex. Then they are all proportionally changed in width so that the entire content width is used. For more accurate control, it is more optimal to specify a flex setting on the columns that are to be stretched & explicit widths on columns that are not."
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
				name: 'FORMBIND',
				fieldLabel: 'Form bind',
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "When inside FormPanel, any component configured with formBind: true will be enabled/disabled depending on the validity state of the form. See Ext.form.Panel for more information and example.\n\nDefaults to false"
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
				name: 'LOADER',
				fieldLabel: 'Loader',
				maxLength: 100,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "A configuration object or an instance of a Ext.ComponentLoader to load remote content for this Component.\n\nloader: {\n url: 'content.html',\n autoLoad: true\n}"
			            });
			        }
			    }
			}]
		},{
			xtype: 'fieldset',
			columnWidth: 0.5,
			title: 'Classes',
			collapsible: true,
			layout: 'anchor',
			defaults: {
				xtype: 'textfield',
				labelWidth: 150,
				padding: 5,
				width: 400
			},
			items: [{
				name: 'BASECLS',
				fieldLabel: 'Base class',
				maxLength: 50,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "The base CSS class to apply to this panel's element. Defaults to: x-panel"
			            });
			        }
			    }
			},{
				name: 'CLS',
				fieldLabel: 'Class',
				maxLength: 50,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "An optional extra CSS class that will be added to this component's Element. This can be useful for adding customized styles to the component or any of its children using standard CSS rules. Defaults to: ''"
			            });
			        }
			    }
			},{
				name: 'BODYCLS',
				fieldLabel: 'Body class',
				maxLength: 50,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "A CSS class, space-delimited string of classes, or array of classes to be applied to the panel's body element. The following examples are all valid:\n\nbodyCls: 'foo'\nbodyCls: 'foo bar'\nbodyCls: ['foo', 'bar']"
			            });
			        }
			    }
			},{
				name: 'CHILDELS',
				fieldLabel: 'Child elements',
				maxLength: 80,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "An array describing the child elements of the Component. Each member of the array is an object with these properties:\n\nname - The property name on the Component for the child element.\nitemId - The id to combine with the Component's id that is the id of the child element.\nid - The id of the child element.\nIf the array member is a string, it is equivalent to { name: m, itemId: m }."
			            });
			        }
			    }
			},{
				name: 'COLLAPSEDCLS',
				fieldLabel: 'Collapsed class',
				maxLength: 50,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "A CSS class to add to the panel's element after it has been collapsed.\nDefaults to: 'collapsed'"
			            });
			        }
			    }
			},{
				name: 'COMPONENTCLS',
				fieldLabel: 'Component class',
				maxLength: 50,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "CSS Class to be added to a components root level element to give distinction to it via styling."
			            });
			        }
			    }
			},{
				name: 'DISABLEDCLS',
				fieldLabel: 'Disabled class',
				maxLength: 50,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "CSS class to add when the Component is disabled.\nDefaults to: 'x-item-disabled'"
			            });
			        }
			    }
			},{
				name: 'HEADEROVERCLS',
				fieldLabel: 'Header over class',
				maxLength: 50,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "Optional CSS class to apply to the header element on mouseover"
			            });
			        }
			    }
			},{
				name: 'ICONCLS',
				fieldLabel: 'Icon class',
				maxLength: 50,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "CSS class for an icon in the header. Used for displaying an icon to the left of a title."
			            });
			        }
			    }
			},{
				name: 'OVERCLS',
				fieldLabel: 'Over class',
				maxLength: 50,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "An optional extra CSS class that will be added to this component's Element when the mouse moves over the Element, and removed when the mouse moves out. This can be useful for adding customized 'active' or 'hover' styles to the component or any of its children using standard CSS rules.\nDefaults to: ''"
			            });
			        }
			    }
			},{
				name: 'GVIEWITEMCLS',
				fieldLabel: 'Item class',
				maxLength: 50,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "Specifies the class to be assigned to each element in the view when used in conjunction with the itemTpl configuration.\nDefaults to: Ext.baseCSSPrefix + 'dataview-item'"
			            });
			        }
			    }
			},{
				name: 'GVIEWFIRSTCLS',
				fieldLabel: 'First class',
				maxLength: 50,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "A CSS class to add to the first cell in every row to enable special styling for the first column. If no styling is needed on the first column, this may be configured as null.\nDefaults to: 'x-grid-cell-first'"
			            });
			        }
			    }
			},{
				name: 'GVIEWLASTCLS',
				fieldLabel: 'Last class',
				maxLength: 50,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "A CSS class to add to the last cell in every row to enable special styling for the last column. If no styling is needed on the last column, this may be configured as null.\nDefaults to: 'x-grid-cell-last'"
			            });
			        }
			    }
			},{
				name: 'GVIEWLOADINGCLS',
				fieldLabel: 'Loading class',
				maxLength: 50,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "The CSS class to apply to the loading message element. Defaults to Ext.LoadMask.prototype.msgCls \"x-mask-loading\"."
			            });
			        }
			    }
			},{
				name: 'GVIEWOVERITEMCLS',
				fieldLabel: 'Over item class',
				maxLength: 50,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "A CSS class to apply to each item in the view on mouseover. Setting this will automatically set trackOver to true.\nDefaults to: Ext.baseCSSPrefix + 'grid-row-over'"
			            });
			        }
			    }
			},{
				name: 'GVIEWSELECTEDITEMCLS',
				fieldLabel: 'Selected item class',
				maxLength: 50,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "A CSS class to apply to each selected item in the view.\nDefaults to: Ext.baseCSSPrefix + 'grid-row-selected'"
			            });
			        }
			    }
			},{
				name: 'LOCKEDGRIDCONFIG',
				fieldLabel: 'Locked grid config',
				maxLength: 50,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "Any special configuration options for the locked part of the grid"
			            });
			        }
			    }
			},{
				name: 'LOCKEDVIEWCONFIG',
				fieldLabel: 'Locked view config',
				maxLength: 50,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "A view configuration to be applied to the locked side of the grid. Any conflicting configurations between lockedViewConfig and viewConfig will be overwritten by the lockedViewConfig."
			            });
			        }
			    }
			},{
				name: 'NORMALGRIDCONFIG',
				fieldLabel: 'Normal grid config',
				maxLength: 50,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "Any special configuration options for the normal part of the grid"
			            });
			        }
			    }
			},{
				name: 'NORMALVIEWCONFIG',
				fieldLabel: 'Normal view config',
				maxLength: 50,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "A view configuration to be applied to the normal/unlocked side of the grid. Any conflicting configurations between normalViewConfig and viewConfig will be overwritten by the normalViewConfig."
			            });
			        }
			    }
			}]
		},{
			xtype: 'fieldset',
			columnWidth: 0.5,
			title: 'View',
			collapsible: true,
			layout: 'anchor',
			defaults: {
				xtype: 'textfield',
				labelWidth: 150,
				padding: 5,
				width: 400
			},
			items: [{
				name: 'QRYVIEW',
				fieldLabel: 'View',
				maxLength: 100,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "The Ext.view.Table used by the grid. Use viewConfig to just supply some config options to view (instead of creating an entire View instance)."
			            });
			        }
			    }
			},{
				name: 'VIEWCONFIG',
				fieldLabel: 'View config',
				maxLength: 100,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "A config object that will be applied to the grid's UI view. Any of the config options available for Ext.view.Table can be specified here. This option is ignored if view is specified."
			            });
			        }
			    }
			},{
				name: 'GVIEWBLOCKREFRESH',
				fieldLabel: 'Block Refresh',
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "Set this to true to ignore refresh events on the bound store. This is useful if you wish to provide custom transition animations via a plugin\nDefaults to: false"
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
				name: 'GVIEWDEFEREMPTYTEXT',
				fieldLabel: 'Defer empty text',
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "True to defer emptyText being applied until the store's first load.\nDefaults to: true"
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
				name: 'GVIEWDEFERINITIALREFRESH',
				fieldLabel: 'Defer initial refresh',
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "Defaults to true to defer the initial refresh of the view.\nThis allows the View to execute its render and initial layout more quickly because the process will not be encumbered by the expensive update of the view structure.\nImportant: Be aware that this will mean that the View's item elements will not be available immediately upon render, so selection may not take place at render time. To access a View's item elements as soon as possible, use the viewready event. Or set deferInitialrefresh to false, but this will be at the cost of slower rendering.\nDefaults to: true"
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
				name: 'GVIEWENABLETEXTSELECTION',
				fieldLabel: 'Enable text selection (True to enable text selections.)',
				xtype: 'combobox',
				queryMode: 'local',
				store: 'query.yesno', 
				displayField: 'yesnoname',
				valueField: 'yesnocode',
				width: 300
			},{
				name: 'GVIEWITEMTPL',
				fieldLabel: 'Item template',
				maxLength: 255,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "The inner portion of the item template to be rendered. Follows an XTemplate structure and will be placed inside of a tpl."
			            });
			        }
			    }
			},{
				name: 'GVIEWLOADMASK',
				fieldLabel: 'Load mask',
				maxLength: 50,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "False to disable a load mask from displaying while the view is loading. This can also be a Ext.LoadMask configuration object.\nDefaults to: true"
			            });
			        }
			    }
			},{
				name: 'GVIEWLOADINGHEIGHT',
				fieldLabel: 'Loading height',
				xtype: 'numberfield',
				maxValue: 999,
				width: 250,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "If specified, gives an explicit height for the data view when it is showing the loadingText, if that is specified. This is useful to prevent the view's height from collapsing to zero when the loading mask is applied and there are no other contents in the data view."
			            });
			        }
			    }
			},{
				name: 'GVIEWLOADINGTEXT',
				fieldLabel: 'Loading text',
				maxLength: 50,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "A string to display during data load operations. If specified, this text will be displayed in a loading div and the view's contents will be cleared while loading, otherwise the view's contents will continue to display normally until the new data is loaded and the contents are replaced.\nDefaults to: 'Loading...'"
			            });
			        }
			    }
			},{
				name: 'GVIEWMARKDIRTY',
				fieldLabel: 'Mark dirty',
				maxLength: 20,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "True to show the dirty cell indicator when a cell has been modified./nDefaults to: true"
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
				name: 'GVIEWMOUSEOVEROUTBUFFER',
				fieldLabel: 'Mouse over out buffer',
				xtype: 'numberfield',
				width: 250,
				maxValue: 9999,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "The number of milliseconds to buffer mouseover and mouseout event handling on view items.\nConfigure this as false to process mouseover and mouseout events immediately.\nDefaults to: 20"
			            });
			        }
			    }
			},{
				name: 'GVIEWPRESERVESCROLLONREFRESH',
				fieldLabel: 'Pre serve scroll on refresh',
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "True to preserve scroll position across refresh operations.\nDefaults to: false"
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
				name: 'GVIEWSTRIPEROWS',
				fieldLabel: 'Stripe rows',
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "True to stripe the rows.\n\nThis causes the CSS class x-grid-row-alt to be added to alternate rows of the grid. A default CSS rule is provided which sets a background color, but you can override this with a rule which either overrides the background-color style using the !important modifier, or which uses a CSS selector of higher specificity.\nDefaults to: true"
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
				name: 'GVIEWTRACKOVER',
				fieldLabel: 'Track over',
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "cfg docs inherited\n\nWhen true the overItemCls will be applied to rows when hovered over. This in return will also cause highlightitem and unhighlightitem events to be fired.\nEnabled automatically when the overItemCls config is set.\nDefaults to: true"
			            });
			        }
			    },
			    xtype: 'combobox',
				queryMode: 'local',
				store: 'query.yesno', 
				displayField: 'yesnoname',
				valueField: 'yesnocode',
				width: 300
			}]
		},{
			xtype: 'fieldset',
			columnWidth: 0.5,
			title: 'State',
			collapsible: true,
			layout: 'anchor',
			defaults: {
				xtype: 'textfield',
				labelWidth: 150,
				padding: 5,
				width: 400
			},
			items: [{
				name: 'STATEEVENTS',
				fieldLabel: 'State events',
				maxLength: 200,
				width: 500,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "An array of events that, when fired, should trigger this object to save its state. Defaults to none. stateEvents may be any type of event supported by this object, including browser or custom events (e.g., ['click', 'customerchange']).\nSee stateful for an explanation of saving and restoring object state."
			            });
			        }
			    }
			},{
				name: 'STATEID',
				fieldLabel: 'State id',
				maxLength: 50,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "The unique id for this object to use for state management purposes.\nSee stateful for an explanation of saving and restoring state."
			            });
			        }
			    }
			},{
				name: 'STATEFUL',
				fieldLabel: 'Stateful',
				maxLength: 50,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "A flag which causes the object to attempt to restore the state of internal properties from a saved state on startup. The object must have a stateId for state to be managed.\nAuto-generated ids are not guaranteed to be stable across page loads and cannot be relied upon to save and restore the same state for a object."
			            });
			        }
			    },
			    xtype: 'combobox',
				queryMode: 'local',
				store: 'query.yesno', 
				displayField: 'yesnoname',
				valueField: 'yesnocode',
				width: 300
			}]
		},{
			xtype: 'fieldset',
			columnWidth: 0.5,
			title: 'Miscellaneous',
			collapsible: true,
			layout: 'anchor',
			defaults: {
				xtype: 'textfield',
				labelWidth: 150,
				padding: 5,
				width: 400
			},
			items: [{
				name: 'LAYOUT',
				fieldLabel: 'Layout',
				maxLength: 50,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "Important: In order for child items to be correctly sized and positioned, typically a layout manager must be specified through the layout configuration option.\nThe sizing and positioning of child items is the responsibility of the Container's layout manager which creates and manages the type of layout you have in mind. For example:\nIf the layout configuration is not explicitly specified for a general purpose container (e.g. Container or Panel) the default layout manager will be used which does nothing but render child components sequentially into the Container (no sizing or positioning will be performed in this situation).\nlayout may be specified as either as an Object or as a String"
			            });
			        }
			    }
			},{
				name: 'QRYID',
				fieldLabel: 'Id',
				maxLength: 50,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "The unique id of this component instance.\n\nIt should not be necessary to use this configuration except for singleton objects in your application. Components created with an id may be accessed globally using Ext.getCmp.\nInstead of using assigned ids, use the itemId config, and ComponentQuery which provides selector-based searching for Sencha Components analogous to DOM querying. The Container class contains shortcut methods to query its descendant Components by selector.\nNote that this id will also be used as the element id for the containing HTML element that is rendered to the page for this component. This allows you to write id-based CSS rules to style the specific instance of this component uniquely, and also to select sub-elements using this component's id as the parent.\nNote: To avoid complications imposed by a unique id also see itemId.\nNote: To access the container of a Component see ownerCt.\nDefaults to an auto-assigned id."
			            });
			        }
			    }
			},{
				name: 'DEFAULTS',
				fieldLabel: 'Defaults',
				maxLength: 100,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "This option is a means of applying default settings to all added items whether added through the items config or via the add or insert methods.\n\nDefaults are applied to both config objects and instantiated components conditionally so as not to override existing properties in the item (see Ext.applyIf).\nIf the defaults option is specified as a function, then the function will be called using this Container as the scope (this reference) and passing the added item as the first parameter. Any resulting object from that call is then applied to the item as default properties.\nFor example, to automatically apply padding to the body of each of a set of contained Ext.panel.Panel items, you could pass: defaults: {bodyStyle:'padding:15px'}."
			            });
			        }
			    }
			},{
				name: 'DEFAULTTYPE',
				fieldLabel: 'Default type',
				maxLength: 20,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "The default xtype of child Components to create in this Container when a child item is specified as a raw configuration object, rather than as an instantiated Component.\nDefaults to: \"panel\""
			            });
			        }
			    }
			},{
				name: 'DEFAULTALIGN',
				fieldLabel: 'Default align',
				maxLength: 10,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "The default Ext.Element#getAlignToXY anchor position value for this menu relative to its element of origin. Used in conjunction with showBy.\n\nDefaults to: \"tl-bl?\""
			            });
			        }
			    }
			},{
				name: 'DEFAULTDOCKWEIGHTS',
				fieldLabel: 'Default dock weights',
				maxLength: 50,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "This object holds the default weights applied to dockedItems that have no weight. These start with a weight of 1, to allow negative weights to insert before top items and are odd numbers so that even weights can be used to get between different dock orders."
			            });
			        }
			    }
			},{
				name: 'RTL',
				fieldLabel: 'Right to left mode',
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "True to layout this component and its descendants in \"rtl\" (right-to-left) mode. Can be explicitly set to false to override a true value inherited from an ancestor."
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
				name: 'XTYPE',
				fieldLabel: 'Xtype',
				maxLength: 50,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "This property provides a shorter alternative to creating objects than using a full class name. Using xtype is the most common way to define component instances, especially in a container. For example, the items in a form containing text fields could be created explicitly like so:\n\nitems: [\nExt.create('Ext.form.field.Text', {\nfieldLabel: 'Foo'\n}),\nExt.create('Ext.form.field.Text', {\nfieldLabel: 'Bar'\n}),\nExt.create('Ext.form.field.Number', {\nfieldLabel: 'Num'\n})\n]\nBut by using xtype, the above becomes:\n\nitems: [\n{\nxtype: 'textfield',\nfieldLabel: 'Foo'\n},{\nxtype: 'textfield',\nfieldLabel: 'Bar'\n},\n{\nxtype: 'numberfield',\nfieldLabel: 'Num'\n}\n]\nWhen the xtype is common to many items, Ext.container.AbstractContainer.defaultType is another way to specify the xtype for all items that don't have an explicit xtype:\ndefaultType: 'textfield',\nitems: [\n{ fieldLabel: 'Foo' },\n{ fieldLabel: 'Bar' },\n{ fieldLabel: 'Num', xtype: 'numberfield' }]"
			            });
			        }
			    }
			},{
				name: 'COMPONENTLAYOUT',
				fieldLabel: 'Component layout',
				maxLength: 50,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "The sizing and positioning of a Component's internal Elements is the responsibility of the Component's layout manager which sizes a Component's internal structure in response to the Component being sized.\n\nGenerally, developers will not use this configuration as all provided Components which need their internal elements sizing (Such as input fields) come with their own componentLayout managers.\n\nThe default layout manager will be used on instances of the base Ext.Component class which simply sizes the Component's encapsulating element to the height and width specified in the setSize method.\nDefaults to: 'dock'"
			            });
			        }
			    }
			},{
				name: 'SUSPENDLAYOUT',
				fieldLabel: 'Suspend layout',
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "If true, suspend calls to doLayout. Useful when batching multiple adds to a container and not passing them as multiple arguments or an array.\nDefaults to: false"
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
				name: 'SUBGRIDXTYPE',
				fieldLabel: 'Sub-grid xtype',
				maxLength: 50,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "The xtype of the subgrid to specify. If this is not specified lockable will determine the subgrid xtype to create by the following rule. Use the superclasses xtype if the superclass is NOT tablepanel, otherwise use the xtype itself."
			            });
			        }
			    }
			},{
				name: 'RENDERSELECTORS',
				fieldLabel: 'Render selectors',
				maxLength: 100,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "An object containing properties specifying DomQuery selectors which identify child elements created by the render process.\n\nAfter the Component's internal structure is rendered according to the renderTpl, this object is iterated through, and the found Elements are added as properties to the Component using the renderSelector property name."
			            });
			        }
			    }
			},{
				name: 'RENDERTO',
				fieldLabel: 'Render to',
				maxLength: 30,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "Specify the id of the element, a DOM element or an existing Element that this component will be rendered into.\n\nNotes:\n\nDo not use this option if the Component is to be a child item of a Container. It is the responsibility of the Container's layout manager to render and manage its child items.\n\nWhen using this config, a call to render() is not required."
			            });
			        }
			    }
			},{
				name: 'LISTENERS',
				fieldLabel: 'Listeners',
				xtype: 'textareafield',
				width: 800,
				height: 200,
				listeners: {
			        afterrender: function(cmp) {
			            cmp.getEl().set({
			                "title": "A config object containing one or more event handlers to be added to this object during initialization. This should be a valid listeners config object as specified in the addListener example for attaching multiple handlers at once."
			            });
			        }
			    }
			},{
				name: 'GRIDEXTRA',
				xtype: 'textareafield',
				width: 800,
				height: 200,
				fieldLabel: 'Extra properties',
			}] 
		},{
			xtype: 'querydefinitionquerydetailschart'
		}];
		
		this.api = {
				load: Ext.qd.Form.Load,
				submit: Ext.qd.Form.Submit // The server-side must mark the submit handler as an 'ExtFormHandler'
		};
		
		this.paramOrder = ['querycode'];
		
		this.buttons = [{
			text: 'Save',
			action: 'save'
		},{
			text: 'Cancel',
			action: 'cancel'
		}];
		
		this.callParent(arguments);
	}
});