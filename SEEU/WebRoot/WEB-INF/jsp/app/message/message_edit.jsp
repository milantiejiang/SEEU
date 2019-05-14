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
					
					<form action="message/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="MESSAGE_ID" id="MESSAGE_ID" value="${pd.MESSAGE_ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">评论消息:</td>
								<td><input type="text" name="COMMENT" id="COMMENT" value="${pd.COMMENT}" maxlength="255" placeholder="这里输入评论消息" title="评论消息" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">收藏消息:</td>
								<td><input type="text" name="COLLECTION" id="COLLECTION" value="${pd.COLLECTION}" maxlength="255" placeholder="这里输入收藏消息" title="收藏消息" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">点赞消息:</td>
								<td><input type="text" name="FABULOUS" id="FABULOUS" value="${pd.FABULOUS}" maxlength="255" placeholder="这里输入点赞消息" title="点赞消息" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">时间:</td>
								<td><input type="text" name="TIME" id="TIME" value="${pd.TIME}" maxlength="255" placeholder="这里输入时间" title="时间" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">是否已读标记:</td>
								<td><input type="number" name="ISREAD" id="ISREAD" value="${pd.ISREAD}" maxlength="32" placeholder="这里输入是否已读标记" title="是否已读标记" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">用户:</td>
								<td><input type="text" name="USER" id="USER" value="${pd.USER}" maxlength="255" placeholder="这里输入用户" title="用户" style="width:98%;"/></td>
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
			if($("#COMMENT").val()==""){
				$("#COMMENT").tips({
					side:3,
		            msg:'请输入评论消息',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#COMMENT").focus();
			return false;
			}
			if($("#COLLECTION").val()==""){
				$("#COLLECTION").tips({
					side:3,
		            msg:'请输入收藏消息',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#COLLECTION").focus();
			return false;
			}
			if($("#FABULOUS").val()==""){
				$("#FABULOUS").tips({
					side:3,
		            msg:'请输入点赞消息',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#FABULOUS").focus();
			return false;
			}
			if($("#TIME").val()==""){
				$("#TIME").tips({
					side:3,
		            msg:'请输入时间',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#TIME").focus();
			return false;
			}
			if($("#ISREAD").val()==""){
				$("#ISREAD").tips({
					side:3,
		            msg:'请输入是否已读标记',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#ISREAD").focus();
			return false;
			}
			if($("#USER").val()==""){
				$("#USER").tips({
					side:3,
		            msg:'请输入用户',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#USER").focus();
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