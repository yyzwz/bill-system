# 基于Vue和SpringBoot的超市账单管理系统

## 介绍
基于Vue和SpringBoot的超市账单管理系统，前端采用View UI组件库，后端集成MyBatisPlus连接MySQL数据库，采用Spring Security做权限控制。    


- 系统基础管理：对登入用户、部门、角色、权限进行维护。       
- 商品管理：对超市所出售的商品档案进行维护。      
- 供应商管理：对超市所合作的供应商档案进行维护。      
- 账单管理：对超市所管理的账单档案进行维护。  
    
## 界面预览  

### 登入页面      
![登入页面](https://images.gitee.com/uploads/images/2021/0730/091240_e625b15a_7525468.png "QQ截图20210730085837.png")      
### 账单管理模块      
![账单管理模块](https://images.gitee.com/uploads/images/2021/0730/091311_8265ee18_7525468.png "QQ截图20210730085818.png")      
### 供应商管理模块      
![供应商管理模块](https://images.gitee.com/uploads/images/2021/0730/091333_7fdeb79c_7525468.png "QQ截图20210730085810.png")      
### 商品管理模块      
![商品管理模块](https://images.gitee.com/uploads/images/2021/0730/091355_aa20f27c_7525468.png "QQ截图20210730085801.png")      
### 菜单管理模块      
![菜单管理模块](https://images.gitee.com/uploads/images/2021/0730/091432_79449dd3_7525468.png "QQ截图20210730085749.png")      
### 权限管理模块      
![权限管理模块](https://images.gitee.com/uploads/images/2021/0730/091454_b24aabeb_7525468.png "QQ截图20210730085723.png")      
### 部门管理模块      
![部门管理模块](https://images.gitee.com/uploads/images/2021/0730/091514_51dd6626_7525468.png "QQ截图20210730085710.png")      
### 员工管理模块      
![员工管理模块](https://images.gitee.com/uploads/images/2021/0730/091536_04641b44_7525468.png "QQ截图20210730085655.png")      


## 安装教程

1.本机安装GIT，输入命令
```java
git clone https://gitee.com/yyzwz/bill-system.git
```
2.前端使用VsCode打开front文件夹，控制台输入npm i 安装依赖

3.前端控制台输入npm run dev 运行（默认8080端口）

4.控制台cd到redis目录，运行以下命令
```java
redis-server.exe redis.windows.conf
```
5.导入数据库（bill.sql）

6.使用idea导入back后端项目，maven方式导入，运行(默认1314端口)！

7.运行项目，账号admin 密码123456

### 欢迎光临我的博客：https://zwz99.blog.csdn.net/   
![我的CSDN博客](https://images.gitee.com/uploads/images/2021/0604/100703_32e14138_7525468.jpeg "132246_599dbf21_7525468.jpeg")