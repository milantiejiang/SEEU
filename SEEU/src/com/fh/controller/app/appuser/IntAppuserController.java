package com.fh.controller.app.appuser;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.entity.system.IMG;
import com.fh.entity.system.UserPreferences;
import com.fh.service.app.comment.CommentManager;
import com.fh.service.app.follow.FollowManager;
import com.fh.service.app.img.IMGManager;
import com.fh.service.app.message.MessageManager;
import com.fh.service.app.share.ShareManager;
import com.fh.service.app.userandpreferences.UserAndPreferencesManager;
import com.fh.service.app.userpreferences.UserPreferencesManager;
import com.fh.service.appversion.appversion.AppversionManager;
import com.fh.service.system.appuser.AppuserManager;
import com.fh.util.AppUtil;
import com.fh.util.Const;
import com.fh.util.DateUtil;
import com.fh.util.FileUpload;
import com.fh.util.MD5;
import com.fh.util.PageData;
import com.fh.util.PathUtil;
import com.fh.util.SmsUtil;
import com.fh.util.Tools;

@Controller
@RequestMapping(value = "/appuser")
public class IntAppuserController extends BaseController {

	@Resource(name = "appuserService")
	private AppuserManager appuserService;
	@Resource(name = "imgService")
	private IMGManager imgService;
	@Resource(name = "userandpreferencesService")
	private UserAndPreferencesManager userandpreferencesService;
	@Resource(name = "userpreferencesService")
	private UserPreferencesManager userpreferencesService;
	@Resource(name = "appversionService")
	private AppversionManager appversionService;
	@Resource(name = "shareService")
	private ShareManager shareService;
	@Resource(name = "followService")
	private FollowManager followService;
	@Resource(name = "messageService")
	private MessageManager messageService;
	@Resource(name = "commentService")
	private CommentManager commentService;

	private boolean checkToken(PageData pd) {
		String username = pd.getString("USERNAME");
		String token = pd.getString("TOKEN");
		if (username != null && token != null) {
			try {
				pd = appuserService.checkToken(pd);
				if (pd != null) {
					return true;
				}
			} catch (Exception e) {
				e.printStackTrace();
				return false;
			}
		}
		return false;
	}

	/**
	 * @return
	 */
	@RequestMapping(value = "/getAppuserByUm")
	@ResponseBody
	public Object getAppuserByUsernmae() {
		Map<String, Object> map = new HashMap<String, Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		String result = "00";
		try {
			if (Tools.checkKey("USERNAME", pd.getString("FKEY"))) { 
				if (AppUtil.checkParam("getAppuserByUsernmae", pd)) { 
					pd = appuserService.findByUsername(pd);
					map.put("pd", pd);
					result = (null == pd) ? "02" : "01";
				} else {
					result = "03";
				}
			} else {
				result = "05";
			}
		} catch (Exception e) {
			logger.error(e.toString(), e);
		} finally {
			map.put("result", result);
			logAfter(logger);
		}
		return AppUtil.returnObject(new PageData(), map);
	}

