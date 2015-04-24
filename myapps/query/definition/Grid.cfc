/**
 * Preview
 *
 * @author LEONELL
 * @date 3/31/15
 **/
component accessors=true output=false persistent=false ExtDirect="true" {
	public struct function getGridDefinition(required string querycode) ExtDirect="true" {
		var ret = structNew();
		var controllerArr = ArrayNew(1);
		var modelArr = ArrayNew(1);
		var storeArr = ArrayNew(1);
		var viewArr = ArrayNew(1);
		var appArr = ArrayNew(1);
		querycode = querycode;
		querygrid = EntityLoad("EGRGQRYGRID",querycode,true);
		tablecolumnArr = OrmExecuteQuery("SELECT EVIEWFIELDCODE, TABLENAME, FIELDNAME, FIELDALIAS FROM EGRGEVIEWFIELDS WHERE EQRYCODEFK = '#querycode#'",false);

		setModel(querycode);
		setStore(querycode);
		setView(querycode);
		setController(querycode);
		setApp(querycode);

		ArrayAppend(modelArr, model);
		ArrayAppend(storeArr, store);
		ArrayAppend(viewArr, view);
		ArrayAppend(controllerArr,controller);
		ArrayAppend(appArr, app);



		ret["model"] = modelArr;
		ret["store"] = storeArr;
		ret["view"] = viewArr;
		ret["controller"] = controllerArr;
		ret["app"] = appArr;
		return ret;
	}

	private void function setModel(required string querycode) {

		// query egrgeviewfields => tablename, fieldname
		// query egrgqrycolumn => outputtype

		var fieldArray = ArrayNew(1);

		for(a=1; a<=ArrayLen(tablecolumnArr); a++) {
			nametypeStruct = StructNew();
			var type = OrmExecuteQuery("SELECT OUTPUTTYPE FROM EGRGQRYCOLUMN WHERE EVIEWFIELDCODE = '#tablecolumnArr[a][1]#'",true);
			if(Isdefined("type")) {
				if(trim(type) eq "") {
					type = "string";
				}
			} else {
				type = "string";
			}
			nametypeStruct["name"] = trim(tablecolumnArr[a][2]) & trim(tablecolumnArr[a][3]);
			nametypeStruct["type"] = type;
			ArrayAppend(fieldArray, nametypeStruct);
		}
		dstring = Serializejson(fieldArray);

		//save content
		savecontent variable="model" {
			writeoutput("Ext.define('Myquery.QueryModel', {
							extend: 'Ext.data.Model',
							fields: #dstring#
						});");
		}
		model = rereplace(model,"[\t\n\f\r]","","all");
	}

	private void function setStore(required string querycode) {
		var timeout = querygrid.getSTORETIMEOUT();
		if(Isdefined("timeout")) {
			if(trim(timeout) eq "") timeout = 300000;
		} else {
			timeout = 300000;
		}

		var pagesize = querygrid.getSTOREPAGESIZE();
		if(Isdefined("pagesize")) {
			if(trim(pagesize) eq "") pagesize = 25;
		} else {
			pagesize = 25;
		}

		var sorters = querygrid.getSTORESORTERS();
		if(Isdefined("sorters")) {
			if(trim(sorters) eq "") {
				//get the first column by default
				var sortersArray = ArrayNew(1);
				for(a=1; a<=1; a++) {
					nametypeStruct = StructNew();
					nametypeStruct["property"] = trim(tablecolumnArr[a][2]) & trim(tablecolumnArr[a][3]);
					nametypeStruct["direction"] = "ASC";
					ArrayAppend(sortersArray, nametypeStruct);
				}
				sorters = Serializejson(sortersArray);
			} else {
				// detect string from array
				sorters = trim(sorters);
				if(left(sorters,1) neq "[" && right(sorters,1) neq "]") {
					sorters = "[{ property: '#sorters#', direction: 'ASC'}]";
				}
			}
		} else {
			//get the first column by default
			var sortersArray = ArrayNew(1);
			for(a=1; a<=1; a++) {
				nametypeStruct = StructNew();
				nametypeStruct["property"] = trim(tablecolumnArr[a][2]) & trim(tablecolumnArr[a][3]);
				nametypeStruct["direction"] = "ASC";
				ArrayAppend(sortersArray, nametypeStruct);
			}
			sorters = Serializejson(sortersArray);
		}

		var filters = querygrid.getSTOREFILTERS();
		if(Isdefined("filters")) {
			if(trim(filters) eq "") {
				//get the first column by default
				var filtersArray = ArrayNew(1);
				for(a=1; a<=1; a++) {
					nametypeStruct = StructNew();
					nametypeStruct["dataIndex"] = trim(tablecolumnArr[a][2]) & trim(tablecolumnArr[a][3]);
					var type = OrmExecuteQuery("SELECT OUTPUTTYPE FROM EGRGQRYCOLUMN WHERE EVIEWFIELDCODE = '#tablecolumnArr[a][1]#'",true);
					if(Isdefined("type")) {
						if(trim(type) eq "") {
							type = "string";
						}
					} else {
						type = "string";
					}
					nametypeStruct["type"] = type;
					ArrayAppend(filtersArray, nametypeStruct);
				}
				filters = Serializejson(filtersArray);
			} else {
				// detect string from array
				filters = trim(filters);
				if(left(filters,1) neq "[" && right(filters,1) neq "]") {
					filters = "[{ dataIndex: '#filters#', type: 'string'}]";
				}
			}
		} else {
			//get the first column by default
			var filtersArray = ArrayNew(1);
			for(a=1; a<=1; a++) {
				nametypeStruct = StructNew();
				nametypeStruct["dataIndex"] = trim(tablecolumnArr[a][2]) & trim(tablecolumnArr[a][3]);
				var type = OrmExecuteQuery("SELECT OUTPUTTYPE FROM EGRGQRYCOLUMN WHERE EVIEWFIELDCODE = '#tablecolumnArr[a][1]#'",true);
					if(Isdefined("type")) {
						if(trim(type) eq "") {
							type = "string";
						}
					} else {
						type = "string";
					}
					nametypeStruct["type"] = type;
				ArrayAppend(filtersArray, nametypeStruct);
			}
			filters = Serializejson(filtersArray);
		}

		var storeextra = querygrid.getSTOREEXTRA();
		if(Isdefined("storeextra")) {
			if(trim(storeextra) eq "") storeextra = "";
		} else {
			storeextra = "";
		}

		var storeproxyextra = querygrid.getSTOREPROXYEXTRA();
		if(Isdefined("storeproxyextra")) {
			if(trim(storeproxyextra) eq "") storeproxyextra = "";
		} else {
			storeproxyextra = "";
		}

		savecontent variable="store" {
			writeoutput("Ext.define('Myquery.QueryStore', {
							extend: 'Ext.data.Store',
							model: 'Myquery.QueryModel',
							remoteFilter: true,
							remoteSort: true,
							simpleSortMode: true,
							autoSave: true,
							autoLoad: true,
							autoSync: true,
							sorters: #sorters#,
							filters: #filters#,
							pageSize: #pagesize#,
							#storeextra#
							#storeproxyextra#
							constructor : function(config) {
								Ext.applyIf(config, {
									proxy  : {
								        type: 'direct',
										timeout: #timeout#,
								        extraParams: {
								        	querycode: '#querycode#',
											extraparams: []
										},
										paramOrder: ['page', 'start', 'limit', 'sort', 'filter', 'querycode', 'extraparams'],
										api: {
											create:  Ext.qd.OutputProcess.Create,
									        read:    Ext.qd.OutputProcess.Read,
									        update:  Ext.qd.OutputProcess.Update,
									        destroy: Ext.qd.OutputProcess.Destroy
									    },
									    paramsAsHash: false,
										filterParam: 'filter',
										sortParam: 'sort',
										limitParam: 'limit',
										idParam: 'ID',
										pageParam: 'page',
										reader: {
								            root: 'topics',
								            totalProperty: 'totalCount'
								        }
								    }
								});
								this.callParent([config]);
							}
						 });");
		}
		store = rereplace(store,"[\t\f\r]","","all");
	}

	private void function setView(required string querycode) {
		columnStringItems = "";
		for(a=1; a<=ArrayLen(tablecolumnArr); a++) {

			if(trim(tablecolumnArr[a][4]) eq "") {
				columnStringItems = columnStringItems & "{text: '#trim(tablecolumnArr[a][2])##trim(tablecolumnArr[a][3])#',";
			} else {
				columnStringItems = columnStringItems & "{text: '#tablecolumnArr[a][4]#',";
			}

			columndef = EntityLoad("EGRGQRYCOLUMN",tablecolumnArr[a][1],true);
			columnStringItems = columnStringItems & "dataIndex: '#trim(tablecolumnArr[a][2])##trim(tablecolumnArr[a][3])#',";

			if(isdefined("columndef")) {
				// column extra properties
				numberOrStringColumn("activeItem","COLUMNACTIVEITEM","columndef");
				stringColumn("align","COLUMNALIGN","columndef");
				stringColumn("altText","CACTIONALTTEXT","columndef");
				numberColumn("flex","COLUMNANCHORSIZE","columndef");
				numberColumn("autoDestroy","COLUMNAUTODESTROY","columndef");
				stringOrObjectOrFunction("autoRender","COLUMNAUTORENDER","columndef");
				numberColumn("autoScroll","COLUMNAUTOSCROLL","columndef");
				numberColumn("autoShow","COLUMNAUTOSHOW","columndef");
				stringColumn("baseCls","COLUMNBASECLS","columndef");
				numberOrStringColumn("border","COLUMNBORDER","columndef");
				stringOrObjectOrFunction("bubbleEvents","COLUMNBUBBLEEVENTS","columndef");
				numberColumn("childEls","COLUMNCHILDELS","columndef");
				stringColumn("cls","COLUMNCLS","columndef");
				numberOrStringColumn("width","COLUMNWIDTH","columndef");
				numberColumn("columns","COLUMNCOLUMNS","columndef");
				stringColumn("componentCls","COLUMNCOMPONENTCLS","columndef");
				numberColumn("constrain","COLUMNCONSTRAIN","columndef");
				stringOrObjectOrFunction("constrainTo","COLUMNCONSTRAINTO","columndef");
				stringOrObjectOrFunction("constraintInsets","COLUMNCONSTRAINTINSETS","columndef");
				stringColumn("contentEl","COLUMNCONTENTEL","columndef");
				numberColumn("data","COLUMNDATA","columndef");
				stringColumn("dataIndex","COLUMNDATAINDEX","columndef");
				stringColumn("defaultAlign","COLUMNDEFAULTALIGN","columndef");
				stringColumn("defaultType","COLUMNDEFAULTTYPE","columndef");
				numberColumn("defaultWidth","COLUMNDEFAULTWIDTH","columndef");
				numberColumn("defaults","COLUMNDEFAULTS","columndef");
				numberColumn("detachOnRemove","COLUMNDETACHONREMOVE","columndef");
				numberColumn("disabled","COLUMNDISABLED","columndef");
				stringColumn("disabledCls","COLUMNDISABLEDCLS","columndef");

				numberColumn("height","COLUMNHEIGHT","columndef");
				numberColumn("hidden","COLUMNHIDDEN","columndef");
				numberColumn("draggable","COLUMNDRAGGABLE","columndef");
				numberColumn("sortable","COLUMNSORTABLE","columndef");
				numberColumn("lockable","COLUMNLOCKABLE","columndef");
				numberColumn("hideable","COLUMNHIDEABLE","columndef");
				numberColumn("resizable","COLUMNRESIZABLE","columndef");
				stringOrObjectOrFunction("editor","COLUMNEDITOR","columndef");
				stringColumn("emptyCellText","COLUMNEMPTYCELLTEXT","columndef");
				stringColumn("hideMode","COLUMNHIDEMODE","columndef");
				stringOrObjectOrFunction("html","COLUMNHTML","columndef");
				stringColumn("icon","COLUMNICON","columndef");
				numberColumn("locked","COLUMNLOCKED","columndef");
				numberOrStringColumn("margin","COLUMNMARGIN","columndef");
				numberColumn("maxHeight","COLUMNMAXHEIGHT","columndef");
				numberColumn("maxWidth","COLUMNMAXWIDTH","columndef");
				stringColumn("menuText","COLUMNMENUTEXT","columndef");
				numberColumn("menuDisabled","CACTIONMENUDISABLED","columndef");
				numberColumn("minHeight","COLUMNMINHEIGHT","columndef");
				numberColumn("minWidth","COLUMNMINWIDTH","columndef");
				numberOrStringColumn("padding","COLUMNPADDING","columndef");
				stringColumn("resizeHandles","COLUMNRESIZEHANDLES","columndef");
				numberColumn("sealed","COLUMNSEALED","columndef");
				stringOrObjectOrFunction("shadow","COLUMNSHADOW","columndef");
				numberColumn("shadowOffset","COLUMNSHADOWOFFSET","columndef");
				numberColumn("shrinkWrap","COLUMNSHRINKWRAP","columndef");
				stringColumn("tooltip","COLUMNTOOLTIP","columndef");
				stringColumn("tooltipType","COLUMNTOOLTIPTYPE","columndef");
				stringOrObjectOrFunction("editRenderer","COLUMNEDITRENDERER","columndef");
				numberColumn("enableColumnHide","COLUMNENABLECOLUMNHIDE","columndef");
				numberColumn("floating","COLUMNFLOATING","columndef");
				numberColumn("focusOnToFront","COLUMNFOCUSONTOFRONT","columndef");
				numberColumn("formBind","COLUMNFORMBIND","columndef");
				numberColumn("frame","COLUMNFRAME","columndef");
				numberColumn("groupable","COLUMNGROUPABLE","columndef");
				stringOrObjectOrFunction("handler","COLUMNHANDLER","columndef");
				stringColumn("iconCls","COLUMNICONCLS","columndef");
				stringColumn("id","COLUMNID","columndef");
				stringColumn("itemId","COLUMNITEMID","columndef");
				numberColumn("items","COLUMNITEMS","columndef");
				stringOrObjectOrFunction("layout","COLUMNLAYOUT","columndef");
				numberColumn("listeners","COLUMNLISTENERS","columndef");
				numberColumn("loader","COLUMNLOADER","columndef");
				stringColumn("overflowX","COLUMNOVERFLOWX","columndef");
				stringColumn("overCls","COLUMNOVERCLS","columndef");
				stringColumn("overflowY","COLUMNOVERFLOWY","columndef");
				stringOrObjectOrFunction("plugins","COLUMNPLUGINS","columndef");
				stringColumn("region","COLUMNREGION","columndef");
				numberColumn("renderData","COLUMNRENDERDATA","columndef");
				numberColumn("renderSelectors","COLUMNRENDERSELECTORS","columndef");
				stringOrObjectOrFunction("renderTo","COLUMNRENDERTO","columndef");
				stringOrObjectOrFunction("renderer","COLUMNRENDERER","columndef");
				numberColumn("rtl","COLUMNRTL","columndef");
				numberColumn("saveDelay","COLUMNSAVEDELAY","columndef");
				numberColumn("scope","CACTIONSCOPE","columndef");
				stringOrObjectOrFunction("stateEvents","COLUMNSTATEEVENTS","columndef");
				stringColumn("stateId","COLUMNSTATEID","columndef");
				numberColumn("stateful","COLUMNSTATEFUL","columndef");
				numberColumn("stopSelection","CACTIONSTOPSELECTION","columndef");
				stringOrObjectOrFunction("style","COLUMNSTYLE","columndef");
				numberColumn("suspendLayout","COLUMNSUSPENDLAYOUT","columndef");
				stringColumn("tdCls","COLUMNTDCLS","columndef");
				numberColumn("toFrontOnShow","COLUMNTOFRONTONSHOW","columndef");
				stringOrObjectOrFunction("tpl","COLUMNTPL","columndef");
				stringColumn("tplWriteMode","COLUMNTPLWRITEMODE","columndef");
				stringColumn("ui","COLUMNUI","columndef");
				stringColumn("undefinedText","CBOOLEANUNDEFINEDTEXT","columndef");
				numberColumn("weight","COLUMNWEIGHT","columndef");
				stringOrObjectOrFunction("xtype","COLUMNXTYPE","columndef");
				stringOrObjectOrFunction("columnextra","COLUMNEXTRA","columndef");

				columnStringItems = columnStringItems & " #toFrontOnShow#
					#tpl# #tplWriteMode# #ui# #undefinedText# #weight# #xtype#
					#columnextra# #renderTo# #renderer# #rtl# #saveDelay# #scope# #stateEvents# #stateId# #stateful#
					#stopSelection# #style# #suspendLayout# #tdCls# #layout# #listeners#
					#overCls# #loader# #overflowX# #overflowY# #plugins# #region# #renderData#
					#renderSelectors# #floating# #focusOnToFront# #formBind# #frame# #groupable# #handler# #iconCls# #id#
					#itemId# #items# #menuDisabled# #minHeight# #minWidth# #padding# #resizeHandles#
					#sealed# #shadow# #shadowOffset# #shrinkWrap# #toolTip# #tooltipType# #editRenderer#
					#enableColumnHide# #lockable# #hideable# #resizable# #editor# #emptyCellText# #hideMode# #html#
					#icon# #locked# #margin# #maxHeight# #maxWidth# #menuText# #activeItem# #align#
					#altText# #flex# #autoDestroy# #autoRender# #autoScroll# #autoShow# #baseCls#
					#border# #bubbleEvents# #childEls# #cls# #width# #columns# #componentCls# #constrain# #constrainTo# #constraintInsets#
					#contentEl# #data# #dataIndex# #defaultAlign# #defaultType# #defaultWidth#
					#detachOnRemove# #disabled# #disabledCls# #height# #hidden# #draggable# #sortable#}";
				if (a != ArrayLen(tablecolumnArr)) columnStringItems = columnStringItems & ",";
			} else {
				columnStringItems = columnStringItems & "'}";
			}

		}

		stringColumn("title","QRYTITLE","querygrid");
		stringColumn("titleAlign","TITLEALIGN","querygrid");
		numberOrStringColumn("activeItem","ACTIVEITEM","querygrid");
		numberColumn("allowDeselect","ALLOWDESELECT","querygrid");
		numberColumn("anchorSize","ANCHORSIZE","querygrid");
		numberOrStringColumn("columnWidth","COLUMNWIDTH","querygrid");
		numberColumn("width","WIDTH","querygrid");
		numberColumn("height","HEIGHT","querygrid");
		numberColumn("maxHeight","MAXHEIGHT","querygrid");
		numberColumn("maxWidth","MAXWIDTH","querygrid");
		numberColumn("minHeight","MINHEIGHT","querygrid");
		numberColumn("minWidth","MINWIDTH","querygrid");
		numberColumn("minButtonWidth","MINBUTTONWIDTH","querygrid");
		numberOrStringColumn("margin","MARGIN","querygrid");
		numberOrStringColumn("padding","PADDING","querygrid");
		numberOrStringColumn("border","BORDER","querygrid");
		numberColumn("bodyBorder","BODYBORDER","querygrid");
		numberOrStringColumn("bodyPadding","BODYPADDING","querygrid");
		stringOrObjectOrFunction("bodyStyle","BODYSTYLE","querygrid");
		stringOrObjectOrFunction("shadow","SHADOW","querygrid");
		numberColumn("shadowOffset","SHADOWOFFSET","querygrid");
		stringOrObjectOrFunction("style","STYLE","querygrid");
		stringColumn("ui","QRYUI","querygrid");
		numberColumn("autoScroll","AUTOSCROLL","querygrid");
		numberColumn("autoDestroy","AUTODESTROY","querygrid");
		stringOrObjectOrFunction("autoRender","AUTORENDER","querygrid");
		numberColumn("autoShow","AUTOSHOW","querygrid");
		numberColumn("closable","CLOSABLE","querygrid");
		numberColumn("collapsible","COLLAPSIBLE","querygrid");
		stringOrObjectOrFunction("draggable","DRAGGABLE","querygrid");
		stringOrObjectOrFunction("resizable","RESIZABLE","querygrid");
		numberColumn("floatable","FLOATABLE","querygrid");
		numberColumn("toFrontOnShow","TOFRONTONSHOW","querygrid");
		stringOrObjectOrFunction("placeholder","PLACEHOLDER","querygrid");
		numberColumn("saveDelay","SAVEDELAY","querygrid");
		numberColumn("collapseFirst","COLLAPSEDFIRST","querygrid");
		numberColumn("collapsed","COLLAPSED","querygrid");
		numberColumn("disabled","DISABLED","querygrid");
		numberColumn("animCollapse","ANIMCOLLAPSE","querygrid");
		stringColumn("collapseDirection","COLLAPSEDIRECTION","querygrid");
		stringColumn("collapseMode","COLLAPSEMODE","querygrid");
		numberColumn("disableSelection","DISABLESELECTION","querygrid");
		numberColumn("fixed","FIXED","querygrid");
		numberColumn("floating","FLOATING","querygrid");
		stringColumn("resizeHandles","RESIZEHANDLES","querygrid");
		numberColumn("titleCollapse","TITLECOLLAPSE","querygrid");
		numberColumn("hidden","HIDDEN","querygrid");
		numberColumn("hideCollapseTool","HIDECOLLAPSETOOL","querygrid");
		numberColumn("hideHeaders","HIDEHEADER","querygrid");
		stringColumn("hideMode","HIDEMODE","querygrid");
		numberColumn("rowLines","ROWLINES","querygrid");
		numberColumn("simpleDrag","SIMPLEDRAG","querygrid");
		numberColumn("enableColumnHide","ENABLECOLUMNHIDE","querygrid");
		numberColumn("enableColumnMove","ENABLECOLUMNMOVE","querygrid");
		numberColumn("enableColumnResize","ENABLECOLUMNRESIZE","querygrid");
		numberColumn("enableLocking","ENABLELOCKING","querygrid");
		numberColumn("placeholderCollapseHideMode","PLACEHOLDERCOLLAPSEHIDEMODE","querygrid");
		numberColumn("overlapHeader","OVERLAPHEADER","querygrid");
		numberColumn("manageHeight","MANAGEHEIGHT","querygrid");
		numberColumn("syncRowHeight","SYNCROWHEIGHT","querygrid");
		stringColumn("buttonAlign","BUTTONALIGN","querygrid");
		stringColumn("headerPosition","HEADERPOSITION","querygrid");
		stringColumn("region","REGION","querygrid");
		stringOrObjectOrFunction("scroll","SCROLL","querygrid");
		stringColumn("overflowX","OVERFLOWX","querygrid");
		stringColumn("overflowY","OVERFLOWY","querygrid");
		stringColumn("emptyText","EMPTYTEXT","querygrid");
		numberColumn("columnLines","COLUMNLINES","querygrid");
		numberColumn("constrain","QRYCONSTRAIN","querygrid");
		numberColumn("constrainHeader","CONSTRAINHEADER","querygrid");
		stringOrObjectOrFunction("constrainTo","QRYCONSTRAINTO","querygrid");
		stringOrObjectOrFunction("constraintInsets","CONSTRAINTINSETS","querygrid");
		numberColumn("frame","FRAME","querygrid");
		numberColumn("frameHeader","FRAMEHEADER","querygrid");
		numberOrStringColumn("glyph","GLYPH","querygrid");
		stringOrObjectOrFunction("header","HEADER","querygrid");
		stringOrObjectOrFunction("items","ITEMS","querygrid");
		stringOrObjectOrFunction("dockedItems","DOCKEDITEMS","querygrid");
		stringColumn("itemId","ITEMID","querygrid");
		numberColumn("sealedColumns","SEALEDCOLUMNS","querygrid");
		stringOrObjectOrFunction("selModel","SELMODEL","querygrid");
		stringColumn("selType","SELTYPE","querygrid");
		numberColumn("shrinkWrap","SHRINKWRAP","querygrid");
		numberColumn("shrinkWrapDock","SHRINKWRAPDOCK","querygrid");
		numberColumn("sortableColumns","SORTABLECOLUMNS","querygrid");
		stringOrObjectOrFunction("tpl","TPL","querygrid");
		numberColumn("data","QRYDATA","querygrid");
		stringColumn("tplWriteMode","TPLWRITEMODE","querygrid");
		stringColumn("contentEl","CONTENTEL","querygrid");
		numberColumn("renderData","RENDERDATA","querygrid");
		numberColumn("scrollDelta","SCROLLDELTA","querygrid");
		stringOrObjectOrFunction("html","HTML","querygrid");
		numberColumn("verticalScroller","VERTICALSCROLLER","querygrid");
		numberColumn("tbar","TBAR","querygrid");
		numberColumn("rbar","RBAR","querygrid");
		numberColumn("bbar","BBAR","querygrid");
		numberColumn("lbar","LBAR","querygrid");
		numberColumn("fbar","FBAR","querygrid");
		numberColumn("tools","TOOLS","querygrid");
		numberColumn("buttons","BUTTONS","querygrid");
		stringColumn("icon","ICON","querygrid");
		stringColumn("closeAction","CLOSEACTION","querygrid");
		stringOrObjectOrFunction("bubbleEvents","BUBBLEEVENTS","querygrid");
		numberColumn("deferRowRender","DEFERROWRENDER","querygrid");
		numberColumn("detachOnRemove","DETACHONREMOVE","querygrid");
		numberColumn("focusOnToFront","FOCUSONTOFRONT","querygrid");
		numberColumn("forceFit","FORCEFIT","querygrid");
		numberColumn("formBind","FORMBIND","querygrid");
		numberColumn("loader","LOADER","querygrid");
		stringColumn("baseCls","BASECLS","querygrid");
		stringColumn("cls","CLS","querygrid");
		stringOrObjectOrFunction("bodyCls","BODYCLS","querygrid");
		numberColumn("childEls","CHILDELS","querygrid");
		stringColumn("collapsedCls","COLLAPSEDCLS","querygrid");
		stringColumn("componentCls","COMPONENTCLS","querygrid");
		stringColumn("disabledCls","DISABLEDCLS","querygrid");
		stringColumn("headerOverCls","HEADEROVERCLS","querygrid");
		stringColumn("iconCls","ICONCLS","querygrid");
		stringColumn("overCls","OVERCLS","querygrid");
		stringColumn("firstCls","GVIEWFIRSTCLS","querygrid");
		stringColumn("lastCls","GVIEWLASTCLS","querygrid");
		stringColumn("loadingCls","GVIEWLOADINGCLS","querygrid");
		stringColumn("overItemCls","GVIEWOVERITEMCLS","querygrid");
		stringColumn("selectedItemCls","GVIEWSELECTEDITEMCLS","querygrid");
		numberColumn("lockedGridConfig","LOCKEDGRIDCONFIG","querygrid");
		numberColumn("lockedViewConfig","LOCKEDVIEWCONFIG","querygrid");
		numberColumn("normalGridConfig","NORMALGRIDCONFIG","querygrid");
		numberColumn("normalViewConfig","NORMALVIEWCONFIG","querygrid");
		numberColumn("view","QRYVIEW","querygrid");
		numberColumn("viewConfig","VIEWCONFIG","querygrid");
		numberColumn("blockRefresh","GVIEWBLOCKREFRESH","querygrid");
		numberColumn("deferEmptyText","GVIEWDEFEREMPTYTEXT","querygrid");
		numberColumn("deferInitialRefresh","GVIEWDEFERINITIALREFRESH","querygrid");
		numberColumn("enableTextSelection","GVIEWENABLETEXTSELECTION","querygrid");
		stringOrObjectOrFunction("itemTpl","GVIEWITEMTPL","querygrid");
		numberColumn("loadMask","GVIEWLOADMASK","querygrid");
		numberColumn("loadingHeight","GVIEWLOADINGHEIGHT","querygrid");
		stringColumn("loadingText","GVIEWLOADINGTEXT","querygrid");
		numberColumn("markDirty","GVIEWMARKDIRTY","querygrid");
		numberColumn("mouseOverOutBuffer","GVIEWMOUSEOVEROUTBUFFER","querygrid");
		numberColumn("preserveScrollOnRefresh","GVIEWPRESERVESCROLLONREFRESH","querygrid");
		numberColumn("stripeRows","GVIEWSTRIPEROWS","querygrid");
		numberColumn("trackOver","GVIEWTRACKOVER","querygrid");
		stringOrObjectOrFunction("stateEvents","STATEEVENTS","querygrid");
		stringColumn("stateId","STATEID","querygrid");
		numberColumn("stateful","STATEFUL","querygrid");
		stringOrObjectOrFunction("layout","STATEEVENTS","querygrid");
		stringColumn("id","QRYID","querygrid");
		numberColumn("defaults","DEFAULTS","querygrid");
		stringColumn("defaultType","DEFAULTTYPE","querygrid");
		stringColumn("defaultAlign","DEFAULTALIGN","querygrid");
		numberColumn("defaultDockWeights","DEFAULTDOCKWEIGHTS","querygrid");
		numberColumn("rtl","RTL","querygrid");
		stringOrObjectOrFunction("xtype","XTYPE","querygrid");
		stringOrObjectOrFunction("componentLayout","COMPONENTLAYOUT","querygrid");
		numberColumn("suspendLayout","SUSPENDLAYOUT","querygrid");
		stringColumn("subGridXType","SUBGRIDXTYPE","querygrid");
		numberColumn("renderSelectors","RENDERSELECTORS","querygrid");
		stringOrObjectOrFunction("renderTo","RENDERTO","querygrid");
		numberColumn("listeners","LISTENERS","querygrid");

		savecontent variable="view" {
			writeoutput("Ext.define('Myquery.QueryView', {
			extend: 'Ext.grid.Panel',
			alias: 'widget.queryview',
			multiSelect: true,
			#title#	#titleAlign# #activeItem# #allowDeselect# #columnWidth# #width# #height# #maxHeight# #maxWidth# #minHeight#
			#minWidth# #minButtonWidth# #margin# #padding# #border# #bodyBorder# #bodyPadding# #bodyStyle#
			#shadow# #shadowOffset# #style# #ui# #autoScroll# #autoDestroy# #autoRender# #autoShow# #closable#
			#collapsible# #draggable# #resizable# #floatable# #toFrontOnShow# #placeholder# #saveDelay#
			#collapseFirst# #collapsed# #disabled# #animCollapse# #collapseDirection# #collapseMode#
			#disableSelection# #fixed# #floating# #resizeHandles# #titleCollapse# #hidden#
			#hideCollapseTool# #hideHeaders# #hideMode# #rowLines# #simpleDrag# #enableColumnHide#
			#enableColumnMove# #enableColumnResize# #enableLocking# #placeholderCollapseHideMode# #overlapHeader#
			#manageHeight# #syncRowHeight# #buttonAlign# #headerPosition# #region# #scroll# #overflowX# #overflowY#
			#emptyText# #columnLines# #constrain# #constrainHeader# #dockedItems#
			#constrainTo# #constraintInsets# #frame# #frameHeader# #glyph# #header# #items#
			#itemId# #sealedColumns# #selModel# #selType# #shrinkWrap# #shrinkWrapDock# #sortableColumns# #tpl#
			#data# #tplWriteMode# #contentEl# #renderData# #scrollDelta# #html# #verticalScroller#
			#tbar# #rbar# #bbar# #lbar# #fbar# #tools# #buttons# #icon# #closeAction# #bubbleEvents# #deferRowRender#
			#detachOnRemove# #focusOnToFront# #forceFit# #formBind# #loader# #baseCls# #cls# #bodyCls# #childEls#
			#collapsedCls# #componentCls# #disabledCls# #headerOverCls# #iconCls# #overCls#
			#firstCls# #lastCls# #loadingCls# #overItemCls# #selectedItemCls# #lockedGridConfig# #lockedViewConfig#
			#normalGridConfig# #normalViewConfig# #view# #viewConfig# #blockRefresh# #deferEmptyText# #deferInitialRefresh#
			#enableTextSelection# #itemTpl# #loadMask# #loadingHeight# #loadingText# #markDirty# #mouseOverOutBuffer#
			#preserveScrollOnRefresh# #stripeRows# #trackOver# #stateEvents# #stateId# #stateful# #layout# #id# #defaults#
			#defaultType# #defaultAlign# #defaultDockWeights# #rtl# #xtype# #componentLayout# #suspendLayout# #subGridXType#
			#renderSelectors# #renderTo# #listeners# #querygrid.getGRIDEXTRA()#

		    flex: 1,
		    width    : '100%',
		    store    : 'Myquery.QueryStore',
		    columns  : [#columnStringItems#],
		    initComponent: function() {
		    	this.tbar = [{
		    		text: 'Share'
		    	},{
		    		text: 'Print'
		    	},{
		    		text: 'Export to excel'
		    	},{
		    		text: 'Add data'
		    	},{
		    		text: 'Remove selection'
		    	},{
		    		text: 'Email'
		    	}];
		    	this.fbar = Ext.create('Ext.toolbar.Paging', {
				        store: 'Myquery.QueryStore',
				        displayInfo: true,
				        emptyMsg: 'No query to display'
				});
				this.callParent(arguments);
		    }
		});");
		}
		view = rereplace(view,"[\t\n\f\r]","","all");
	}

	private void function setController(required string querycode) {
		savecontent variable="controller" {
			writeoutput("Ext.define('Myquery.QueryController', {
    						extend: 'Ext.app.Controller',
    						views: ['Myquery.QueryView'],
    						models: ['Myquery.QueryModel'],
    						stores: ['Myquery.QueryStore'],
    						init: function() {
    							this.control({
    								'panel': {
    									render: this.initPanel
    								}
    							})
    						},
    						initPanel: function(b) {
    							console.log('init panel');
    						}
			})");
		}
		controller = rereplace(controller,"[\t\n\f\r]","","all");
	}

	private void function setApp(required string querycode) {
		savecontent variable="app" {
			writeoutput("
				Ext.application({
					name: 'Myquery',
					controllers: ['Myquery.QueryController'],
					appFolder: './app',
					init: function(app) {
						console.log('init app');
					},
					launch: function(){
					   console.log('app launched');
					   qdetails.add([{
					   	   xtype: 'queryview'
					   }]);
					}
				});
			");
		}
		app = rereplace(app,"[\t\n\f\r]","","all");
	}

	private void function numberColumn( numberfield, fieldname, resultobj ) {
		"#numberfield#" = evaluate("#resultobj#.get#fieldname#()");
		if(Isdefined("#numberfield#")) {
			if(trim(evaluate("#numberfield#")) eq "") {
				"#numberfield#" = "";
			} else {
				"#numberfield#" = "#numberfield#: " & evaluate("#numberfield#") & ",";
			}
		} else {
			"#numberfield#" = "";
		}
	}

	private void function numberOrStringColumn( numberOrStringfield, fieldname, resultobj ) {
		"#numberOrStringfield#" = evaluate("#resultobj#.get#fieldname#()");
		if(Isdefined("#numberOrStringfield#")) {
			if(trim(evaluate("#numberOrStringfield#")) eq "") {
				"#numberOrStringfield#" = "";
			} else {
				if(IsNumeric(evaluate("#numberOrStringfield#"))) {
					// a number
					"#numberOrStringfield#" = "#numberOrStringfield#: " & evaluate("#numberOrStringfield#") & ",";
				} else {
					if(trim(evaluate("#numberOrStringfield#")) eq "true" or trim(evaluate("#numberOrStringfield#")) eq "false") {
						// a boolean
						"#numberOrStringfield#" = "#numberOrStringfield#: " & evaluate("#numberOrStringfield#") & ",";
					} else {
						// a string
						"#numberOrStringfield#" = "#numberOrStringfield#: '" & evaluate("#numberOrStringfield#") & "',";
					}
				}
			}
		} else {
			"#numberOrStringfield#" = "";
		}
	}

	private void function stringColumn( stringfield, fieldname, resultobj ) {
		"#stringfield#" = evaluate("#resultobj#.get#fieldname#()");
		if(Isdefined("#stringfield#")) {
			if(trim(evaluate("#stringfield#")) eq "") {
				"#stringfield#" = "";
			} else {
				"#stringfield#" = "#stringfield#: '" & evaluate("#stringfield#") & "',";
			}
		} else {
			"#stringfield#" = "";
		}
	}


	private void function stringOrObjectOrFunction( stringobjectfunctionboolint, fieldname, resultobj ) {
		"#stringobjectfunctionboolint#" = evaluate("#resultobj#.get#fieldname#()");
		if(Isdefined("#stringobjectfunctionboolint#")) {
			if(trim(evaluate("#stringobjectfunctionboolint#")) eq "") {
				"#stringobjectfunctionboolint#" = "";
			} else {
				if(IsNumeric(evaluate("#stringobjectfunctionboolint#"))) {
					// a number
					"#stringobjectfunctionboolint#" = "#stringobjectfunctionboolint#: " & evaluate("#stringobjectfunctionboolint#") & ",";
				} else {
					if(trim(evaluate("#stringobjectfunctionboolint#")) eq "true" or trim(evaluate("#stringobjectfunctionboolint#")) eq "false") {
						// a boolean
						"#stringobjectfunctionboolint#" = "#stringobjectfunctionboolint#: " & evaluate("#stringobjectfunctionboolint#") & ",";
					} else {
						// a string, an object, or function
						if((left(trim(evaluate("#stringobjectfunctionboolint#")),1) eq "{" and right(trim(evaluate("#stringobjectfunctionboolint#")),1) eq "}") or (left(trim(evaluate("#stringobjectfunctionboolint#")),1) eq "[" and right(trim(evaluate("#stringobjectfunctionboolint#")),1) eq "]") or left(trim(evaluate("#stringobjectfunctionboolint#")),4) eq "Ext.") {
							// an object, array, Ext.* app
							"#stringobjectfunctionboolint#" = "#stringobjectfunctionboolint#: " & evaluate("#stringobjectfunctionboolint#") & ",";
						} else if(left(trim(evaluate("#stringobjectfunctionboolint#")),8) eq "function" and right(trim(evaluate("#stringobjectfunctionboolint#")),1) eq "}" ) {
							// a function
							"#stringobjectfunctionboolint#" = "#stringobjectfunctionboolint#: " & evaluate("#stringobjectfunctionboolint#") & ",";
						} else {
							// a string
							"#stringobjectfunctionboolint#" = "#stringobjectfunctionboolint#: '" & evaluate("#stringobjectfunctionboolint#") & "',";
						}
					}
				}
			}
		} else {
			"#stringobjectfunctionboolint#" = "";
		}



	}


}