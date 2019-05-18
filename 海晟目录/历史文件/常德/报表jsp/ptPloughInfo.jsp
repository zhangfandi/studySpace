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
	var isSelfLevel ="0"; //统计分组下拉级别
	initGroupOrgLevelCombo("0,2_1,2_2,2_3,2_4,2_5,2_A,2_B,2_C");
	//不分页
	g_pageRow = -1;
	showPageToolbar = false;
	//固定列
	FixedRowCol=[6,1];
	//报表是否支持列手动排序：0不支持，1支持(默认)
	g_orderCol = 1;
	/*
	 //排序
	 g_orderCol = 1;
	 //报表是否支持列手动排序：0不支持，1支持(默认)
	 g_orderCol = 1;
	 //是否按第一列的组织代码自动排序
	 autoOrder = 1;
	 */


	//初始化参数
	function initParam(){
		title = "起垄统计表";
		//下钻链接
		linkHigh = ['1-5,1'];
		//链接跳转
		preNext = ['1,2,3,4,5'];
		sumFlag = 1;
		//表头行数
		titleRows= 2;
		//计算单位不变列
		/*if(g_fixUnitColShow==01){
		 fixUnitCol = '16,17,18';
		 }*/
		//表格标题[开始列,开始行,结束列,结束行,对齐,文本]
		/*tcells= [
			[1,4,1,5,'中','单位编号'],
			[2,4,2,5,'中','单位名称'],
			[3,4,3,5,'中','户数'],
			[4,4,4,5,'中','完成户数'],
			[5,4,5,5,'中','完成户数占比'],
			[6,4,6,5,'中','种植批复面积(亩)'],
			[7,4,7,5,'中','起垄面积(亩)'],
			[8,4,8,5,'中','完成比例%'],
			[9,4,9,5,'中','起垄高度达标(亩)'],
			[10,4,10,5,'中','起垄高度未达标(亩)'],
			[11,4,14,4,'中','实施效果评价(亩)'],
			[15,4,15,5,'中','开始日期'],
			[16,4,16,5,'中','结束日期']
		];*/
		tcells= [
			[1,4,1,5,'中','单位'],
			[2,4,2,5,'中','户数'],
			[3,4,3,5,'中','完成户数'],
			[4,4,4,5,'中','完成户数占比'],
			[5,4,5,5,'中','种植批复面积(亩)'],
			[6,4,6,5,'中','起垄面积(亩)'],
			[7,4,7,5,'中','完成比例%'],
			[8,4,8,5,'中','起垄高度达标(亩)'],
			[9,4,9,5,'中','起垄高度未达标(亩)'],
			[10,4,13,5,'中','实施效果评价(亩)'],
			[14,4,14,5,'中','开始日期'],
			[15,4,15,5,'中','结束日期']
		];
		//非数值列、非合计列
		unNumSumCol = ['1,14,15','4,7'];
		//计量单位：0文本或%,1面积,2重量,3金额,4户,5株
		unitType="0,4,4,0,1,1,0,1,1,1,1,1,1,1,1,1,0,0";
		//小数位
		dotCol ="0,0,2,2,2,2,2,2,2,2,2,2,2,2,2,2,0,0";
		sumForm = "4=%3/2,7=%6/5";
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

		tableTitle = "单位,户数,完成户数,完成户数占比,种植批复面积(亩),起垄面积(亩),完成比例%,起垄高度达标(亩),起垄高度未达标(亩),好,较好,一般,差,开始日期,结束日期";

		whereSql =  "         WHERE DATA_STATE = '1' " ;
		whereSql += "            AND BUSINESS_DATE >= " + timestampStart +
				"            		AND BUSINESS_DATE <= " + timestampEnd ;
		whereSql += "            AND BUSINESS_YEAR = " + year ;
		whereSql += "            AND "+loginOrgCdField+"  = '"+loginOldOrgCd+"' ";
		whereSql += "            AND "+searchOrgCdField+" = '"+searchOrgCd+"' ";
		whereSql += "         AND "+groupOrgNameField+" IS NOT NULL " +
				"         AND "+groupOrgCdField+" IS NOT NULL ";

		//group by语句
		groupBySql = " GROUP BY "+groupOrgCdField ;

		sql = "";
		sql += " SELECT A.ORG_CD,A.ORG_NAME, D.hs,D.wchs, 0 as wchsbl,";
		sql += "     D.zzpfmj,D.PREPAR_AREA,0 as wcbl,";
		sql += "     A.qldb,A.qlwdb,A.hao,A.jhao,A.yban,A.cha,";
		sql += "     A.BEGIN_DATE,A.END_DATE";
		sql +=" FROM ";
		sql += "( SELECT "+groupOrgCdField+" AS ORG_CD, ";
		sql += "  		MAX("+groupOrgNameField+") AS ORG_NAME, ";
		sql += "      sum(case when IS_HIGH_STAND='1' then PREPAR_AREA end) as qldb,";  //起垄达标
		sql += "      sum(case when IS_HIGH_STAND='0' then PREPAR_AREA end) as qlwdb,";  //起垄未达标
		sql += "      sum(case when WORK_EFFECT_EVAL='01' then PREPAR_AREA end) as hao,";
		sql += "      sum(case when WORK_EFFECT_EVAL='02' then PREPAR_AREA end) as jhao,";
		sql += "      sum(case when WORK_EFFECT_EVAL='03' then PREPAR_AREA end) as yban,";
		sql += "      sum(case when WORK_EFFECT_EVAL='04' then PREPAR_AREA end) as cha,";
		sql += "       TO_CHAR(TIMESTAMP(min(BEGIN_DATE)),'YYYY-MM-DD') as BEGIN_DATE,";
		sql += "       TO_CHAR(TIMESTAMP( max(END_DATE)),'YYYY-MM-DD') as END_DATE";
		sql +=" FROM R_PT_PREPAR_FM_D ";
		sql += whereSql;
		sql += groupBySql;
		sql += " ) A";
		sql += " LEFT JOIN ";
		sql += " (SELECT A.ORG_CD,";
		sql += "     SUM(A.PREPAR_AREA) AS PREPAR_AREA,";     //起垄面积
		sql += "     SUM(B.zzpfMJ) AS zzpfMJ,";                 //种植批复面积
		sql += "     COUNT(DISTINCT A.FARMER_CD) AS hs,";  //户数
		sql += "     COUNT(DISTINCT (case when A.PREPAR_AREA = B.zzpfMJ THEN A.FARMER_CD END)) AS wchs "; //起垄面积等于批复面积的烟农为完成户数
		sql += " FROM ";
		sql +=" (SELECT "+groupOrgCdField+" AS ORG_CD,";
		//sql += "  		MAX(A."+groupOrgNameField+") AS ORG_NAME, ";
		sql += "      FARMER_CD,";
		sql += "   SUM(PREPAR_AREA) as PREPAR_AREA";  //烟农起垄面积
		sql +=" FROM R_PT_PREPAR_FM_D ";
		sql +=whereSql;
		sql +=" group by "+groupOrgCdField+",FARMER_CD ) A";
		sql+=" LEFT JOIN (";
		sql+="  SELECT FRM_CD AS FARMER_CD,SUM(APPROVE_AREA) AS zzpfMJ";  //种植批复面积
		sql+="  FROM PC_AI_PLANT_APPLY";
		sql+=" WHERE DATA_STATE='1' AND BIZ_YEAR="+ year;
		sql+="    AND AUDIT_STATE='3' AND  IS_INVALID_FLAG='0'";
		sql+=" GROUP BY FRM_CD ) B ON A.FARMER_CD=B.FARMER_CD";
		sql+=" GROUP BY A.ORG_CD";
		sql+= " ) D ON A.ORG_CD = D.ORG_CD";

	}

	//list转换
	function convertList(rsList){
		return rsList;
	}

</script>
