package cn.zwz.basics.code;

import cn.zwz.basics.code.bean.Entity;
import cn.zwz.basics.code.bean.Item;
import cn.hutool.core.util.StrUtil;
import cn.zwz.basics.exception.ZwzException;
import com.baomidou.mybatisplus.annotation.TableField;
import io.swagger.annotations.ApiModelProperty;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.beetl.core.Configuration;
import org.beetl.core.GroupTemplate;
import org.beetl.core.Template;
import org.beetl.core.resource.ClasspathResourceLoader;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;

/**
 * 代码生成器
 * @author 郑为中
 */
@Slf4j
public class MyBatisPlusCodeUtils {

    @ApiOperation(value = "生成代码")
    public static void main(String[] args) throws Exception {
        ClasspathResourceLoader resourceLoader = new ClasspathResourceLoader("/btl/");
        GroupTemplate gt = new GroupTemplate(resourceLoader, Configuration.defaultConfiguration());
        // 生成代码
        generateCode(gt);
        // 读取实体类
        generatePlus(gt);
        // 删除代码
        // deleteCode(className);
    }

    @ApiModelProperty(value = "类名")
    private static final String className = "Student";

    @ApiModelProperty(value = "类备注")
    private static final String description = "学生";

    @ApiModelProperty(value = "作者")
    private static final String author = "郑为中";

    @ApiModelProperty(value = "数据库表前缀")
    private static final String tablePre = "t_";

    @ApiModelProperty(value = "主键类型")
    private static final String primaryKeyType = "String";

    @ApiModelProperty(value = "实体类对应包")
    private static final String entityPackage = "cn.zwz.data.entity";

    @ApiModelProperty(value = "dao对应包")
    private static final String daoPackage = "cn.zwz.data.mapper";

    @ApiModelProperty(value = "service对应包")
    private static final String servicePackage = "cn.zwz.data.service";

    @ApiModelProperty(value = "serviceImpl对应包")
    private static final String serviceImplPackage = "cn.zwz.data.serviceimpl";

    @ApiModelProperty(value = "controller对应包")
    private static final String controllerPackage = "cn.zwz.data.controller";

