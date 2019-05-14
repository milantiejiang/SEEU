package com.fh.service.app.fabulous.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.util.PageData;
import com.fh.service.app.fabulous.FabulousManager;

/** 
 * 说明： 分享点赞
 * 创建人：FH Q313596790
 * 创建时间：2016-11-23
 * @version
 */
@Service("fabulousService")
public class FabulousService implements FabulousManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		dao.save("FabulousMapper.save", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		dao.delete("FabulousMapper.delete", pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		dao.update("FabulousMapper.edit", pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("FabulousMapper.datalistPage", page);
	}
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("FabulousMapper.listAll", pd);
	}
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("FabulousMapper.findById", pd);
	}
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("FabulousMapper.deleteAll", ArrayDATA_IDS);
	}

	@Override
	public List<PageData> findByShareId(PageData pd) throws Exception {
		return (List<PageData>)dao.findForList("FabulousMapper.findByShareId", pd);
	}

	@Override
	public PageData checkRepret(PageData pd) throws Exception {
		return (PageData)dao.findForObject("FabulousMapper.checkRepret", pd);
	}

	@Override
	public List<PageData> shareFabulousListPage(Page page) throws Exception {
		return (List<PageData>)dao.findForList("FabulousMapper.shareFabulouslistPage", page);
	}

	@Override
	public PageData getFabulousCount(PageData pd) throws Exception {
		return (PageData)dao.findForObject("FabulousMapper.getFabulousCount", pd);
	}
	
}

