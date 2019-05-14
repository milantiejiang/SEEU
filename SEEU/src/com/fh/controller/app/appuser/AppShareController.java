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
import org.springframework.web.servlet.ModelAndView;

import sun.rmi.runtime.Log;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.entity.system.IMG;
import com.fh.entity.system.UserPreferences;
import com.fh.service.app.collection.CollectionManager;
import com.fh.service.app.comment.CommentManager;
import com.fh.service.app.fabulous.FabulousManager;
import com.fh.service.app.img.IMGManager;
import com.fh.service.app.message.MessageManager;
import com.fh.service.app.share.ShareManager;
import com.fh.service.app.userandpreferences.UserAndPreferencesManager;
import com.fh.service.app.userpreferences.UserPreferencesManager;
import com.fh.service.system.appuser.AppuserManager;
import com.fh.util.AppUtil;
import com.fh.util.Const;
import com.fh.util.DateUtil;
import com.fh.util.FileUpload;
import com.fh.util.Jurisdiction;
import com.fh.util.MD5;
import com.fh.util.PageData;
import com.fh.util.PathUtil;
import com.fh.util.Tools;

/**
 * @author FH Q313596790 会员-接口类 相关参数协议： 00 请求失败 01 请求成功 02 返回空值 03 请求协议参数不完整 04
 *         用户名或密码错误 05 FKEY验证失败
 */
@Controller
@RequestMapping(value = "/appshare")
public class AppShareController extends BaseController {

	@Resource(name = "appuserService")
	private AppuserManager appuserService;
	@Resource(name = "imgService")
	private IMGManager imgService;
	@Resource(name = "userandpreferencesService")
	private UserAndPreferencesManager userandpreferencesService;
	@Resource(name = "userpreferencesService")
	private UserPreferencesManager userpreferencesService;
	@Resource(name = "shareService")
	private ShareManager shareService;
	@Resource(name = "collectionService")
	private CollectionManager collectionService;
	@Resource(name = "commentService")
	private CommentManager commentService;
	@Resource(name = "fabulousService")
	private FabulousManager fabulousService;
	@Resource(name="messageService")
	private MessageManager messageService;