    @ApiOperation(value = "生成代码")
    private static void generateCode(GroupTemplate gt) throws IOException{
        Template entityTemplate = gt.getTemplate("entity.btl");
        Template daoTemplate = gt.getTemplate("mapper.btl");
        Template serviceTemplate = gt.getTemplate("mpService.btl");
        Template serviceImplTemplate = gt.getTemplate("mpServiceImpl.btl");
        Template controllerTemplate = gt.getTemplate("mpController.btl");
        Template mapperXmlTemplate = gt.getTemplate("mapperXml.btl");
        Entity entity = new Entity();
        entity.setEntityPackage(entityPackage);
        entity.setDaoPackage(daoPackage);
        entity.setServicePackage(servicePackage);
        entity.setServiceImplPackage(serviceImplPackage);
        entity.setControllerPackage(controllerPackage);
        entity.setAuthor(author);
        entity.setClassName(name(className, true));
        entity.setTableName(tablePre+camel2Underline(className));
        entity.setClassNameLowerCase(name(className, false));
        entity.setDescription(description);
        entity.setPrimaryKeyType(primaryKeyType);
        entity.setActiviti(false);
        entity.setIsTree(false);
        OutputStream out = null;
        /**
         * 生成实体类代码
         */
        entityTemplate.binding("entity", entity);
        String entityRrender = entityTemplate.render();
        System.out.println(entityRrender);
        String entityFileUrl = System.getProperty("user.dir")+"/src/main/java/"+ dotToLine(entityPackage) + "/" + className + ".java";
        File entityFile = new File(entityFileUrl);
        File entityDir = entityFile.getParentFile();
        if (!entityDir.exists()) {
            entityDir.mkdirs();
        }
        if(!entityFile.exists()){
            // 若文件存在则不重新生成
            entityFile.createNewFile();
            out = new FileOutputStream(entityFile);
            entityTemplate.renderTo(out);
        }
        /**
         * Dao代码
         */
        daoTemplate.binding("entity",entity);
        String daoResult = daoTemplate.render();
        System.out.println(daoResult);
        String daoFileUrl = System.getProperty("user.dir")+"/src/main/java/"+ dotToLine(daoPackage) + "/" +className + "Mapper.java";
        File daoFile = new File(daoFileUrl);
        File daoDir = daoFile.getParentFile();
        if (!daoDir.exists()) {
            daoDir.mkdirs();
        }
        if(!daoFile.exists()) {
            daoFile.createNewFile();
            out = new FileOutputStream(daoFile);
            daoTemplate.renderTo(out);
        }
        /**
         * Service代码
         */
        serviceTemplate.binding("entity",entity);
        String serviceResult = serviceTemplate.render();
        System.out.println(serviceResult);
        String serviceFileUrl = System.getProperty("user.dir")+"/src/main/java/"+ dotToLine(servicePackage) + "/I" + className + "Service.java";
        File serviceFile = new File(serviceFileUrl);
        File serviceDir = serviceFile.getParentFile();
        if (!serviceDir.exists()) {
            serviceDir.mkdirs();
        }
        if(!serviceFile.exists()) {
            serviceFile.createNewFile();
            out = new FileOutputStream(serviceFile);
            serviceTemplate.renderTo(out);
        }
        /**
         * 生成serviceImpl代码
         */
        serviceImplTemplate.binding("entity",entity);
        String serviceImplResult = serviceImplTemplate.render();
        System.out.println(serviceImplResult);
        String serviceImplFileUrl = System.getProperty("user.dir")+"/src/main/java/"+ dotToLine(serviceImplPackage) + "/I" + className + "ServiceImpl.java";
        File serviceImplFile = new File(serviceImplFileUrl);
        File serviceImplDir = serviceImplFile.getParentFile();
        if (!serviceImplDir.exists()) {
            serviceImplDir.mkdirs();
        }
        if(!serviceImplFile.exists()) {
            serviceImplFile.createNewFile();
            out = new FileOutputStream(serviceImplFile);
            serviceImplTemplate.renderTo(out);
        }
        /**
         * 生成controller代码
         */
        controllerTemplate.binding("entity",entity);
        String controllerResult = controllerTemplate.render();
        System.out.println(controllerResult);
        String controllerFileUrl = System.getProperty("user.dir")+"/src/main/java/"+ dotToLine(controllerPackage) + "/" + className + "Controller.java";
        File controllerFile = new File(controllerFileUrl);
        File controllerDir = controllerFile.getParentFile();
        if (!controllerDir.exists()) {
            controllerDir.mkdirs();
        }
        if(!controllerFile.exists()) {
            controllerFile.createNewFile();
            out = new FileOutputStream(controllerFile);
            controllerTemplate.renderTo(out);
        }
        /**
         * 生成mapperXml代码
         */
        mapperXmlTemplate.binding("entity",entity);
        String mapperXmlResult = mapperXmlTemplate.render();
        System.out.println(mapperXmlResult);
        String mapperXmlFileUrl = System.getProperty("user.dir")+"/src/main/resources/mapper/" + className + "Mapper.xml";
        File mapperXmlFile = new File(mapperXmlFileUrl);
        File mapperXmlDir = mapperXmlFile.getParentFile();
        if (!mapperXmlDir.exists()) {
            mapperXmlDir.mkdirs();
        }
        if(!mapperXmlFile.exists()) {
            mapperXmlFile.createNewFile();
            out = new FileOutputStream(mapperXmlFile);
            mapperXmlTemplate.renderTo(out);
        }
        // 关闭流
        if(out!=null){
            out.close();
        }
        System.out.println("\n\n\n生成代码成功！\n\n");
    }

    @ApiOperation(value = "删除代码")
    private static void deleteCode(String className) {
        String entityFileUrl = System.getProperty("user.dir")+"/src/main/java/"+ dotToLine(entityPackage) + "/" +className+".java";
        File entityFile = new File(entityFileUrl);
        if(entityFile.exists()){
            entityFile.delete();
        }
        String daoFileUrl = System.getProperty("user.dir")+"/src/main/java/"+ dotToLine(daoPackage) + "/" +className+"Mapper.java";
        File daoFile = new File(daoFileUrl);
        if(daoFile.exists()){
            daoFile.delete();
        }

        String serviceFileUrl = System.getProperty("user.dir")+"/src/main/java/"+ dotToLine(servicePackage) + "/I" +className+"Service.java";
        File serviceFile = new File(serviceFileUrl);
        if(serviceFile.exists()){
            serviceFile.delete();
        }

        String serviceImplFileUrl = System.getProperty("user.dir")+"/src/main/java/"+ dotToLine(serviceImplPackage) + "/I" +className+"ServiceImpl.java";
        File serviceImplFile = new File(serviceImplFileUrl);
        if(serviceImplFile.exists()){
            serviceImplFile.delete();
        }

        String controllerFileUrl = System.getProperty("user.dir")+"/src/main/java/"+ dotToLine(controllerPackage) + "/" +className+"Controller.java";
        File controllerFile = new File(controllerFileUrl);
        if(controllerFile.exists()){
            controllerFile.delete();
        }

        String mapperXmlFileUrl = System.getProperty("user.dir")+"/src/main/resources/mapper/" + className + "Mapper.xml";
        File mapperXmlFile = new File(mapperXmlFileUrl);
        if(mapperXmlFile.exists()){
            mapperXmlFile.delete();
        }

        System.out.println("删除代码完毕！");
    }

