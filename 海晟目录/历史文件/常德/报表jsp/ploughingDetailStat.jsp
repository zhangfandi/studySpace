<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<html>
<head>
    <title><c:out value="${title}"/></title>
    <%@ include file="/common/headext.jsp"%>
    <%@ include file="/commonflex/cellOcx.jsp"%>
    <%@ include file="/common/report/reportHead.jsp"%>
    <script type="text/javascript" src="<c:url value='/dwr/interface/reportService.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/dwr/interface/reportTsoService.js'/>"></script>
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
<%@ include file="/commonflex/report/reportTail/clickUpDown2.jsp"%>
<%@ include file="/pages/report/pt/common.jsp"%>
<%@ include file="/pages/report/pt/commonImageHandle.jsp"%>

<%@ include file="/pages/report/pt/heilongjiang/sqls.jsp"%>

<script>
    //统计分组重新赋值，以满足该报表的个性下钻需求
//    groupOrgLevels = [[["无分组","0"],["省公司","1"],["市公司","2"],["分公司","3"],["烟站","4"],["收购点","5"]]];
    //组织单位层级查询语句
    var orgLevelSqlEx = "select int(org_level),org_cd from b_org where org_cd='cd' and org_type='2' ";
    orgLevelSqlEx += "union all select 4,org_cd from tp_grow_point where grow_point_cd='cd' and data_state='1' ";
    orgLevelSqlEx += "union all select 5,BIG_CANOPY_CD from TP_BIG_CANOPY where BIG_CANOPY_CD='cd' and data_state='1' "
    //行政单位层级查询语句
    var divLevelSqlEx = "select org_level, org_cd from b_division where org_cd='cd' and org_type='1' ";
    divLevelSqlEx += "union all select 6,org_unique_cd from pt_as_tlg_frm_rela where frm_cd='cd' and data_state='1' ";

    orgLevelSqls = [orgLevelSqlEx, divLevelSqlEx];

    //打开是否查询
    openSearch = 1;

    //不分页
    g_pageRow = 1;
    //不分页
    g_pageRow = 20;
    //显示序号行
    showNoRow = false;
    showPageToolbar = true;

    //排序
    g_orderCol = 1;

