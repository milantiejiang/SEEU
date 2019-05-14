<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
	<head>
	<base href="<%=basePath%>">
	<!-- 下拉框 -->
	<link rel="stylesheet" href="static/ace/css/chosen.css" />
	<!-- jsp文件头和头部 -->
	<%@ include file="../../system/index/top.jsp"%>
	<!-- 日期框 -->
	<link rel="stylesheet" href="static/ace/css/datepicker.css" />
</head>
<body class="no-skin">
<!-- /section:basics/navbar.layout -->
<div class="main-container" id="main-container">
	<!-- /section:basics/sidebar -->
	<div class="main-content">
		<div class="main-content-inner">
			<div class="page-content">
				<div class="row">
					<div class="col-xs-12">
					
					<form action="order/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="ORDER_ID" id="ORDER_ID" value="${pd.ORDER_ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">商品总金额:</td>
								<td><input type="number" name="GOODSMONEY" id="GOODSMONEY" value="${pd.GOODSMONEY}" maxlength="32" placeholder="这里输入商品总金额 商品总价格--未进行任何折扣的总价格" title="商品总金额 商品总价格--未进行任何折扣的总价格" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">运费:</td>
								<td><input type="number" name="DELIVERMONEY" id="DELIVERMONEY" value="${pd.DELIVERMONEY}" maxlength="32" placeholder="这里输入运费 运费规则按照每家店的规则算。" title="运费 运费规则按照每家店的规则算。" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">订单总金额:</td>
								<td><input type="number" name="TOTALMONEY" id="TOTALMONEY" value="${pd.TOTALMONEY}" maxlength="32" placeholder="这里输入订单总金额 包括运费" title="订单总金额 包括运费" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">实际订单总金额:</td>
								<td><input type="number" name="REALTOTALMONEY" id="REALTOTALMONEY" value="${pd.REALTOTALMONEY}" maxlength="32" placeholder="这里输入实际订单总金额 进行各种折扣之后的金额" title="实际订单总金额 进行各种折扣之后的金额" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">收货人名称:</td>
								<td><input type="text" name="USERNAME" id="USERNAME" value="${pd.USERNAME}" maxlength="20" placeholder="这里输入收货人名称" title="收货人名称" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">收件人地址:</td>
								<td><input type="text" name="USERADDRESS" id="USERADDRESS" value="${pd.USERADDRESS}" maxlength="255" placeholder="这里输入收件人地址" title="收件人地址" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">收件人手机	:</td>
								<td><input type="text" name="USERPHONE" id="USERPHONE" value="${pd.USERPHONE}" maxlength="11" placeholder="这里输入收件人手机	" title="收件人手机	" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">发票抬头:</td>
								<td><input type="text" name="INVOICECLIENT" id="INVOICECLIENT" value="${pd.INVOICECLIENT}" maxlength="255" placeholder="这里输入发票抬头" title="发票抬头" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">订单备注:</td>
								<td><input type="text" name="ORDERREMARKS" id="ORDERREMARKS" value="${pd.ORDERREMARKS}" maxlength="255" placeholder="这里输入订单备注	" title="订单备注	" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">拒收原因:</td>
								<td><input type="text" name="REJECTOTHERREASON" id="REJECTOTHERREASON" value="${pd.REJECTOTHERREASON}" maxlength="255" placeholder="这里输入拒收原因	" title="拒收原因	" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">订单流水号	:</td>
								<td><input type="text" name="ORDERUNIQUE" id="ORDERUNIQUE" value="${pd.ORDERUNIQUE}" maxlength="50" placeholder="这里输入订单流水号	" title="订单流水号	" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">收货时间:</td>
								<td><input class="span10 date-picker" name="RECEIVETIME" id="RECEIVETIME" value="${pd.RECEIVETIME}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="收货时间	" title="收货时间	" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">发货时间:</td>
								<td><input class="span10 date-picker" name="DELIVERYTIME" id="DELIVERYTIME" value="${pd.DELIVERYTIME}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="发货时间	" title="发货时间	" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">快递公司ID:</td>
								<td><input type="number" name="EXPRESSID" id="EXPRESSID" value="${pd.EXPRESSID}" maxlength="32" placeholder="这里输入快递公司ID	" title="快递公司ID	" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">快递号:</td>
								<td><input type="text" name="EXPRESSNO" id="EXPRESSNO" value="${pd.EXPRESSNO}" maxlength="20" placeholder="这里输入快递号	" title="快递号	" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">在线支付交易流水:</td>
								<td><input type="text" name="TRADENO" id="TRADENO" value="${pd.TRADENO}" maxlength="100" placeholder="这里输入在线支付交易流水	" title="在线支付交易流水	" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">订单应收佣金:</td>
								<td><input type="number" name="COMMISSIONFEE" id="COMMISSIONFEE" value="${pd.COMMISSIONFEE}" maxlength="32" placeholder="这里输入订单应收佣金	" title="订单应收佣金	" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="text-align: center;" colspan="10">
									<a class="btn btn-mini btn-primary" onclick="save();">保存</a>
									<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
								</td>
							</tr>
						</table>
						</div>
						<div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><br/><br/><img src="static/images/jiazai.gif" /><br/><h4 class="lighter block green">提交中...</h4></div>
					</form>
					</div>
					<!-- /.col -->
				</div>
				<!-- /.row -->
			</div>
			<!-- /.page-content -->
		</div>
	</div>
	<!-- /.main-content -->
</div>
<!-- /.main-container -->


	<!-- 页面底部js¨ -->
	<%@ include file="../../system/index/foot.jsp"%>
	<!-- 下拉框 -->
	<script src="static/ace/js/chosen.jquery.js"></script>
	<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
		<script type="text/javascript">
		$(top.hangge());
		//保存
		function save(){
			if($("#GOODSMONEY").val()==""){
				$("#GOODSMONEY").tips({
					side:3,
		            msg:'请输入商品总金额 商品总价格--未进行任何折扣的总价格',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#GOODSMONEY").focus();
			return false;
			}
			if($("#DELIVERMONEY").val()==""){
				$("#DELIVERMONEY").tips({
					side:3,
		            msg:'请输入运费 运费规则按照每家店的规则算。',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#DELIVERMONEY").focus();
			return false;
			}
			if($("#TOTALMONEY").val()==""){
				$("#TOTALMONEY").tips({
					side:3,
		            msg:'请输入订单总金额 包括运费',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#TOTALMONEY").focus();
			return false;
			}
			if($("#REALTOTALMONEY").val()==""){
				$("#REALTOTALMONEY").tips({
					side:3,
		            msg:'请输入实际订单总金额 进行各种折扣之后的金额',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#REALTOTALMONEY").focus();
			return false;
			}
			if($("#USERNAME").val()==""){
				$("#USERNAME").tips({
					side:3,
		            msg:'请输入收货人名称',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#USERNAME").focus();
			return false;
			}
			if($("#USERADDRESS").val()==""){
				$("#USERADDRESS").tips({
					side:3,
		            msg:'请输入收件人地址',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#USERADDRESS").focus();
			return false;
			}
			if($("#USERPHONE").val()==""){
				$("#USERPHONE").tips({
					side:3,
		            msg:'请输入收件人手机	',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#USERPHONE").focus();
			return false;
			}
			if($("#INVOICECLIENT").val()==""){
				$("#INVOICECLIENT").tips({
					side:3,
		            msg:'请输入发票抬头',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#INVOICECLIENT").focus();
			return false;
			}
			if($("#ORDERREMARKS").val()==""){
				$("#ORDERREMARKS").tips({
					side:3,
		            msg:'请输入订单备注	',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#ORDERREMARKS").focus();
			return false;
			}
			if($("#REJECTOTHERREASON").val()==""){
				$("#REJECTOTHERREASON").tips({
					side:3,
		            msg:'请输入拒收原因	',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#REJECTOTHERREASON").focus();
			return false;
			}
			if($("#ORDERUNIQUE").val()==""){
				$("#ORDERUNIQUE").tips({
					side:3,
		            msg:'请输入订单流水号	',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#ORDERUNIQUE").focus();
			return false;
			}
			if($("#RECEIVETIME").val()==""){
				$("#RECEIVETIME").tips({
					side:3,
		            msg:'请输入收货时间	',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#RECEIVETIME").focus();
			return false;
			}
			if($("#DELIVERYTIME").val()==""){
				$("#DELIVERYTIME").tips({
					side:3,
		            msg:'请输入发货时间	',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#DELIVERYTIME").focus();
			return false;
			}
			if($("#EXPRESSID").val()==""){
				$("#EXPRESSID").tips({
					side:3,
		            msg:'请输入快递公司ID	',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#EXPRESSID").focus();
			return false;
			}
			if($("#EXPRESSNO").val()==""){
				$("#EXPRESSNO").tips({
					side:3,
		            msg:'请输入快递号	',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#EXPRESSNO").focus();
			return false;
			}
			if($("#TRADENO").val()==""){
				$("#TRADENO").tips({
					side:3,
		            msg:'请输入在线支付交易流水	',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#TRADENO").focus();
			return false;
			}
			if($("#COMMISSIONFEE").val()==""){
				$("#COMMISSIONFEE").tips({
					side:3,
		            msg:'请输入订单应收佣金	',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#COMMISSIONFEE").focus();
			return false;
			}
			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}
		
		$(function() {
			//日期框
			$('.date-picker').datepicker({autoclose: true,todayHighlight: true});
		});
		</script>
</body>
</html>