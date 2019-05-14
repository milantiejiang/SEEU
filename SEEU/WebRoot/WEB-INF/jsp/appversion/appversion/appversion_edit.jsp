<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
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

							<form action="appversion/${msg }.do" name="Form" id="Form"
								method="post" enctype="multipart/form-data">
								<input type="hidden" name="APPVERSION_ID" id="APPVERSION_ID"
									value="${pd.APPVERSION_ID}" />
								<div id="zhongxin" style="padding-top: 13px;">
									<table id="table_report"
										class="table table-striped table-bordered table-hover">
							
										<tr>
											<td style="width:75px;text-align: right;padding-top: 13px;">版本名称:</td>
											<td><input type="text" name="APPVERSION_NAME"
												id="APPVERSION_NAME" value="${pd.APPVERSION_NAME}"
												maxlength="255" placeholder="这里输入版本名称" title="版本名称"
												style="width:98%;" />
												*版本名称不能重复 例如：fakie_1.0.*
											</td>
										</tr>
										<tr>
											<td style="width:75px;text-align: right;padding-top: 13px;">描述:</td>
											<td><input type="text" name="APPVERSION_DESCRIBE"
												id="APPVERSION_DESCRIBE" value="${pd.APPVERSION_DESCRIBE}"
												maxlength="500" placeholder="这里输入描述" title="描述"
												style="width:98%;" />
											</td>
										</tr>
										<tr>
											<td style="width:75px;text-align: right;padding-top: 13px;">APP版本号:</td>
											<td><input type="number" name="APPVERSION_CODE" id="APPVERSION_CODE"
												value="${pd.APPVERSION_CODE}" maxlength="500"
												placeholder="APP版本号" title="APP版本号" style="width:98%;" />
												*版本号值要比上一个版本大*
											</td>
										</tr>
										<tr>
											<td style="width:75px;text-align: right;padding-top: 13px;">APP安装文件:</td>
											<td><input type="file" name="myfiles" id="myfiles" accept=".apk"
												 maxlength="500"
												placeholder="请选择APP安装文件" title="APP安装文件" style="width:98%;" />
											</td>
										</tr>
										<tr>
											<td style="text-align: center;" colspan="10"><a
												class="btn btn-mini btn-primary" onclick="save();">保存</a> <a
												class="btn btn-mini btn-danger"
												onclick="top.Dialog.close();">取消</a></td>
										</tr>
									</table>
								</div>
								<div id="zhongxin2" class="center" style="display:none">
									<br /> <br /> <br /> <br /> <br /> <img
										src="static/images/jiazai.gif" /><br />
									<h4 class="lighter block green">提交中...</h4>
								</div>
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
		function save() {
			if ($("#APPVERSION_NAME").val() == "") {
				$("#APPVERSION_NAME").tips({
					side : 3,
					msg : '请输入版本名称',
					bg : '#AE81FF',
					time : 2
				});
				$("#APPVERSION_NAME").focus();
				return false;
			}
			if ($("#APPVERSION_DESCRIBE").val() == "") {
				$("#APPVERSION_DESCRIBE").tips({
					side : 3,
					msg : '请输入描述',
					bg : '#AE81FF',
					time : 2
				});
				$("#APPVERSION_DESCRIBE").focus();
				return false;
			}
			if ($("#APP_URL").val() == "") {
				$("#APP_URL").tips({
					side : 3,
					msg : '请输入app下载地址',
					bg : '#AE81FF',
					time : 2
				});
				$("#APP_URL").focus();
				return false;
			}
			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}

		$(function() {
			//日期框
			$('.date-picker').datepicker({
				autoclose : true,
				todayHighlight : true
			});
		});
	</script>
</body>
</html>