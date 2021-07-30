package cn.zwz.modules.quartz.service;

import cn.zwz.base.XbootBaseService;
import cn.zwz.modules.quartz.entity.QuartzJob;

import java.util.List;

/**
 * 定时任务接口
 * @author 郑为中
 */
public interface QuartzJobService extends XbootBaseService<QuartzJob,String> {

    /**
     * 通过类名获取
     * @param jobClassName
     * @return
     */
    List<QuartzJob> findByJobClassName(String jobClassName);
}