package com.fh.service.app.userandpreferences.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.util.PageData;
import com.fh.service.app.userandpreferences.UserAndPreferencesManager;

/** 
 * 说明： 用户与用户喜好关系表
 * 创建人：FH Q313596790
 * 创建时间：2016-11-19
 * @version
 */
@Service("userandpreferencesService")
public class UserAndPreferencesService implements UserAndPreferencesManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		dao.save("UserAndPreferencesMapper.save", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		dao.delete("UserAndPreferencesMapper.delete", pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		dao.update("UserAndPreferencesMapper.edit", pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("UserAndPreferencesMapper.datalistPage", page);
	}
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("UserAndPreferencesMapper.listAll", pd);
	}
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("UserAndPreferencesMapper.findById", pd);
	}
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("UserAndPreferencesMapper.deleteAll", ArrayDATA_IDS);
	}

	@Override
	public void deleteByUIDAndPID(PageData pd) throws Exception {
		dao.delete("UserAndPreferencesMapper.deleteByUIDAndPID", pd);
	}

	@Override
	public List<PageData> findByUId(PageData pd) throws Exception {
		return (List<PageData>)dao.findForList("UserAndPreferencesMapper.findByUId", pd);
	}

	
	
}

