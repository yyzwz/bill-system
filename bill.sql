-- --------------------------------------------------------
-- 主机:                           127.0.0.1
-- 服务器版本:                        8.0.26 - MySQL Community Server - GPL
-- 服务器操作系统:                      Win64
-- HeidiSQL 版本:                  11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- 导出 bill 的数据库结构
DROP DATABASE IF EXISTS `bill`;
CREATE DATABASE IF NOT EXISTS `bill` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_croatian_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `bill`;

-- 导出  表 bill.t_bill 结构
DROP TABLE IF EXISTS `t_bill`;
CREATE TABLE IF NOT EXISTS `t_bill` (
  `id` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci NOT NULL,
  `create_by` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci DEFAULT NULL,
  `create_time` datetime(6) DEFAULT NULL,
  `del_flag` int DEFAULT NULL,
  `update_by` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci DEFAULT NULL,
  `update_time` datetime(6) DEFAULT NULL,
  `commodity_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci DEFAULT NULL,
  `supplier_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci DEFAULT NULL,
  `user_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci DEFAULT NULL,
  `date_time` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci DEFAULT NULL,
  `number` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci DEFAULT NULL,
  `price` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci DEFAULT NULL,
  `sum` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_croatian_ci;

-- 正在导出表  bill.t_bill 的数据：~0 rows (大约)
DELETE FROM `t_bill`;
/*!40000 ALTER TABLE `t_bill` DISABLE KEYS */;
INSERT INTO `t_bill` (`id`, `create_by`, `create_time`, `del_flag`, `update_by`, `update_time`, `commodity_id`, `supplier_id`, `user_id`, `date_time`, `number`, `price`, `sum`) VALUES
	('1356533591177302017', 'admin', '2021-02-02 17:23:05.985000', 0, NULL, NULL, '1356526407001444353', '1356521214562144256', '682265633886208', '2021-02-02', '65', '3.2', '208.0');
/*!40000 ALTER TABLE `t_bill` ENABLE KEYS */;

-- 导出  表 bill.t_commodity 结构
DROP TABLE IF EXISTS `t_commodity`;
CREATE TABLE IF NOT EXISTS `t_commodity` (
  `id` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci NOT NULL,
  `create_by` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci DEFAULT NULL,
  `create_time` datetime(6) DEFAULT NULL,
  `del_flag` int DEFAULT NULL,
  `update_by` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci DEFAULT NULL,
  `update_time` datetime(6) DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci DEFAULT NULL,
  `stock` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci DEFAULT NULL,
  `supplier_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci DEFAULT NULL,
  `type` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci DEFAULT NULL,
  `unit_price` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_croatian_ci;

-- 正在导出表  bill.t_commodity 的数据：~4 rows (大约)
DELETE FROM `t_commodity`;
/*!40000 ALTER TABLE `t_commodity` DISABLE KEYS */;
INSERT INTO `t_commodity` (`id`, `create_by`, `create_time`, `del_flag`, `update_by`, `update_time`, `name`, `stock`, `supplier_id`, `type`, `unit_price`) VALUES
	('1356522623944757249', 'admin', '2021-02-02 16:39:31.179000', 0, NULL, NULL, '营养快线500ML', '12', '1356521286188273665', '零食', '4.0'),
	('1356526407001444353', 'admin', '2021-02-02 16:54:33.134000', 0, NULL, NULL, '娃哈哈八宝粥', '100', '1356521436071727105', '零食', '3.6'),
	('1356526501729800193', 'admin', '2021-02-02 16:54:55.715000', 0, NULL, NULL, '砂糖橘', '13.6', '1356521436071727105', '水果', '8.8'),
	('1356526614837596161', 'admin', '2021-02-02 16:55:22.682000', 0, NULL, NULL, 'A4打印纸400张', '100', '1356521214562144256', '文具', '21');
/*!40000 ALTER TABLE `t_commodity` ENABLE KEYS */;

-- 导出  表 bill.t_department 结构
DROP TABLE IF EXISTS `t_department`;
CREATE TABLE IF NOT EXISTS `t_department` (
  `id` bigint unsigned NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` int DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `parent_id` bigint unsigned DEFAULT NULL,
  `sort_order` decimal(10,2) DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `is_parent` bit(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- 正在导出表  bill.t_department 的数据：~3 rows (大约)
DELETE FROM `t_department`;
/*!40000 ALTER TABLE `t_department` DISABLE KEYS */;
INSERT INTO `t_department` (`id`, `create_by`, `create_time`, `del_flag`, `update_by`, `update_time`, `parent_id`, `sort_order`, `status`, `title`, `is_parent`) VALUES
	(1356533711235059713, 'admin', '2021-02-02 17:23:35', 0, 'admin', '2021-02-02 17:23:35', 0, 1.00, 0, '信息与机电工程分院', b'0'),
	(1356533743178878977, 'admin', '2021-02-02 17:23:42', 0, 'admin', '2021-02-02 17:23:42', 0, 0.00, 0, '语言文学分院', b'0'),
	(1356533797428006913, 'admin', '2021-02-02 17:23:55', 0, 'admin', '2021-02-02 17:23:55', 0, 3.00, 0, '医药与健康分院', b'0');
/*!40000 ALTER TABLE `t_department` ENABLE KEYS */;

-- 导出  表 bill.t_department_header 结构
DROP TABLE IF EXISTS `t_department_header`;
CREATE TABLE IF NOT EXISTS `t_department_header` (
  `id` bigint unsigned NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `department_id` bigint unsigned DEFAULT NULL,
  `type` tinyint(1) DEFAULT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- 正在导出表  bill.t_department_header 的数据：~0 rows (大约)
DELETE FROM `t_department_header`;
/*!40000 ALTER TABLE `t_department_header` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_department_header` ENABLE KEYS */;

-- 导出  表 bill.t_dict 结构
DROP TABLE IF EXISTS `t_dict`;
CREATE TABLE IF NOT EXISTS `t_dict` (
  `id` bigint unsigned NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `sort_order` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- 正在导出表  bill.t_dict 的数据：~11 rows (大约)
DELETE FROM `t_dict`;
/*!40000 ALTER TABLE `t_dict` DISABLE KEYS */;
INSERT INTO `t_dict` (`id`, `create_by`, `create_time`, `del_flag`, `update_by`, `update_time`, `description`, `title`, `type`, `sort_order`) VALUES
	(75135930788220928, 'admin', '2018-11-14 22:15:43', 0, 'admin', '2018-11-27 01:39:06', '', '性别', 'sex', 0.00),
	(75388696739713024, 'admin', '2018-11-15 15:00:07', 0, 'admin', '2018-11-27 01:39:22', '', '按钮权限类型', 'permission_type', 2.00),
	(81843858882695168, 'admin', '2018-12-03 10:30:38', 0, 'admin', '2018-12-03 10:30:49', '', '优先级', 'priority', 5.00),
	(99020862912466944, 'admin', '2019-01-19 20:05:54', 0, 'admin', '2019-01-19 20:06:10', '', '请假类型', 'leave_type', 8.00),
	(1356516237135450113, 'admin', '2021-02-02 16:14:08', 0, 'admin', '2021-02-02 16:15:24', '', '商品类型', 'commodity_type', 9.00),
	(1356519672450781184, 'admin', '2021-02-02 16:27:47', 0, 'admin', '2021-02-02 16:30:48', '', '供应商类型', 'supplierType', 0.00);
/*!40000 ALTER TABLE `t_dict` ENABLE KEYS */;

-- 导出  表 bill.t_dict_data 结构
DROP TABLE IF EXISTS `t_dict_data`;
CREATE TABLE IF NOT EXISTS `t_dict_data` (
  `id` bigint unsigned NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `dict_id` bigint unsigned DEFAULT NULL,
  `sort_order` decimal(10,2) DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sort_order` (`sort_order`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- 正在导出表  bill.t_dict_data 的数据：~61 rows (大约)
DELETE FROM `t_dict_data`;
/*!40000 ALTER TABLE `t_dict_data` DISABLE KEYS */;
INSERT INTO `t_dict_data` (`id`, `create_by`, `create_time`, `del_flag`, `update_by`, `update_time`, `description`, `dict_id`, `sort_order`, `status`, `title`, `value`) VALUES
	(75158227712479232, 'admin', '2018-11-14 23:44:19', 0, 'admin', '2019-04-01 23:53:13', '', 75135930788220928, 0.00, 0, '男', '男'),
	(75159254272577536, 'admin', '2018-11-14 23:48:24', 0, 'admin', '2019-04-01 23:53:17', '', 75135930788220928, 1.00, 0, '女', '女'),
	(75159898425397248, 'admin', '2018-11-14 23:50:57', 0, 'admin', '2019-04-01 23:53:22', '', 75135930788220928, 2.00, -1, '保密', '保密'),
	(75390787835138048, 'admin', '2018-11-15 15:08:26', 0, 'admin', '2018-11-15 15:08:26', '', 75388696739713024, 0.00, 0, '查看操作(view)', 'view'),
	(75390886501945344, 'admin', '2018-11-15 15:08:49', 0, 'admin', '2018-11-15 15:08:57', '', 75388696739713024, 1.00, 0, '添加操作(add)', 'add'),
	(75390993939042304, 'admin', '2018-11-15 15:09:15', 0, 'admin', '2018-11-15 15:09:15', '', 75388696739713024, 2.00, 0, '编辑操作(edit)', 'edit'),
	(75391067532300288, 'admin', '2018-11-15 15:09:32', 0, 'admin', '2018-11-15 15:09:32', '', 75388696739713024, 3.00, 0, '删除操作(delete)', 'delete'),
	(75391126902673408, 'admin', '2018-11-15 15:09:46', 0, 'admin', '2018-11-15 15:09:46', '', 75388696739713024, 4.00, 0, '清空操作(clear)', 'clear'),
	(75391192883269632, 'admin', '2018-11-15 15:10:02', 0, 'admin', '2018-11-15 15:10:02', '', 75388696739713024, 5.00, 0, '启用操作(enable)', 'enable'),
	(75391251024711680, 'admin', '2018-11-15 15:10:16', 0, 'admin', '2018-11-15 15:10:16', '', 75388696739713024, 6.00, 0, '禁用操作(disable)', 'disable'),
	(75391297124306944, 'admin', '2018-11-15 15:10:27', 0, 'admin', '2018-11-15 15:10:27', '', 75388696739713024, 7.00, 0, '搜索操作(search)', 'search'),
	(75391343379091456, 'admin', '2018-11-15 15:10:38', 0, 'admin', '2018-11-15 15:10:38', '', 75388696739713024, 8.00, 0, '上传文件(upload)', 'upload'),
	(75391407526776832, 'admin', '2018-11-15 15:10:53', 0, 'admin', '2018-11-15 15:10:53', '', 75388696739713024, 9.00, 0, '导出操作(output)', 'output'),
	(75391475042488320, 'admin', '2018-11-15 15:11:09', 0, 'admin', '2018-11-15 15:11:09', '', 75388696739713024, 10.00, 0, '导入操作(input)', 'input'),
	(75391522182270976, 'admin', '2018-11-15 15:11:21', 0, 'admin', '2018-11-15 15:11:21', '', 75388696739713024, 11.00, 0, '分配权限(editPerm)', 'editPerm'),
	(75391576364290048, 'admin', '2018-11-15 15:11:34', 0, 'admin', '2018-11-15 15:11:34', '', 75388696739713024, 12.00, 0, '设为默认(setDefault)', 'setDefault'),
	(75391798033256448, 'admin', '2018-11-15 15:12:26', 0, 'admin', '2018-11-15 15:12:26', '', 75388696739713024, 13.00, 0, '其他操作(other)', 'other'),
	(81843987719131136, 'admin', '2018-12-03 10:31:08', 0, 'admin', '2018-12-03 10:31:08', '', 81843858882695168, 0.00, 0, '普通', '0'),
	(81844044015079424, 'admin', '2018-12-03 10:31:22', 0, 'admin', '2018-12-03 10:31:22', '', 81843858882695168, 1.00, 0, '重要', '1'),
	(81844100705292288, 'admin', '2018-12-03 10:31:35', 0, 'admin', '2018-12-03 10:31:35', '', 81843858882695168, 2.00, 0, '紧急', '2'),
	(99020985985929216, 'admin', '2019-01-19 20:06:23', 0, 'admin', '2019-04-01 23:55:48', '', 99020862912466944, 0.00, 0, '年假', '年假'),
	(99021020739932160, 'admin', '2019-01-19 20:06:32', 0, 'admin', '2019-04-01 23:55:52', '', 99020862912466944, 1.00, 0, '事假', '事假'),
	(99021195566911488, 'admin', '2019-01-19 20:07:13', 0, 'admin', '2019-04-01 23:55:56', '', 99020862912466944, 2.00, 0, '病假', '病假'),
	(99021242476007424, 'admin', '2019-01-19 20:07:24', 0, 'admin', '2019-04-01 23:56:01', '', 99020862912466944, 3.00, 0, '调休', '调休'),
	(99021300730695680, 'admin', '2019-01-19 20:07:38', 0, 'admin', '2019-04-01 23:56:05', '', 99020862912466944, 4.00, 0, '产假', '产假'),
	(99021341889400832, 'admin', '2019-01-19 20:07:48', 0, 'admin', '2019-04-01 23:56:10', '', 99020862912466944, 5.00, 0, '陪产假', '陪产假'),
	(99021382393794560, 'admin', '2019-01-19 20:07:58', 0, 'admin', '2019-04-01 23:56:14', '', 99020862912466944, 6.00, 0, '婚假', '婚假'),
	(99021437171404800, 'admin', '2019-01-19 20:08:11', 0, 'admin', '2019-04-01 23:56:18', '', 99020862912466944, 7.00, 0, '例假', '例假'),
	(99021497724571648, 'admin', '2019-01-19 20:08:25', 0, 'admin', '2019-04-01 23:56:23', '', 99020862912466944, 8.00, 0, '丧假', '丧假'),
	(99021556704874496, 'admin', '2019-01-19 20:08:39', 0, 'admin', '2019-04-01 23:56:27', '', 99020862912466944, 9.00, 0, '哺乳假', '哺乳假'),
	(1356516276201197569, 'admin', '2021-02-02 16:14:18', 0, 'admin', '2021-02-02 16:14:18', '', 1356516237135450113, 1.00, 0, '水果', '水果'),
	(1356516309881458689, 'admin', '2021-02-02 16:14:26', 0, 'admin', '2021-02-02 16:14:26', '', 1356516237135450113, 2.00, 0, '零食', '零食'),
	(1356516334371999745, 'admin', '2021-02-02 16:14:32', 0, 'admin', '2021-02-02 16:14:32', '', 1356516237135450113, 3.00, 0, '文具', '文具'),
	(1356519711638163456, 'admin', '2021-02-02 16:27:57', 0, 'admin', '2021-02-02 16:27:57', '', 1356519672450781184, 3.00, 0, '三级供应商', '三级供应商'),
	(1356519734010580993, 'admin', '2021-02-02 16:28:02', 0, 'admin', '2021-02-02 16:28:02', '', 1356519672450781184, 2.00, 0, '二级供应商', '二级供应商'),
	(1356519758442401793, 'admin', '2021-02-02 16:28:08', 0, 'admin', '2021-02-02 16:28:08', '', 1356519672450781184, 1.00, 0, '一级供应商', '一级供应商');
/*!40000 ALTER TABLE `t_dict_data` ENABLE KEYS */;

-- 导出  表 bill.t_file 结构
DROP TABLE IF EXISTS `t_file`;
CREATE TABLE IF NOT EXISTS `t_file` (
  `id` bigint unsigned NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `size` bigint unsigned DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `f_key` varchar(255) DEFAULT NULL,
  `location` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `create_time` (`create_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- 正在导出表  bill.t_file 的数据：~0 rows (大约)
DELETE FROM `t_file`;
/*!40000 ALTER TABLE `t_file` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_file` ENABLE KEYS */;

-- 导出  表 bill.t_log 结构
DROP TABLE IF EXISTS `t_log`;
CREATE TABLE IF NOT EXISTS `t_log` (
  `id` bigint unsigned NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `cost_time` int unsigned DEFAULT NULL,
  `ip` varchar(255) DEFAULT NULL,
  `ip_info` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `request_param` longtext,
  `request_type` varchar(255) DEFAULT NULL,
  `request_url` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `log_type` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `create_time` (`create_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- 正在导出表  bill.t_log 的数据：~9 rows (大约)
DELETE FROM `t_log`;
/*!40000 ALTER TABLE `t_log` DISABLE KEYS */;
INSERT INTO `t_log` (`id`, `create_by`, `create_time`, `del_flag`, `update_by`, `update_time`, `cost_time`, `ip`, `ip_info`, `name`, `request_param`, `request_type`, `request_url`, `username`, `log_type`) VALUES
	(1356427539991629824, NULL, '2021-02-02 10:21:42', 0, NULL, '2021-02-02 10:21:42', 84, '127.0.0.1', '未知', '登录系统', '{"password":"你是看不见我的","code":"vywu","saveLogin":"true","captchaId":"4e3a75718a9841ddb86513b40a9b6677","username":"admin"}', 'POST', '/xboot/login', 'admin', 1),
	(1356494459717685248, NULL, '2021-02-02 14:47:37', 0, NULL, '2021-02-02 14:47:37', 212, '127.0.0.1', '未知', '登录系统', '{"password":"你是看不见我的","code":"hbyk","saveLogin":"true","captchaId":"a1bf99a0f4f84ea6bc00990e9d58bf52","username":"admin"}', 'POST', '/xboot/login', 'admin', 1),
	(1356513294730530816, NULL, '2021-02-02 16:02:27', 0, NULL, '2021-02-02 16:02:27', 206, '127.0.0.1', '未知', '登录系统', '{"password":"你是看不见我的","code":"21mn","saveLogin":"true","captchaId":"4a13bab32f5449729c1945b009f4139e","username":"admin"}', 'POST', '/xboot/login', 'admin', 1),
	(1356517927511265280, NULL, '2021-02-02 16:20:52', 0, NULL, '2021-02-02 16:20:52', 57, '127.0.0.1', '未知', '登录系统', '{"password":"你是看不见我的","code":"MWHN","saveLogin":"true","captchaId":"30b8b62594de4b138423eaef875130b4","username":"admin"}', 'POST', '/xboot/login', 'admin', 1),
	(1356520586016329728, NULL, '2021-02-02 16:31:25', 0, NULL, '2021-02-02 16:31:25', 83, '127.0.0.1', '未知', '登录系统', '{"password":"你是看不见我的","code":"po5q","saveLogin":"true","captchaId":"213846424f4b43a0be80e069a0503eae","username":"admin"}', 'POST', '/xboot/login', 'admin', 1),
	(1420910007049916416, NULL, '2021-07-30 08:52:00', 0, NULL, '2021-07-30 08:52:00', 268, '127.0.0.1', '未知', '登录系统', '{"password":"你是看不见我的","code":"q14l","saveLogin":"true","captchaId":"0f934c09249e418d886a57d9251535d2","username":"admin"}', 'POST', '/xboot/login', 'admin', 1),
	(1420913158993874944, NULL, '2021-07-30 09:04:31', 0, NULL, '2021-07-30 09:04:31', 230, '127.0.0.1', '未知', '登录系统', '{"password":"你是看不见我的","code":"hqxc","saveLogin":"true","captchaId":"9858c00a3af54094accb0f3511406dd3","username":"admin"}', 'POST', '/xboot/login', 'admin', 1),
	(1501458322484760576, NULL, '2022-03-09 15:22:15', 0, NULL, '2022-03-09 15:22:15', 379, '127.0.0.1', '本地测试', '登录系统', '{"password":"密码隐藏","code":"4289","saveLogin":"true","captchaId":"e9c1f3b85f944d769f27604ab0e34e6d","username":"admin"}', 'POST', '/zwz/login', 'admin', 0),
	(1501458350469156864, NULL, '2022-03-09 15:22:21', 0, NULL, '2022-03-09 15:22:21', 84, '127.0.0.1', '本地测试', '登录系统', '{"password":"密码隐藏","code":"2284","saveLogin":"true","captchaId":"9f79ac31b5e744f9ab763099ef2e4dfb","username":"admin"}', 'POST', '/zwz/login', 'admin', 0),
	(1501460000827117568, NULL, '2022-03-09 15:28:55', 0, NULL, '2022-03-09 15:28:55', 92, '127.0.0.1', '本地测试', '登录系统', '{"password":"密码隐藏","code":"9999","saveLogin":"true","captchaId":"bd0bbf77ee124cce879f2dfdb6c8ffa2","username":"admin"}', 'POST', '/zwz/login', 'admin', 0),
	(1501461179481067520, NULL, '2022-03-09 15:33:36', 0, NULL, '2022-03-09 15:33:36', 56, '127.0.0.1', '本地测试', '登录系统', '{"password":"密码隐藏","code":"2896","saveLogin":"true","captchaId":"295f8f5780c84b9b991aa69f755b069a","username":"admin"}', 'POST', '/zwz/login', 'admin', 0),
	(1501467314112040960, NULL, '2022-03-09 15:57:59', 0, NULL, '2022-03-09 15:57:59', 263, '127.0.0.1', '本地测试', '登录系统', '{"password":"密码隐藏","code":"6837","saveLogin":"true","captchaId":"9f96cc696f9c4f65877744c2e6f14dd2","username":"admin"}', 'POST', '/zwz/login', 'admin', 0);
/*!40000 ALTER TABLE `t_log` ENABLE KEYS */;

-- 导出  表 bill.t_permission 结构
DROP TABLE IF EXISTS `t_permission`;
CREATE TABLE IF NOT EXISTS `t_permission` (
  `id` bigint unsigned NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `parent_id` bigint unsigned DEFAULT NULL,
  `type` tinyint(1) DEFAULT NULL,
  `sort_order` decimal(10,2) DEFAULT NULL,
  `component` varchar(255) DEFAULT NULL,
  `path` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `level` int unsigned DEFAULT NULL,
  `button_type` varchar(255) DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `show_always` bit(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- 正在导出表  bill.t_permission 的数据：~47 rows (大约)
DELETE FROM `t_permission`;
/*!40000 ALTER TABLE `t_permission` DISABLE KEYS */;
INSERT INTO `t_permission` (`id`, `create_by`, `create_time`, `del_flag`, `update_by`, `update_time`, `description`, `name`, `parent_id`, `type`, `sort_order`, `component`, `path`, `title`, `icon`, `level`, `button_type`, `status`, `url`, `show_always`) VALUES
	(5129710648430592, '', '2018-06-04 19:02:29', 0, 'admin', '2021-11-27 14:46:19', '', 'sys', 125909152017944576, 0, 4.00, 'Main', '/sys', '权限管理', 'ios-settings', 1, '', 0, '', b'1'),
	(5129710648430593, '', '2018-06-04 19:02:32', 0, 'admin', '2022-01-28 13:35:13', '', 'user-admin', 1464484663442673664, 0, 1.10, 'roster/user/user', 'user-admin', '用户管理', 'md-person', 2, '', 0, '', b'1'),
	(5129710648430594, '', '2018-06-04 19:02:35', 0, '', '2018-10-13 13:51:36', '', 'role-manage', 5129710648430592, 0, 1.60, 'sys/role-manage/roleManage', 'role-manage', '角色权限管理', 'md-contacts', 2, '', 0, '', b'1'),
	(5129710648430595, '', '2018-06-04 19:02:37', 0, '', '2018-09-23 23:32:02', '', 'menu-manage', 5129710648430592, 0, 1.70, 'sys/menu-manage/menuManage', 'menu-manage', '菜单权限管理', 'md-menu', 2, '', 0, '', b'1'),
	(15701400130424832, '', '2018-06-03 22:04:06', 0, '', '2018-09-19 22:16:44', '', '', 5129710648430593, 1, 1.11, '', '/xboot/user/admin/add*', '添加用户', '', 3, 'add', 0, '', b'1'),
	(15701915807518720, '', '2018-06-03 22:06:09', 0, '', '2018-06-06 14:46:51', '', '', 5129710648430593, 1, 1.13, '', '/xboot/user/admin/disable/**', '禁用用户', '', 3, 'disable', 0, NULL, b'1'),
	(15708892205944832, '', '2018-06-03 22:33:52', 0, '', '2018-06-28 16:44:48', '', '', 5129710648430593, 1, 1.14, '', '/xboot/user/admin/enable/**', '启用用户', '', 3, 'enable', 0, NULL, b'1'),
	(16678126574637056, '', '2018-06-06 14:45:16', 0, '', '2018-09-19 22:16:48', '', '', 5129710648430593, 1, 1.12, '', '/xboot/user/admin/edit*', '编辑用户', '', 3, 'edit', 0, '', b'1'),
	(16678447719911424, '', '2018-06-06 14:46:32', 0, 'admin', '2020-04-28 14:27:03', '', '', 5129710648430593, 1, 1.15, '', '/xboot/user/delByIds**', '删除用户', '', 3, 'delete', 0, '', b'1'),
	(16687383932047360, '', '2018-06-06 15:22:03', 0, '', '2018-09-19 22:07:34', '', '', 5129710648430594, 1, 1.21, '', '/xboot/role/save*', '添加角色', '', 3, 'add', 0, '', b'1'),
	(16689632049631232, '', '2018-06-06 15:30:59', 0, '', '2018-09-19 22:07:37', '', '', 5129710648430594, 1, 1.22, '', '/xboot/role/edit*', '编辑角色', '', 3, 'edit', 0, '', b'1'),
	(16689745006432256, '', '2018-06-06 15:31:26', 0, 'admin', '2020-04-28 14:29:02', '', '', 5129710648430594, 1, 1.23, '', '/xboot/role/delByIds**', '删除角色', '', 3, 'delete', 0, '', b'1'),
	(16689883993083904, NULL, '2018-06-06 15:31:59', 0, NULL, '2018-06-06 15:31:59', NULL, NULL, 5129710648430594, 1, 1.24, NULL, '/xboot/role/editRolePerm**', '分配权限', NULL, 3, 'editPerm', 0, NULL, b'1'),
	(16690313745666048, '', '2018-06-06 15:33:41', 0, '', '2018-09-19 22:07:46', '', '', 5129710648430594, 1, 1.25, '', '/xboot/role/setDefault*', '设为默认角色', '', 3, 'setDefault', 0, '', b'1'),
	(16694861252005888, '', '2018-06-06 15:51:46', 0, '', '2018-09-19 22:07:52', '', '', 5129710648430595, 1, 1.31, '', '/xboot/permission/add*', '添加菜单', '', 3, 'add', 0, '', b'1'),
	(16695107491205120, '', '2018-06-06 15:52:44', 0, '', '2018-09-19 22:07:57', '', '', 5129710648430595, 1, 1.32, '', '/xboot/permission/edit*', '编辑菜单', '', 3, 'edit', 0, '', b'1'),
	(16695243126607872, '', '2018-06-06 15:53:17', 0, 'admin', '2020-04-28 14:29:17', '', '', 5129710648430595, 1, 1.33, '', '/xboot/permission/delByIds**', '删除菜单', '', 3, 'delete', 0, '', b'1'),
	(25014528525733888, '', '2018-06-29 14:51:09', 0, '', '2018-10-08 11:13:27', '', '', 5129710648430593, 1, 1.16, '', '无', '上传图片', '', 3, 'upload', 0, '', b'1'),
	(39915540965232640, '', '2018-08-09 17:42:28', 0, 'admin', '2021-11-27 14:46:28', '', 'monitor', 125909152017944576, 0, 10.00, 'Main', '/monitor', '日志管理', 'ios-analytics', 1, '', 0, '', b'1'),
	(40238597734928384, '', '2018-08-10 15:06:10', 0, 'admin', '2022-01-28 13:35:09', '', 'department-admin', 1464485105081913345, 0, 1.20, 'roster/department/department', 'department-admin', '部门管理', 'md-git-branch', 2, '', 0, '', b'1'),
	(41363147411427328, '', '2018-08-13 17:34:43', 0, 'admin', '2020-03-25 20:31:16', '', 'log-manage', 39915540965232640, 0, 2.20, 'sys/log-manage/logManage', 'log-manage', '日志管理', 'md-list-box', 2, '', 0, '', b'1'),
	(41363537456533504, '', '2018-08-13 17:36:16', 0, 'admin', '2020-04-28 14:31:54', '', '', 41363147411427328, 1, 2.11, '', '/xboot/log/delByIds**', '删除日志', '', 3, 'delete', 0, '', b'1'),
	(41364927394353152, '', '2018-08-13 17:41:48', 0, '', '2018-09-19 22:08:57', '', '', 41363147411427328, 1, 2.12, '', '/xboot/log/delAll*', '清空日志', '', 3, 'undefined', 0, '', b'1'),
	(45235621697949696, '', '2018-08-24 10:02:33', 0, '', '2018-09-19 22:06:57', '', '', 40238597734928384, 1, 1.21, '', '/xboot/department/add*', '添加部门', '', 3, 'add', 0, '', b'1'),
	(45235787867885568, '', '2018-08-24 10:03:13', 0, '', '2018-09-19 22:07:02', '', '', 40238597734928384, 1, 1.22, '', '/xboot/department/edit*', '编辑部门', '', 3, 'edit', 0, '', b'1'),
	(45235939278065664, '', '2018-08-24 10:03:49', 0, 'admin', '2020-04-28 14:27:35', '', '', 40238597734928384, 1, 1.23, '', '/xboot/department/delByIds*', '删除部门', '', 3, 'delete', 0, '', b'1'),
	(56309618086776832, '', '2018-09-23 23:26:40', 0, 'admin', '2021-11-27 14:47:48', '', 'file-admin', 1464485485316542465, 0, 1.00, 'sys/oss-manage/ossManage', 'file-admin', '文件对象存储', 'ios-folder', 2, '', 0, '', b'1'),
	(56898976661639168, '', '2018-09-25 14:28:34', 0, '', '2018-09-25 15:12:46', '', '', 5129710648430593, 1, 1.17, '', '/xboot/user/importData*', '导入用户', '', 3, 'input', 0, '', b'1'),
	(57212882168844288, '', '2018-09-26 11:15:55', 0, '', '2018-10-08 11:10:05', '', '', 56309618086776832, 1, 1.41, '', '无', '上传文件', '', 3, 'upload', 0, '', b'1'),
	(61560041605435392, NULL, '2018-10-08 11:09:58', 0, NULL, '2018-10-08 11:09:58', NULL, '', 56309618086776832, 1, 1.42, '', '/xboot/file/rename*', '重命名文件', '', 3, 'edit', 0, NULL, b'1'),
	(61560275261722624, NULL, '2018-10-08 11:10:54', 0, NULL, '2018-10-08 11:10:54', NULL, '', 56309618086776832, 1, 1.43, '', '/xboot/file/copy*', '复制文件', '', 3, 'edit', 0, NULL, b'1'),
	(61560480518377472, '', '2018-10-08 11:11:43', 0, 'admin', '2020-04-28 14:28:22', '', '', 56309618086776832, 1, 1.44, '', '/xboot/file/delete*', '删除文件', '', 3, 'delete', 0, '', b'1'),
	(75002207560273920, 'admin', '2018-11-14 13:24:21', 0, 'admin', '2021-11-27 14:47:55', '', 'dict-admin', 1464485485316542465, 0, 2.00, 'sys/dict-manage/dictManage', 'dict-admin', '数据字典管理', 'md-bookmarks', 2, '', 0, '', b'1'),
	(76215889006956544, 'admin', '2018-11-17 21:47:05', 0, 'admin', '2018-11-17 21:47:53', '', '', 75002207560273920, 1, 1.81, '', '/xboot/dict/add*', '添加字典', '', 3, 'add', 0, '', b'1'),
	(76216071333351424, 'admin', '2018-11-17 21:47:48', 0, 'admin', '2018-11-17 21:47:48', NULL, '', 75002207560273920, 1, 1.82, '', '/xboot/dict/edit*', '编辑字典', '', 3, 'edit', 0, NULL, b'1'),
	(76216264070008832, 'admin', '2018-11-17 21:48:34', 0, 'admin', '2020-04-28 14:29:30', '', '', 75002207560273920, 1, 1.83, '', '/xboot/dict/delByIds**', '删除字典', '', 3, 'delete', 0, '', b'1'),
	(76216459709124608, 'admin', '2018-11-17 21:49:21', 0, 'admin', '2018-11-17 21:49:21', NULL, '', 75002207560273920, 1, 1.84, '', '/xboot/dictData/add*', '添加字典数据', '', 3, 'add', 0, NULL, b'1'),
	(76216594207870976, 'admin', '2018-11-17 21:49:53', 0, 'admin', '2018-11-17 21:49:53', NULL, '', 75002207560273920, 1, 1.85, '', '/xboot/dictData/edit*', '编辑字典数据', '', 3, 'edit', 0, NULL, b'1'),
	(76216702639017984, 'admin', '2018-11-17 21:50:18', 0, 'admin', '2018-11-17 21:50:18', NULL, '', 75002207560273920, 1, 1.86, '', '/xboot/dictData/delByIds/**', '删除字典数据', '', 3, 'delete', 0, NULL, b'1'),
	(121426317022334976, 'admin', '2019-03-22 15:57:11', 0, 'admin', '2021-11-27 14:46:36', '', 'redis', 39915540965232640, 0, 2.21, 'sys/redis/redis', 'redis', 'Redis日志', 'md-barcode', 2, '', 0, '', b'1'),
	(125909152017944576, 'admin', '2019-04-04 00:50:22', 0, 'admin', '2021-11-27 14:40:00', '', 'xboot', 0, -1, 1.00, '', '', '数据中心', 'md-home', 0, '', 0, '', b'1'),
	(156365156580855808, 'admin', '2019-06-27 01:51:39', 0, 'admin', '2019-06-27 01:51:39', NULL, '', 5129710648430593, 1, 1.18, '', '/xboot/user/resetPass', '重置密码', '', 3, 'other', 0, NULL, b'1'),
	(1255336077691064320, 'admin', '2020-04-29 11:20:18', 0, 'admin', '2020-04-29 11:20:47', '', '', 121426317022334976, 1, 0.00, '', '/xboot/redis/getAllByPage**', '获取Redis', '', 3, 'view', 0, '', b'1'),
	(1255336361339260928, 'admin', '2020-04-29 11:21:26', 0, 'admin', '2020-04-29 11:21:26', NULL, '', 121426317022334976, 1, 0.00, '', '/xboot/redis/save', '添加Redis', '', 3, 'add', 0, NULL, b'1'),
	(1255336455472025601, 'admin', '2020-04-29 11:21:48', 0, 'admin', '2020-04-29 11:21:48', NULL, '', 121426317022334976, 1, 0.00, '', '/xboot/redis/delByKeys**', '删除Redis', '', 3, 'delete', 0, NULL, b'1'),
	(1255336553971060737, 'admin', '2020-04-29 11:22:12', 0, 'admin', '2020-04-29 11:22:12', NULL, '', 121426317022334976, 1, 0.00, '', '/xboot/redis/delAll', '清空Redis', '', 3, 'clear', 0, NULL, b'1'),
	(1356495199970398208, 'admin', '2021-02-02 14:50:33', 0, 'admin', '2021-02-02 14:50:33', NULL, 'commoditySystem', NULL, -1, 1.00, NULL, NULL, '商品管理', 'ios-american-football', 0, NULL, 0, NULL, b'1'),
	(1356495466673606656, 'admin', '2021-02-02 14:51:36', 0, 'admin', '2021-02-02 14:51:36', NULL, 'commodity', 1356495199970398208, 0, 1.00, 'Main', '/commodity', '商品管理', 'md-analytics', 1, '', 0, NULL, b'1'),
	(1356495562643476480, 'admin', '2021-02-02 14:51:59', 0, 'admin', '2021-02-02 14:51:59', NULL, 'commodity', 1356495466673606656, 0, 1.00, 'commodity/commodity/commodity', 'commodity', '商品管理', 'md-beer', 2, '', 0, NULL, b'1'),
	(1356499201571295232, 'admin', '2021-02-02 15:06:27', 0, 'admin', '2021-02-02 15:06:27', NULL, 'supplierSystem', NULL, -1, 3.00, NULL, NULL, '供应商管理', 'md-cloudy-night', 0, NULL, 0, NULL, b'1'),
	(1356499247591198721, 'admin', '2021-02-02 15:06:38', 0, 'admin', '2021-02-02 15:06:38', NULL, 'supplierSystem', 1356499201571295232, 0, 1.00, 'Main', '/supplierSystem', '供应商管理', 'ios-checkbox', 1, '', 0, NULL, b'1'),
	(1356499311105544193, 'admin', '2021-02-02 15:06:53', 0, 'admin', '2021-02-02 16:10:01', '', 'supplier', 1356499247591198721, 0, 1.00, 'supplier/supplier/supplier', 'supplier', '供应商', 'ios-chatboxes', 2, '', 0, '', b'1'),
	(1356499478537965569, 'admin', '2021-02-02 15:07:33', 0, 'admin', '2021-02-02 15:07:33', NULL, 'sillSystem', NULL, -1, 4.00, NULL, NULL, '账单管理', 'md-backspace', 0, NULL, 0, NULL, b'1'),
	(1356513445691920384, 'admin', '2021-02-02 16:03:03', 0, 'admin', '2021-02-02 16:56:03', '', 'bill', 1356499478537965569, 0, 1.00, 'Main', '/bill', '账单管理', 'md-aperture', 1, '', 0, '', b'1'),
	(1356513518173687809, 'admin', '2021-02-02 16:03:20', 0, 'admin', '2021-02-02 16:55:58', '', 'bill', 1356513445691920384, 0, 1.00, 'bill/bill/bill', 'bill', '账单', 'ios-apps', 2, '', 0, '', b'1'),
	(1464484663442673664, 'admin', '2021-11-27 14:42:07', 0, 'admin', '2021-11-27 14:42:37', '', 'userTwoMenu', 125909152017944576, 0, 1.00, 'Main', '/userTwoMenu', '用户管理', 'md-analytics', 1, '', 0, '', b'1'),
	(1464485105081913345, 'admin', '2021-11-27 14:43:53', 0, 'admin', '2021-11-27 14:43:53', NULL, 'depTwoMenu', 125909152017944576, 0, 2.00, 'Main', '/depTwoMenu', '部门管理', 'ios-apps', 1, '', 0, NULL, b'1'),
	(1464485485316542465, 'admin', '2021-11-27 14:45:23', 0, 'admin', '2021-11-27 14:47:05', '', 'fileAdmin', 125909152017944576, 0, 3.00, 'Main', '/fileAdmin', '资源管理', 'md-basketball', 1, '', 0, '', b'1'),
	(1464486736955576321, 'admin', '2021-11-27 14:50:22', 0, 'admin', '2021-11-27 14:50:22', NULL, 'file-setting', 1464485485316542465, 0, 3.00, 'sys/setting-manage/settingManage', 'file-setting', '文件存储配置', 'ios-settings-outline', 2, '', 0, NULL, b'1'),
	(1464514283202285568, 'admin', '2021-11-27 16:39:49', 0, 'admin', '2021-11-27 16:39:49', NULL, 'vue-code', 1464485485316542465, 0, 4.00, 'sys/oneJavaVue/tableGenerator', 'vue-code', 'Vue', 'md-analytics', 2, '', 0, NULL, b'1');
/*!40000 ALTER TABLE `t_permission` ENABLE KEYS */;

-- 导出  表 bill.t_role 结构
DROP TABLE IF EXISTS `t_role`;
CREATE TABLE IF NOT EXISTS `t_role` (
  `id` bigint unsigned NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `default_role` bit(1) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `data_type` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- 正在导出表  bill.t_role 的数据：~4 rows (大约)
DELETE FROM `t_role`;
/*!40000 ALTER TABLE `t_role` DISABLE KEYS */;
INSERT INTO `t_role` (`id`, `create_by`, `create_time`, `update_by`, `update_time`, `name`, `del_flag`, `default_role`, `description`, `data_type`) VALUES
	(496138616573952, '', '2018-04-22 23:03:49', 'admin', '2018-11-15 23:02:59', 'ROLE_ADMIN', 0, NULL, '超级管理员 拥有所有权限', 0),
	(16457350655250432, '', '2018-06-06 00:08:00', 'admin', '2021-02-02 10:23:43', 'ROLE_TEST', 0, b'1', '测试权限按钮显示', 1),
	(1356534242120699904, 'admin', '2021-02-02 17:25:41', 'admin', '2021-02-02 17:26:21', 'ROLE_ZHIYUAN', 0, NULL, '超市采购部的职员', 0),
	(1356534329106370560, 'admin', '2021-02-02 17:26:02', 'admin', '2021-02-02 17:26:02', 'ROLE_HEADER', 0, NULL, '超市部门经理', 0);
/*!40000 ALTER TABLE `t_role` ENABLE KEYS */;

-- 导出  表 bill.t_role_department 结构
DROP TABLE IF EXISTS `t_role_department`;
CREATE TABLE IF NOT EXISTS `t_role_department` (
  `id` bigint unsigned NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `department_id` bigint unsigned DEFAULT NULL,
  `role_id` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- 正在导出表  bill.t_role_department 的数据：~0 rows (大约)
DELETE FROM `t_role_department`;
/*!40000 ALTER TABLE `t_role_department` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_role_department` ENABLE KEYS */;

-- 导出  表 bill.t_role_permission 结构
DROP TABLE IF EXISTS `t_role_permission`;
CREATE TABLE IF NOT EXISTS `t_role_permission` (
  `id` bigint unsigned NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `permission_id` bigint unsigned DEFAULT NULL,
  `role_id` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- 正在导出表  bill.t_role_permission 的数据：~77 rows (大约)
DELETE FROM `t_role_permission`;
/*!40000 ALTER TABLE `t_role_permission` DISABLE KEYS */;
INSERT INTO `t_role_permission` (`id`, `create_by`, `create_time`, `del_flag`, `update_by`, `update_time`, `permission_id`, `role_id`) VALUES
	(1464514325862551552, 'admin', '2021-11-27 16:39:59', 0, 'admin', '2021-11-27 16:39:59', 125909152017944576, 496138616573952),
	(1464514325862551553, 'admin', '2021-11-27 16:39:59', 0, 'admin', '2021-11-27 16:39:59', 1464484663442673664, 496138616573952),
	(1464514325862551554, 'admin', '2021-11-27 16:39:59', 0, 'admin', '2021-11-27 16:39:59', 5129710648430593, 496138616573952),
	(1464514325862551555, 'admin', '2021-11-27 16:39:59', 0, 'admin', '2021-11-27 16:39:59', 15701400130424832, 496138616573952),
	(1464514325862551556, 'admin', '2021-11-27 16:39:59', 0, 'admin', '2021-11-27 16:39:59', 16678126574637056, 496138616573952),
	(1464514325862551557, 'admin', '2021-11-27 16:39:59', 0, 'admin', '2021-11-27 16:39:59', 15701915807518720, 496138616573952),
	(1464514325862551558, 'admin', '2021-11-27 16:39:59', 0, 'admin', '2021-11-27 16:39:59', 15708892205944832, 496138616573952),
	(1464514325862551559, 'admin', '2021-11-27 16:39:59', 0, 'admin', '2021-11-27 16:39:59', 16678447719911424, 496138616573952),
	(1464514325862551560, 'admin', '2021-11-27 16:39:59', 0, 'admin', '2021-11-27 16:39:59', 25014528525733888, 496138616573952),
	(1464514325862551561, 'admin', '2021-11-27 16:39:59', 0, 'admin', '2021-11-27 16:39:59', 56898976661639168, 496138616573952),
	(1464514325862551562, 'admin', '2021-11-27 16:39:59', 0, 'admin', '2021-11-27 16:39:59', 156365156580855808, 496138616573952),
	(1464514325862551563, 'admin', '2021-11-27 16:39:59', 0, 'admin', '2021-11-27 16:39:59', 1464485105081913345, 496138616573952),
	(1464514325862551564, 'admin', '2021-11-27 16:39:59', 0, 'admin', '2021-11-27 16:39:59', 40238597734928384, 496138616573952),
	(1464514325862551565, 'admin', '2021-11-27 16:39:59', 0, 'admin', '2021-11-27 16:39:59', 45235621697949696, 496138616573952),
	(1464514325862551566, 'admin', '2021-11-27 16:39:59', 0, 'admin', '2021-11-27 16:39:59', 45235787867885568, 496138616573952),
	(1464514325862551567, 'admin', '2021-11-27 16:39:59', 0, 'admin', '2021-11-27 16:39:59', 45235939278065664, 496138616573952),
	(1464514325862551568, 'admin', '2021-11-27 16:39:59', 0, 'admin', '2021-11-27 16:39:59', 1464485485316542465, 496138616573952),
	(1464514325862551569, 'admin', '2021-11-27 16:39:59', 0, 'admin', '2021-11-27 16:39:59', 56309618086776832, 496138616573952),
	(1464514325862551570, 'admin', '2021-11-27 16:39:59', 0, 'admin', '2021-11-27 16:39:59', 57212882168844288, 496138616573952),
	(1464514325862551571, 'admin', '2021-11-27 16:39:59', 0, 'admin', '2021-11-27 16:39:59', 61560041605435392, 496138616573952),
	(1464514325862551572, 'admin', '2021-11-27 16:39:59', 0, 'admin', '2021-11-27 16:39:59', 61560275261722624, 496138616573952),
	(1464514325862551573, 'admin', '2021-11-27 16:39:59', 0, 'admin', '2021-11-27 16:39:59', 61560480518377472, 496138616573952),
	(1464514325862551574, 'admin', '2021-11-27 16:39:59', 0, 'admin', '2021-11-27 16:39:59', 75002207560273920, 496138616573952),
	(1464514325862551575, 'admin', '2021-11-27 16:39:59', 0, 'admin', '2021-11-27 16:39:59', 76215889006956544, 496138616573952),
	(1464514325862551576, 'admin', '2021-11-27 16:39:59', 0, 'admin', '2021-11-27 16:39:59', 76216071333351424, 496138616573952),
	(1464514325862551577, 'admin', '2021-11-27 16:39:59', 0, 'admin', '2021-11-27 16:39:59', 76216264070008832, 496138616573952),
	(1464514325862551578, 'admin', '2021-11-27 16:39:59', 0, 'admin', '2021-11-27 16:39:59', 76216459709124608, 496138616573952),
	(1464514325862551579, 'admin', '2021-11-27 16:39:59', 0, 'admin', '2021-11-27 16:39:59', 76216594207870976, 496138616573952),
	(1464514325862551580, 'admin', '2021-11-27 16:39:59', 0, 'admin', '2021-11-27 16:39:59', 76216702639017984, 496138616573952),
	(1464514325862551581, 'admin', '2021-11-27 16:39:59', 0, 'admin', '2021-11-27 16:39:59', 1464486736955576321, 496138616573952),
	(1464514325862551582, 'admin', '2021-11-27 16:39:59', 0, 'admin', '2021-11-27 16:39:59', 1464514283202285568, 496138616573952),
	(1464514325862551583, 'admin', '2021-11-27 16:39:59', 0, 'admin', '2021-11-27 16:39:59', 5129710648430592, 496138616573952),
	(1464514325862551584, 'admin', '2021-11-27 16:39:59', 0, 'admin', '2021-11-27 16:39:59', 5129710648430594, 496138616573952),
	(1464514325862551585, 'admin', '2021-11-27 16:39:59', 0, 'admin', '2021-11-27 16:39:59', 16687383932047360, 496138616573952),
	(1464514325862551586, 'admin', '2021-11-27 16:39:59', 0, 'admin', '2021-11-27 16:39:59', 16689632049631232, 496138616573952),
	(1464514325862551587, 'admin', '2021-11-27 16:39:59', 0, 'admin', '2021-11-27 16:39:59', 16689745006432256, 496138616573952),
	(1464514325862551588, 'admin', '2021-11-27 16:39:59', 0, 'admin', '2021-11-27 16:39:59', 16689883993083904, 496138616573952),
	(1464514325862551589, 'admin', '2021-11-27 16:39:59', 0, 'admin', '2021-11-27 16:39:59', 16690313745666048, 496138616573952),
	(1464514325862551590, 'admin', '2021-11-27 16:39:59', 0, 'admin', '2021-11-27 16:39:59', 5129710648430595, 496138616573952),
	(1464514325862551591, 'admin', '2021-11-27 16:39:59', 0, 'admin', '2021-11-27 16:39:59', 16694861252005888, 496138616573952),
	(1464514325862551592, 'admin', '2021-11-27 16:39:59', 0, 'admin', '2021-11-27 16:39:59', 16695107491205120, 496138616573952),
	(1464514325862551593, 'admin', '2021-11-27 16:39:59', 0, 'admin', '2021-11-27 16:39:59', 16695243126607872, 496138616573952),
	(1464514325862551594, 'admin', '2021-11-27 16:39:59', 0, 'admin', '2021-11-27 16:39:59', 39915540965232640, 496138616573952),
	(1464514325862551595, 'admin', '2021-11-27 16:39:59', 0, 'admin', '2021-11-27 16:39:59', 41363147411427328, 496138616573952),
	(1464514325862551596, 'admin', '2021-11-27 16:39:59', 0, 'admin', '2021-11-27 16:39:59', 41363537456533504, 496138616573952),
	(1464514325862551597, 'admin', '2021-11-27 16:39:59', 0, 'admin', '2021-11-27 16:39:59', 41364927394353152, 496138616573952),
	(1464514325862551598, 'admin', '2021-11-27 16:39:59', 0, 'admin', '2021-11-27 16:39:59', 121426317022334976, 496138616573952),
	(1464514325862551599, 'admin', '2021-11-27 16:39:59', 0, 'admin', '2021-11-27 16:39:59', 1255336077691064320, 496138616573952),
	(1464514325862551600, 'admin', '2021-11-27 16:39:59', 0, 'admin', '2021-11-27 16:39:59', 1255336361339260928, 496138616573952),
	(1464514325862551601, 'admin', '2021-11-27 16:39:59', 0, 'admin', '2021-11-27 16:39:59', 1255336455472025601, 496138616573952),
	(1464514325862551602, 'admin', '2021-11-27 16:39:59', 0, 'admin', '2021-11-27 16:39:59', 1255336553971060737, 496138616573952),
	(1501460131194474500, 'admin', '2022-03-09 15:29:26', 0, NULL, NULL, 1356495199970398208, 496138616573952),
	(1501460131219640320, 'admin', '2022-03-09 15:29:26', 0, NULL, NULL, 1356495466673606656, 496138616573952),
	(1501460131232223232, 'admin', '2022-03-09 15:29:26', 0, NULL, NULL, 1356495562643476480, 496138616573952),
	(1501460131240611840, 'admin', '2022-03-09 15:29:26', 0, NULL, NULL, 1356499201571295232, 496138616573952),
	(1501460131249000448, 'admin', '2022-03-09 15:29:26', 0, NULL, NULL, 1356499247591198721, 496138616573952),
	(1501460131257389056, 'admin', '2022-03-09 15:29:26', 0, NULL, NULL, 1356499311105544193, 496138616573952),
	(1501460131261583360, 'admin', '2022-03-09 15:29:26', 0, NULL, NULL, 1356499478537965569, 496138616573952),
	(1501460131265777664, 'admin', '2022-03-09 15:29:26', 0, NULL, NULL, 1356513445691920384, 496138616573952),
	(1501460131269971968, 'admin', '2022-03-09 15:29:26', 0, NULL, NULL, 1356513518173687809, 496138616573952),
	(1501460160273584128, 'admin', '2022-03-09 15:29:33', 0, NULL, NULL, 1356495199970398208, 1356534329106370560),
	(1501460160281972736, 'admin', '2022-03-09 15:29:33', 0, NULL, NULL, 1356495466673606656, 1356534329106370560),
	(1501460160290361344, 'admin', '2022-03-09 15:29:33', 0, NULL, NULL, 1356495562643476480, 1356534329106370560),
	(1501460184663461888, 'admin', '2022-03-09 15:29:38', 0, NULL, NULL, 1356499201571295232, 1356534242120699904),
	(1501460184676044800, 'admin', '2022-03-09 15:29:38', 0, NULL, NULL, 1356499247591198721, 1356534242120699904),
	(1501460184684433408, 'admin', '2022-03-09 15:29:38', 0, NULL, NULL, 1356499311105544193, 1356534242120699904),
	(1501460184692822016, 'admin', '2022-03-09 15:29:38', 0, NULL, NULL, 1356499478537965569, 1356534242120699904),
	(1501460184701210624, 'admin', '2022-03-09 15:29:38', 0, NULL, NULL, 1356513445691920384, 1356534242120699904),
	(1501460184709599232, 'admin', '2022-03-09 15:29:38', 0, NULL, NULL, 1356513518173687809, 1356534242120699904),
	(1501460207954432002, 'admin', '2022-03-09 15:29:44', 0, NULL, NULL, 1356499201571295232, 1356534329106370560),
	(1501460207967014912, 'admin', '2022-03-09 15:29:44', 0, NULL, NULL, 1356499247591198721, 1356534329106370560),
	(1501460207975403520, 'admin', '2022-03-09 15:29:44', 0, NULL, NULL, 1356499311105544193, 1356534329106370560),
	(1501460207979597824, 'admin', '2022-03-09 15:29:44', 0, NULL, NULL, 1356499478537965569, 1356534329106370560),
	(1501460207987986432, 'admin', '2022-03-09 15:29:44', 0, NULL, NULL, 1356513445691920384, 1356534329106370560),
	(1501460207996375040, 'admin', '2022-03-09 15:29:44', 0, NULL, NULL, 1356513518173687809, 1356534329106370560);
/*!40000 ALTER TABLE `t_role_permission` ENABLE KEYS */;

-- 导出  表 bill.t_setting 结构
DROP TABLE IF EXISTS `t_setting`;
CREATE TABLE IF NOT EXISTS `t_setting` (
  `id` varchar(255) NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `value` longtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- 正在导出表  bill.t_setting 的数据：~0 rows (大约)
DELETE FROM `t_setting`;
/*!40000 ALTER TABLE `t_setting` DISABLE KEYS */;
INSERT INTO `t_setting` (`id`, `create_by`, `create_time`, `del_flag`, `update_by`, `update_time`, `value`) VALUES
	('LOCAL_OSS', 'admin', '2021-11-27 14:23:13', 0, 'admin', '2022-01-26 14:16:12', '{"serviceName":"LOCAL_OSS","accessKey":"","secretKey":"**********","endpoint":"127.0.0.1:9999/zwz/file/view","bucket":"","http":"http://","bucketRegion":"","filePath":"C:\\\\oa-file"}'),
	('OSS_USED', 'admin', '2021-11-27 14:23:13', 0, 'admin', '2021-11-27 14:23:13', 'LOCAL_OSS');
/*!40000 ALTER TABLE `t_setting` ENABLE KEYS */;

-- 导出  表 bill.t_supplier 结构
DROP TABLE IF EXISTS `t_supplier`;
CREATE TABLE IF NOT EXISTS `t_supplier` (
  `id` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci NOT NULL,
  `create_by` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci DEFAULT NULL,
  `create_time` datetime(6) DEFAULT NULL,
  `del_flag` int DEFAULT NULL,
  `update_by` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci DEFAULT NULL,
  `update_time` datetime(6) DEFAULT NULL,
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci DEFAULT NULL,
  `mobile` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci DEFAULT NULL,
  `type` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_croatian_ci;

-- 正在导出表  bill.t_supplier 的数据：~3 rows (大约)
DELETE FROM `t_supplier`;
/*!40000 ALTER TABLE `t_supplier` DISABLE KEYS */;
INSERT INTO `t_supplier` (`id`, `create_by`, `create_time`, `del_flag`, `update_by`, `update_time`, `address`, `mobile`, `name`, `type`) VALUES
	('1356521214562144256', 'admin', '2021-02-02 16:33:55.159000', 0, NULL, NULL, '绍兴市越城区XXXX1', '17857661111', 'XXX1食品有限公司', '一级供应商'),
	('1356521286188273665', 'admin', '2021-02-02 16:34:12.232000', 0, NULL, NULL, '北京市东城区XXXX', '17859872222', 'XXX2食品有限公司', '二级供应商'),
	('1356521436071727105', 'admin', '2021-02-02 16:34:47.967000', 0, NULL, NULL, '宁波市海曙区XXXXX', '1769873333', 'XXX3水果有限公司', '三级供应商');
/*!40000 ALTER TABLE `t_supplier` ENABLE KEYS */;

-- 导出  表 bill.t_user 结构
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE IF NOT EXISTS `t_user` (
  `id` bigint unsigned NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `mobile` varchar(255) DEFAULT NULL,
  `nickname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `sex` varchar(255) DEFAULT NULL,
  `status` int DEFAULT NULL,
  `type` int DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `department_id` bigint unsigned DEFAULT NULL,
  `street` varchar(255) DEFAULT NULL,
  `pass_strength` varchar(2) DEFAULT NULL,
  `department_title` varchar(255) DEFAULT NULL,
  `birth` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`) USING BTREE,
  UNIQUE KEY `email` (`email`) USING BTREE,
  UNIQUE KEY `mobile` (`mobile`) USING BTREE,
  KEY `create_time` (`create_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- 正在导出表  bill.t_user 的数据：~3 rows (大约)
DELETE FROM `t_user`;
/*!40000 ALTER TABLE `t_user` DISABLE KEYS */;
INSERT INTO `t_user` (`id`, `create_by`, `create_time`, `update_by`, `update_time`, `address`, `avatar`, `description`, `email`, `mobile`, `nickname`, `password`, `sex`, `status`, `type`, `username`, `del_flag`, `department_id`, `street`, `pass_strength`, `department_title`, `birth`) VALUES
	(682265633886208, '', '2018-05-01 16:13:51', 'admin', '2021-02-02 17:24:19', '["510000","510100","510104"]', 'https://i.loli.net/2019/04/28/5cc5a71a6e3b6.png', '我是大帅逼', 'admin@exrick.cn', '18782059031', '管理员', '$2a$10$PS04ecXfknNd3V8d.ymLTObQciapMU4xU8.GADBZZsuTZr7ymnagy', '男', 0, 1, 'admin', 0, 1356533711235059713, '天府1街', '弱', '信息与机电工程分院', '2020-04-15 00:00:00.000000'),
	(1356540500563333121, 'admin', '2021-02-02 17:50:33', 'admin', '2021-02-02 17:50:33', NULL, 'https://i.loli.net/2019/04/28/5cc5a71a6e3b6.png', NULL, 'staff1@qq.com', '17859651275', '职员A', '$2a$10$gqPjmuz.sAlX05fsPYJsUeOUrt0LaD6WIaN4qxJv1Of4TUTRnFsyi', '女', 0, 0, 'staff1', 0, 1356533743178878977, NULL, '弱', '语言文学分院', NULL),
	(1356540810790834176, 'admin', '2021-02-02 17:51:47', 'admin', '2021-02-02 17:51:47', NULL, 'https://i.loli.net/2019/04/28/5cc5a71a6e3b6.png', NULL, 'header1@qq.com', '17859641235', '经理A', '$2a$10$taDbe.mKzcb47o.9hPpKm.5UJPygYFC3NettuT7phxbklXUde9Of.', '女', 0, 0, 'header1', 0, 1356533797428006913, NULL, '弱', '医药与健康分院', NULL);
/*!40000 ALTER TABLE `t_user` ENABLE KEYS */;

-- 导出  表 bill.t_user_role 结构
DROP TABLE IF EXISTS `t_user_role`;
CREATE TABLE IF NOT EXISTS `t_user_role` (
  `id` bigint unsigned NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `role_id` bigint unsigned DEFAULT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- 正在导出表  bill.t_user_role 的数据：~3 rows (大约)
DELETE FROM `t_user_role`;
/*!40000 ALTER TABLE `t_user_role` DISABLE KEYS */;
INSERT INTO `t_user_role` (`id`, `create_by`, `create_time`, `del_flag`, `update_by`, `update_time`, `role_id`, `user_id`) VALUES
	(1356533899093741568, 'admin', '2021-02-02 17:24:19', 0, 'admin', '2021-02-02 17:24:19', 496138616573952, 682265633886208),
	(1356540500991152128, 'admin', '2021-02-02 17:50:33', 0, 'admin', '2021-02-02 17:50:33', 1356534242120699904, 1356540500563333121),
	(1356540811113795585, 'admin', '2021-02-02 17:51:47', 0, 'admin', '2021-02-02 17:51:47', 1356534329106370560, 1356540810790834176);
/*!40000 ALTER TABLE `t_user_role` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
