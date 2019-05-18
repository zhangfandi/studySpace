<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/common/taglibs.jsp" %>
<html>
<head>
    <title><c:out value="${title}"/></title>
    <%@ include file="/common/headext.jsp" %>
    <%@ include file="/commonflex/cellOcx.jsp" %>
    <%@ include file="/common/report/reportHead.jsp" %>
    <script type="text/javascript" src="<c:url value='/dwr/interface/reportService.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/dwr/interface/reportTsoService.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/dwr/interface/commonManager.js'/>"></script>
</head>
<body style="margin:0px;overflow-y:hidden;">
<jsp:include page="/common/header.jsp"/>
<div id="printToolbar-div" style="width:100%;"></div>
<div id="cellContainer" style="width:100%;">
    <c:out value="${cellOcx}" escapeXml="false"/>
</div>
<div id="pageToolbar-div" style="display:none;"></div>
<div id="chartdiv" style="display:none;"></div>
<jsp:include page="/common/footer.jsp"/>
</body>
</html>

<%@ include file="/commonflex/report/reportTail.jsp" %>
<%@ include file="/common/report/reportSql.jsp" %>
<%@ include file="/pages/report/pt/guizhou/clickUpDownGz.jsp" %>
<%@ include file="/pages/report/pt/common.jsp" %>
<%@ include file="/pages/report/pt/commonImageHandle.jsp" %>

