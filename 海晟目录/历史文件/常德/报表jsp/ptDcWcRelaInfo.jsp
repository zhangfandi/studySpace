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
		title = "督导情况分析表";
        //下钻链接
        linkHigh = ['1-3,1'];
        //链接跳转
        preNext = ['1,2,3'];

		//表头行数
		titleRows= 2;
		//计算单位不变列
		/*if(g_fixUnitColShow==01){
			fixUnitCol = '16,17,18';
		}*/
		//表格标题[开始列,开始行,结束列,结束行,对齐,文本]
		/*tcells= [
			[1,4,1,4,'中','农事阶段'],
			[2,4,2,4,'中','烟点'],
			[3,4,3,4,'中','烟技员'],
			[4,4,4,4,'中','乡镇'],
			[5,4,5,4,'中','村'],
			[6,4,6,4,'中','烟农'],
			[7,4,7,4,'中','烟农编码'],
            [8,4,8,4,'中','存在问题'],
            [9,4,9,4,'中','整改措施'],
            [10,4,10,4,'中','督查单位'],
            [11,4,11,4,'中','督查员']
		];*/
		//非数值列、非合计列
		unNumSumCol = ['1,2,3,4,5,6,7,8,9,10,11','1,2,3,4,5,6,7,8,9,10,11'];
		//计量单位：0文本或%,1面积,2重量,3金额,4户,5株
		unitType="0,0,0,0,0,0,0,0,0,0,0";
		//小数位
		dotCol ="0,0,0,0,0,0,0,0,0,0,0";
		//sumForm = "4=%3/2,7=%6/5";
		showNoRow = false;
	}

	//报表标题
	function setTitle(){
		var busiDateStar,busiDateEnd;
	/*	//开始日期
		if(Ext.getCmp('busiDateStar')){
			busiDateStar = Ext.getCmp('busiDateStar').getRawValue();
		}
		//结束日期
		if(Ext.getCmp('busiDateEnd')){
			busiDateEnd = Ext.getCmp('busiDateEnd').getRawValue();
		}*/
		var year = Ext.getCmp('busiYear').getRawValue();
		var orgName = Ext.getCmp('searchOrgName').getRawValue();
		rcells= [
			[1,2,centerCol,2,'左','填报日期:'+new Date().dateFormat('Y-m-d')],
		//	[centerCol+1,2,allcols,2,'右','单位: 亩'],
			[1,3,centerCol,3,'左','组织单位:'+orgName]
			//[centerCol+1,3,allcols,3,'右','统计年度：'+year+'        统计时段：从'+busiDateStar+"至"+busiDateEnd]
		];
	}

	//设置查询条件
	function setCondition(){
		addCondItem({xtype:"yearCombo",id:"busiYear",fieldLabel:"业务年度",width:120,saveLast:true });
        addCondItem({xtype:"searchOrgTypeCombo",fieldLabel:"组织类型",id:"searchOrgType",showSome:"2",width:120,listeners:{select:searchOrgTypeChange} });
		addCondItem({xtype:'TREE_FIELD',fieldLabel:'组织单位',id:'searchOrgName',cd:'searchOrgCd',rootValue:loginOldOrgCd,cdValue:loginOldOrgCd,textValue:loginOrgName,width:120,sql:clickOrgTreeSql,change:searchOrgsFieldChange});
        addCondItem({xtype:"textfield",fieldLabel:"农事阶段",id:"stageName",width:120,value:"" });
        addCondItem({xtype:"textfield",fieldLabel:"烟农编号",id:"farmerCd",width:120,value:"" });
        addCondItem({xtype:"textfield",fieldLabel:"烟农姓名",id:"farmerName",width:120,value:"" });
        addCondItem({xtype:'TREE_FIELD',fieldLabel:'督查单位',id:'wcOrgName',cd:'wcOrgCd',rootValue:loginOldOrgCd,cdValue:"",textValue:"",width:120,sql:clickOrgTreeSql,change:searchOrgsFieldChange});
        addCondItem({xtype:"textfield",fieldLabel:"督查员",id:"scPsnName",width:120,value:"" });
    }

	//下钻至站点级别缓存站点代码
/*	var spotOrgCd = "";
	var spotOrgUnique_cd = "";*/
	//一个sql语句当中的from要统一大写或统一小写
	function setSQL(){
		var orgType = paramMap["searchOrgType"];
/*		var dateStar = paramMap['busiDateStar'];
		var dateEnd = paramMap['busiDateEnd'];
		var timestampStart = timestamp(dateStar,'00:00:00');
		var timestampEnd = timestamp(dateEnd,'23:59:59');*/
        var stageName = paramMap["stageName"];
        var farmerCd = paramMap["farmerCd"];
        var farmerName = paramMap["farmerName"];
        var wcPsnName = paramMap["scPsnName"];
        var wcOrgCd = paramMap['wcOrgCd'];
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

		tableTitle = "农事阶段,烟点,烟技员,乡镇,村,烟农,烟农编码,存在问题,整改措施,督查单位,督查员";

		whereSql =  "         WHERE DATA_STATE = '1' " ;
        whereSql += "            AND BUSINESS_YEAR = " + year ;
		whereSql += "            AND "+loginOrgCdField+"  = '"+loginOldOrgCd+"' ";
		whereSql += "            AND "+searchOrgCdField+" = '"+searchOrgCd+"' ";
		whereSql += "         AND "+groupOrgNameField+" IS NOT NULL " +
				"         AND "+groupOrgCdField+" IS NOT NULL ";

        if(!Ext.isEmpty(farmerCd)){
            whereSql +=  and("FARMER_CD likelr",farmerCd);
        }
        if(!Ext.isEmpty(farmerName)){
            whereSql +=  and("FARMER_NAME likelr",farmerName);
        }
        if(!Ext.isEmpty(stageName)){
            whereSql +=  and("stage_Name likelr",stageName);
        }
        if(!Ext.isEmpty(wcOrgCd)){
            whereSql +=  and("WC_ORG_CD =",wcOrgCd);
        }
        if(!Ext.isEmpty(wcPsnName)){
            whereSql +=  and("WC_PSN_NAME likelr",wcPsnName);
        }


		sql = "";
		sql += " SELECT STAGE_NAME,SSTC,TECHNICIAN_NAME,TOWN_NAME,VAGE_NAME,FARMER_NAME,FARMER_CD,WC_PROBLEM,WC_IMPORVE_METHOD,WC_ORG_NAME,WC_PSN_NAME";
        sql +=" FROM R_PT_DC_WC_RELA_D ";
        sql += whereSql;


	}

	//list转换
	function convertList(rsList){
		return rsList;
	}

</script>
