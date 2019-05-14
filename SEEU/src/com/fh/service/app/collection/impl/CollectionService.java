package com.fh.service.app.collection.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.util.PageData;
import com.fh.service.app.collection.CollectionManager;

/** 
 * 说明： 分享收藏
 * 创建人：FH Q313596790
 * 创建时间：2016-11-23
 * @version
 */
@Service("collectionService")
public class CollectionService implements CollectionManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		dao.save("CollectionMapper.save", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		dao.delete("CollectionMapper.delete", pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		dao.update("CollectionMapper.edit", pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("CollectionMapper.datalistPage", page);
	}
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("CollectionMapper.listAll", pd);
	}
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("CollectionMapper.findById", pd);
	}
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("CollectionMapper.deleteAll", ArrayDATA_IDS);
	}

	@Override
	public List<PageData> findByShareId(PageData pd) throws Exception {
		return (List<PageData>)dao.findForList("CollectionMapper.findByShareId", pd);
	}

	@Override
	public PageData checkRepret(PageData pd) throws Exception {
		return (PageData)dao.findForObject("CollectionMapper.checkRepret", pd);
	}

	@SuppressWarnings("unchecked")
	public List<PageData> findByUserId(Page page) throws Exception {
		return (List<PageData>)dao.findForList("CollectionMapper.findByUserIdlistPage", page);
	}

	@Override
	public PageData getMyCollectionCount(PageData pd) throws Exception {
		return (PageData)dao.findForObject("CollectionMapper.getUserCollectionCount", pd);
	}

	@Override
	public List<PageData> shareCollectionListPage(Page page) throws Exception {
		return (List<PageData>)dao.findForList("CollectionMapper.shareCollectionlistPage", page);
	}

	@Override
	public PageData getCollectionCount(PageData pd) throws Exception {
		return (PageData)dao.findForObject("CollectionMapper.getCollectionCount", pd);
	}
	
}

