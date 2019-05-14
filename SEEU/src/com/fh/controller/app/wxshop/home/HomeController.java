package com.fh.controller.app.wxshop.home;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.fh.controller.base.BaseController;
import com.fh.util.AppUtil;
import com.fh.util.PageData;
import com.fh.service.app.banner.BannerManager;

/** 
 * 说明：banner
 * 创建人：FH Q313596790
 * 创建时间：2018-10-26
 */
@Controller
@RequestMapping(value="/wxshop/home")
public class HomeController extends BaseController {
	@Resource(name="bannerService")
	private BannerManager bannerService;
	
	@RequestMapping(value = "/banners")
	@ResponseBody
	public Object applist() {
		Map<String, Object> map = new HashMap<String, Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("STATE",0);
		try {
			List<PageData> cls  = bannerService.banners(pd);
			if (pd != null) {
				map.put("array", cls);
				map.put("result", "0");
			} else {
				map.put("result", "2");
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			map.put("result", "1");
		}
		return AppUtil.returnObject(new PageData(), map);
	}
}
