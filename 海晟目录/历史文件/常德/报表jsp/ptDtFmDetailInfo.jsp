<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<html>
<head>
    <title><c:out value="${title}"/></title>
    <%@ include file="/common/headext.jsp"%>
    <%@ include file="/commonflex/cellOcx.jsp"%>
    <%@ include file="/common/report/reportHead.jsp"%>
    <script type="text/javascript" src="<c:url value='/dwr/interface/reportService.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/dwr/interface/commonManager.js'/>"></script>
</head>
<body style="margin:0px;overflow-y:hidden;" >
<jsp:include page="/common/header.jsp" />
<div id="printToolbar-div" style="width:100%;"></div>
<div id="cellContainer" style="width:100%;">
    <c:out value="${cellOcx}" escapeXml="false"/>
</div>
<div id="pageToolbar-div" style="display:none;"></div>
<div id="chartdiv" style="display:none;"></div>
<jsp:include page="/common/footer.jsp" />
</body>
</html>

<%@ include file="/commonflex/report/reportTail.jsp"%>
<%@ include file="/common/report/reportSql.jsp"%>
<%@ include file="/commonflex/report/reportTail/clickUpDownEx.jsp"%>
<%@ include file="../common.jsp"%>
<script>


    //不立即加载
	openSearch = 0;
	//0:下级    1:本级
	var isSelfLevel ="1";
	//不分页
	g_pageRow = 20;
	showPageToolbar = true;
	//固定列
	//FixedRowCol=[6,1];
	//排序
	g_orderCol = 1;
	//报表是否支持列手动排序：0不支持，1支持(默认)
	g_orderCol = 1;
	//是否按第一列的组织代码自动排序
	autoOrder = 1;
	sumFlag = 1;

	//初始化参数
	function initParam(){
		title = "打顶抹杈明细表";
        //下钻链接
        linkHigh = [];
        //链接跳转
        //preNext = ['1,2,3,4,5'];

		//表头行数
		titleRows= 2;
		//计算单位不变列
		/*if(g_fixUnitColShow==01){
			fixUnitCol = '16,17,18';
		}*/
		//表格标题[开始列,开始行,结束列,结束行,对齐,文本]
	/*	tcells= [
			[1,4,1,4,'中','乡镇'],
			[2,4,2,4,'中','村'],
			[3,4,3,4,'中','烟农编号'],
			[4,4,4,4,'中','烟农姓名'],
			[5,4,5,4,'中','合同面积(亩)'],
			[6,4,6,4,'中','打顶面积面积(亩)'],
			[7,4,7,4,'中','完成比例%'],
			[8,4,8,4,'中','打顶时机'],
			[9,4,9,4,'中','打顶后有效叶数'],
			[10,4,10,4,'中','实施效果评价'],
			[11,4,11,4,'中','开始日期'],
			[12,4,12,4,'中','结束日期'],
			[13,4,13,4,'中','烟技员']
		];*/
		//非数值列、非合计列
		unNumSumCol = ['1,2,3,4,8,9,10,11,12,13','7'];
		//计量单位：0文本或%,1面积,2重量,3金额,4户,5株
		unitType="0,0,0,0,1,1,0,0,0,0,0,0,0";
		//小数位
		dotCol ="0,0,0,0,2,2,2,0,0,0,0,0,0";
		sumForm = "7=%6/5";
		showNoRow = false;
	}

	//报表标题
	function setTitle(){
		var busiDateStar,busiDateEnd;
		//开始日期
		if(Ext.getCmp('busiDateStar')){
			busiDateStar = Ext.getCmp('busiDateStar').getRawValue();
		}
		//结束日期
		if(Ext.getCmp('busiDateEnd')){
			busiDateEnd = Ext.getCmp('busiDateEnd').getRawValue();
		}
		var year = Ext.getCmp('busiYear').getRawValue();
		var orgName = Ext.getCmp('searchOrgName').getRawValue();
		rcells= [
			[1,2,centerCol,2,'左','填报日期:'+new Date().dateFormat('Y-m-d')],
			[centerCol+1,2,allcols,2,'右','单位: 亩'],
			[1,3,centerCol,3,'左','组织单位:'+orgName],
			[centerCol+1,3,allcols,3,'右','统计年度：'+year+'        统计时段：从'+busiDateStar+"至"+busiDateEnd]
		];
	}

	//设置查询条件
	function setCondition(){
		addCondItem({xtype:"yearCombo",id:"busiYear",fieldLabel:"业务年度",width:120,saveLast:true });
		addCondItem({xtype:"datefieldDC",fieldLabel:"开始日期",id:"busiDateStar",width:120,value:"<c:out value="${busiDateStar}"/>",format:"Y-m-d",saveLast:true });
		addCondItem({xtype:"datefieldDC",fieldLabel:"结束日期",id:"busiDateEnd",width:120,value:"<c:out value="${busiDateEnd}"/>",format:"Y-m-d",saveLast:true });
		addCondItem({xtype:"searchOrgTypeCombo",fieldLabel:"组织类型",id:"searchOrgType",showSome:"1,2",value:"2",width:120,listeners:{select:searchOrgTypeChange} });
		addCondItem({xtype:'TREE_FIELD',fieldLabel:'组织单位',id:'searchOrgName',cd:'searchOrgCd',rootValue:loginOldOrgCd,cdValue:loginOldOrgCd,textValue:loginOrgName,width:120,sql:clickOrgTreeSql,change:searchOrgsFieldChange});
		addCondItem({xtype:"groupOrgLevelCombo",fieldLabel:"统计分组",id:"groupOrgLevel",width:120,showSome:"0,2_1,2_2,2_3,2_4,2_5"});
		addCondItem({xtype:"textfield",fieldLabel:"烟农编号",id:"farmerCd",width:120,value:"" });
		addCondItem({xtype:"textfield",fieldLabel:"烟农姓名",id:"farmerName",width:120,value:"" });
	}

	//下钻至站点级别缓存站点代码
