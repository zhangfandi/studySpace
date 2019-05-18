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
	var isSelfLevel ="0";
	//不分页
	g_pageRow = -1;
	showPageToolbar = false;
	//固定列
	FixedRowCol=[6,1];
	//排序
	g_orderCol = 1;
	//报表是否支持列手动排序：0不支持，1支持(默认)
	g_orderCol = 1;
	//是否按第一列的组织代码自动排序
	autoOrder = 1;
	sumFlag = 1;

	//初始化参数
	function initParam(){
		title = "移栽汇总表";
        //下钻链接
        linkHigh = ['1-5,1'];
        //链接跳转
        preNext = ['1,2,3,4,5'];

		//表头行数
		titleRows= 2;
		//计算单位不变列
		/*if(g_fixUnitColShow==01){
			fixUnitCol = '16,17,18';
		}*/
		//表格标题[开始列,开始行,结束列,结束行,对齐,文本]
		tcells= [
			[1,4,1,5,'中','单位'],
			[2,4,2,5,'中','户数'],
			[3,4,3,5,'中','完成户数'],
			[4,4,4,5,'中','完成户数占比'],
			[5,4,5,5,'中','合同面积(亩)'],
			[6,4,6,5,'中','移栽面积(亩)'],
			[7,4,7,5,'中','完成比例%'],
			[8,4,11,5,'中','行距(亩)'],
			[12,4,15,4,'中','株距(亩)'],
			[16,4,18,4,'中','实施效果评价(亩)'],
			[19,4,19,5,'中','开始日期'],
			[20,4,20,5,'中','结束日期']
		];
		//非数值列、非合计列
		unNumSumCol = ['1,2,14,15','5,8'];
		//计量单位：0文本或%,1面积,2重量,3金额,4户,5株
		unitType="0,0,4,4,0,1,1,0,1,1,1,1,1,1,1,1,1,1,1,0,0";
		//小数位
		dotCol ="0,0,0,0,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,0,0";
		sumForm = "5=%4/3,8=%7/6";
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

		tableTitle = "单位,户数,完成户数,完成户数占比,合同面积(亩),移栽面积(亩),完成比例%,小于1.1M,等于1.1M,等于1.2M,大于1.2M,小于0.45M,等于0.45M,等于0.5M,大于0.5M,较密,正常,较稀,开始日期,结束日期";

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
		sql += " SELECT A.ORG_CD,A.ORG_NAME, d.hs,d.wchs, 0 as wchsbl,";
		sql += "     d.htmj,d.yzmj,0 as wcbl,";
		sql += "     A.S11,A.E11,A.E12,A.D12,A.S045,A.E045,A.E05,A.D05,A.JM,A.ZC,A.JS,";
		sql += "      TO_CHAR(TIMESTAMP(A.BEGIN_DATE),'YYYY-MM-DD') as BEGIN_DATE,";
        sql += "     TO_CHAR(TIMESTAMP(A.END_DATE),'YYYY-MM-DD') as END_DATE";
		sql +=" FROM ";
		sql += "( SELECT "+groupOrgCdField+" AS ORG_CD, ";
		sql += "  		MAX("+groupOrgNameField+") AS ORG_NAME, ";
		sql += "      sum(case when LINE_DISTANCE='S1.1' then TRANSPLANT_AREA end) as s11,";
		sql += "      sum(case when LINE_DISTANCE='E1.1' then TRANSPLANT_AREA end) as e11,";
		sql += "      sum(case when LINE_DISTANCE='E1.2' then TRANSPLANT_AREA end) as e12,";
		sql += "      sum(case when LINE_DISTANCE='D1.2' then TRANSPLANT_AREA end) as d12,";
		sql += "      sum(case when ONE_DISTANCE='S0.45' then TRANSPLANT_AREA end) as s045,";
		sql += "      sum(case when ONE_DISTANCE='E0.45' then TRANSPLANT_AREA end) as e045,";
		sql += "      sum(case when ONE_DISTANCE='E0.5' then TRANSPLANT_AREA end) as e05,";
		sql += "      sum(case when ONE_DISTANCE='D0.5' then TRANSPLANT_AREA end) as d05,";
		sql += "      sum(case when WORK_EFFECT_EVAL='1' then TRANSPLANT_AREA end) as jm,";
		sql += "      sum(case when WORK_EFFECT_EVAL='2' then TRANSPLANT_AREA end) as zc,";
		sql += "      sum(case when WORK_EFFECT_EVAL='3' then TRANSPLANT_AREA end) as js,";
		sql += "      min(BEGIN_DATE) as BEGIN_DATE,";
		sql += "      max(END_DATE) as END_DATE";
		sql +=" FROM R_PT_TRANSPLANT_FM_D ";
		sql += whereSql;
		sql += groupBySql;
		sql += " ) A";
		sql += " LEFT JOIN ";
		sql += " (SELECT A.ORG_CD,";
		sql += "     SUM(A.TRANSPLANT_AREA) AS yzmj,";     //移栽面积
		sql += "     SUM(B.HTMJ) AS HTMJ,";                 //合同面积
		sql += "     COUNT(DISTINCT A.FARMER_CD) AS hs,";  //户数
		sql += "     COUNT(DISTINCT (case when A.TRANSPLANT_AREA = B.HTMJ THEN A.FARMER_CD END)) AS wchs "; //完成户数
		sql += " FROM ";
		sql +=" (SELECT "+groupOrgCdField+" AS ORG_CD,";
		//sql += "  		MAX(A."+groupOrgNameField+") AS ORG_NAME, ";
		sql += "      FARMER_CD,";
		sql += "   SUM(TRANSPLANT_AREA) as TRANSPLANT_AREA";
		sql +=" FROM R_PT_TRANSPLANT_FM_D ";
		sql +=whereSql;
		sql +=" group by "+groupOrgCdField+",FARMER_CD ) A";
		sql+=" LEFT JOIN (";
		sql+="  SELECT FARMER_CD,SUM(CNTRCT_PLNT_AREA) AS HTMJ";
        sql +=" FROM ";
		sql+= getDCTbName("R_PC_CTRT_PC_Y_YXX",g_searchOrgLevel,orgType,subYear);
        sql+=" WHERE DATA_STATE='1'";
        sql+=" AND BUSINESS_YEAR = " + year ;
		sql+=" GROUP BY FARMER_CD ) B ON A.FARMER_CD=B.FARMER_CD";
		sql+=" GROUP BY A.org_cd";
		sql+= " ) D ON A.ORG_CD = D.ORG_CD";
	}

	//list转换
	function convertList(rsList){
		return rsList;
	}

</script>
