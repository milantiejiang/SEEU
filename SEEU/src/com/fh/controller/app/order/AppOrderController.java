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
@RequestMapping(value="/order")
public class AppOrderController extends BaseController {
	
	String menuUrl = "order/list.do"; //菜单地址(权限用)
	@Resource(name="orderService")
	private OrderManager orderService;
	
	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增Order");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("ORDER_ID", this.get32UUID());	//主键
		pd.put("ORDERNO", "0");	//订单号
		pd.put("SHOPID", "0");	//门店ID
		pd.put("USERID", "0");	//用户ID 0：为0则说明是闪电购，游客直接下单
		pd.put("ORDERSTATUS", "-2");	//订单状态 -3:用户拒收 -2:未付款的订单 -1：用户取消 0:待发货 1:配送中 2:用户确认收货
		pd.put("DELIVERTYPE", "0");	//收货方式 0:送货上门 1:自提
		pd.put("PAYTYPE", "0");	//支付方式	 0:货到付款 1:在线支付
		pd.put("PAYFROM", "0");	//支付来源	1:支付宝，2：微信	
		pd.put("ISPAY", "0");	//是否支付	0:未支付 1:已支付	
		pd.put("ORDERSCORE", "0");	//所得积分	
		pd.put("ISINVOICE", "0");	//是否需要发票	1:需要 0:不需要	
		pd.put("ORDERSRC", "0");	//订单来源	0:商城 1:微信 2:手机版 3:安卓App 4:苹果App	
		pd.put("NEEDPAY", "0");	//需缴费用	
		pd.put("ISREFUND", "0");	//是否退款	0:否 1：是	
		pd.put("ISAPPRAISE", "0");	//是否点评	0:未点评 1:已点评	
		pd.put("CANCELREASON", "0");	//取消原因ID	
		pd.put("REJECTREASON", "0");	//拒收原因ID	
		pd.put("ISCLOSED", "0");	//是否订单已完结0：未完结 1:已完结	
		pd.put("SETTLEMENTID", "0");	//是否结算，大于0的话则是结算ID	
		pd.put("DATAFLAG", "1");	//订单有效标志	-1：删除 1:有效	
		pd.put("CREATETIME", Tools.date2Str(new Date()));	//下单时间	
		orderService.save(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	
	
	/**删除
	 * @param out
	 * @throws Exception
	 */
	@RequestMapping(value="/delete")
	public void delete(PrintWriter out) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"删除Order");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		orderService.delete(pd);
		out.write("success");
		out.close();
	}
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改Order");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		orderService.edit(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表Order");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		page.setPd(pd);
		List<PageData>	varList = orderService.list(page);	//列出Order列表
		mv.setViewName("app/order/order_list");
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		return mv;
	}
	
	/**去新增页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goAdd")
	public ModelAndView goAdd()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		mv.setViewName("app/order/order_edit");
		mv.addObject("msg", "save");
		mv.addObject("pd", pd);
		return mv;
	}	
	
	 /**去修改页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goEdit")
	public ModelAndView goEdit()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = orderService.findById(pd);	//根据ID读取
		mv.setViewName("app/order/order_edit");
		mv.addObject("msg", "edit");
		mv.addObject("pd", pd);
		return mv;
	}	
	
	 /**批量删除
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/deleteAll")
	@ResponseBody
	public Object deleteAll() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"批量删除Order");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			orderService.deleteAll(ArrayDATA_IDS);
			pd.put("msg", "ok");
		}else{
			pd.put("msg", "no");
		}
		pdList.add(pd);
		map.put("list", pdList);
		return AppUtil.returnObject(pd, map);
	}
	
	 /**导出到excel
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/excel")
	public ModelAndView exportExcel() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"导出Order到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("订单号");	//1
		titles.add("门店ID");	//2
		titles.add("用户ID 0：为0则说明是闪电购，游客直接下单");	//3
		titles.add("订单状态 -3:用户拒收 -2:未付款的订单 -1：用户取消 0:待发货 1:配送中 2:用户确认收货");	//4
		titles.add("商品总金额 商品总价格--未进行任何折扣的总价格");	//5
		titles.add("收货方式 0:送货上门 1:自提");	//6
		titles.add("运费 运费规则按照每家店的规则算。");	//7
		titles.add("订单总金额 包括运费");	//8
		titles.add("实际订单总金额 进行各种折扣之后的金额");	//9
		titles.add("支付方式	 0:货到付款 1:在线支付");	//10
		titles.add("支付来源	1:支付宝，2：微信	");	//11
		titles.add("是否支付	0:未支付 1:已支付	");	//12
		titles.add("收货人名称");	//13
		titles.add("收件人地址");	//14
		titles.add("收件人手机	");	//15
		titles.add("所得积分	");	//16
		titles.add("是否需要发票	1:需要 0:不需要	");	//17
		titles.add("发票抬头");	//18
		titles.add("订单备注	");	//19
		titles.add("订单来源	0:商城 1:微信 2:手机版 3:安卓App 4:苹果App	");	//20
		titles.add("需缴费用	");	//21
		titles.add("是否退款	0:否 1：是	");	//22
		titles.add("是否点评	0:未点评 1:已点评	");	//23
		titles.add("取消原因ID	");	//24
		titles.add("拒收原因ID	");	//25
		titles.add("拒收原因	");	//26
		titles.add("是否订单已完结0：未完结 1:已完结	");	//27
		titles.add("订单流水号	");	//28
		titles.add("是否结算，大于0的话则是结算ID	");	//29
		titles.add("收货时间	");	//30
		titles.add("发货时间	");	//31
		titles.add("快递公司ID	");	//32
		titles.add("快递号	");	//33
		titles.add("在线支付交易流水	");	//34
		titles.add("订单有效标志	-1：删除 1:有效	");	//35
		titles.add("下单时间	");	//36
		titles.add("订单应收佣金	");	//37
		dataMap.put("titles", titles);
		List<PageData> varOList = orderService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("ORDERNO"));	    //1
			vpd.put("var2", varOList.get(i).get("SHOPID").toString());	//2
			vpd.put("var3", varOList.get(i).get("USERID").toString());	//3
			vpd.put("var4", varOList.get(i).get("ORDERSTATUS").toString());	//4
			vpd.put("var5", varOList.get(i).get("GOODSMONEY").toString());	//5
			vpd.put("var6", varOList.get(i).get("DELIVERTYPE").toString());	//6
			vpd.put("var7", varOList.get(i).get("DELIVERMONEY").toString());	//7
			vpd.put("var8", varOList.get(i).get("TOTALMONEY").toString());	//8
			vpd.put("var9", varOList.get(i).get("REALTOTALMONEY").toString());	//9
			vpd.put("var10", varOList.get(i).get("PAYTYPE").toString());	//10
			vpd.put("var11", varOList.get(i).get("PAYFROM").toString());	//11
			vpd.put("var12", varOList.get(i).get("ISPAY").toString());	//12
			vpd.put("var13", varOList.get(i).getString("USERNAME"));	    //13
			vpd.put("var14", varOList.get(i).getString("USERADDRESS"));	    //14
			vpd.put("var15", varOList.get(i).getString("USERPHONE"));	    //15
			vpd.put("var16", varOList.get(i).get("ORDERSCORE").toString());	//16
			vpd.put("var17", varOList.get(i).get("ISINVOICE").toString());	//17
			vpd.put("var18", varOList.get(i).getString("INVOICECLIENT"));	    //18
			vpd.put("var19", varOList.get(i).getString("ORDERREMARKS"));	    //19
			vpd.put("var20", varOList.get(i).get("ORDERSRC").toString());	//20
			vpd.put("var21", varOList.get(i).get("NEEDPAY").toString());	//21
			vpd.put("var22", varOList.get(i).get("ISREFUND").toString());	//22
			vpd.put("var23", varOList.get(i).get("ISAPPRAISE").toString());	//23
			vpd.put("var24", varOList.get(i).get("CANCELREASON").toString());	//24
			vpd.put("var25", varOList.get(i).get("REJECTREASON").toString());	//25
			vpd.put("var26", varOList.get(i).getString("REJECTOTHERREASON"));	    //26
			vpd.put("var27", varOList.get(i).get("ISCLOSED").toString());	//27
			vpd.put("var28", varOList.get(i).getString("ORDERUNIQUE"));	    //28
			vpd.put("var29", varOList.get(i).get("SETTLEMENTID").toString());	//29
			vpd.put("var30", varOList.get(i).getString("RECEIVETIME"));	    //30
			vpd.put("var31", varOList.get(i).getString("DELIVERYTIME"));	    //31
			vpd.put("var32", varOList.get(i).get("EXPRESSID").toString());	//32
			vpd.put("var33", varOList.get(i).getString("EXPRESSNO"));	    //33
			vpd.put("var34", varOList.get(i).getString("TRADENO"));	    //34
			vpd.put("var35", varOList.get(i).get("DATAFLAG").toString());	//35
			vpd.put("var36", varOList.get(i).getString("CREATETIME"));	    //36
			vpd.put("var37", varOList.get(i).get("COMMISSIONFEE").toString());	//37
			varList.add(vpd);
		}
		dataMap.put("varList", varList);
		ObjectExcelView erv = new ObjectExcelView();
		mv = new ModelAndView(erv,dataMap);
		return mv;
	}
	
	@InitBinder
	public void initBinder(WebDataBinder binder){
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
	}
}