	/**
	 * TOKEN 检查
	 */
	private boolean checkToken(PageData pd) {
		try {
			pd = appuserService.checkToken(pd);
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		if (pd != null) {
			return true;
		}
		return false;

	}

	/**
	 * 列表
	 * 
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value = "/list")
	@ResponseBody
	public Object list() {
		Map<String, Object> map = new HashMap<String, Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		Page page = new Page();
		int currentPage = Integer.parseInt(pd.getString("CurrentPage"));
		page.setCurrentPage(currentPage);
		page.setShowCount(10);
		String keywords = pd.getString("keywords"); // 关键词检索条件
		if (null != keywords && !"".equals(keywords)) {
			pd.put("keywords", keywords.trim());
		}
		page.setPd(pd);
		List<PageData> varList;
		try {
			// varList = getShareList(page);
			// map.put("array", varList);
			// map.put("result", "0");
			PageData cp = shareService.getCount("");
			Long count = (Long) cp.get("shareCount");
			Long l = count / 10;
			Long z = count % 10;
			if (z == 0) {
				if (currentPage > l) {
					varList = getShareList(page);
					map.put("array", varList);
					map.put("result", "2");// 没有更多数据
				} else {
					varList = getShareList(page);
					map.put("array", varList);
					map.put("result", "0");
				}
			} else {
				if (currentPage > l + 1) {
					varList = getShareList(page);
					map.put("array", varList);
					map.put("result", "2");// 没有更多数据
				} else {
					varList = getShareList(page);
					map.put("array", varList);
					map.put("result", "0");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			map.put("result", "1");
		}
		return AppUtil.returnObject(new PageData(), map);
	}
	
	/**
	 * 根据条件查找分享列表
	 * 
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value = "/searchSharelist")
	@ResponseBody
	public Object searchSharelist() {
		Map<String, Object> map = new HashMap<String, Object>();
		PageData pd = new PageData();
		pd = this.getPageData();

		Page page = new Page();
		int currentPage = Integer.parseInt(pd.getString("CurrentPage"));
		page.setCurrentPage(currentPage);
		page.setShowCount(10);
		String keywords = pd.getString("keywords"); // 关键词检索条件
		if (null != keywords && !"".equals(keywords)) {
			pd.put("keywords", keywords.trim());
		}
		page.setPd(pd);
		List<PageData> varList;
		try {
			PageData cpd=new PageData();
			cpd.put("keywords", keywords);
			PageData cp = shareService.getSearchCount(cpd);
			Long count = (Long) cp.get("shareCount");
			Long l = count / 10;
			Long z = count % 10;
			if (z == 0) {
				if (currentPage > l) {
					varList = getSearchShareList(page);
					map.put("array", varList);
					map.put("result", "2");// 没有更多数据
				} else {
					varList = getSearchShareList(page);
					map.put("array", varList);
					map.put("result", "0");
				}
			} else {
				if (currentPage > l + 1) {
					varList = getSearchShareList(page);
					map.put("array", varList);
					map.put("result", "2");// 没有更多数据
				} else {
					varList = getSearchShareList(page);
					map.put("array", varList);
					map.put("result", "0");
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
			map.put("result", "1");
		}
		return AppUtil.returnObject(new PageData(), map);
	}
	
	private List<PageData> getSearchShareList(Page page) throws Exception {
		List<PageData> varList = shareService.searchlist(page);
		if (varList != null && varList.size() != 0) {

			for (int i = 0; i < varList.size(); i++) {
				// 分享ID
				String shareID = varList.get(i).getString("SHARE_ID");
				// 用户
				String user = varList.get(i).getString("USER");
				PageData userPd = new PageData();
				userPd.put("USER_ID", user);
				userPd = appuserService.findByUiId(userPd);
				/* 用户头像 */
				PageData img = new PageData();
				img.put("IMG_ID", userPd.getString("ICON"));
				img = imgService.findById(img);
				userPd.put("ICON", img);
				varList.get(i).put("USER", userPd);
				// 图片
				String image = varList.get(i).getString("IMAGE");
				PageData imagePd = new PageData();
				imagePd.put("IMG_ID", image);
				imagePd = imgService.findById(imagePd);
				varList.get(i).put("IMAGE", imagePd);
				// 分享类型
				String type = varList.get(i).getString("SHARE_TYPE");
				if (type != null) {
					PageData typePd = new PageData();
					typePd.put("USERPREFERENCES_ID", type);
					typePd = userpreferencesService.findById(typePd);
					typePd.put("ICON", null);
					varList.get(i).put("SHARE_TYPE", typePd);
				}

				// 点赞
				PageData fabulousPd = new PageData();
				fabulousPd.put("SHARE", shareID);
				List<PageData> list = fabulousService.findByShareId(fabulousPd);
				varList.get(i).put("FABULOUS", list.size());
				// 收藏
				PageData collectionPd = new PageData();
				collectionPd.put("SHARE", shareID);
				List<PageData> list1 = collectionService
						.findByShareId(collectionPd);
				varList.get(i).put("COLLECTION", list1.size());
				// 评论
				PageData commentPd = new PageData();
				commentPd.put("SHARE", shareID);
				List<PageData> list2 = commentService.findByShareId(commentPd);
				varList.get(i).put("COMMENT", list2.size());
			}
		}
		return varList;
	}

	/**
	 * 我的分享列表
	 * 
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value = "/mySharelist")
	@ResponseBody
	public Object mySharelist() {
		Map<String, Object> map = new HashMap<String, Object>();
		PageData pd = new PageData();
		pd = this.getPageData();

		Page page = new Page();
		int currentPage = Integer.parseInt(pd.getString("CurrentPage"));
		page.setCurrentPage(currentPage);
		page.setShowCount(10);
		String keywords = pd.getString("keywords"); // 关键词检索条件
		if (null != keywords && !"".equals(keywords)) {
			pd.put("keywords", keywords.trim());
		}
		page.setPd(pd);
		List<PageData> varList;
		try {
			pd.put("USER", keywords);
			// List<PageData> allList=shareService.mylistAll(pd);//获取所有
			PageData cp = shareService.getMyCount(pd);
			Long count = (Long) cp.get("shareCount");
			Long l = count / 10;
			Long z = count % 10;
			if (z == 0) {
				if (currentPage > l) {
					map.put("result", "2");// 没有更多数据
				} else {
					varList = getShareList(page);
					map.put("array", varList);
					map.put("result", "0");
				}
			} else {
				if (currentPage > l + 1) {
					map.put("result", "2");// 没有更多数据
				} else {
					varList = getShareList(page);
					map.put("array", varList);
					map.put("result", "0");
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
			map.put("result", "1");
		}
		return AppUtil.returnObject(new PageData(), map);
	}

	private List<PageData> getShareList(Page page) throws Exception {
		List<PageData> varList = shareService.list(page);
		if (varList != null && varList.size() != 0) {

			for (int i = 0; i < varList.size(); i++) {
				// 分享ID
				String shareID = varList.get(i).getString("SHARE_ID");
				// 用户
				String user = varList.get(i).getString("USER");
				PageData userPd = new PageData();
				userPd.put("USER_ID", user);
				userPd = appuserService.findByUiId(userPd);
				/* 用户头像 */
				PageData img = new PageData();
				img.put("IMG_ID", userPd.getString("ICON"));
				img = imgService.findById(img);
				userPd.put("ICON", img);
				varList.get(i).put("USER", userPd);
				// 图片
				String image = varList.get(i).getString("IMAGE");
				PageData imagePd = new PageData();
				imagePd.put("IMG_ID", image);
				imagePd = imgService.findById(imagePd);
				varList.get(i).put("IMAGE", imagePd);
				// 分享类型
				String type = varList.get(i).getString("SHARE_TYPE");
				if (type != null) {
					PageData typePd = new PageData();
					typePd.put("USERPREFERENCES_ID", type);
					typePd = userpreferencesService.findById(typePd);
					typePd.put("ICON", null);
					varList.get(i).put("SHARE_TYPE", typePd);
				}

				// 点赞
				PageData fabulousPd = new PageData();
				fabulousPd.put("SHARE", shareID);
				List<PageData> list = fabulousService.findByShareId(fabulousPd);
				varList.get(i).put("FABULOUS", list.size());
				// 收藏
				PageData collectionPd = new PageData();
				collectionPd.put("SHARE", shareID);
				List<PageData> list1 = collectionService
						.findByShareId(collectionPd);
				varList.get(i).put("COLLECTION", list1.size());
				// 评论
				PageData commentPd = new PageData();
				commentPd.put("SHARE", shareID);
				List<PageData> list2 = commentService.findByShareId(commentPd);
				varList.get(i).put("COMMENT", list2.size());
			}
		}
		return varList;
	}

	/**
	 * 我的收藏列表
	 * 
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value = "/myCollectionlist")
	@ResponseBody
	public Object myCollectionlist() {
		Map<String, Object> map = new HashMap<String, Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		Page page = new Page();
		int currentPage = Integer.parseInt(pd.getString("CurrentPage"));
		page.setCurrentPage(currentPage);
		page.setShowCount(10);
		String keywords = pd.getString("keywords"); // 关键词检索条件
		if (null != keywords && !"".equals(keywords)) {
			pd.put("keywords", keywords.trim());
		}
		page.setPd(pd);
		List<PageData> varList;
		try {
			List<PageData> cls = collectionService.findByUserId(page);
			if (cls != null) {
				pd.put("USER", keywords);
				PageData cp = collectionService.getMyCollectionCount(pd);
				Long count = (Long) cp.get("CollectionCount");
				Long l = count / 10;
				Long z = count % 10;
				if (z == 0) {
					if (currentPage > l) {
						map.put("result", "2");// 没有更多数据
					} else {
						varList = getShareList(cls);
						map.put("array", varList);
						map.put("result", "0");
					}
				} else {
					if (currentPage > l + 1) {
						map.put("result", "2");// 没有更多数据
					} else {
						varList = getShareList(cls);
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

	private List<PageData> getShareList(List<PageData> cls) throws Exception {
		List<PageData> varList = new ArrayList<PageData>();
		PageData pd = new PageData();
		for (int i = 0; i < cls.size(); i++) {
			pd.put("SHARE_ID", cls.get(i).getString("SHARE"));
			PageData sharePd = shareService.findById(pd);
			if (sharePd != null) {
				varList.add(sharePd);
			}
		}
		if (varList != null && varList.size() != 0) {

			for (int i = 0; i < varList.size(); i++) {
				// 分享ID
				String shareID = varList.get(i).getString("SHARE_ID");
				// 用户
				String user = varList.get(i).getString("USER");
				PageData userPd = new PageData();
				userPd.put("USER_ID", user);
				userPd = appuserService.findByUiId(userPd);
				/* 用户头像 */
				PageData img = new PageData();
				img.put("IMG_ID", userPd.getString("ICON"));
				img = imgService.findById(img);
				userPd.put("ICON", img);
				varList.get(i).put("USER", userPd);
				// 图片
				String image = varList.get(i).getString("IMAGE");
				PageData imagePd = new PageData();
				imagePd.put("IMG_ID", image);
				imagePd = imgService.findById(imagePd);
				varList.get(i).put("IMAGE", imagePd);
				// 分享类型
				String type = varList.get(i).getString("SHARE_TYPE");
				if (type != null) {
					PageData typePd = new PageData();
					typePd.put("USERPREFERENCES_ID", type);
					typePd = userpreferencesService.findById(typePd);
					typePd.put("ICON", null);
					varList.get(i).put("SHARE_TYPE", typePd);
				}

				// 点赞
				PageData fabulousPd = new PageData();
				fabulousPd.put("SHARE", shareID);
				List<PageData> list = fabulousService.findByShareId(fabulousPd);
				varList.get(i).put("FABULOUS", list.size());
				// 收藏
				PageData collectionPd = new PageData();
				collectionPd.put("SHARE", shareID);
				List<PageData> list1 = collectionService
						.findByShareId(collectionPd);
				varList.get(i).put("COLLECTION", list1.size());
				// 评论
				PageData commentPd = new PageData();
				commentPd.put("SHARE", shareID);
				List<PageData> list2 = commentService.findByShareId(commentPd);
				varList.get(i).put("COMMENT", list2.size());
			}
		}
		return varList;
	}

	/**
	 * 发布分享
	 */
	@RequestMapping(value = "/sendShare")
	@ResponseBody
	public Object sendShare() {
		Map<String, Object> map = new HashMap<String, Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		if (!checkToken(pd)) {
			map.put("result", "2");// token无效
			return AppUtil.returnObject(new PageData(), map);
		}
		try {
			PageData imgpd=new PageData();
			String img_id=this.get32UUID();
			imgpd.put("IMG_ID", img_id); // 主键
			imgpd.put("IMG_PATH", pd.getString("IMG_PATH"));
			imgpd.put("IMG_WITH", pd.get("IMG_WITH"));
			imgpd.put("IMG_HIGH", pd.get("IMG_HIGH"));
			imgService.save(imgpd);
			pd.put("SHARE_ID", this.get32UUID()); // 主键
			pd.put("TIME", DateUtil.getDay1());
			pd.put("IMAGE", img_id);
			shareService.save(pd);
			map.put("pd", pd);
			map.put("result", "0");
		} catch (Exception e) {
			e.printStackTrace();
			map.put("result", "1");
		}
		return AppUtil.returnObject(new PageData(), map);
	}

	/**
	 * 收藏
	 */
	@RequestMapping(value = "/collection")
	@ResponseBody
	public Object collection() {
		Map<String, Object> map = new HashMap<String, Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		if (!checkToken(pd)) {
			map.put("result", "2");// token无效
			return AppUtil.returnObject(new PageData(), map);
		}
		try {
			PageData repPd = collectionService.checkRepret(pd);
			if (repPd == null) {
				String collection_id=this.get32UUID();
				pd.put("COLLECTION_ID", collection_id); // 主键
				pd.put("TIME", DateUtil.getDay1());
				collectionService.save(pd);
				map.put("pd", pd);
				map.put("result", "0");
			} else {
				map.put("result", "3");// 有重复
			}
		} catch (Exception e) {
			e.printStackTrace();
			map.put("result", "1");
		}
		return AppUtil.returnObject(new PageData(), map);
	}

	/**
	 * 点赞
	 */
	@RequestMapping(value = "/fabulous")
	@ResponseBody
	public Object fabulous() {
		Map<String, Object> map = new HashMap<String, Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		if (!checkToken(pd)) {
			map.put("result", "2");// token无效
			return AppUtil.returnObject(new PageData(), map);
		}
		try {
			PageData repPd = fabulousService.checkRepret(pd);
			if (repPd == null) {
				String fabulous_id=this.get32UUID();
				pd.put("FABULOUS_ID", fabulous_id); // 主键
				pd.put("TIME", DateUtil.getDay1());
				fabulousService.save(pd);
				map.put("pd", pd);
				map.put("result", "0");
			} else {
				map.put("result", "3");// 有重复
			}
		} catch (Exception e) {
			e.printStackTrace();
			map.put("result", "1");
		}
		return AppUtil.returnObject(new PageData(), map);
	}

	/**
	 * 评论
	 */
	@RequestMapping(value = "/comment")
	@ResponseBody
	public Object comment() {
		Map<String, Object> map = new HashMap<String, Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		if (!checkToken(pd)) {
			map.put("result", "2");// token无效
			return AppUtil.returnObject(new PageData(), map);
		}
		try {
			String comment_id=this.get32UUID();
			pd.put("COMMENT_ID", comment_id); // 主键
			pd.put("TIME", DateUtil.getDay1());
			commentService.save(pd);
			PageData msgPd=new PageData();
			msgPd.put("MESSAGE_ID", this.get32UUID());
			msgPd.put("TIME", DateUtil.getDay1());
			msgPd.put("ISREAD", 0);//0未读，1已读
			msgPd.put("USER", pd.getString("USER"));
			msgPd.put("COMMENT", comment_id);
			messageService.save(msgPd);
			map.put("pd", pd);
			map.put("result", "0");
		} catch (Exception e) {
			e.printStackTrace();
			map.put("result", "1");
		}
		return AppUtil.returnObject(new PageData(), map);
	}
	
	/**
	 * 获取分享的点赞人
	 */
	@RequestMapping(value = "/getShareFabulousUser")
	@ResponseBody
	public Object getShareFabulousUser() {
		Map<String, Object> map = new HashMap<String, Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		Page page = new Page();
		int currentPage = Integer.parseInt(pd.getString("CurrentPage"));
		page.setCurrentPage(currentPage);
		page.setShowCount(10);
		String keywords = pd.getString("keywords"); // 关键词检索条件
		if (null != keywords && !"".equals(keywords)) {
			pd.put("keywords", keywords.trim());
		}
		page.setPd(pd);
		List<PageData> varList;
		try {
			List<PageData> cls = fabulousService.shareFabulousListPage(page);
			if (cls != null) {
				pd.put("SHARE", keywords);
				PageData cp = fabulousService.getFabulousCount(pd);
				Long count = (Long) cp.get("fabulousCount");
				Long l = count / 10;
				Long z = count % 10;
				if (z == 0) {
					if (currentPage > l) {
						map.put("result", "2");// 没有更多数据
					} else {
						varList = getUserList(cls);
						map.put("array", varList);
						map.put("result", "0");
					}
				} else {
					if (currentPage > l + 1) {
						map.put("result", "2");// 没有更多数据
					} else {
						varList = getUserList(cls);
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
	
	/**
	 * 获取分享的收藏人
	 */
	@RequestMapping(value = "/getShareCollectionUser")
	@ResponseBody
	public Object getShareCollectionUser() {
		Map<String, Object> map = new HashMap<String, Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		Page page = new Page();
		int currentPage = Integer.parseInt(pd.getString("CurrentPage"));
		page.setCurrentPage(currentPage);
		page.setShowCount(10);
		String keywords = pd.getString("keywords"); // 关键词检索条件
		if (null != keywords && !"".equals(keywords)) {
			pd.put("keywords", keywords.trim());
		}
		page.setPd(pd);
		List<PageData> varList;
		try {
			List<PageData> cls = collectionService.shareCollectionListPage(page);
			if (cls != null) {
				pd.put("SHARE", keywords);
				PageData cp = collectionService.getCollectionCount(pd);
				Long count = (Long) cp.get("collectionCount");
				Long l = count / 10;
				Long z = count % 10;
				if (z == 0) {
					if (currentPage > l) {
						map.put("result", "2");// 没有更多数据
					} else {
						varList = getUserList(cls);
						map.put("array", varList);
						map.put("result", "0");
					}
				} else {
					if (currentPage > l + 1) {
						map.put("result", "2");// 没有更多数据
					} else {
						varList = getUserList(cls);
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
	
	/**
	 * 获取分享的评论
	 */
	@RequestMapping(value = "/getShareComment")
	@ResponseBody
	public Object getShareComment() {
		Map<String, Object> map = new HashMap<String, Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		Page page = new Page();
		int currentPage = Integer.parseInt(pd.getString("CurrentPage"));
		page.setCurrentPage(currentPage);
		page.setShowCount(10);
		String keywords = pd.getString("keywords"); // 关键词检索条件
		if (null != keywords && !"".equals(keywords)) {
			pd.put("keywords", keywords.trim());
		}
		page.setPd(pd);
		List<PageData> varList;
		try {
			List<PageData> cls = commentService.shareCommentListPage(page);
			if (cls != null) {
				pd.put("SHARE", keywords);
				PageData cp = commentService.getCommentCount(pd);
				Long count = (Long) cp.get("commentCount");
				Long l = count / 10;
				Long z = count % 10;
				if (z == 0) {
					if (currentPage > l) {
						map.put("result", "2");// 没有更多数据
					} else {
						varList = getCommentList(cls);
						map.put("array", varList);
						map.put("result", "0");
					}
				} else {
					if (currentPage > l + 1) {
						map.put("result", "2");// 没有更多数据
					} else {
						varList = getCommentList(cls);
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
	
	private List<PageData> getUserList(List<PageData> mfl) {
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
	
	private List<PageData> getCommentList(List<PageData> mfl) {
		for (int i = 0; i < mfl.size(); i++) {
			mfl.get(i).put("USER", getUser(mfl.get(i).getString("USER")));
			mfl.get(i).put("COMMENT_USER", getUser(mfl.get(i).getString("COMMENT_USER")));
		}
		return mfl;
	}
	
	private PageData getUser(String user){
		PageData pd=new PageData();
		try {
			pd.put("USER_ID", user);
			pd = appuserService.findByUiId(pd);
			PageData img = new PageData();
			img.put("IMG_ID", pd.getString("ICON"));
			img = imgService.findById(img);
			pd.put("ICON", img);
		} catch (Exception e) {

		}
		return pd;
	}
}
