package com.fh.service.app.share.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.util.PageData;
import com.fh.service.app.share.ShareManager;

/** 
 * 说明： 分享
 * 创建人：FH Q313596790
 * 创建时间：2016-11-23
 * @version
 */
@Service("shareService")
public class ShareService implements ShareManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		dao.save("ShareMapper.save", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		dao.delete("ShareMapper.delete", pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		dao.update("ShareMapper.edit", pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("ShareMapper.datalistPage", page);
	}
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("ShareMapper.listAll", pd);
	}
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("ShareMapper.findById", pd);
	}
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("ShareMapper.deleteAll", ArrayDATA_IDS);
	}

	@Override
	public PageData getCount(String str) throws Exception {
		// TODO Auto-generated method stub
		return (PageData)dao.findForObject("ShareMapper.getShareCount", str);
	}

	@Override
	public PageData getMyCount(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		return (PageData)dao.findForObject("ShareMapper.getMyShareCount", pd);
	}

	@Override
	public List<PageData> mylistAll(PageData pd) throws Exception {
		return (List<PageData>)dao.findForList("ShareMapper.mylistAll", pd);
	}

	@Override
	public List<PageData> searchlist(Page page) throws Exception {
		return (List<PageData>)dao.findForList("ShareMapper.searchlistPage", page);
	}

	@Override
	public PageData getSearchCount(PageData pd) throws Exception {
		return (PageData)dao.findForObject("ShareMapper.getSearchShareCount", pd);
	}
	
}