	/**
	 * 
	 * @return
	 */
	@RequestMapping(value = "/checkUserName")
	@ResponseBody
	public Object checkUserName() {
		Map<String, Object> map = new HashMap<String, Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			if (appuserService.findByUsername(pd) != null) {
				map.put("result", "2");
			} else {
				map.put("result", "0");
			}
		} catch (Exception e) {
			e.printStackTrace();
			map.put("result", "1");
		}
		return AppUtil.returnObject(new PageData(), map);
	}

	/**
	 * @return
	 */
	@RequestMapping(value = "/register")
	@ResponseBody
	public Object appRegister() {
		Map<String, Object> map = new HashMap<String, Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			if (appuserService.findByUsername(pd) != null) {
				map.put("result", "2");
			} else {
				pd.put("ROLE_ID", "1b67fc82ce89457a8347ae53e43a347e");
				pd.put("USER_ID", this.get32UUID()); // ID
				pd.put("RIGHTS", "");
				pd.put("LAST_LOGIN", ""); 
				pd.put("IP", ""); // IP
				pd.put("PASSWORD", pd.getString("PASSWORD"));
				appuserService.saveU(pd);
				map.put("result", "0");
			}
		} catch (Exception e) {
			e.printStackTrace();
			map.put("result", "1");
		}
		return AppUtil.returnObject(new PageData(), map);
	}

	
	@RequestMapping(value = "/login")
	@ResponseBody
	public Object appLogin() {
		Map<String, Object> map = new HashMap<String, Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			pd = appuserService.getUserByNameAndPwd(pd);
			if (pd != null) {
				String token = this.get32UUID();
				pd.put("TOKEN", token);
				appuserService.editUTOKEN(pd);
				String icon = pd.getString("ICON");
				if (icon != null) {
					pd.put("ICON", getIMG(icon));
				}
				pd.put("PREFERENCES",
						getUserPreferences(pd.getString("USER_ID")));
				map.put("pd", pd);
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


	@RequestMapping(value = "/loginOut")
	@ResponseBody
	public Object loginOut() {
		Map<String, Object> map = new HashMap<String, Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		if (checkToken(pd)) {
			try {
				pd.put("TOKEN", "0");
				appuserService.editUTOKEN(pd);
				map.put("result", "0");
			} catch (Exception e) {
				e.printStackTrace();
				map.put("result", "1");
			}
		} else {
			map.put("result", "2");
		}
		return AppUtil.returnObject(new PageData(), map);
	}

	/**
	 * 
	 * @param icon
	 * @return
	 */

	private PageData getIMG(String id) {
		PageData pd = new PageData();
		pd.put("IMG_ID", id);
		// IMG img = new IMG();
		try {
			pd = imgService.findById(pd);
			// if(pd!=null){
			// img.setIMG_ID(pd.getString("IMG_ID"));
			// img.setIMG_PATH(pd.getString("IMG_PATH"));
			// int w = (Integer) pd.get("IMG_WITH");
			// int h = (Integer) pd.get("IMG_HIGH");
			// img.setIMG_WITH(w);
			// img.setIMG_HIGH(h);
			// }
		} catch (Exception e) {
			e.printStackTrace();
		}
		return pd;
	}

	/**
	 * 
	 * @param icon
	 * @return
	 */

	private List<UserPreferences> getUserPreferences(String id) {
		List<UserPreferences> pfList = new ArrayList();
		PageData pd = new PageData();
		pd.put("USER_ID", id);
		try {
			List<PageData> pl = userandpreferencesService.findByUId(pd);
			if (pl != null) {
				for (int i = 0; i < pl.size(); i++) {
					UserPreferences p = new UserPreferences();
					String pid = pl.get(i).getString("USERPREFERENCES_ID");
					p.setUSERPREFERENCES_ID(pid);
					pd.put("USERPREFERENCES_ID", pid);
					pd = userpreferencesService.findById(pd);
					p.setNAME(pd.getString("NAME"));
					pd.put("IMG_ID", pd.getString("ICON"));
					pd = imgService.findById(pd);
					IMG img = new IMG();
					img.setIMG_ID(pd.getString("IMG_ID"));
					img.setIMG_PATH(pd.getString("IMG_PATH"));
					int w = (Integer) pd.get("IMG_WITH");
					int h = (Integer) pd.get("IMG_HIGH");
					img.setIMG_WITH(w);
					img.setIMG_HIGH(h);
					p.setICON(img);
					pfList.add(p);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return pfList;
	}

	
	@RequestMapping(value = "/updateU")
	@ResponseBody
	public Object updateU() {
		Map<String, Object> map = new HashMap<String, Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		if (checkToken(pd)) {
			try {
				appuserService.editU(pd);
				pd = appuserService.findByUiId(pd);
				String icon = pd.getString("ICON");
				if (icon != null) {
					pd.put("ICON", getIMG(icon));
				}
				pd.put("PREFERENCES",
						getUserPreferences(pd.getString("USER_ID")));
				map.put("pd", pd);
				map.put("result", "0");
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				map.put("result", "1");
			}
		} else {
			map.put("result", "2");
		}
		return AppUtil.returnObject(new PageData(), map);
	}

	
	@RequestMapping(value = "/updateUIcon")
	@ResponseBody
	public Object updateUIcon() {
		Map<String, Object> map = new HashMap<String, Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		if (checkToken(pd)) {
			try {
				PageData imgpd = new PageData();
				String img_id = this.get32UUID();
				imgpd.put("IMG_ID", img_id); 
				imgpd.put("IMG_PATH", pd.getString("IMG_PATH"));
				imgpd.put("IMG_WITH", pd.get("IMG_WITH"));
				imgpd.put("IMG_HIGH", pd.get("IMG_HIGH"));
				imgService.save(imgpd);
				pd.put("ICON", img_id);
				appuserService.editUIcon(pd);
				pd = appuserService.findByUiId(pd);
				String icon = pd.getString("ICON");
				if (icon != null) {
					pd.put("ICON", getIMG(icon));
				}
				pd.put("PREFERENCES",
						getUserPreferences(pd.getString("USER_ID")));
				map.put("pd", pd);
				map.put("result", "0");
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				map.put("result", "1");
			}
		} else {
			map.put("result", "2");
		}
		return AppUtil.returnObject(new PageData(), map);
	}


	@RequestMapping(value = "/updateUName")
	@ResponseBody
	public Object updateUName() {
		Map<String, Object> map = new HashMap<String, Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		if (checkToken(pd)) {
			try {
				appuserService.editUName(pd);
				pd = appuserService.findByUiId(pd);
				String icon = pd.getString("ICON");
				if (icon != null) {
					pd.put("ICON", getIMG(icon));
				}
				pd.put("PREFERENCES",
						getUserPreferences(pd.getString("USER_ID")));
				map.put("pd", pd);
				map.put("result", "0");
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				map.put("result", "1");
			}
		} else {
			map.put("result", "2");
		}
		return AppUtil.returnObject(new PageData(), map);
	}


	@RequestMapping(value = "/updateUPassword")
	@ResponseBody
	public Object updateUPassword() {
		Map<String, Object> map = new HashMap<String, Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			appuserService.editUPassword(pd);
			map.put("result", "0");
		} catch (Exception e) {
			e.printStackTrace();
			map.put("result", "1");
		}
		return AppUtil.returnObject(new PageData(), map);
	}


	@RequestMapping(value = "/updateUCity")
	@ResponseBody
	public Object updateUCity() {
		Map<String, Object> map = new HashMap<String, Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		if (checkToken(pd)) {
			try {
				appuserService.editUCity(pd);
				pd = appuserService.findByUiId(pd);
				String icon = pd.getString("ICON");
				if (icon != null) {
					pd.put("ICON", getIMG(icon));
				}
				pd.put("PREFERENCES",
						getUserPreferences(pd.getString("USER_ID")));
				map.put("pd", pd);
				map.put("result", "0");
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				map.put("result", "1");
			}
		} else {
			map.put("result", "2");
		}
		return AppUtil.returnObject(new PageData(), map);
	}


	@RequestMapping(value = "/addULike")
	@ResponseBody
	public Object addULike() {
		Map<String, Object> map = new HashMap<String, Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		String ps = pd.getString("PREFERENCES");
		if (ps != null) {
			String[] pl = ps.split(",");
			try {
				if (pl != null && pl.length != 0) {
					for (int i = 0; i < pl.length; i++) {
						pd.put("USERANDPREFERENCES_ID", this.get32UUID()); // ID
						pd.put("USERPREFERENCES_ID", pl[i]);
						userandpreferencesService.save(pd);
					}
				}
				map.put("result", "0");
			} catch (Exception e) {
				map.put("result", "1");
				e.printStackTrace();
			}
		}

		return AppUtil.returnObject(new PageData(), map);
	}

	@RequestMapping(value = "/deleteULike")
	@ResponseBody
	public Object deleteULike() {
		Map<String, Object> map = new HashMap<String, Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		String ps = pd.getString("PREFERENCES");
		if (ps != null) {
			String[] pl = ps.split(",");
			try {
				if (pl != null && pl.length != 0) {
					for (int i = 0; i < pl.length; i++) {
						pd.put("USERPREFERENCES_ID", pl[i]);
						userandpreferencesService.deleteByUIDAndPID(pd);
					}
				}
				map.put("result", "0");
			} catch (Exception e) {
				map.put("result", "1");
				e.printStackTrace();
			}
		}

		return AppUtil.returnObject(new PageData(), map);
	}


	@RequestMapping(value = "/uploadimg")
	@ResponseBody
	public Object uploadimg(@RequestParam(required = false) MultipartFile file) {
		Map<String, Object> map = new HashMap<String, Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		String ffile = DateUtil.getDays(), fileName = "";
		String url = "";
		if (null != file && !file.isEmpty()) {
			String filePath = PathUtil.getClasspath() + Const.FILEPATHIMG
					+ ffile; 
			fileName = FileUpload.fileUp(file, filePath, this.get32UUID()); 
			url = Const.WEB_SERVICE_URL + Const.FILEPATHIMG + ffile + "/"
					+ fileName;
			System.out.println("***filePath:" + filePath + "***");
			pd.put("IMG_ID", this.get32UUID()); 
			pd.put("IMG_PATH", url);
			pd.put("IMG_WITH", pd.get("IMG_WITH"));
			pd.put("IMG_HIGH", pd.get("IMG_HIGH"));
			try {
				imgService.save(pd);
				map.put("pd", pd);
				map.put("result", "0");
			} catch (Exception e) {
				e.printStackTrace();
				map.put("result", "1");
			}
		} else {
			map.put("result", "1");
		}
		return AppUtil.returnObject(new PageData(), map);
	}

	
	@RequestMapping(value = "/uploadimgInfo")
	@ResponseBody
	public Object uploadimgInfo() {
		Map<String, Object> map = new HashMap<String, Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("IMG_ID", this.get32UUID()); 
		pd.put("IMG_PATH", pd.getString("IMG_PATH"));
		pd.put("IMG_WITH", pd.get("IMG_WITH"));
		pd.put("IMG_HIGH", pd.get("IMG_HIGH"));
		try {
			imgService.save(pd);
			map.put("pd", pd);
			map.put("result", "0");
		} catch (Exception e) {
			e.printStackTrace();
			map.put("result", "1");
		}
		return AppUtil.returnObject(new PageData(), map);
	}


	@RequestMapping(value = "/appVersionCheck")
	@ResponseBody
	public Object appVersionCheck() {
		Map<String, Object> map = new HashMap<String, Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		int theversioncode = Integer.parseInt(pd.getString("APPVERSION"));
		try {
			List<PageData> varList = appversionService.listAll(pd);
			if (varList != null && varList.size() != 0) {
				PageData p = varList.get(0);
				int versioncode = (Integer) p.get("APPVERSION_CODE");
				if (versioncode > theversioncode) {
					pd.put("APPVERSION_NAME", p.getString("APPVERSION_NAME"));
					pd.put("APPVERSION_CODE", p.get("APPVERSION_CODE"));
					pd.put("APPVERSION_DESCRIBE",
							p.getString("APPVERSION_DESCRIBE"));
					pd.put("APP_URL", p.getString("APP_URL"));
					map.put("pd", pd);
					map.put("result", "0");
				} else {
					map.put("result", "2");
				}
			}
		} catch (Exception e) {
			map.put("result", "1");
			e.printStackTrace();
		}
		return AppUtil.returnObject(new PageData(), map);
	}


	@RequestMapping(value = "/getUserShareCount")
	@ResponseBody
	public Object getUserShareCount() {
		Map<String, Object> map = new HashMap<String, Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		// if (checkToken(pd)) {
		try {
			PageData cp = shareService.getMyCount(pd);
			Long count = (Long) cp.get("shareCount");
			map.put("count", count);
			map.put("result", "0");
		} catch (Exception e) {
			map.put("result", "1");
			e.printStackTrace();
		}
		// } else {
		// map.put("result", "2");
		// }
		return AppUtil.returnObject(new PageData(), map);
	}

	
	@RequestMapping(value = "/getUserFollowCount")
	@ResponseBody
	public Object getUserFollowCount() {
		Map<String, Object> map = new HashMap<String, Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		// if (checkToken(pd)) {
		try {
			PageData cp = followService.getFollowMeCount(pd);
			Long count = (Long) cp.get("followCount");
			map.put("count", count);
			map.put("result", "0");
		} catch (Exception e) {
			map.put("result", "1");
			e.printStackTrace();
		}
		// } else {
		// map.put("result", "2");
		// }
		return AppUtil.returnObject(new PageData(), map);
	}

	
	@RequestMapping(value = "/getPhoneCode")
	@ResponseBody
	public Object getPhoneCode() {
		Map<String, Object> map = new HashMap<String, Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			boolean result = SmsUtil.SendSMS(pd.getString("PHONE"),
					pd.getString("CODE"), "5");
			if (result) {
				map.put("result", "0");
			} else {
				map.put("result", "2");
			}
		} catch (Exception e) {
			map.put("result", "1");
			e.printStackTrace();
		}
		return AppUtil.returnObject(new PageData(), map);
	}

	
	@RequestMapping(value = "/follow")
	@ResponseBody
	public Object follow() {
		Map<String, Object> map = new HashMap<String, Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		if (checkToken(pd)) {
			try {
				PageData cpd = followService.checkfollow(pd);
				if (cpd == null) {
					pd.put("FOLLOW_ID", this.get32UUID());
					followService.save(pd);
					map.put("result", "0");
				} else {
					map.put("result", "3");
				}
			} catch (Exception e) {
				map.put("result", "1");
				e.printStackTrace();
			}
		} else {
			map.put("result", "2");
		}
		return AppUtil.returnObject(new PageData(), map);
	}

	
	@RequestMapping(value = "/unfollow")
	@ResponseBody
	public Object unfollow() {
		Map<String, Object> map = new HashMap<String, Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		if (checkToken(pd)) {
			try {
				followService.unFollow(pd);
				map.put("result", "0");
			} catch (Exception e) {
				map.put("result", "1");
				e.printStackTrace();
			}
		} else {
			map.put("result", "2");
		}
		return AppUtil.returnObject(new PageData(), map);
	}

	
	@RequestMapping(value = "/getAllMyfollow")
	@ResponseBody
	public Object getAllMyfollow() {
		Map<String, Object> map = new HashMap<String, Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		// if (checkToken(pd)) {
		try {
			List<PageData> cls = followService.myFollowlistAll(pd);
			map.put("array", cls);
			map.put("result", "0");
		} catch (Exception e) {
			map.put("result", "1");
			e.printStackTrace();
		}
		// } else {
		// map.put("result", "2");
		// }
		return AppUtil.returnObject(new PageData(), map);
	}


	@RequestMapping(value = "/getFollowMe")
	@ResponseBody
	public Object getFollowMe() {
		Map<String, Object> map = new HashMap<String, Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		Page page = new Page();
		int currentPage = Integer.parseInt(pd.getString("CurrentPage"));
		page.setCurrentPage(currentPage);
		page.setShowCount(10);
		String keywords = pd.getString("keywords"); 
		if (null != keywords && !"".equals(keywords)) {
			pd.put("keywords", keywords.trim());
		}
		page.setPd(pd);
		List<PageData> varList;
		try {
			List<PageData> cls = followService.followMelist(page);
			if (cls != null) {
				pd.put("USER", keywords);
				PageData cp = followService.getFollowMeCount(pd);
				Long count = (Long) cp.get("followCount");
				Long l = count / 10;
				Long z = count % 10;
				if (z == 0) {
					if (currentPage > l) {
						map.put("result", "2");
					} else {
						varList = getFollowMeList(cls);
						map.put("array", varList);
						map.put("result", "0");
					}
				} else {
					if (currentPage > l + 1) {
						map.put("result", "2");
					} else {
						varList = getFollowMeList(cls);
						map.put("array", varList);
						map.put("result", "0");
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			map.put("result", "1");
		}
		return AppUtil.returnObject(new PageData(), map);
	}

	
	@RequestMapping(value = "/getMyfollow")
	@ResponseBody
	public Object getMyfollow() {
		Map<String, Object> map = new HashMap<String, Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		Page page = new Page();
		int currentPage = Integer.parseInt(pd.getString("CurrentPage"));
		page.setCurrentPage(currentPage);
		page.setShowCount(10);
		String keywords = pd.getString("keywords"); 
		if (null != keywords && !"".equals(keywords)) {
			pd.put("keywords", keywords.trim());
		}
		page.setPd(pd);
		List<PageData> varList;
		try {
			List<PageData> cls = followService.myFollowlist(page);
			if (cls != null) {
				pd.put("FOLLOW_USER", keywords);
				PageData cp = followService.getMyFollowCount(pd);
				Long count = (Long) cp.get("followCount");
				Long l = count / 10;
				Long z = count % 10;
				if (z == 0) {
					if (currentPage > l) {
						map.put("result", "2");
					} else {
						varList = getMyFollowList(cls);
						map.put("array", varList);
						map.put("result", "0");
					}
				} else {
					if (currentPage > l + 1) {
						map.put("result", "2");
					} else {
						varList = getMyFollowList(cls);
						map.put("array", varList);
						map.put("result", "0");
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			map.put("result", "1");
		}
		return AppUtil.returnObject(new PageData(), map);
	}

	private List<PageData> getFollowMeList(List<PageData> flm) {
		List<PageData> varList = new ArrayList<PageData>();
		PageData pd = new PageData();
		for (int i = 0; i < flm.size(); i++) {
			try {
				pd.put("USER_ID", flm.get(i).getString("FOLLOW_USER"));
				PageData userPd = appuserService.findByUiId(pd);
				PageData img = new PageData();
				img.put("IMG_ID", userPd.getString("ICON"));
				img = imgService.findById(img);
				userPd.put("ICON", img);
				if (userPd != null) {
					varList.add(userPd);
				}
			} catch (Exception e) {

			}
		}
		return varList;
	}

	private List<PageData> getMyFollowList(List<PageData> mfl) {
		List<PageData> varList = new ArrayList<PageData>();
		PageData pd = new PageData();
		for (int i = 0; i < mfl.size(); i++) {
			try {
				pd.put("USER_ID", mfl.get(i).getString("USER"));
				PageData userPd = appuserService.findByUiId(pd);
				PageData img = new PageData();
				img.put("IMG_ID", userPd.getString("ICON"));
				img = imgService.findById(img);
				userPd.put("ICON", img);
				if (userPd != null) {
					varList.add(userPd);
				}
			} catch (Exception e) {

			}
		}
		return varList;
	}


	@RequestMapping(value = "/message")
	@ResponseBody
	public Object message() {
		Map<String, Object> map = new HashMap<String, Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		if (checkToken(pd)) {
			try {
				List<PageData> varList = messageService.myMsglistAll(pd);
				if (varList != null && varList.size() != 0) {
					map.put("array", varList);
					map.put("result", "0");
				} else {
					map.put("result", "2");
				}
			} catch (Exception e) {
				map.put("result", "1");
				e.printStackTrace();
			}
		}

		return AppUtil.returnObject(new PageData(), map);
	}

	@RequestMapping(value = "/messageDetail")
	@ResponseBody
	public Object messageDetail() {
		Map<String, Object> map = new HashMap<String, Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		if (checkToken(pd)) {
			try {
				List<PageData> varList = messageService.myMsglistAll(pd);
				if (varList != null && varList.size() != 0) {
					map.put("array", getCollectionList(varList));
					map.put("result", "0");
				} else {
					map.put("result", "2");
				}
			} catch (Exception e) {
				map.put("result", "1");
				e.printStackTrace();
			}
		}

		return AppUtil.returnObject(new PageData(), map);
	}

	private List<PageData> getCollectionList(List<PageData> list) {
		PageData pd = new PageData();
		try {
			for (int i = 0; i < list.size(); i++) {
				PageData commentPd = new PageData();
				pd.put("COMMENT_ID", list.get(i).getString("COMMENT"));
				commentPd = commentService.findById(pd);
				commentPd.put("COMMENT_USER", getUserPd(commentPd.getString("COMMENT_USER")));
				commentPd.put("USER", getUserPd(commentPd.getString("USER")));
				list.get(i).put("COMMENT", commentPd);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	
	private PageData getUserPd(String userid){
		PageData userPd = new PageData();
		userPd.put("USER_ID", userid);
		try {
			userPd = appuserService.findByUiId(userPd);
			PageData img = new PageData();
			img.put("IMG_ID", userPd.getString("ICON"));
			img = imgService.findById(img);
			userPd.put("ICON", img);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return userPd;
	}

	@RequestMapping(value = "/updateMsgState")
	@ResponseBody
	public Object updateMsgState() {
		Map<String, Object> map = new HashMap<String, Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		if (checkToken(pd)) {
			try {
				String msgids=pd.getString("MESSAGE_ID");
				String[] strlist=msgids.split(",");
				if(strlist!=null){
					for(int i=0;i<strlist.length;i++){
						pd.put("MESSAGE_ID", strlist[i]);
						messageService.editMsgState(pd);
					}
				}
				map.put("result", "0");
			} catch (Exception e) {
				map.put("result", "1");
				e.printStackTrace();
			}
		}

		return AppUtil.returnObject(new PageData(), map);
	}
}
