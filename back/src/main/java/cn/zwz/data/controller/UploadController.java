package cn.zwz.data.controller;

import cn.zwz.basics.utils.*;
import cn.zwz.data.manage.impl.LocalFileManage;
import cn.zwz.data.service.IFileService;
import cn.zwz.data.service.ISettingService;
import cn.zwz.data.vo.OssSetting;
import cn.zwz.basics.baseVo.Result;
import cn.zwz.data.entity.File;
import cn.hutool.core.util.StrUtil;
import com.google.gson.Gson;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.InputStream;

/**
 * @author 郑为中
 */
@RestController
@Api(tags = "文件上传")
@RequestMapping("/zwz/upload")
@Transactional
public class UploadController {

    @Autowired
    private LocalFileManage localFileManage;

    @Autowired
    private ISettingService iSettingService;

    @Autowired
    private IFileService iFileService;

    @RequestMapping(value = "/file", method = RequestMethod.POST)
    @ApiOperation(value = "文件上传")
    public Result<Object> upload(@RequestParam(required = false) MultipartFile file,@RequestParam(required = false) String base64) {
        if(StrUtil.isNotBlank(base64)){
            file = Base64DecodeMultipartFile.base64Convert(base64);
        }
        String result = null;
        String fKey = CommonUtil.renamePic(file.getOriginalFilename());
        File f = new File();
        try {
            InputStream inputStream = file.getInputStream();
            result = localFileManage.inputStreamUpload(inputStream, fKey, file);
            f.setLocation(0);
            f.setName(file.getOriginalFilename());
            f.setSize(file.getSize());
            f.setType(file.getContentType());
            f.setFKey(fKey);
            f.setUrl(result);
            iFileService.saveOrUpdate(f);
        } catch (Exception e) {
            return ResultUtil.error(e.toString());
        }
        OssSetting ossSetting = new Gson().fromJson(iSettingService.getById("LOCAL_OSS").getValue(), OssSetting.class);
        return ResultUtil.data(ossSetting.getHttp() + ossSetting.getEndpoint() + "/" + f.getId());
    }
}
