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
					
					<form action="comment/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="COMMENT_ID" id="COMMENT_ID" value="${pd.COMMENT_ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">分享ID:</td>
								<td><input type="text" name="SHARE" id="SHARE" value="${pd.SHARE}" maxlength="255" placeholder="这里输入分享ID" title="分享ID" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">被评论者:</td>
								<td><input type="text" name="USER" id="USER" value="${pd.USER}" maxlength="255" placeholder="这里输入被评论者" title="被评论者" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">评论者:</td>
								<td><input type="text" name="COMMENT_USER" id="COMMENT_USER" value="${pd.COMMENT_USER}" maxlength="255" placeholder="这里输入评论者" title="评论者" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">时间:</td>
								<td><input type="text" name="TIME" id="TIME" value="${pd.TIME}" maxlength="255" placeholder="这里输入时间" title="时间" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">内容:</td>
								<td><input type="text" name="CONTENT" id="CONTENT" value="${pd.CONTENT}" maxlength="255" placeholder="这里输入内容" title="内容" style="width:98%;"/></td>
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
			if($("#SHARE").val()==""){
				$("#SHARE").tips({
					side:3,
		            msg:'请输入分享ID',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#SHARE").focus();
			return false;
			}
			if($("#USER").val()==""){
				$("#USER").tips({
					side:3,
		            msg:'请输入被评论者',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#USER").focus();
			return false;
			}
			if($("#COMMENT_USER").val()==""){
				$("#COMMENT_USER").tips({
					side:3,
		            msg:'请输入评论者',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#COMMENT_USER").focus();
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
			if($("#CONTENT").val()==""){
				$("#CONTENT").tips({
					side:3,
		            msg:'请输入内容',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#CONTENT").focus();
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