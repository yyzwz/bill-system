package cn.zwz.modules.quartz.dao;

import cn.zwz.base.XbootBaseDao;
import cn.zwz.modules.quartz.entity.QuartzJob;

import java.util.List;

/**
 * 定时任务数据处理层
 * @author 郑为中
 */
public interface QuartzJobDao extends XbootBaseDao<QuartzJob,String> {

    /**
     * 通过类名获取
     * @param jobClassName
     * @return
     */
    List<QuartzJob> findByJobClassName(String jobClassName);
}