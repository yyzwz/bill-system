package cn.zwz.data.manage;

import cn.zwz.data.vo.OssSetting;
import io.swagger.annotations.ApiOperation;
import org.springframework.web.multipart.MultipartFile;

import java.io.InputStream;

/**
 * @author 郑为中
 */
public interface FileManage {

    @ApiOperation(value = "删除文件")
    void deleteFile(String key);

    @ApiOperation(value = "重命名文件")
    String renameFile(String fromKey, String toKey);

    @ApiOperation(value = "获取配置")
    OssSetting getOssSetting();

    @ApiOperation(value = "拷贝文件")
    String copyFile(String fromKey, String toKey);

    @ApiOperation(value = "文件流上传")
    String inputStreamUpload(InputStream inputStream, String key, MultipartFile file);
}
