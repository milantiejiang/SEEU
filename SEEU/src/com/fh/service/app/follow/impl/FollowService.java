package com.fh.service.app.follow.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.util.PageData;
import com.fh.service.app.follow.FollowManager;

/** 
 * 说明： 关注
 * 创建人：FH Q313596790
 * 创建时间：2016-12-10
 * @version
 */
@Service("followService")
public class FollowService implements FollowManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		dao.save("FollowMapper.save", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		dao.delete("FollowMapper.delete", pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		dao.update("FollowMapper.edit", pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("FollowMapper.datalistPage", page);
	}
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("FollowMapper.listAll", pd);
	}
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("FollowMapper.findById", pd);
	}
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("FollowMapper.deleteAll", ArrayDATA_IDS);
	}

	@Override
	public void unFollow(PageData pd) throws Exception {
		dao.delete("FollowMapper.unFollow", pd);
	}

	@Override
	public PageData getMyFollowCount(PageData pd) throws Exception {
		return (PageData)dao.findForObject("FollowMapper.getMyFollowCount", pd);
	}

	@Override
	public PageData getFollowMeCount(PageData pd) throws Exception {
		return (PageData)dao.findForObject("FollowMapper.getFollowMeCount", pd);

	}

	@Override
	public List<PageData> myFollowlist(Page page) throws Exception {
		return (List<PageData>)dao.findForList("FollowMapper.myfollowlistPage", page);
	}

	@Override
	public List<PageData> followMelist(Page page) throws Exception {
		return (List<PageData>)dao.findForList("FollowMapper.followMelistPage", page);
	}

	@Override
	public List<PageData> myFollowlistAll(PageData pd) throws Exception {
		return (List<PageData>)dao.findForList("FollowMapper.allmyfollowList", pd);
	}

	@Override
	public PageData checkfollow(PageData pd) throws Exception {
		return (PageData)dao.findForObject("FollowMapper.checkfollow", pd);
	}
	
}

