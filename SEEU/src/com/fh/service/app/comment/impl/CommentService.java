package com.fh.service.app.comment.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.util.PageData;
import com.fh.service.app.comment.CommentManager;

/** 
 * 说明： 分享评论
 * 创建人：FH Q313596790
 * 创建时间：2016-11-23
 * @version
 */
@Service("commentService")
public class CommentService implements CommentManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		dao.save("CommentMapper.save", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		dao.delete("CommentMapper.delete", pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		dao.update("CommentMapper.edit", pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("CommentMapper.datalistPage", page);
	}
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("CommentMapper.listAll", pd);
	}
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("CommentMapper.findById", pd);
	}
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("CommentMapper.deleteAll", ArrayDATA_IDS);
	}

	@Override
	public List<PageData> findByShareId(PageData pd) throws Exception {
		return (List<PageData>)dao.findForList("CommentMapper.findByShareId", pd);
	}

	@Override
	public List<PageData> shareCommentListPage(Page page) throws Exception {
		return (List<PageData>)dao.findForList("CommentMapper.shareCommentlistPage", page);
	}

	@Override
	public PageData getCommentCount(PageData pd) throws Exception {
		return (PageData)dao.findForObject("CommentMapper.getCommentCount", pd);
	}
	
}