/*	var spotOrgCd = "";
	var spotOrgUnique_cd = "";*/
	//一个sql语句当中的from要统一大写或统一小写
	function setSQL(){
		var orgType = paramMap["searchOrgType"];
		var dateStar = paramMap['busiDateStar'];
		var dateEnd = paramMap['busiDateEnd'];
		var timestampStart = timestamp(dateStar,'00:00:00');
		var timestampEnd = timestamp(dateEnd,'23:59:59');
		var year = paramMap["busiYear"];
		var farmerCd= paramMap["farmerCd"];
		var farmerName= paramMap["farmerName"];
        var subYear =  (year+"").substr(2,2);
		//本级编码
		var searchOrgLevelNo = g_searchOrgLevel;
		//下级编码
		var groupOrgLevelNo = g_groupOrgLevel;
		//选择的单位代码
		var searchOrgCd = paramMap['searchOrgCd'];
		//过滤登录单位字段
		var loginOrgCdField = paramMap['loginOrgCdField'];
		//过滤查询单位字段
		var searchOrgCdField = paramMap['searchOrgCdField'];
		//分组字段
		var groupOrgCdField = paramMap["groupOrgCdField"];
		//分组字段
		var groupOrgNameField = paramMap['groupOrgNameField'];
		//查询级别编码
		var searchOrgLevel = getSearchOrgLevel(searchOrgLevelNo,groupOrgLevelNo,isSelfLevel);

		tableTitle = "乡镇,村,烟农编码,烟农姓名,合同面积(亩),打顶面积面积(亩),完成比例%,打顶时机,打顶后有效叶数,实施效果评价,开始日期,结束日期,烟技员";

		//where查询条件语句
		whereSql =  "         WHERE DATA_STATE = '1' " ;
		whereSql += "            AND BUSINESS_DATE >= " + timestampStart +
				"            		AND BUSINESS_DATE <= " + timestampEnd ;
        whereSql += "            AND BUSINESS_YEAR = " + year ;
		whereSql += "            AND "+loginOrgCdField+"  = '"+loginOldOrgCd+"' ";
		whereSql += "            AND "+searchOrgCdField+" = '"+searchOrgCd+"' ";

		if(!Ext.isEmpty(farmerCd)){
			whereSql +=  and("FARMER_CD likelr",farmerCd);
		}
		if(!Ext.isEmpty(farmerName)){
			whereSql +=  and("FARMER_NAME likelr",farmerName);
		}

		sql=" SELECT A.TOWN_NAME,A.VAGE_NAME,A.FARMER_CD,A.FARMER_NAME,B.HTMJ,A.BEAT_TOP_AREA,0 AS WCBL,";
		sql+="   X1.ENUM_NAME AS BEAT_TOP_OPPORT ,";
		sql+="   X2.ENUM_NAME AS BEAT_TOP_LEAF_QTY_EK,";
		sql+="   X3.ENUM_NAME AS WORK_EFFECT_EVAL,";
		sql+="   A.BEGIN_DATE,";
        sql+="   A.END_DATE,";
        sql+= "  C.TECHNICIAN_NAME";
		sql+=" FROM";
		sql+=" (SELECT TOWN_NAME,VAGE_NAME,FARMER_CD,FARMER_NAME,BEAT_TOP_OPPORT,BEAT_TOP_LEAF_QTY_EK,WORK_EFFECT_EVAL,";
        sql+=" TO_CHAR(TIMESTAMP(BEGIN_DATE),'YYYY-MM-DD') as BEGIN_DATE ,";
        sql+=" TO_CHAR(TIMESTAMP(END_DATE),'YYYY-MM-DD') as END_DATE,";
        sql+=" SUM(BEAT_TOP_AREA) AS BEAT_TOP_AREA";
		sql+=" FROM R_PT_DT_FM_D";
		sql+=whereSql;
		sql+=" GROUP BY TOWN_NAME,VAGE_NAME,FARMER_CD,FARMER_NAME,BEAT_TOP_OPPORT,BEAT_TOP_LEAF_QTY_EK,WORK_EFFECT_EVAL,TO_CHAR(TIMESTAMP(BEGIN_DATE),'YYYY-MM-DD'),TO_CHAR(TIMESTAMP(END_DATE),'YYYY-MM-DD')) A";
		sql+=" LEFT JOIN (";
        sql+="  SELECT FARMER_CD,SUM(CNTRCT_PLNT_AREA) AS HTMJ";  //合同面积
        sql+=" FROM ";
        sql+= getDCTbName("R_PC_CTRT_PC_Y_YXX",g_searchOrgLevel,orgType,subYear);
        sql+=" WHERE DATA_STATE='1'";
        sql+=" AND BUSINESS_YEAR = " + year ;
		sql+=" GROUP BY FARMER_CD ) B ON A.FARMER_CD=B.FARMER_CD";
		sql+=" LEFT JOIN "+ getDCTbName("R_FRMR_TECH_REL_YXX",g_searchOrgLevel,orgType,subYear) +" C ON C.FARMER_CD=A.FARMER_CD AND C.DATA_STATE='1'";   //烟技员
		sql+=" LEFT JOIN pt_ix_enum_data X1 ON X1.ENUM_CD=A.LINE_DISTANCE AND X1.DATA_STATE='1' AND X1.idx_id='8a3c34536a8cad24016a950d945b0053' ";  //打顶时机
		sql+=" LEFT JOIN pt_ix_enum_data X2 ON X2.ENUM_CD=A.ONE_DISTANCE AND X2.DATA_STATE='1' AND X2.idx_id='8a3c34536a8cad24016a950e7aa00057' ";   //打顶后有效叶数
		sql+=" LEFT JOIN pt_ix_enum_data X3 ON X3.ENUM_CD=A.WORK_EFFECT_EVAL AND X3.DATA_STATE='1' AND X3.idx_id='8a3c345369b94fd80169b9b9801e00a9' "; //实施效果评价

	}

	//list转换
	function convertList(rsList){
		return rsList;
	}

</script>
