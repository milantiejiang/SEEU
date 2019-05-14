package com.fh.service.app.collection;

import java.util.List;
import com.fh.entity.Page;
import com.fh.util.PageData;

/** 
 * 说明： 分享收藏接口
 * 创建人：FH Q313596790
 * 创建时间：2016-11-23
 * @version
 */
public interface CollectionManager{

	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception;
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception;
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception;
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	public List<PageData> list(Page page)throws Exception;
	
	
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	public List<PageData> listAll(PageData pd)throws Exception;
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception;
	
	/**通过Shareid获取数据
	 * @param pd
	 * @throws Exception
	 */
	public List<PageData> findByShareId(PageData pd)throws Exception;
	
	/**通过Userid获取数据
	 * @param pd
	 * @throws Exception
	 */
	public List<PageData> findByUserId(Page page)throws Exception;
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception;
	
	/**判断是否有重复
	 * @param pd
	 * @throws Exception
	 */
	public PageData checkRepret(PageData pd)throws Exception;
	
	/**获取我的 收藏列表总数
	 * @param pd
	 * @throws Exception
	 */
	public PageData getMyCollectionCount(PageData pd)throws Exception;
	
	/**分享 收藏列表
	 * @param page
	 * @throws Exception
	 */
	public List<PageData> shareCollectionListPage(Page page)throws Exception;
	
	/**获取分享收藏列表总数
	 * @param pd
	 * @throws Exception
	 */
	public PageData getCollectionCount(PageData pd)throws Exception;
	
}

