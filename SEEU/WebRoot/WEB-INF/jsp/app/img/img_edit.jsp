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

							<form action="img/${msg }.do" name="Form" id="Form" method="post"
								enctype="multipart/form-data">
								<input type="hidden" name="IMG_ID" id="IMG_ID"
									value="${pd.IMG_ID}" />
								<div id="zhongxin" style="padding-top: 13px;">
									<table id="table_report"
										class="table table-striped table-bordered table-hover">
										<!--  
										<tr>
											<td style="width:75px;text-align: right;padding-top: 13px;">URL路径:</td>
											<td><input type="text" name="IMG_PATH" id="IMG_PATH"
												value="${pd.IMG_PATH}" maxlength="500"
												placeholder="这里输入URL路径" title="URL路径" style="width:98%;" />
											</td>
										</tr>
										<tr>
											<td style="width:75px;text-align: right;padding-top: 13px;">宽:</td>
											<td><input type="number" name="IMG_WITH" id="IMG_WITH"
												value="${pd.IMG_WITH}" maxlength="32" placeholder="这里输入宽"
												title="宽" style="width:98%;" />
											</td>
										</tr>
										<tr>
											<td style="width:75px;text-align: right;padding-top: 13px;">高:</td>
											<td><input type="number" name="IMG_HIGH" id="IMG_HIGH"
												value="${pd.IMG_HIGH}" maxlength="32" placeholder="这里输入高"
												title="高" style="width:98%;" />
											</td>
										</tr>-->
										<tr>
											<td style="width:75px;text-align: right;padding-top: 13px;">图片:</td>
											<td><input type="file" name="myfiles" id="myfiles"
												accept=".jpg" maxlength="500" placeholder="图片"
												title="图片" style="width:98%;" /></td>
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
									<br />
									<br />
									<br />
									<br />
									<br />
									<img src="static/images/jiazai.gif" /><br />
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
			if ($("#IMG_PATH").val() == "") {
				$("#IMG_PATH").tips({
					side : 3,
					msg : '请输入URL路径',
					bg : '#AE81FF',
					time : 2
				});
				$("#IMG_PATH").focus();
				return false;
			}
			if ($("#IMG_WITH").val() == "") {
				$("#IMG_WITH").tips({
					side : 3,
					msg : '请输入宽',
					bg : '#AE81FF',
					time : 2
				});
				$("#IMG_WITH").focus();
				return false;
			}
			if ($("#IMG_HIGH").val() == "") {
				$("#IMG_HIGH").tips({
					side : 3,
					msg : '请输入高',
					bg : '#AE81FF',
					time : 2
				});
				$("#IMG_HIGH").focus();
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