    @ApiOperation(value = "构建代码")
    private static void generatePlus(GroupTemplate gt){
        try {
            generateMPlus(gt);
        }catch (Exception e){
            System.out.println("请确保实体类存在并且已完善填入字段后再生成条件构造代码哦！");
        }
    }

    @ApiOperation(value = "构建代码")
    private static void generateMPlus(GroupTemplate gt) throws Exception{
        Template plusTemplate = gt.getTemplate("mplus.btl");

        Entity entity = new Entity();

        entity.setClassName(name(className, true));
        entity.setClassNameLowerCase(name(className, false));
        List<Item> items = new ArrayList<>();

        String path = entityPackage + "." + name(className, true);
        Class c = Class.forName(path);
        Object obj = c.getDeclaredConstructor().newInstance();
        java.lang.reflect.Field[] fields = obj.getClass().getDeclaredFields();

        for (int i = 0; i < fields.length; i++) {

            java.lang.reflect.Field field = fields[i];
            field.setAccessible(true);
            // 字段名
            String fieldName = field.getName();
            String fieldType = field.getType().getName();
            // 白名单
            if("serialVersionUID".equals(fieldName)){
                continue;
            }
            TableField tableField = field.getAnnotation(TableField.class);
            if(tableField!=null&&!tableField.exist()){
                continue;
            }

            // 获得字段注解
            ApiModelProperty myFieldAnnotation = field.getAnnotation(ApiModelProperty.class);
            String fieldNameCN = fieldName;
            if (myFieldAnnotation != null) {
                fieldNameCN = myFieldAnnotation.value();
            }
            fieldNameCN = (fieldNameCN == null || fieldNameCN == "") ? fieldName : fieldNameCN;

            if(fieldType.startsWith("java.lang.")){
                fieldType = StrUtil.subAfter(fieldType, "java.lang.", false);
            }

            Item item = new Item();
            item.setType(fieldType);
            item.setUpperName(name(fieldName, true));
            item.setLowerName(name(fieldName, false));
            item.setLineName(camel2Underline(fieldName));
            item.setTitle(fieldNameCN);

            items.add(item);
        }

        // 绑定参数
        plusTemplate.binding("entity", entity);
        plusTemplate.binding("items", items);
        String result = plusTemplate.render();

        System.out.println("=================================================================================");
        System.out.println("=====生成条件构造代码Plus成功！请根据需要自行复制添加以下代码至控制层方法Controller中======");
        System.out.println("=================================条件构造代码起始线=================================");

        System.out.println(result);

        System.out.println("=================================条件构造代码终止线=================================");
        System.out.println("【代码方法添加位置："+ controllerPackage + "." + className +"Controller.java】");
    }


    @ApiOperation(value = "点转斜线")
    public static String dotToLine(String str){
        return str.replace(".", "/");
    }

    @ApiOperation(value = "驼峰法转下划线")
    public static String camel2Underline(String str) {
        if (StrUtil.isBlank(str)) {
            return "";
        }
        if(str.length()==1){
            return str.toLowerCase();
        }
        StringBuffer sb = new StringBuffer();
        for(int i=1;i<str.length();i++){
            if(Character.isUpperCase(str.charAt(i))){
                sb.append("_"+Character.toLowerCase(str.charAt(i)));
            }else{
                sb.append(str.charAt(i));
            }
        }
        return (str.charAt(0)+sb.toString()).toLowerCase();
    }

    @ApiOperation(value = "首字母是否大小写")
    public static String name(String name, boolean isFirstUpper){
        if(StrUtil.isBlank(name)){
            throw new ZwzException("name不能为空");
        }
        if(name.length()==1){
            if(isFirstUpper){
                return name.toUpperCase();
            } else {
                return name.toLowerCase();
            }
        }
        StringBuffer sb = new StringBuffer();
        if(isFirstUpper){
            sb.append(Character.toUpperCase(name.charAt(0)));
        } else {
            sb.append(Character.toLowerCase(name.charAt(0)));
        }
        sb.append(name.substring(1));
        return sb.toString();
    }
}