<script>
    groupOrgLevels = [[["无分组", "0"], ["省公司", "1"], ["市公司", "2"], ["分公司", "3"], ["烟站", "4"], ["收购点", "5"], ["烟技员", "6"], ["烟农", "7"], ["田块", "8"], ["无", "9"]]
        , [["无分组", "0"], ["省", "1"], ["市", "2"], ["县", "3"], ["镇", "4"], ["村", "5"], ["组", "6"], ["烟农", "7"], ["田块", "8"], ["无", "9"]]
        , [["无分组", "0"], ["省公司", "1"], ["市公司", "2"], ["分公司", "3"], ["基地单元", "4"]]];

    //组织单位层级查询语句
    var orgLevelSqlEx = "select int(org_level),org_cd from b_org where org_cd='cd' and org_type='2' ";
    orgLevelSqlEx += "union all select 6,org_unique_cd from cm_om_staff where psn_name='cd' and data_state='1'";
    orgLevelSqlEx += "union all select 7,org_unique_cd from pt_as_tlg_frm_rela where frm_cd='cd' and data_state='1'";
    //行政单位层级查询语句
    var divLevelSqlEx = "select org_level, org_cd from b_division where org_cd='cd' and org_type='1' ";
    divLevelSqlEx += "union all select 7,org_unique_cd from pt_as_tlg_frm_rela where frm_cd='cd' and data_state='1' ";
    orgLevelSqls = [orgLevelSqlEx, divLevelSqlEx];
    //jdbc=tso对应jdbc/TSO，报表增加js引用/dwr/interface/reportTsoService.js
    //jdbc默认为dccell对应jdbc/DCCELL
    //jdbc = "tso";

    //打开是否查询
    openSearch = 1;

    mergeCol = "";

    tailRows = 2;

    //是否显示翻页工具栏
    //	showPageToolbar = false;

    //重量初始化为担
    //uweight = 50;
    //不分页
    g_pageRow = -1;

    //排序
    g_orderCol = 1;
    //报表是否支持列手动排序：0不支持，1支持(默认)
    g_orderCol = 1;
    //表头行数
    titleRows = 2;
    // 固定第8行第2列
    //    FixedRowCol=[8,4];
    sumFlag = 1;
    //重载参数内容
    cdFields = [["PROV","CITC","COUC","STAC","SSTC"]];
    //初始化参数
    function initParam() {
        title = "专业化机耕情况监控表";
//        //下钻链接
//        linkHigh = ['1-6,1'];
//        //链接跳转
//        preNext = ['1,2,3,4,5,6,7'];
        //fixUnitCol = "16,17";
        //表格标题[开始列,开始行,结束列,结束行,对齐,文本]
        tcells= [
            [1,4,1,5,'中','单位'],
            [2,4,2,5,'中','户数'],
            [3,4,3,5,'中','机耕面积(亩)'],
            [4,4,4,5,'中','专业化服务比例%'],
            [5,4,8,5,'中','实施效果评价（亩）'],
            [9,4,9,5,'中','开始日期'],
            [10,4,10,5,'中','结束日期']
        ];
        //非数值列、非合计列
        unNumSumCol = ['1,5,6,7,8,9,10'];
        //计量单位：0文本或%,1面积,2重量,3金额,4户,5株
        unitType = "0,4,1,0,0,0,0,0,0,0";
        //小数位
        dotCol = "0,2,2,2,2,2,2,2,0,0";
    }

    //报表标题
    function setTitle() {
        var bizYear = Ext.getCmp('businessYear').getRawValue();
        var orgName = Ext.getCmp('searchOrgName').getRawValue();
        rcells = [
            [1, 2, centerCol, 2, '左', '填报日期:' + new Date().dateFormat('Y-m-d')],
            [centerCol + 1, 2, allcols, 2, '右', '单位: 亩，%'],
            [1, 3, centerCol, 3, '左', '组织单位:' + orgName]
        ];
    }

    //设置查询条件
    function setCondition() {
        addCondItem({xtype: 'TREE_FIELD', fieldLabel: '组织单位', id: 'searchOrgName', cd: 'searchOrgCd', rootValue: loginOldOrgCd, cdValue: loginOldOrgCd, textValue: loginOrgName, width: 120, sql: clickOrgTreeSql, change: searchOrgsFieldChange});
        addCondItem({xtype: "yearCombo", fieldLabel: "年度", id: "businessYear", width: 120});
        addCondItem({xtype: "searchOrgTypeCombo", hidden: true, id: "searchOrgType", width: 120, showSome: "0,1", listeners: {select: searchOrgTypeChange}});
        //1省、2市、3县、4烟站、5收购点、6收购线、7镇、8村、9组、10服务片区、12种植主体、13明细
        addCondItem({xtype: "groupOrgLevelCombo", hidden: true, fieldLabel: "", id: "groupOrgLevel", width: 120, showSome: "0,1,2,3,4,5"});
    }

    //下钻至站点级别缓存站点代码
    var spotOrgCd = "";
    var spotOrgUnique_cd = "";
    //一个sql语句当中的from要统一大写或统一小写
    function setSQL() {
        var bizYear = paramMap['businessYear'];
        //组织类型
        var searchOrgType = paramMap['searchOrgType'];
        //选择的单位代码
        var searchOrgCd = paramMap['searchOrgCd'];
        //过滤查询单位字段
        var searchOrgCdField = paramMap['searchOrgCdField'];

        tableTitle = "单位,户数,机耕面积(亩),专业化服务比例%,好,较好,一般,差,开始日期,结束日期";

        sql = "SELECT serv.SERV_ORG_NAME,COUNT(DISTINCT a.FARMER_CD) AS hs,SUM(a.PLOUGH_AREA) AS PLOUGH_AREA, ";
        sql += " cast(sum(CASE WHEN IS_PROPESS = '1' THEN PLOUGH_AREA END) as double)*100/sum(CASE WHEN IS_PROPESS = '1' OR IS_PROPESS='0' THEN PLOUGH_AREA END) AS zyhbl, ";
        sql += " SUM(CASE WHEN a.WORK_EFFECT_EVAL = '01' THEN PLOUGH_AREA END) AS hao,";
        sql += " SUM(CASE WHEN a.WORK_EFFECT_EVAL = '02' THEN PLOUGH_AREA END) AS jhao,";
        sql += " SUM(CASE WHEN a.WORK_EFFECT_EVAL = '03' THEN PLOUGH_AREA END) AS yban,";
        sql += " SUM(CASE WHEN a.WORK_EFFECT_EVAL = '04' THEN PLOUGH_AREA END) AS cha,";
        sql += " TO_CHAR(TIMESTAMP(min(a.END_DATE)), 'YYYY-MM-DD') AS BEGIN_DATE,";
        sql += " TO_CHAR(TIMESTAMP(MAX(a.END_DATE)), 'YYYY-MM-DD') AS END_DATE";
        sql += " FROM R_PT_PLOUGH_FM_D a ";
        sql += "  LEFT JOIN CM_PS_SERV_ORG serv ON a.SERV_ORG_ID=serv.SERV_ORG_ID AND a.DATA_STATE=serv.DATA_STATE ";
        sql += "  WHERE ";
        sql += "  a.DATA_STATE='1'  AND a.SERV_ORG_ID IS NOT NULL  ";
        sql += "  AND a.BUSINESS_YEAR = " + bizYear ;
        sql += "  AND a." +searchOrgCdField + "='" + searchOrgCd + "' ";
        sql +=" GROUP BY serv.SERV_ORG_NAME ";

    }

    //list转换
    function convertList(rsList) {
        return rsList;
    }

    //最后调用
    function afterFillTableData() {
        setTitleCell(0, 0, title);
        setTitleCell(2, 2, '单位: 亩，%');
        refreshTitleCell();
    }
</script>
