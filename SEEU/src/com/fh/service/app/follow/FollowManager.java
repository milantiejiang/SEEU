package com.fh.service.app.follow;

import java.util.List;
import com.fh.entity.Page;
import com.fh.util.PageData;

/** 
 * 说明： 关注接口
 * 创建人：FH Q313596790
 * 创建时间：2016-12-10
 * @version
 */
public interface FollowManager{

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
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void unFollow(PageData pd)throws Exception;
	
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
	
	/**我的关注列表
	 * @param page
	 * @throws Exception
	 */
	public List<PageData> myFollowlist(Page page)throws Exception;
	
	/**关注我的列表
	 * @param page
	 * @throws Exception
	 */
	public List<PageData> followMelist(Page page)throws Exception;
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	public List<PageData> listAll(PageData pd)throws Exception;
	
	/**我的关注列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	public List<PageData> myFollowlistAll(PageData pd)throws Exception;
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception;
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception;
	/**获取我的关注列表总数
	 * @param pd
	 * @throws Exception
	 */
	public PageData getMyFollowCount(PageData pd)throws Exception;
	
	/**获取关注我的列表总数
	 * @param pd
	 * @throws Exception
	 */
	public PageData getFollowMeCount(PageData pd)throws Exception;
	
	/**检查关注是否已经存在
	 * @param pd
	 * @throws Exception
	 */
	public PageData checkfollow(PageData pd)throws Exception;
	
}