//    saveFormatBtnShow = true;

    sumFlag = 1;
    //重载参数内容
    cdFields = [["PROV","CITC","COUC","STAC","SSTC"],
        ["AREA_PROV","AREA_CITC","AREA_COUC","AREA_TOWN","AREA_VAGE","AREA_GRUP"]];

    //初始化参数
    function initParam(){
        title="翻耕明细表";
        //报表是否支持列手动排序：0不支持，1支持(默认)
        g_orderCol = 1;
        //表头行数
        titleRows = 1;
        //下钻链接
//        linkHigh = ['1-4,1'];
        //链接跳转
//        preNext = ['1,2,3,4,5'];
        //fixUnitCol = "16,17";
    }

    //报表标题
    function setTitle(){
        var bizYear = Ext.getCmp('businessYear').getRawValue();
        var orgName = Ext.getCmp('searchOrgName').getRawValue();
        rcells= [
            [1,2,centerCol,2,'左','填报日期:'+new Date().dateFormat('Y-m-d')],
            [centerCol+1,2,allcols,2,'右','单位: 亩、公斤'],
            [1,3,centerCol,3,'左','组织单位:'+orgName],
            [centerCol+1,3,allcols,3,'右','统计年度:'+bizYear]
        ];
    }

    //设置查询条件
    function setCondition(){
        addCondItem({xtype:"searchOrgTypeCombo",fieldLabel:'组织类型',id:"searchOrgType",width:120,showSome:"0,1",listeners:{select:searchOrgTypeChange}});
        addCondItem({xtype:'TREE_FIELD',fieldLabel:'组织单位',id:'searchOrgName',cd:'searchOrgCd',rootValue:loginOldOrgCd,cdValue:loginOldOrgCd,textValue:loginOrgName,width:120,sql:clickOrgTreeSql,change:searchOrgsFieldChange});

        addCondItem({xtype:"datefieldDC",fieldLabel:"开始日期",id:"busiDateStar",width:120,value:"<c:out value="${busiDateStar}"/>",format:"Y-m-d",saveLast:true});
        addCondItem({xtype:"datefieldDC",fieldLabel:"结束日期",id:"busiDateEnd",width:120,value:"<c:out value="${busiDateEnd}"/>",format:"Y-m-d"});
        addCondItem({xtype: "textfield", fieldLabel: "烟农编号", id: "frmCd", width: 120});
        addCondItem({xtype: "textfield", fieldLabel: "烟农姓名", id: "frmName", width: 120});
        addCondItem({xtype:"yearCombo",fieldLabel:"年度",id:"businessYear",width:120});
        //1省、2市、3县、4烟站、5收购点、6收购线、7镇、8村、9组、10服务片区、12种植主体、13明细
        addCondItem({xtype:"groupOrgLevelCombo",hidden:true,fieldLabel:"",id:"groupOrgLevel",width:120,showSome:"0,1,2,3,4,5"});
    }

    //下钻至站点级别缓存站点代码
    var spotOrgCd = "";
    var spotOrgUnique_cd = "";
    //一个sql语句当中的from要统一大写或统一小写
    function setSQL(){
        var bizYear = paramMap['businessYear'];
        //年度后缀
        var sufYear = String(bizYear).substring(2,4);
        //组织类型
        var searchOrgType = paramMap['searchOrgType'];
        //起始日期
        var dateStar = paramMap['busiDateStar'];
        //结束日期
        var dateEnd = paramMap['busiDateEnd'];
        //选择的单位代码
        var searchOrgCd = paramMap['searchOrgCd'];
        //过滤查询单位字段
        var searchOrgCdField = paramMap['searchOrgCdField'];
        //分组字段
        var groupOrgCdField = paramMap['groupOrgCdField'];
        //分组级别
        var groupOrgLevel =  paramMap['groupOrgLevel']=='0'?g_groupOrgLevel:paramMap['groupOrgLevel'];
        //单位类型表
        var orgTblName = searchOrgType=='0'?"b_org":"b_division";
        //烟农编号
        var frmCd = paramMap['frmCd'];
        //烟农姓名
        var frmName = paramMap['frmName'];
        //站点下钻至烟技员级别时缓存站点代码
        if(searchOrgType=='0' && groupOrgLevel==6){
            spotOrgCd = searchOrgCd;
            //dwr同步取值，获取站点代码对于的org_unique_cd
            DWREngine.setAsync(false);
            commonManager.findBySql({'sql':"select org_unique_cd from b_org where org_cd='" + searchOrgCd + "' and data_state='0'"}, function(val){spotOrgUniqueCd=val;});
            DWREngine.setAsync(true);
        }
        //组织单位级别下钻，单位层级大于烟技员级别的清空缓存的站点代码
        if(searchOrgType!='0' || groupOrgLevel<6){
            spotOrgCd = "";
            spotOrgUniqueCd = "";
        }

        //计量单位：0文本或%,1面积,2重量,3金额,4户,5株
        unitType="0,0,0,0,1,1,1,0,0,0,0,0";
        //小数位
        dotCol = "0,0,0,0,2,2,2,2,0,0,0,0";
        //非数值列、非合计列
        unNumSumCol = ['1,2,3,4,9,10,11,12','8'];
        //设置表格的表头合并
//        tcells = [
//            [12,4,15,4,"中","实施效果评价（亩）"]
//        ];

        tableTitle = "乡镇,村,烟农编码,烟农姓名,种植批复面积(亩),翻耕面积(亩),专业化作业面积(亩),完成比例,翻耕深度是否达到标准,是否打开腰围沟,实施效果评价,翻耕结束日期";
        sql = " SELECT";
        sql += "   A.TOWN_NAME,";
        sql += "   A.VAGE_NAME,";
        sql += "   A.FARMER_CD,";
        sql += "   A.FARMER_NAME,";
        sql += "   B.APPROVE_AREA,";
        sql += "   A.PLOUGH_AREA,";
        sql += "   CASE WHEN A.IS_DEPTH_STAND = '1'";
        sql += "     THEN A.PLOUGH_AREA";
        sql += "   ELSE 0 END,";
        sql += getSqlDivisionExpression("A.PLOUGH_AREA","B.APPROVE_AREA",true,2)+",";
        sql += "   CASE WHEN A.IS_DEPTH_STAND = '1'";
        sql += "     THEN '是'";
        sql += "   ELSE '否' END,";
        sql += "   CASE WHEN A.IS_OPEN_TRENCH = '1'";
        sql += "     THEN '是'";
        sql += "   ELSE '否' END,";
        sql += "   CASE A.WORK_EFFECT_EVAL";
        sql += "   WHEN '01'";
        sql += "     THEN '好'";
        sql += "   WHEN '02'";
        sql += "     THEN '较好'";
        sql += "   WHEN '03'";
        sql += "     THEN '一般'";
        sql += "   WHEN '04'";
        sql += "     THEN '差' END,";
        sql += ts2cd("A.END_DATE");
        sql += " FROM";
        sql += "   R_PT_PLOUGH_FM_D A";
        sql += "   LEFT JOIN";
        sql += "   (";
        sql += "     SELECT DISTINCT";
        sql += "       FRM_CD            AS FARMER_CD,";
        sql += "       SUM(APPROVE_AREA) AS APPROVE_AREA";
        sql += "     FROM";
        sql += "       PC_AI_PLANT_APPLY";
        sql += "     WHERE";
        sql += "       DATA_STATE = '1'";
        sql += "       AND BIZ_YEAR = " + bizYear;
        sql += "       AND AUDIT_STATE = '3' AND IS_INVALID_FLAG = '0'";
        sql += "     GROUP BY FRM_CD";
        sql += "   ) B ON A.FARMER_CD = B.FARMER_CD";
        sql += " WHERE";
        sql += "   A.DATA_STATE = '1'";
        sql += "   AND A.END_DATE>=" + timestamp(dateStar,"00:00:00");
        sql += "   AND A.END_DATE<=" + timestamp(dateEnd,"00:00:00");
        sql += "   AND A.BUSINESS_YEAR = "+bizYear;
        sql += "   AND A."+searchOrgCdField+" = '"+searchOrgCd+"' ";
        if(!Ext.isEmpty(frmCd)){
            sql +=  and("A.FARMER_CD likelr",frmCd);
        }
        if(!Ext.isEmpty(frmName)){
            sql +=  and("A.FARMER_NAME likelr",frmName);
        }


    }


    //list转换
    function convertList(rsList){
        return rsList;
    }

    //最后调用
    function afterFillTableData(){

    }
</script>
