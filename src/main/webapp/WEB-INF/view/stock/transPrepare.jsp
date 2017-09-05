﻿<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="s" uri="/struts-tags"%>
<jsp:useBean id="now" class="java.util.Date" />   
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<form id="pagerForm" action="${ctx}/stock/transPrepare!confirm.action?callbackType=forward&forwardUrl=${ctx}/stock/transPrepare.action&navTabId=tab_transPrepare" method="post" class="pageForm required-validate" onsubmit="return validateCallback(this, navTabAjaxDone)">
<div class="pageHeader">
	<div class="pageFormContent nowrap">
		<fieldset>
			<legend>调拨单信息</legend>
			<dl>
				<dt>调拨仓：</dt>
				<dd>${transfer.transferTo }</dd>
			</dl>
		</fieldset>
		<dl>
			<dt>调货单:</dt>
			<dd><input name="transferId" type="text" class="textInput digits required" value="${transferId }" readonly="readonly"/></dd>
		</dl>
		<dl id="scanIndiv2">
			<dt>扫描类型：</dt>
			<dd>
                <input type="radio" name="isImei" checked value="0"/> imei
                <input type="radio" name="isImei" value="1" /> 箱号
            </dd>
		</dl>
		<dl id="scanIndiv">
			<dt>编码：</dt>
			<dd><input id="indivCode2" name="indivCode" type="text" class="textInput" onKeydown="doKeydown(event, this)"/><span id="scanCode" style="color: red; font-size: 12pt; float: left;"></span></dd>
		</dl>
		<dl id="scanShipping" style="display: none;">
			<dt>扫描物流运单：</dt>
			<dd><input id="logisticNo" name="logisticNo" type="text" class="required textInput" maxlength="20" size="30" onkeydown="toSubmit(event, this)"/></dd>
		</dl>
		</ul>
		<div class="subBar">
			<span id="errorTips" style="color: red; font-size: 12pt; float: left;"></span>
		</div>
	</div>
</div>
<div class="pageContent" id="goodsBox" style="overflow: auto;">
</div>
</form>
<script type="text/javascript">
var $pagerForm = $("#pagerForm", navTab.getCurrentPanel());
//防止回车提交表单
$pagerForm.keydown(function(e){
	var e = e || event;
	  var keyNum = e.keyCode || e.which || e.charCode;
	  return keyNum==13 ? false : true;
});

//监听输入框回车 
function doKeydown(event, obj) {
	var theEvent = event || window.event;
	var code = theEvent.keyCode || theEvent.which || theEvent.charCode;
	if (code == 13) {
		prepareIndiv(obj.value);
	}
}

//扫描内容提示
function scanCode(message) {
	$("#scanCode", navTab.getCurrentPanel()).html(message);
	$("#errorTips", navTab.getCurrentPanel()).html("");
}

//错误提示
function errorTips(message) {
	$("#errorTips", navTab.getCurrentPanel()).html(message);
	soundError();
}

//商品配货
// 配货
function prepareIndiv(value) {
	scanCode(value);
	var codeInput = $("#indivCode2", navTab.getCurrentPanel());
	codeInput.attr("readonly", "readonly");
	codeInput.attr("class", "textInput readonly");
	$.ajax({
	   url: "${ctx}/stock/transPrepare!prepareIndiv.action",
	   data:$pagerForm.serialize(),
	   complete: function(){
	  		codeInput.removeAttr("readonly");
	  		codeInput.attr("class", "textInput");
	  		codeInput.val("");//清空输入框
	  		codeInput.focus();//聚焦输入框	  	 
	   },
	   success: function(data){
		   	if(data.ok==true) {
		   		var indiv = data.result;
		   		errorTips(data.message);
		   		$("#goodsBox").loadUrl("${ctx}/stock/transPrepare!loadGoods.action",$pagerForm.serialize(),confirmFinish);
		   	} else {
		   		errorTips(data.message);
		   		soundError();
		   		return false;
		   	}
	   },
	   error: function (XMLHttpRequest, textStatus, errorThrown) {     
			alert(errorThrown);     
		}
	});
}
/*
function addIndiv(code, transid) {
	$.ajax({
	   url: "${ctx}/stock/transPrepare!addIndiv.action" ,
	   data: "indivCode=" + code + "&transferId=" + transid,
	   success: function(data){
		   	if(data.ok==true) {
		   		// 更新商品个体列表
		   		$("#goodsBox").loadUrl("${ctx}/stock/transPrepare!loadGoods.action","transferId=" + transid,confirmFinish);
		   	} else {
		   		errorTips(data.message);
		   		return false;
		   	}
	   },
	   error: function (XMLHttpRequest, textStatus, errorThrown) {     
			alert(errorThrown);
		}
	});
}
*/
function confirmFinish() {
	var finished = $("#finished", navTab.getCurrentPanel());
	if(finished.val() == 'true') {
		$("#scanIndiv", navTab.getCurrentPanel()).find("dd").html("<span style=\"color:green;\">扫描已完成</span>");
		$("#scanShipping", navTab.getCurrentPanel()).show();
		$("#logisticNo", navTab.getCurrentPanel()).focus();
		return true;
	}
}

//提交物流单号 
function toSubmit(event, obj) {
	var theEvent = event || window.event;
	var code = theEvent.keyCode || theEvent.which || theEvent.charCode;
	if (code == 13) {
		$(obj).closest("form").submit();
	}
}

function batchPrepare(goodsId, quantity) {
	$.ajax({
		url:"${ctx}/stock/transPrepare!batchPrepare.action",
		data:"goodsId="+goodsId+"&preparedNum="+quantity,
		success: function(data){
		   	if(data.ok==true) {
		   		// 更新商品个体列表
		   		$("#goodsBox").loadUrl("${ctx}/stock/transPrepare!loadGoods.action",$pagerForm.serialize(),confirmFinish);
		   	} else {
		   		errorTips(data.message);
		   		return false;
		   	}
		},
		  error: function (XMLHttpRequest, textStatus, errorThrown) {     
			alert(errorThrown);
		}
	});
}

$(function(){
	// 页面初始化加载表单
	$("#goodsBox").loadUrl("${ctx}/stock/transPrepare!loadGoods.action",$pagerForm.serialize(),confirmFinish);
	setTimeout(function() {
		$("#indivCode2", navTab.getCurrentPanel()).focus();	
	},1000);
});
</script>
