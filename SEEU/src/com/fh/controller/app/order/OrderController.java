package com.fh.controller.app.order;

import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.util.AppUtil;
import com.fh.util.ObjectExcelView;
import com.fh.util.PageData;
import com.fh.util.Jurisdiction;
import com.fh.util.Tools;
import com.fh.service.app.order.OrderManager;

/** 
 * 说明：订单
 * 创建人：FH Q313596790
 * 创建时间：2018-11-25
 */
@Controller
@RequestMapping(value="/apporder")
public class OrderController extends BaseController {
	
	@Resource(name="orderService")
	private OrderManager orderService;
	
	/**
	 * 创建订单
	 */
	@RequestMapping(value="/createorder")
	@ResponseBody
	public Object createorder(){
		Map<String, Object> map = new HashMap<String, Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("ORDER_ID", this.get32UUID());	//主键
		pd.put("ORDERNO", pd.getString("ORDERNO"));	//订单号
		pd.put("SHOPID", pd.getString("SHOPID"));	//门店ID
		pd.put("USERID", pd.getString("USERID"));	//用户ID 0：为0则说明是闪电购，游客直接下单
		pd.put("ORDERSTATUS", "-2");	//订单状态 -3:用户拒收 -2:未付款的订单 -1：用户取消 0:待发货 1:配送中 2:用户确认收货
		pd.put("DELIVERTYPE", pd.getString("DELIVERTYPE"));	//收货方式 0:送货上门 1:自提
		pd.put("PAYTYPE", pd.getString("PAYTYPE"));	//支付方式	 0:货到付款 1:在线支付
		pd.put("PAYFROM", pd.getString("PAYFROM"));	//支付来源	1:支付宝，2：微信	
		pd.put("ISPAY", pd.getString("ISPAY"));	//是否支付	0:未支付 1:已支付	
		pd.put("ORDERSCORE", pd.getString("ORDERSCORE"));	//所得积分	
		pd.put("ISINVOICE", pd.getString("ISINVOICE"));	//是否需要发票	1:需要 0:不需要	
		pd.put("ORDERSRC", pd.getString("ORDERSRC"));	//订单来源	0:商城 1:微信 2:手机版 3:安卓App 4:苹果App	
		pd.put("NEEDPAY", pd.getString("NEEDPAY"));	//需缴费用	
		pd.put("ISREFUND", pd.getString("ISREFUND"));	//是否退款	0:否 1：是	
		pd.put("ISAPPRAISE", pd.getString("ISAPPRAISE"));	//是否点评	0:未点评 1:已点评	
		pd.put("CANCELREASON", pd.getString("CANCELREASON"));	//取消原因ID	
		pd.put("REJECTREASON", pd.getString("REJECTREASON"));	//拒收原因ID	
		pd.put("ISCLOSED", pd.getString("ISCLOSED"));	//是否订单已完结0：未完结 1:已完结	
		pd.put("SETTLEMENTID", pd.getString("SETTLEMENTID"));	//是否结算，大于0的话则是结算ID	
		pd.put("DATAFLAG", "1");	//订单有效标志	-1：删除 1:有效	
		pd.put("CREATETIME", Tools.date2Str(new Date()));	//下单时间	
		pd.put("EXPRESSID", "0");
		try {
			orderService.save(pd);
			map.put("code", "100");
			map.put("message","create order sucess");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			map.put("code", "200");
			map.put("message","create order faile");
		}
		return AppUtil.returnObject(new PageData(), map);
	}

//	@RequestMapping(value="/getcode")
//	@ResponseBody
//	public Object getcode(){
//    	Map<String, Object> map = new HashMap<String, Object>();
//		PageData pd = new PageData();
//		pd = this.getPageData();
//		String code=pd.getString("CODE");
//		try {
//			map.put("code", "100");
//			map.put("message","sucess");
//		} catch (Exception e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//			map.put("code", "200");
//			map.put("message","faile");
//		}
//		return AppUtil.returnObject(new PageData(), map);
//    }
}
