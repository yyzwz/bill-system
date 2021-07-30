-- --------------------------------------------------------
-- 主机:                           127.0.0.1
-- 服务器版本:                        5.7.30-log - MySQL Community Server (GPL)
-- 服务器操作系统:                      Win64
-- HeidiSQL 版本:                  10.3.0.5771
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- 导出 bill 的数据库结构
DROP DATABASE IF EXISTS `bill`;
CREATE DATABASE IF NOT EXISTS `bill` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_croatian_ci */;
USE `bill`;

-- 导出  表 bill.act_evt_log 结构
DROP TABLE IF EXISTS `act_evt_log`;
CREATE TABLE IF NOT EXISTS `act_evt_log` (
  `LOG_NR_` bigint(20) NOT NULL AUTO_INCREMENT,
  `TYPE_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TIME_STAMP_` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `DATA_` longblob,
  `LOCK_OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `LOCK_TIME_` timestamp(3) NULL DEFAULT NULL,
  `IS_PROCESSED_` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`LOG_NR_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- 正在导出表  bill.act_evt_log 的数据：~0 rows (大约)
DELETE FROM `act_evt_log`;
/*!40000 ALTER TABLE `act_evt_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_evt_log` ENABLE KEYS */;

-- 导出  表 bill.act_ge_bytearray 结构
DROP TABLE IF EXISTS `act_ge_bytearray`;
CREATE TABLE IF NOT EXISTS `act_ge_bytearray` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `DEPLOYMENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `BYTES_` longblob,
  `GENERATED_` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_FK_BYTEARR_DEPL` (`DEPLOYMENT_ID_`),
  CONSTRAINT `ACT_FK_BYTEARR_DEPL` FOREIGN KEY (`DEPLOYMENT_ID_`) REFERENCES `act_re_deployment` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- 正在导出表  bill.act_ge_bytearray 的数据：~0 rows (大约)
DELETE FROM `act_ge_bytearray`;
/*!40000 ALTER TABLE `act_ge_bytearray` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_ge_bytearray` ENABLE KEYS */;

-- 导出  表 bill.act_ge_property 结构
DROP TABLE IF EXISTS `act_ge_property`;
CREATE TABLE IF NOT EXISTS `act_ge_property` (
  `NAME_` varchar(64) COLLATE utf8_bin NOT NULL,
  `VALUE_` varchar(300) COLLATE utf8_bin DEFAULT NULL,
  `REV_` int(11) DEFAULT NULL,
  PRIMARY KEY (`NAME_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- 正在导出表  bill.act_ge_property 的数据：~3 rows (大约)
DELETE FROM `act_ge_property`;
/*!40000 ALTER TABLE `act_ge_property` DISABLE KEYS */;
INSERT INTO `act_ge_property` (`NAME_`, `VALUE_`, `REV_`) VALUES
	('next.dbid', '1', 1),
	('schema.history', 'create(5.22.0.0)', 1),
	('schema.version', '5.22.0.0', 1);
/*!40000 ALTER TABLE `act_ge_property` ENABLE KEYS */;

-- 导出  表 bill.act_hi_actinst 结构
DROP TABLE IF EXISTS `act_hi_actinst`;
CREATE TABLE IF NOT EXISTS `act_hi_actinst` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `ACT_ID_` varchar(255) COLLATE utf8_bin NOT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `CALL_PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACT_NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `ACT_TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `ASSIGNEE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `START_TIME_` datetime(3) NOT NULL,
  `END_TIME_` datetime(3) DEFAULT NULL,
  `DURATION_` bigint(20) DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_ACT_INST_START` (`START_TIME_`),
  KEY `ACT_IDX_HI_ACT_INST_END` (`END_TIME_`),
  KEY `ACT_IDX_HI_ACT_INST_PROCINST` (`PROC_INST_ID_`,`ACT_ID_`),
  KEY `ACT_IDX_HI_ACT_INST_EXEC` (`EXECUTION_ID_`,`ACT_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- 正在导出表  bill.act_hi_actinst 的数据：~0 rows (大约)
DELETE FROM `act_hi_actinst`;
/*!40000 ALTER TABLE `act_hi_actinst` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_hi_actinst` ENABLE KEYS */;

-- 导出  表 bill.act_hi_attachment 结构
DROP TABLE IF EXISTS `act_hi_attachment`;
CREATE TABLE IF NOT EXISTS `act_hi_attachment` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `URL_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `CONTENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TIME_` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- 正在导出表  bill.act_hi_attachment 的数据：~0 rows (大约)
DELETE FROM `act_hi_attachment`;
/*!40000 ALTER TABLE `act_hi_attachment` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_hi_attachment` ENABLE KEYS */;

-- 导出  表 bill.act_hi_comment 结构
DROP TABLE IF EXISTS `act_hi_comment`;
CREATE TABLE IF NOT EXISTS `act_hi_comment` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TIME_` datetime(3) NOT NULL,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACTION_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `MESSAGE_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `FULL_MSG_` longblob,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- 正在导出表  bill.act_hi_comment 的数据：~0 rows (大约)
DELETE FROM `act_hi_comment`;
/*!40000 ALTER TABLE `act_hi_comment` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_hi_comment` ENABLE KEYS */;

-- 导出  表 bill.act_hi_detail 结构
DROP TABLE IF EXISTS `act_hi_detail`;
CREATE TABLE IF NOT EXISTS `act_hi_detail` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACT_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin NOT NULL,
  `VAR_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `REV_` int(11) DEFAULT NULL,
  `TIME_` datetime(3) NOT NULL,
  `BYTEARRAY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DOUBLE_` double DEFAULT NULL,
  `LONG_` bigint(20) DEFAULT NULL,
  `TEXT_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TEXT2_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_DETAIL_PROC_INST` (`PROC_INST_ID_`),
  KEY `ACT_IDX_HI_DETAIL_ACT_INST` (`ACT_INST_ID_`),
  KEY `ACT_IDX_HI_DETAIL_TIME` (`TIME_`),
  KEY `ACT_IDX_HI_DETAIL_NAME` (`NAME_`),
  KEY `ACT_IDX_HI_DETAIL_TASK_ID` (`TASK_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- 正在导出表  bill.act_hi_detail 的数据：~0 rows (大约)
DELETE FROM `act_hi_detail`;
/*!40000 ALTER TABLE `act_hi_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_hi_detail` ENABLE KEYS */;

-- 导出  表 bill.act_hi_identitylink 结构
DROP TABLE IF EXISTS `act_hi_identitylink`;
CREATE TABLE IF NOT EXISTS `act_hi_identitylink` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `GROUP_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_IDENT_LNK_USER` (`USER_ID_`),
  KEY `ACT_IDX_HI_IDENT_LNK_TASK` (`TASK_ID_`),
  KEY `ACT_IDX_HI_IDENT_LNK_PROCINST` (`PROC_INST_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- 正在导出表  bill.act_hi_identitylink 的数据：~0 rows (大约)
DELETE FROM `act_hi_identitylink`;
/*!40000 ALTER TABLE `act_hi_identitylink` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_hi_identitylink` ENABLE KEYS */;

-- 导出  表 bill.act_hi_procinst 结构
DROP TABLE IF EXISTS `act_hi_procinst`;
CREATE TABLE IF NOT EXISTS `act_hi_procinst` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `BUSINESS_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `START_TIME_` datetime(3) NOT NULL,
  `END_TIME_` datetime(3) DEFAULT NULL,
  `DURATION_` bigint(20) DEFAULT NULL,
  `START_USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `START_ACT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `END_ACT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SUPER_PROCESS_INSTANCE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DELETE_REASON_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  UNIQUE KEY `PROC_INST_ID_` (`PROC_INST_ID_`),
  KEY `ACT_IDX_HI_PRO_INST_END` (`END_TIME_`),
  KEY `ACT_IDX_HI_PRO_I_BUSKEY` (`BUSINESS_KEY_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- 正在导出表  bill.act_hi_procinst 的数据：~0 rows (大约)
DELETE FROM `act_hi_procinst`;
/*!40000 ALTER TABLE `act_hi_procinst` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_hi_procinst` ENABLE KEYS */;

-- 导出  表 bill.act_hi_taskinst 结构
DROP TABLE IF EXISTS `act_hi_taskinst`;
CREATE TABLE IF NOT EXISTS `act_hi_taskinst` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_DEF_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PARENT_TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `ASSIGNEE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `START_TIME_` datetime(3) NOT NULL,
  `CLAIM_TIME_` datetime(3) DEFAULT NULL,
  `END_TIME_` datetime(3) DEFAULT NULL,
  `DURATION_` bigint(20) DEFAULT NULL,
  `DELETE_REASON_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `PRIORITY_` int(11) DEFAULT NULL,
  `DUE_DATE_` datetime(3) DEFAULT NULL,
  `FORM_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_TASK_INST_PROCINST` (`PROC_INST_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- 正在导出表  bill.act_hi_taskinst 的数据：~0 rows (大约)
DELETE FROM `act_hi_taskinst`;
/*!40000 ALTER TABLE `act_hi_taskinst` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_hi_taskinst` ENABLE KEYS */;

-- 导出  表 bill.act_hi_varinst 结构
DROP TABLE IF EXISTS `act_hi_varinst`;
CREATE TABLE IF NOT EXISTS `act_hi_varinst` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin NOT NULL,
  `VAR_TYPE_` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `REV_` int(11) DEFAULT NULL,
  `BYTEARRAY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DOUBLE_` double DEFAULT NULL,
  `LONG_` bigint(20) DEFAULT NULL,
  `TEXT_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TEXT2_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `CREATE_TIME_` datetime(3) DEFAULT NULL,
  `LAST_UPDATED_TIME_` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_PROCVAR_PROC_INST` (`PROC_INST_ID_`),
  KEY `ACT_IDX_HI_PROCVAR_NAME_TYPE` (`NAME_`,`VAR_TYPE_`),
  KEY `ACT_IDX_HI_PROCVAR_TASK_ID` (`TASK_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- 正在导出表  bill.act_hi_varinst 的数据：~0 rows (大约)
DELETE FROM `act_hi_varinst`;
/*!40000 ALTER TABLE `act_hi_varinst` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_hi_varinst` ENABLE KEYS */;

-- 导出  表 bill.act_id_group 结构
DROP TABLE IF EXISTS `act_id_group`;
CREATE TABLE IF NOT EXISTS `act_id_group` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- 正在导出表  bill.act_id_group 的数据：~0 rows (大约)
DELETE FROM `act_id_group`;
/*!40000 ALTER TABLE `act_id_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_id_group` ENABLE KEYS */;

-- 导出  表 bill.act_id_info 结构
DROP TABLE IF EXISTS `act_id_info`;
CREATE TABLE IF NOT EXISTS `act_id_info` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `USER_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `VALUE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PASSWORD_` longblob,
  `PARENT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- 正在导出表  bill.act_id_info 的数据：~0 rows (大约)
DELETE FROM `act_id_info`;
/*!40000 ALTER TABLE `act_id_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_id_info` ENABLE KEYS */;

-- 导出  表 bill.act_id_membership 结构
DROP TABLE IF EXISTS `act_id_membership`;
CREATE TABLE IF NOT EXISTS `act_id_membership` (
  `USER_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `GROUP_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`USER_ID_`,`GROUP_ID_`),
  KEY `ACT_FK_MEMB_GROUP` (`GROUP_ID_`),
  CONSTRAINT `ACT_FK_MEMB_GROUP` FOREIGN KEY (`GROUP_ID_`) REFERENCES `act_id_group` (`ID_`),
  CONSTRAINT `ACT_FK_MEMB_USER` FOREIGN KEY (`USER_ID_`) REFERENCES `act_id_user` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- 正在导出表  bill.act_id_membership 的数据：~0 rows (大约)
DELETE FROM `act_id_membership`;
/*!40000 ALTER TABLE `act_id_membership` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_id_membership` ENABLE KEYS */;

-- 导出  表 bill.act_id_user 结构
DROP TABLE IF EXISTS `act_id_user`;
CREATE TABLE IF NOT EXISTS `act_id_user` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `FIRST_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `LAST_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `EMAIL_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PWD_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PICTURE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- 正在导出表  bill.act_id_user 的数据：~0 rows (大约)
DELETE FROM `act_id_user`;
/*!40000 ALTER TABLE `act_id_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_id_user` ENABLE KEYS */;

-- 导出  表 bill.act_procdef_info 结构
DROP TABLE IF EXISTS `act_procdef_info`;
CREATE TABLE IF NOT EXISTS `act_procdef_info` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `INFO_JSON_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  UNIQUE KEY `ACT_UNIQ_INFO_PROCDEF` (`PROC_DEF_ID_`),
  KEY `ACT_IDX_INFO_PROCDEF` (`PROC_DEF_ID_`),
  KEY `ACT_FK_INFO_JSON_BA` (`INFO_JSON_ID_`),
  CONSTRAINT `ACT_FK_INFO_JSON_BA` FOREIGN KEY (`INFO_JSON_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
  CONSTRAINT `ACT_FK_INFO_PROCDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- 正在导出表  bill.act_procdef_info 的数据：~0 rows (大约)
DELETE FROM `act_procdef_info`;
/*!40000 ALTER TABLE `act_procdef_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_procdef_info` ENABLE KEYS */;

-- 导出  表 bill.act_re_deployment 结构
DROP TABLE IF EXISTS `act_re_deployment`;
CREATE TABLE IF NOT EXISTS `act_re_deployment` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  `DEPLOY_TIME_` timestamp(3) NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- 正在导出表  bill.act_re_deployment 的数据：~0 rows (大约)
DELETE FROM `act_re_deployment`;
/*!40000 ALTER TABLE `act_re_deployment` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_re_deployment` ENABLE KEYS */;

-- 导出  表 bill.act_re_model 结构
DROP TABLE IF EXISTS `act_re_model`;
CREATE TABLE IF NOT EXISTS `act_re_model` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
  `LAST_UPDATE_TIME_` timestamp(3) NULL DEFAULT NULL,
  `VERSION_` int(11) DEFAULT NULL,
  `META_INFO_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DEPLOYMENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EDITOR_SOURCE_VALUE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EDITOR_SOURCE_EXTRA_VALUE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_FK_MODEL_SOURCE` (`EDITOR_SOURCE_VALUE_ID_`),
  KEY `ACT_FK_MODEL_SOURCE_EXTRA` (`EDITOR_SOURCE_EXTRA_VALUE_ID_`),
  KEY `ACT_FK_MODEL_DEPLOYMENT` (`DEPLOYMENT_ID_`),
  CONSTRAINT `ACT_FK_MODEL_DEPLOYMENT` FOREIGN KEY (`DEPLOYMENT_ID_`) REFERENCES `act_re_deployment` (`ID_`),
  CONSTRAINT `ACT_FK_MODEL_SOURCE` FOREIGN KEY (`EDITOR_SOURCE_VALUE_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
  CONSTRAINT `ACT_FK_MODEL_SOURCE_EXTRA` FOREIGN KEY (`EDITOR_SOURCE_EXTRA_VALUE_ID_`) REFERENCES `act_ge_bytearray` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- 正在导出表  bill.act_re_model 的数据：~0 rows (大约)
DELETE FROM `act_re_model`;
/*!40000 ALTER TABLE `act_re_model` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_re_model` ENABLE KEYS */;

-- 导出  表 bill.act_re_procdef 结构
DROP TABLE IF EXISTS `act_re_procdef`;
CREATE TABLE IF NOT EXISTS `act_re_procdef` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `KEY_` varchar(255) COLLATE utf8_bin NOT NULL,
  `VERSION_` int(11) NOT NULL,
  `DEPLOYMENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `RESOURCE_NAME_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DGRM_RESOURCE_NAME_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `HAS_START_FORM_KEY_` tinyint(4) DEFAULT NULL,
  `HAS_GRAPHICAL_NOTATION_` tinyint(4) DEFAULT NULL,
  `SUSPENSION_STATE_` int(11) DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  UNIQUE KEY `ACT_UNIQ_PROCDEF` (`KEY_`,`VERSION_`,`TENANT_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- 正在导出表  bill.act_re_procdef 的数据：~0 rows (大约)
DELETE FROM `act_re_procdef`;
/*!40000 ALTER TABLE `act_re_procdef` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_re_procdef` ENABLE KEYS */;

-- 导出  表 bill.act_ru_event_subscr 结构
DROP TABLE IF EXISTS `act_ru_event_subscr`;
CREATE TABLE IF NOT EXISTS `act_ru_event_subscr` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `EVENT_TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `EVENT_NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACTIVITY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `CONFIGURATION_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CREATED_` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_EVENT_SUBSCR_CONFIG_` (`CONFIGURATION_`),
  KEY `ACT_FK_EVENT_EXEC` (`EXECUTION_ID_`),
  CONSTRAINT `ACT_FK_EVENT_EXEC` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- 正在导出表  bill.act_ru_event_subscr 的数据：~0 rows (大约)
DELETE FROM `act_ru_event_subscr`;
/*!40000 ALTER TABLE `act_ru_event_subscr` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_ru_event_subscr` ENABLE KEYS */;

-- 导出  表 bill.act_ru_execution 结构
DROP TABLE IF EXISTS `act_ru_execution`;
CREATE TABLE IF NOT EXISTS `act_ru_execution` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `BUSINESS_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PARENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `SUPER_EXEC_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `IS_ACTIVE_` tinyint(4) DEFAULT NULL,
  `IS_CONCURRENT_` tinyint(4) DEFAULT NULL,
  `IS_SCOPE_` tinyint(4) DEFAULT NULL,
  `IS_EVENT_SCOPE_` tinyint(4) DEFAULT NULL,
  `SUSPENSION_STATE_` int(11) DEFAULT NULL,
  `CACHED_ENT_STATE_` int(11) DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `LOCK_TIME_` timestamp(3) NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_EXEC_BUSKEY` (`BUSINESS_KEY_`),
  KEY `ACT_FK_EXE_PROCINST` (`PROC_INST_ID_`),
  KEY `ACT_FK_EXE_PARENT` (`PARENT_ID_`),
  KEY `ACT_FK_EXE_SUPER` (`SUPER_EXEC_`),
  KEY `ACT_FK_EXE_PROCDEF` (`PROC_DEF_ID_`),
  CONSTRAINT `ACT_FK_EXE_PARENT` FOREIGN KEY (`PARENT_ID_`) REFERENCES `act_ru_execution` (`ID_`),
  CONSTRAINT `ACT_FK_EXE_PROCDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`),
  CONSTRAINT `ACT_FK_EXE_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ACT_FK_EXE_SUPER` FOREIGN KEY (`SUPER_EXEC_`) REFERENCES `act_ru_execution` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- 正在导出表  bill.act_ru_execution 的数据：~0 rows (大约)
DELETE FROM `act_ru_execution`;
/*!40000 ALTER TABLE `act_ru_execution` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_ru_execution` ENABLE KEYS */;

-- 导出  表 bill.act_ru_identitylink 结构
DROP TABLE IF EXISTS `act_ru_identitylink`;
CREATE TABLE IF NOT EXISTS `act_ru_identitylink` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `GROUP_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_IDENT_LNK_USER` (`USER_ID_`),
  KEY `ACT_IDX_IDENT_LNK_GROUP` (`GROUP_ID_`),
  KEY `ACT_IDX_ATHRZ_PROCEDEF` (`PROC_DEF_ID_`),
  KEY `ACT_FK_TSKASS_TASK` (`TASK_ID_`),
  KEY `ACT_FK_IDL_PROCINST` (`PROC_INST_ID_`),
  CONSTRAINT `ACT_FK_ATHRZ_PROCEDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`),
  CONSTRAINT `ACT_FK_IDL_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`),
  CONSTRAINT `ACT_FK_TSKASS_TASK` FOREIGN KEY (`TASK_ID_`) REFERENCES `act_ru_task` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- 正在导出表  bill.act_ru_identitylink 的数据：~0 rows (大约)
DELETE FROM `act_ru_identitylink`;
/*!40000 ALTER TABLE `act_ru_identitylink` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_ru_identitylink` ENABLE KEYS */;

-- 导出  表 bill.act_ru_job 结构
DROP TABLE IF EXISTS `act_ru_job`;
CREATE TABLE IF NOT EXISTS `act_ru_job` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `LOCK_EXP_TIME_` timestamp(3) NULL DEFAULT NULL,
  `LOCK_OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `EXCLUSIVE_` tinyint(1) DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROCESS_INSTANCE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `RETRIES_` int(11) DEFAULT NULL,
  `EXCEPTION_STACK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXCEPTION_MSG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DUEDATE_` timestamp(3) NULL DEFAULT NULL,
  `REPEAT_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `HANDLER_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `HANDLER_CFG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_FK_JOB_EXCEPTION` (`EXCEPTION_STACK_ID_`),
  CONSTRAINT `ACT_FK_JOB_EXCEPTION` FOREIGN KEY (`EXCEPTION_STACK_ID_`) REFERENCES `act_ge_bytearray` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- 正在导出表  bill.act_ru_job 的数据：~0 rows (大约)
DELETE FROM `act_ru_job`;
/*!40000 ALTER TABLE `act_ru_job` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_ru_job` ENABLE KEYS */;

-- 导出  表 bill.act_ru_task 结构
DROP TABLE IF EXISTS `act_ru_task`;
CREATE TABLE IF NOT EXISTS `act_ru_task` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PARENT_TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TASK_DEF_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `ASSIGNEE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `DELEGATION_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PRIORITY_` int(11) DEFAULT NULL,
  `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
  `DUE_DATE_` datetime(3) DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SUSPENSION_STATE_` int(11) DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  `FORM_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_TASK_CREATE` (`CREATE_TIME_`),
  KEY `ACT_FK_TASK_EXE` (`EXECUTION_ID_`),
  KEY `ACT_FK_TASK_PROCINST` (`PROC_INST_ID_`),
  KEY `ACT_FK_TASK_PROCDEF` (`PROC_DEF_ID_`),
  CONSTRAINT `ACT_FK_TASK_EXE` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`),
  CONSTRAINT `ACT_FK_TASK_PROCDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`),
  CONSTRAINT `ACT_FK_TASK_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- 正在导出表  bill.act_ru_task 的数据：~0 rows (大约)
DELETE FROM `act_ru_task`;
/*!40000 ALTER TABLE `act_ru_task` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_ru_task` ENABLE KEYS */;

-- 导出  表 bill.act_ru_variable 结构
DROP TABLE IF EXISTS `act_ru_variable`;
CREATE TABLE IF NOT EXISTS `act_ru_variable` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin NOT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `BYTEARRAY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DOUBLE_` double DEFAULT NULL,
  `LONG_` bigint(20) DEFAULT NULL,
  `TEXT_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TEXT2_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_VARIABLE_TASK_ID` (`TASK_ID_`),
  KEY `ACT_FK_VAR_EXE` (`EXECUTION_ID_`),
  KEY `ACT_FK_VAR_PROCINST` (`PROC_INST_ID_`),
  KEY `ACT_FK_VAR_BYTEARRAY` (`BYTEARRAY_ID_`),
  CONSTRAINT `ACT_FK_VAR_BYTEARRAY` FOREIGN KEY (`BYTEARRAY_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
  CONSTRAINT `ACT_FK_VAR_EXE` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`),
  CONSTRAINT `ACT_FK_VAR_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- 正在导出表  bill.act_ru_variable 的数据：~0 rows (大约)
DELETE FROM `act_ru_variable`;
/*!40000 ALTER TABLE `act_ru_variable` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_ru_variable` ENABLE KEYS */;

-- 导出  表 bill.app_member 结构
DROP TABLE IF EXISTS `app_member`;
CREATE TABLE IF NOT EXISTS `app_member` (
  `id` bigint(20) unsigned NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime(6) DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime(6) DEFAULT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `mobile` varchar(255) DEFAULT NULL,
  `nickname` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `platform` tinyint(1) DEFAULT NULL,
  `sex` varchar(255) DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `type` tinyint(1) DEFAULT NULL,
  `username` varchar(255) NOT NULL,
  `vip_end_time` datetime(6) DEFAULT NULL,
  `vip_start_time` datetime(6) DEFAULT NULL,
  `permissions` varchar(255) DEFAULT NULL,
  `vip_status` tinyint(1) DEFAULT NULL,
  `birth` datetime(6) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `invite_code` varchar(255) DEFAULT NULL,
  `grade` int(11) unsigned DEFAULT NULL,
  `position` varchar(255) DEFAULT NULL,
  `invite_by` varchar(255) DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `mobile` (`mobile`) USING BTREE,
  UNIQUE KEY `invite_code` (`invite_code`) USING BTREE,
  KEY `create_time` (`create_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  bill.app_member 的数据：~3 rows (大约)
DELETE FROM `app_member`;
/*!40000 ALTER TABLE `app_member` DISABLE KEYS */;
INSERT INTO `app_member` (`id`, `create_by`, `create_time`, `del_flag`, `update_by`, `update_time`, `avatar`, `email`, `mobile`, `nickname`, `password`, `platform`, `sex`, `status`, `type`, `username`, `vip_end_time`, `vip_start_time`, `permissions`, `vip_status`, `birth`, `address`, `invite_code`, `grade`, `position`, `invite_by`, `description`) VALUES
	(255227305549369344, '', '2020-03-25 21:14:32.000000', 0, 'admin', '2020-04-27 17:20:45.307000', 'https://i.loli.net/2020/04/18/NmF3IP4TOoVbLf5.png', '', '18782059031', '187****9031', NULL, -1, '', 0, 1, '1251014922381430800', '2030-04-30 00:00:00.000000', '2020-04-01 00:00:00.000000', 'MEMBER', 1, NULL, '中国 北京市 北京市 朝阳区 酒仙桥路 3号 电子城．国际电子总部', '12N3VE6CK440G', 0, '30.5681733200,104.0666198700', '', NULL),
	(1251783645962833920, 'admin', '2020-04-19 16:04:12.000000', 0, 'admin', '2020-04-27 17:24:23.091000', 'https://i.loli.net/2020/04/18/NmF3IP4TOoVbLf5.png', '', '18782059092', '187****9092', NULL, 1, '', 0, 1, '1251783646004776960', '2020-04-07 00:00:00.000000', '2020-04-01 00:00:00.000000', 'MEMBER', 2, NULL, '中国 北京市 北京市 朝阳区 酒仙桥路 3号 电子城．国际电子总部', '12NPQJ01S4400', 0, '30.5681733200,104.0666198700', '1251014922381430800', NULL),
	(1251783729291071489, 'admin', '2020-04-19 16:04:32.000000', 0, 'admin', '2020-04-27 22:03:48.509000', 'https://i.loli.net/2020/04/18/NmF3IP4TOoVbLf5.png', '', '18782059033', '187****9093', NULL, 2, '', 0, 0, '1251783729303654400', NULL, NULL, 'MEMBER', 0, NULL, '中国 北京市 北京市 朝阳区 酒仙桥路 3号 电子城．国际电子总部', '12NPQLDKC4400', 0, '30.5681733200,104.0666198700', '1251014922381430800', NULL);
/*!40000 ALTER TABLE `app_member` ENABLE KEYS */;

-- 导出  表 bill.qrtz_blob_triggers 结构
DROP TABLE IF EXISTS `qrtz_blob_triggers`;
CREATE TABLE IF NOT EXISTS `qrtz_blob_triggers` (
  `SCHED_NAME` varchar(120) COLLATE utf8_croatian_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) COLLATE utf8_croatian_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) COLLATE utf8_croatian_ci NOT NULL,
  `BLOB_DATA` blob,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_croatian_ci;

-- 正在导出表  bill.qrtz_blob_triggers 的数据：~0 rows (大约)
DELETE FROM `qrtz_blob_triggers`;
/*!40000 ALTER TABLE `qrtz_blob_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_blob_triggers` ENABLE KEYS */;

-- 导出  表 bill.qrtz_calendars 结构
DROP TABLE IF EXISTS `qrtz_calendars`;
CREATE TABLE IF NOT EXISTS `qrtz_calendars` (
  `SCHED_NAME` varchar(120) COLLATE utf8_croatian_ci NOT NULL,
  `CALENDAR_NAME` varchar(200) COLLATE utf8_croatian_ci NOT NULL,
  `CALENDAR` blob NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`CALENDAR_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_croatian_ci;

-- 正在导出表  bill.qrtz_calendars 的数据：~0 rows (大约)
DELETE FROM `qrtz_calendars`;
/*!40000 ALTER TABLE `qrtz_calendars` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_calendars` ENABLE KEYS */;

-- 导出  表 bill.qrtz_cron_triggers 结构
DROP TABLE IF EXISTS `qrtz_cron_triggers`;
CREATE TABLE IF NOT EXISTS `qrtz_cron_triggers` (
  `SCHED_NAME` varchar(120) COLLATE utf8_croatian_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) COLLATE utf8_croatian_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) COLLATE utf8_croatian_ci NOT NULL,
  `CRON_EXPRESSION` varchar(200) COLLATE utf8_croatian_ci NOT NULL,
  `TIME_ZONE_ID` varchar(80) COLLATE utf8_croatian_ci DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_croatian_ci;

-- 正在导出表  bill.qrtz_cron_triggers 的数据：~0 rows (大约)
DELETE FROM `qrtz_cron_triggers`;
/*!40000 ALTER TABLE `qrtz_cron_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_cron_triggers` ENABLE KEYS */;

-- 导出  表 bill.qrtz_fired_triggers 结构
DROP TABLE IF EXISTS `qrtz_fired_triggers`;
CREATE TABLE IF NOT EXISTS `qrtz_fired_triggers` (
  `SCHED_NAME` varchar(120) COLLATE utf8_croatian_ci NOT NULL,
  `ENTRY_ID` varchar(95) COLLATE utf8_croatian_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) COLLATE utf8_croatian_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) COLLATE utf8_croatian_ci NOT NULL,
  `INSTANCE_NAME` varchar(200) COLLATE utf8_croatian_ci NOT NULL,
  `FIRED_TIME` bigint(13) NOT NULL,
  `SCHED_TIME` bigint(13) NOT NULL,
  `PRIORITY` int(11) NOT NULL,
  `STATE` varchar(16) COLLATE utf8_croatian_ci NOT NULL,
  `JOB_NAME` varchar(200) COLLATE utf8_croatian_ci DEFAULT NULL,
  `JOB_GROUP` varchar(200) COLLATE utf8_croatian_ci DEFAULT NULL,
  `IS_NONCONCURRENT` varchar(1) COLLATE utf8_croatian_ci DEFAULT NULL,
  `REQUESTS_RECOVERY` varchar(1) COLLATE utf8_croatian_ci DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`,`ENTRY_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_croatian_ci;

-- 正在导出表  bill.qrtz_fired_triggers 的数据：~0 rows (大约)
DELETE FROM `qrtz_fired_triggers`;
/*!40000 ALTER TABLE `qrtz_fired_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_fired_triggers` ENABLE KEYS */;

-- 导出  表 bill.qrtz_job_details 结构
DROP TABLE IF EXISTS `qrtz_job_details`;
CREATE TABLE IF NOT EXISTS `qrtz_job_details` (
  `SCHED_NAME` varchar(120) COLLATE utf8_croatian_ci NOT NULL,
  `JOB_NAME` varchar(200) COLLATE utf8_croatian_ci NOT NULL,
  `JOB_GROUP` varchar(200) COLLATE utf8_croatian_ci NOT NULL,
  `DESCRIPTION` varchar(250) COLLATE utf8_croatian_ci DEFAULT NULL,
  `JOB_CLASS_NAME` varchar(250) COLLATE utf8_croatian_ci NOT NULL,
  `IS_DURABLE` varchar(1) COLLATE utf8_croatian_ci NOT NULL,
  `IS_NONCONCURRENT` varchar(1) COLLATE utf8_croatian_ci NOT NULL,
  `IS_UPDATE_DATA` varchar(1) COLLATE utf8_croatian_ci NOT NULL,
  `REQUESTS_RECOVERY` varchar(1) COLLATE utf8_croatian_ci NOT NULL,
  `JOB_DATA` blob,
  PRIMARY KEY (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_croatian_ci;

-- 正在导出表  bill.qrtz_job_details 的数据：~0 rows (大约)
DELETE FROM `qrtz_job_details`;
/*!40000 ALTER TABLE `qrtz_job_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_job_details` ENABLE KEYS */;

-- 导出  表 bill.qrtz_locks 结构
DROP TABLE IF EXISTS `qrtz_locks`;
CREATE TABLE IF NOT EXISTS `qrtz_locks` (
  `SCHED_NAME` varchar(120) COLLATE utf8_croatian_ci NOT NULL,
  `LOCK_NAME` varchar(40) COLLATE utf8_croatian_ci NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`LOCK_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_croatian_ci;

-- 正在导出表  bill.qrtz_locks 的数据：~0 rows (大约)
DELETE FROM `qrtz_locks`;
/*!40000 ALTER TABLE `qrtz_locks` DISABLE KEYS */;
INSERT INTO `qrtz_locks` (`SCHED_NAME`, `LOCK_NAME`) VALUES
	('quartzScheduler', 'TRIGGER_ACCESS');
/*!40000 ALTER TABLE `qrtz_locks` ENABLE KEYS */;

-- 导出  表 bill.qrtz_paused_trigger_grps 结构
DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;
CREATE TABLE IF NOT EXISTS `qrtz_paused_trigger_grps` (
  `SCHED_NAME` varchar(120) COLLATE utf8_croatian_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) COLLATE utf8_croatian_ci NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_croatian_ci;

-- 正在导出表  bill.qrtz_paused_trigger_grps 的数据：~0 rows (大约)
DELETE FROM `qrtz_paused_trigger_grps`;
/*!40000 ALTER TABLE `qrtz_paused_trigger_grps` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_paused_trigger_grps` ENABLE KEYS */;

-- 导出  表 bill.qrtz_scheduler_state 结构
DROP TABLE IF EXISTS `qrtz_scheduler_state`;
CREATE TABLE IF NOT EXISTS `qrtz_scheduler_state` (
  `SCHED_NAME` varchar(120) COLLATE utf8_croatian_ci NOT NULL,
  `INSTANCE_NAME` varchar(200) COLLATE utf8_croatian_ci NOT NULL,
  `LAST_CHECKIN_TIME` bigint(13) NOT NULL,
  `CHECKIN_INTERVAL` bigint(13) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`INSTANCE_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_croatian_ci;

-- 正在导出表  bill.qrtz_scheduler_state 的数据：~0 rows (大约)
DELETE FROM `qrtz_scheduler_state`;
/*!40000 ALTER TABLE `qrtz_scheduler_state` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_scheduler_state` ENABLE KEYS */;

-- 导出  表 bill.qrtz_simple_triggers 结构
DROP TABLE IF EXISTS `qrtz_simple_triggers`;
CREATE TABLE IF NOT EXISTS `qrtz_simple_triggers` (
  `SCHED_NAME` varchar(120) COLLATE utf8_croatian_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) COLLATE utf8_croatian_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) COLLATE utf8_croatian_ci NOT NULL,
  `REPEAT_COUNT` bigint(7) NOT NULL,
  `REPEAT_INTERVAL` bigint(12) NOT NULL,
  `TIMES_TRIGGERED` bigint(10) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_croatian_ci;

-- 正在导出表  bill.qrtz_simple_triggers 的数据：~0 rows (大约)
DELETE FROM `qrtz_simple_triggers`;
/*!40000 ALTER TABLE `qrtz_simple_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_simple_triggers` ENABLE KEYS */;

-- 导出  表 bill.qrtz_simprop_triggers 结构
DROP TABLE IF EXISTS `qrtz_simprop_triggers`;
CREATE TABLE IF NOT EXISTS `qrtz_simprop_triggers` (
  `SCHED_NAME` varchar(120) COLLATE utf8_croatian_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) COLLATE utf8_croatian_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) COLLATE utf8_croatian_ci NOT NULL,
  `STR_PROP_1` varchar(512) COLLATE utf8_croatian_ci DEFAULT NULL,
  `STR_PROP_2` varchar(512) COLLATE utf8_croatian_ci DEFAULT NULL,
  `STR_PROP_3` varchar(512) COLLATE utf8_croatian_ci DEFAULT NULL,
  `INT_PROP_1` int(11) DEFAULT NULL,
  `INT_PROP_2` int(11) DEFAULT NULL,
  `LONG_PROP_1` bigint(20) DEFAULT NULL,
  `LONG_PROP_2` bigint(20) DEFAULT NULL,
  `DEC_PROP_1` decimal(13,4) DEFAULT NULL,
  `DEC_PROP_2` decimal(13,4) DEFAULT NULL,
  `BOOL_PROP_1` varchar(1) COLLATE utf8_croatian_ci DEFAULT NULL,
  `BOOL_PROP_2` varchar(1) COLLATE utf8_croatian_ci DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_croatian_ci;

-- 正在导出表  bill.qrtz_simprop_triggers 的数据：~0 rows (大约)
DELETE FROM `qrtz_simprop_triggers`;
/*!40000 ALTER TABLE `qrtz_simprop_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_simprop_triggers` ENABLE KEYS */;

-- 导出  表 bill.qrtz_triggers 结构
DROP TABLE IF EXISTS `qrtz_triggers`;
CREATE TABLE IF NOT EXISTS `qrtz_triggers` (
  `SCHED_NAME` varchar(120) COLLATE utf8_croatian_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) COLLATE utf8_croatian_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) COLLATE utf8_croatian_ci NOT NULL,
  `JOB_NAME` varchar(200) COLLATE utf8_croatian_ci NOT NULL,
  `JOB_GROUP` varchar(200) COLLATE utf8_croatian_ci NOT NULL,
  `DESCRIPTION` varchar(250) COLLATE utf8_croatian_ci DEFAULT NULL,
  `NEXT_FIRE_TIME` bigint(13) DEFAULT NULL,
  `PREV_FIRE_TIME` bigint(13) DEFAULT NULL,
  `PRIORITY` int(11) DEFAULT NULL,
  `TRIGGER_STATE` varchar(16) COLLATE utf8_croatian_ci NOT NULL,
  `TRIGGER_TYPE` varchar(8) COLLATE utf8_croatian_ci NOT NULL,
  `START_TIME` bigint(13) NOT NULL,
  `END_TIME` bigint(13) DEFAULT NULL,
  `CALENDAR_NAME` varchar(200) COLLATE utf8_croatian_ci DEFAULT NULL,
  `MISFIRE_INSTR` smallint(2) DEFAULT NULL,
  `JOB_DATA` blob,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  KEY `SCHED_NAME` (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`),
  CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) REFERENCES `qrtz_job_details` (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_croatian_ci;

-- 正在导出表  bill.qrtz_triggers 的数据：~0 rows (大约)
DELETE FROM `qrtz_triggers`;
/*!40000 ALTER TABLE `qrtz_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_triggers` ENABLE KEYS */;

-- 导出  表 bill.t_act_business 结构
DROP TABLE IF EXISTS `t_act_business`;
CREATE TABLE IF NOT EXISTS `t_act_business` (
  `id` bigint(20) unsigned NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `proc_def_id` varchar(255) DEFAULT NULL,
  `proc_inst_id` varchar(255) DEFAULT NULL,
  `result` tinyint(1) DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `table_id` bigint(20) unsigned DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `apply_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `create_time` (`create_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  bill.t_act_business 的数据：~0 rows (大约)
DELETE FROM `t_act_business`;
/*!40000 ALTER TABLE `t_act_business` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_act_business` ENABLE KEYS */;

-- 导出  表 bill.t_act_category 结构
DROP TABLE IF EXISTS `t_act_category`;
CREATE TABLE IF NOT EXISTS `t_act_category` (
  `id` bigint(20) unsigned NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `is_parent` bit(1) DEFAULT NULL,
  `parent_id` bigint(20) unsigned DEFAULT NULL,
  `sort_order` decimal(10,2) DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `type` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  bill.t_act_category 的数据：~0 rows (大约)
DELETE FROM `t_act_category`;
/*!40000 ALTER TABLE `t_act_category` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_act_category` ENABLE KEYS */;

-- 导出  表 bill.t_act_model 结构
DROP TABLE IF EXISTS `t_act_model`;
CREATE TABLE IF NOT EXISTS `t_act_model` (
  `id` bigint(20) unsigned NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `model_key` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `version` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `create_time` (`create_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  bill.t_act_model 的数据：~0 rows (大约)
DELETE FROM `t_act_model`;
/*!40000 ALTER TABLE `t_act_model` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_act_model` ENABLE KEYS */;

-- 导出  表 bill.t_act_node 结构
DROP TABLE IF EXISTS `t_act_node`;
CREATE TABLE IF NOT EXISTS `t_act_node` (
  `id` bigint(20) unsigned NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `node_id` varchar(255) DEFAULT NULL,
  `type` tinyint(1) DEFAULT NULL,
  `relate_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  bill.t_act_node 的数据：~0 rows (大约)
DELETE FROM `t_act_node`;
/*!40000 ALTER TABLE `t_act_node` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_act_node` ENABLE KEYS */;

-- 导出  表 bill.t_act_process 结构
DROP TABLE IF EXISTS `t_act_process`;
CREATE TABLE IF NOT EXISTS `t_act_process` (
  `id` varchar(255) NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `category_id` bigint(20) unsigned DEFAULT NULL,
  `deployment_id` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `diagram_name` varchar(255) DEFAULT NULL,
  `latest` bit(1) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `process_key` varchar(255) DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  `xml_name` varchar(255) DEFAULT NULL,
  `business_table` varchar(255) DEFAULT NULL,
  `route_name` varchar(255) DEFAULT NULL,
  `all_user` bit(1) DEFAULT NULL,
  `category_title` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `create_time` (`create_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  bill.t_act_process 的数据：~0 rows (大约)
DELETE FROM `t_act_process`;
/*!40000 ALTER TABLE `t_act_process` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_act_process` ENABLE KEYS */;

-- 导出  表 bill.t_act_starter 结构
DROP TABLE IF EXISTS `t_act_starter`;
CREATE TABLE IF NOT EXISTS `t_act_starter` (
  `id` bigint(20) unsigned NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime(6) DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime(6) DEFAULT NULL,
  `process_def_id` varchar(255) DEFAULT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  bill.t_act_starter 的数据：~0 rows (大约)
DELETE FROM `t_act_starter`;
/*!40000 ALTER TABLE `t_act_starter` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_act_starter` ENABLE KEYS */;

-- 导出  表 bill.t_bill 结构
DROP TABLE IF EXISTS `t_bill`;
CREATE TABLE IF NOT EXISTS `t_bill` (
  `id` varchar(255) COLLATE utf8_croatian_ci NOT NULL,
  `create_by` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `create_time` datetime(6) DEFAULT NULL,
  `del_flag` int(11) DEFAULT NULL,
  `update_by` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `update_time` datetime(6) DEFAULT NULL,
  `commodity_id` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `supplier_id` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `user_id` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `date_time` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `number` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `price` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `sum` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_croatian_ci;

-- 正在导出表  bill.t_bill 的数据：~0 rows (大约)
DELETE FROM `t_bill`;
/*!40000 ALTER TABLE `t_bill` DISABLE KEYS */;
INSERT INTO `t_bill` (`id`, `create_by`, `create_time`, `del_flag`, `update_by`, `update_time`, `commodity_id`, `supplier_id`, `user_id`, `date_time`, `number`, `price`, `sum`) VALUES
	('1356533591177302017', 'admin', '2021-02-02 17:23:05.985000', 0, NULL, NULL, '1356526407001444353', '1356521214562144256', '682265633886208', '2021-02-02', '65', '3.2', '208.0');
/*!40000 ALTER TABLE `t_bill` ENABLE KEYS */;

-- 导出  表 bill.t_client 结构
DROP TABLE IF EXISTS `t_client`;
CREATE TABLE IF NOT EXISTS `t_client` (
  `id` bigint(20) unsigned NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime(6) DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime(6) DEFAULT NULL,
  `client_secret` varchar(255) DEFAULT NULL,
  `home_uri` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `redirect_uri` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `create_time` (`create_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  bill.t_client 的数据：~0 rows (大约)
DELETE FROM `t_client`;
/*!40000 ALTER TABLE `t_client` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_client` ENABLE KEYS */;

-- 导出  表 bill.t_commodity 结构
DROP TABLE IF EXISTS `t_commodity`;
CREATE TABLE IF NOT EXISTS `t_commodity` (
  `id` varchar(255) COLLATE utf8_croatian_ci NOT NULL,
  `create_by` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `create_time` datetime(6) DEFAULT NULL,
  `del_flag` int(11) DEFAULT NULL,
  `update_by` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `update_time` datetime(6) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `stock` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `supplier_id` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `type` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `unit_price` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_croatian_ci;

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
  `id` bigint(20) unsigned NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` int(11) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `parent_id` bigint(20) unsigned DEFAULT NULL,
  `sort_order` decimal(10,2) DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `is_parent` bit(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
  `id` bigint(20) unsigned NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `department_id` bigint(20) unsigned DEFAULT NULL,
  `type` tinyint(1) DEFAULT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  bill.t_department_header 的数据：~0 rows (大约)
DELETE FROM `t_department_header`;
/*!40000 ALTER TABLE `t_department_header` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_department_header` ENABLE KEYS */;

-- 导出  表 bill.t_dict 结构
DROP TABLE IF EXISTS `t_dict`;
CREATE TABLE IF NOT EXISTS `t_dict` (
  `id` bigint(20) unsigned NOT NULL,
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  bill.t_dict 的数据：~11 rows (大约)
DELETE FROM `t_dict`;
/*!40000 ALTER TABLE `t_dict` DISABLE KEYS */;
INSERT INTO `t_dict` (`id`, `create_by`, `create_time`, `del_flag`, `update_by`, `update_time`, `description`, `title`, `type`, `sort_order`) VALUES
	(75135930788220928, 'admin', '2018-11-14 22:15:43', 0, 'admin', '2018-11-27 01:39:06', '', '性别', 'sex', 0.00),
	(75383353938808832, 'admin', '2018-11-15 14:38:53', 0, 'admin', '2018-11-27 01:39:15', '', '消息类型', 'message_type', 1.00),
	(75388696739713024, 'admin', '2018-11-15 15:00:07', 0, 'admin', '2018-11-27 01:39:22', '', '按钮权限类型', 'permission_type', 2.00),
	(75392985935646720, 'admin', '2018-11-15 15:17:10', 0, 'admin', '2018-11-27 01:39:29', '', '腾讯云对象存储区域', 'tencent_bucket_region', 3.00),
	(79717732567748608, 'admin', '2018-11-27 13:42:10', 0, 'admin', '2018-11-27 13:42:10', '', '流程节点类型', 'process_node_type', 4.00),
	(81843858882695168, 'admin', '2018-12-03 10:30:38', 0, 'admin', '2018-12-03 10:30:49', '', '优先级', 'priority', 5.00),
	(82236987314016256, 'admin', '2018-12-04 12:32:47', 0, 'admin', '2018-12-04 12:32:47', '', '业务表', 'business_table', 6.00),
	(82236987314016257, 'admin', '2018-12-04 12:32:47', 0, 'admin', '2018-12-04 12:32:47', '', '业务表单路由', 'business_form', 7.00),
	(99020862912466944, 'admin', '2019-01-19 20:05:54', 0, 'admin', '2019-01-19 20:06:10', '', '请假类型', 'leave_type', 8.00),
	(1356516237135450113, 'admin', '2021-02-02 16:14:08', 0, 'admin', '2021-02-02 16:15:24', '', '商品类型', 'commodity_type', 9.00),
	(1356519672450781184, 'admin', '2021-02-02 16:27:47', 0, 'admin', '2021-02-02 16:30:48', '', '供应商类型', 'supplierType', 0.00);
/*!40000 ALTER TABLE `t_dict` ENABLE KEYS */;

-- 导出  表 bill.t_dict_data 结构
DROP TABLE IF EXISTS `t_dict_data`;
CREATE TABLE IF NOT EXISTS `t_dict_data` (
  `id` bigint(20) unsigned NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `dict_id` bigint(20) unsigned DEFAULT NULL,
  `sort_order` decimal(10,2) DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sort_order` (`sort_order`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  bill.t_dict_data 的数据：~61 rows (大约)
DELETE FROM `t_dict_data`;
/*!40000 ALTER TABLE `t_dict_data` DISABLE KEYS */;
INSERT INTO `t_dict_data` (`id`, `create_by`, `create_time`, `del_flag`, `update_by`, `update_time`, `description`, `dict_id`, `sort_order`, `status`, `title`, `value`) VALUES
	(75158227712479232, 'admin', '2018-11-14 23:44:19', 0, 'admin', '2019-04-01 23:53:13', '', 75135930788220928, 0.00, 0, '男', '男'),
	(75159254272577536, 'admin', '2018-11-14 23:48:24', 0, 'admin', '2019-04-01 23:53:17', '', 75135930788220928, 1.00, 0, '女', '女'),
	(75159898425397248, 'admin', '2018-11-14 23:50:57', 0, 'admin', '2019-04-01 23:53:22', '', 75135930788220928, 2.00, -1, '保密', '保密'),
	(75385648017575936, 'admin', '2018-11-15 14:48:00', 0, 'admin', '2019-04-02 00:10:36', '', 75383353938808832, 0.00, 0, '系统公告', '系统公告'),
	(75385706913992704, 'admin', '2018-11-15 14:48:14', 0, 'admin', '2019-04-02 00:10:32', '', 75383353938808832, 1.00, 0, '提醒', '提醒'),
	(75385774274514944, 'admin', '2018-11-15 14:48:30', 0, 'admin', '2019-04-02 00:10:28', '', 75383353938808832, 2.00, 0, '私信', '私信'),
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
	(75393605291741184, 'admin', '2018-11-15 15:19:37', 0, 'admin', '2018-11-15 15:19:37', '', 75392985935646720, 0.00, 0, '北京一区（华北）', 'ap-beijing-1'),
	(75393681254780928, 'admin', '2018-11-15 15:19:55', 0, 'admin', '2018-11-15 15:19:55', '', 75392985935646720, 1.00, 0, '北京', 'ap-beijing'),
	(75393767619694592, 'admin', '2018-11-15 15:20:16', 0, 'admin', '2018-11-15 15:20:16', '', 75392985935646720, 2.00, 0, '上海（华东）', 'ap-shanghai'),
	(75393851484803072, 'admin', '2018-11-15 15:20:36', 0, 'admin', '2018-11-15 15:20:36', '', 75392985935646720, 3.00, 0, '广州（华南）', 'ap-guangzhou'),
	(75393961887272960, 'admin', '2018-11-15 15:21:02', 0, 'admin', '2018-11-15 15:21:02', '', 75392985935646720, 4.00, 0, '成都（西南）', 'ap-chengdu'),
	(75394053969022976, 'admin', '2018-11-15 15:21:24', 0, 'admin', '2018-11-15 15:21:24', '', 75392985935646720, 5.00, 0, '重庆', 'ap-chongqing'),
	(75394122474590208, 'admin', '2018-11-15 15:21:41', 0, 'admin', '2018-11-15 15:21:41', '', 75392985935646720, 6.00, 0, '新加坡', 'ap-singapore'),
	(75394186202845184, 'admin', '2018-11-15 15:21:56', 0, 'admin', '2018-11-15 15:21:56', '', 75392985935646720, 7.00, 0, '香港', 'ap-hongkong'),
	(75394254255427584, 'admin', '2018-11-15 15:22:12', 0, 'admin', '2018-11-15 15:22:12', '', 75392985935646720, 8.00, 0, '多伦多', 'na-toronto'),
	(75394309125312512, 'admin', '2018-11-15 15:22:25', 0, 'admin', '2018-11-15 15:22:25', '', 75392985935646720, 9.00, 0, '法兰克福', 'eu-frankfurt'),
	(75394367044456448, 'admin', '2018-11-15 15:22:39', 0, 'admin', '2018-11-15 15:22:39', '', 75392985935646720, 10.00, 0, '孟买', 'ap-mumbai'),
	(75394448523005952, 'admin', '2018-11-15 15:22:58', 0, 'admin', '2018-11-15 15:22:58', '', 75392985935646720, 11.00, 0, '首尔', 'ap-seoul'),
	(75394604765024256, 'admin', '2018-11-15 15:23:36', 0, 'admin', '2018-11-15 15:23:36', '', 75392985935646720, 12.00, 0, '硅谷', 'na-siliconvalley'),
	(75394659299364864, 'admin', '2018-11-15 15:23:49', 0, 'admin', '2018-11-15 15:23:49', '', 75392985935646720, 13.00, 0, '弗吉尼亚', 'na-ashburn'),
	(75394705700950016, 'admin', '2018-11-15 15:24:00', 0, 'admin', '2018-11-15 15:24:00', '', 75392985935646720, 14.00, 0, '曼谷', 'ap-bangkok'),
	(75394759287377920, 'admin', '2018-11-15 15:24:12', 0, 'admin', '2018-11-15 15:24:12', '', 75392985935646720, 15.00, 0, '莫斯科', 'eu-moscow'),
	(79717808262352896, 'admin', '2018-11-27 13:42:28', 0, 'admin', '2018-11-27 13:42:28', '', 79717732567748608, 0.00, 0, '开始节点', '0'),
	(79717858308788224, 'admin', '2018-11-27 13:42:40', 0, 'admin', '2018-11-27 13:42:40', '', 79717732567748608, 1.00, 0, '审批节点', '1'),
	(79717920061526016, 'admin', '2018-11-27 13:42:54', 0, 'admin', '2018-12-08 20:35:39', '', 79717732567748608, 2.00, 0, '结束节点', '2'),
	(81843987719131136, 'admin', '2018-12-03 10:31:08', 0, 'admin', '2018-12-03 10:31:08', '', 81843858882695168, 0.00, 0, '普通', '0'),
	(81844044015079424, 'admin', '2018-12-03 10:31:22', 0, 'admin', '2018-12-03 10:31:22', '', 81843858882695168, 1.00, 0, '重要', '1'),
	(81844100705292288, 'admin', '2018-12-03 10:31:35', 0, 'admin', '2018-12-03 10:31:35', '', 81843858882695168, 2.00, 0, '紧急', '2'),
	(82237106587439104, 'admin', '2018-12-04 12:33:15', 0, 'admin', '2018-12-04 12:33:15', '', 82236987314016256, 0.00, 0, '请假申请表', 't_leave'),
	(82237106587439105, 'admin', '2018-12-04 12:33:15', 0, 'admin', '2018-12-04 12:33:15', '', 82236987314016257, 0.00, 0, '请假申请表', 'leave'),
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
	(125170157323554816, 'admin', '2019-04-01 23:53:52', 0, 'admin', '2019-04-01 23:53:52', '', 75383353938808832, 3.00, 0, '工作流', '工作流'),
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
  `id` bigint(20) unsigned NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `size` bigint(20) unsigned DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `f_key` varchar(255) DEFAULT NULL,
  `location` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `create_time` (`create_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  bill.t_file 的数据：~0 rows (大约)
DELETE FROM `t_file`;
/*!40000 ALTER TABLE `t_file` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_file` ENABLE KEYS */;

-- 导出  表 bill.t_leave 结构
DROP TABLE IF EXISTS `t_leave`;
CREATE TABLE IF NOT EXISTS `t_leave` (
  `id` bigint(20) unsigned NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `start_date` datetime DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `duration` int(11) unsigned DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  bill.t_leave 的数据：~0 rows (大约)
DELETE FROM `t_leave`;
/*!40000 ALTER TABLE `t_leave` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_leave` ENABLE KEYS */;

-- 导出  表 bill.t_log 结构
DROP TABLE IF EXISTS `t_log`;
CREATE TABLE IF NOT EXISTS `t_log` (
  `id` bigint(20) unsigned NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `cost_time` int(11) unsigned DEFAULT NULL,
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  bill.t_log 的数据：~7 rows (大约)
DELETE FROM `t_log`;
/*!40000 ALTER TABLE `t_log` DISABLE KEYS */;
INSERT INTO `t_log` (`id`, `create_by`, `create_time`, `del_flag`, `update_by`, `update_time`, `cost_time`, `ip`, `ip_info`, `name`, `request_param`, `request_type`, `request_url`, `username`, `log_type`) VALUES
	(1356427539991629824, NULL, '2021-02-02 10:21:42', 0, NULL, '2021-02-02 10:21:42', 84, '127.0.0.1', '未知', '登录系统', '{"password":"你是看不见我的","code":"vywu","saveLogin":"true","captchaId":"4e3a75718a9841ddb86513b40a9b6677","username":"admin"}', 'POST', '/xboot/login', 'admin', 1),
	(1356494459717685248, NULL, '2021-02-02 14:47:37', 0, NULL, '2021-02-02 14:47:37', 212, '127.0.0.1', '未知', '登录系统', '{"password":"你是看不见我的","code":"hbyk","saveLogin":"true","captchaId":"a1bf99a0f4f84ea6bc00990e9d58bf52","username":"admin"}', 'POST', '/xboot/login', 'admin', 1),
	(1356513294730530816, NULL, '2021-02-02 16:02:27', 0, NULL, '2021-02-02 16:02:27', 206, '127.0.0.1', '未知', '登录系统', '{"password":"你是看不见我的","code":"21mn","saveLogin":"true","captchaId":"4a13bab32f5449729c1945b009f4139e","username":"admin"}', 'POST', '/xboot/login', 'admin', 1),
	(1356517927511265280, NULL, '2021-02-02 16:20:52', 0, NULL, '2021-02-02 16:20:52', 57, '127.0.0.1', '未知', '登录系统', '{"password":"你是看不见我的","code":"MWHN","saveLogin":"true","captchaId":"30b8b62594de4b138423eaef875130b4","username":"admin"}', 'POST', '/xboot/login', 'admin', 1),
	(1356520586016329728, NULL, '2021-02-02 16:31:25', 0, NULL, '2021-02-02 16:31:25', 83, '127.0.0.1', '未知', '登录系统', '{"password":"你是看不见我的","code":"po5q","saveLogin":"true","captchaId":"213846424f4b43a0be80e069a0503eae","username":"admin"}', 'POST', '/xboot/login', 'admin', 1),
	(1420910007049916416, NULL, '2021-07-30 08:52:00', 0, NULL, '2021-07-30 08:52:00', 268, '127.0.0.1', '未知', '登录系统', '{"password":"你是看不见我的","code":"q14l","saveLogin":"true","captchaId":"0f934c09249e418d886a57d9251535d2","username":"admin"}', 'POST', '/xboot/login', 'admin', 1),
	(1420913158993874944, NULL, '2021-07-30 09:04:31', 0, NULL, '2021-07-30 09:04:31', 230, '127.0.0.1', '未知', '登录系统', '{"password":"你是看不见我的","code":"hqxc","saveLogin":"true","captchaId":"9858c00a3af54094accb0f3511406dd3","username":"admin"}', 'POST', '/xboot/login', 'admin', 1);
/*!40000 ALTER TABLE `t_log` ENABLE KEYS */;

-- 导出  表 bill.t_message 结构
DROP TABLE IF EXISTS `t_message`;
CREATE TABLE IF NOT EXISTS `t_message` (
  `id` bigint(20) unsigned NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `create_send` bit(1) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `content` longtext CHARACTER SET utf8mb4,
  PRIMARY KEY (`id`),
  KEY `create_time` (`create_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  bill.t_message 的数据：~5 rows (大约)
DELETE FROM `t_message`;
/*!40000 ALTER TABLE `t_message` DISABLE KEYS */;
INSERT INTO `t_message` (`id`, `create_by`, `create_time`, `del_flag`, `update_by`, `update_time`, `create_send`, `title`, `type`, `content`) VALUES
	(43615268366192640, '', '2018-08-19 22:43:51', 0, 'admin', '2020-04-26 23:32:08', b'1', '欢迎您注册账号使用X-Boot 点我查看使用须知', '系统公告', '<p style="text-align: center;">X-Boot是很棒的Web前后端分离开发平台，开源版本请遵循GPL v3.0开源协议，不得闭源，商用需求请联系作者签署授权协议。</p><p style="text-align: center;">捐赠获取完整版：<a href="http://xpay.exrick.cn/pay?xboot" target="_blank" style="background-color: rgb(255, 255, 255);">立即去捐赠获取</a></p><p style="text-align: center;"><img src="https://i.loli.net/2018/08/24/5b801c8652227.png" style="max-width:150px;"><br></p><p style="text-align: center;">手机扫一扫支付</p><p style="text-align: center;">获取商用授权：<a href="http://wpa.qq.com/msgrd?v=3&amp;uin=1012139570&amp;site=qq&amp;menu=yes" target="_blank" style="background-color: rgb(255, 255, 255);">立即联系作者获取商用授权</a></p>'),
	(124717033060306944, 'admin', '2019-03-31 17:53:19', 0, 'admin', '2019-03-31 17:53:19', NULL, '您收到了一条新的工作流待办消息，赶快去处理查看吧', '工作流', '<p>您收到了一条新的工作流待办消息，赶快去”工作流程-我的待办“处理查看吧</p>'),
	(124743474544119808, 'admin', '2019-03-31 19:38:23', 0, 'admin', '2019-03-31 19:38:23', NULL, '您有一个工作流申请已审批通过，赶快去处理查看吧', '工作流', '<p>您有一个工作流申请已审批通过，赶快去”工作流程-我的申请“处理查看吧</p>'),
	(124744392996032512, 'admin', '2019-03-31 19:42:02', 0, 'admin', '2019-03-31 19:42:02', NULL, '您有一个工作流申请已被驳回，赶快去处理查看吧', '工作流', '<p>您有一个工作流申请已已被驳回，赶快去”工作流程-我的申请“处理查看吧</p>'),
	(124744706050494464, 'admin', '2019-03-31 19:43:17', 0, 'admin', '2020-02-26 15:53:41', b'0', '您收到了一个新的被委托待办工作流任务，赶快去处理查看吧', '工作流', '<p>您收到了一个新的被委托待办工作流任务，赶快去”工作流程-我的待办“处理查看吧</p>');
/*!40000 ALTER TABLE `t_message` ENABLE KEYS */;

-- 导出  表 bill.t_message_send 结构
DROP TABLE IF EXISTS `t_message_send`;
CREATE TABLE IF NOT EXISTS `t_message_send` (
  `id` bigint(20) unsigned NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `message_id` bigint(20) unsigned DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `create_time` (`create_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  bill.t_message_send 的数据：~4 rows (大约)
DELETE FROM `t_message_send`;
/*!40000 ALTER TABLE `t_message_send` DISABLE KEYS */;
INSERT INTO `t_message_send` (`id`, `create_by`, `create_time`, `del_flag`, `update_by`, `update_time`, `message_id`, `status`, `user_id`) VALUES
	(43615268663988224, NULL, '2018-08-19 22:43:51', 0, NULL, '2018-08-19 22:43:51', 43615268366192640, 0, 682265633886209),
	(43615268663988226, '', '2018-08-19 22:43:51', 0, '', '2018-08-24 12:41:24', 43615268366192640, 2, 4363087427670016),
	(1356540501037289472, NULL, '2021-02-02 17:50:33', 0, NULL, '2021-02-02 17:50:33', 43615268366192640, 0, 1356540500563333121),
	(1356540811122184193, NULL, '2021-02-02 17:51:47', 0, NULL, '2021-02-02 17:51:47', 43615268366192640, 0, 1356540810790834176);
/*!40000 ALTER TABLE `t_message_send` ENABLE KEYS */;

-- 导出  表 bill.t_permission 结构
DROP TABLE IF EXISTS `t_permission`;
CREATE TABLE IF NOT EXISTS `t_permission` (
  `id` bigint(20) unsigned NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `parent_id` bigint(20) unsigned DEFAULT NULL,
  `type` tinyint(1) DEFAULT NULL,
  `sort_order` decimal(10,2) DEFAULT NULL,
  `component` varchar(255) DEFAULT NULL,
  `path` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `level` int(11) unsigned DEFAULT NULL,
  `button_type` varchar(255) DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `show_always` bit(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  bill.t_permission 的数据：~47 rows (大约)
DELETE FROM `t_permission`;
/*!40000 ALTER TABLE `t_permission` DISABLE KEYS */;
INSERT INTO `t_permission` (`id`, `create_by`, `create_time`, `del_flag`, `update_by`, `update_time`, `description`, `name`, `parent_id`, `type`, `sort_order`, `component`, `path`, `title`, `icon`, `level`, `button_type`, `status`, `url`, `show_always`) VALUES
	(5129710648430592, '', '2018-06-04 19:02:29', 0, '', '2018-09-29 23:11:56', '', 'sys', 125909152017944576, 0, 1.00, 'Main', '/sys', '系统管理', 'ios-settings', 1, '', 0, '', b'1'),
	(5129710648430593, '', '2018-06-04 19:02:32', 0, '', '2018-08-13 15:15:33', '', 'user-manage', 5129710648430592, 0, 1.10, 'sys/user-manage/userManage', 'user-manage', '用户管理', 'md-person', 2, '', 0, '', b'1'),
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
	(39915540965232640, NULL, '2018-08-09 17:42:28', 0, NULL, '2018-08-09 17:42:28', NULL, 'monitor', 125909152017944576, 0, 2.00, 'Main', '/monitor', '系统监控', 'ios-analytics', 1, NULL, 0, NULL, b'1'),
	(40238597734928384, NULL, '2018-08-10 15:06:10', 0, NULL, '2018-08-10 15:06:10', NULL, 'department-manage', 5129710648430592, 0, 1.20, 'sys/department-manage/departmentManage', 'department-manage', '部门管理', 'md-git-branch', 2, '', 0, NULL, b'1'),
	(41363147411427328, '', '2018-08-13 17:34:43', 0, 'admin', '2020-03-25 20:31:16', '', 'log-manage', 39915540965232640, 0, 2.20, 'sys/log-manage/logManage', 'log-manage', '日志管理', 'md-list-box', 2, '', 0, '', b'1'),
	(41363537456533504, '', '2018-08-13 17:36:16', 0, 'admin', '2020-04-28 14:31:54', '', '', 41363147411427328, 1, 2.11, '', '/xboot/log/delByIds**', '删除日志', '', 3, 'delete', 0, '', b'1'),
	(41364927394353152, '', '2018-08-13 17:41:48', 0, '', '2018-09-19 22:08:57', '', '', 41363147411427328, 1, 2.12, '', '/xboot/log/delAll*', '清空日志', '', 3, 'undefined', 0, '', b'1'),
	(45235621697949696, '', '2018-08-24 10:02:33', 0, '', '2018-09-19 22:06:57', '', '', 40238597734928384, 1, 1.21, '', '/xboot/department/add*', '添加部门', '', 3, 'add', 0, '', b'1'),
	(45235787867885568, '', '2018-08-24 10:03:13', 0, '', '2018-09-19 22:07:02', '', '', 40238597734928384, 1, 1.22, '', '/xboot/department/edit*', '编辑部门', '', 3, 'edit', 0, '', b'1'),
	(45235939278065664, '', '2018-08-24 10:03:49', 0, 'admin', '2020-04-28 14:27:35', '', '', 40238597734928384, 1, 1.23, '', '/xboot/department/delByIds*', '删除部门', '', 3, 'delete', 0, '', b'1'),
	(56898976661639168, '', '2018-09-25 14:28:34', 0, '', '2018-09-25 15:12:46', '', '', 5129710648430593, 1, 1.17, '', '/xboot/user/importData*', '导入用户', '', 3, 'input', 0, '', b'1'),
	(75002207560273920, 'admin', '2018-11-14 13:24:21', 0, 'admin', '2018-11-20 20:06:22', '', 'dict', 5129710648430592, 0, 1.80, 'sys/dict-manage/dictManage', 'dict', '数据字典管理', 'md-bookmarks', 2, '', 0, '', b'1'),
	(76215889006956544, 'admin', '2018-11-17 21:47:05', 0, 'admin', '2018-11-17 21:47:53', '', '', 75002207560273920, 1, 1.81, '', '/xboot/dict/add*', '添加字典', '', 3, 'add', 0, '', b'1'),
	(76216071333351424, 'admin', '2018-11-17 21:47:48', 0, 'admin', '2018-11-17 21:47:48', NULL, '', 75002207560273920, 1, 1.82, '', '/xboot/dict/edit*', '编辑字典', '', 3, 'edit', 0, NULL, b'1'),
	(76216264070008832, 'admin', '2018-11-17 21:48:34', 0, 'admin', '2020-04-28 14:29:30', '', '', 75002207560273920, 1, 1.83, '', '/xboot/dict/delByIds**', '删除字典', '', 3, 'delete', 0, '', b'1'),
	(76216459709124608, 'admin', '2018-11-17 21:49:21', 0, 'admin', '2018-11-17 21:49:21', NULL, '', 75002207560273920, 1, 1.84, '', '/xboot/dictData/add*', '添加字典数据', '', 3, 'add', 0, NULL, b'1'),
	(76216594207870976, 'admin', '2018-11-17 21:49:53', 0, 'admin', '2018-11-17 21:49:53', NULL, '', 75002207560273920, 1, 1.85, '', '/xboot/dictData/edit*', '编辑字典数据', '', 3, 'edit', 0, NULL, b'1'),
	(76216702639017984, 'admin', '2018-11-17 21:50:18', 0, 'admin', '2018-11-17 21:50:18', NULL, '', 75002207560273920, 1, 1.86, '', '/xboot/dictData/delByIds/**', '删除字典数据', '', 3, 'delete', 0, NULL, b'1'),
	(125909152017944576, 'admin', '2019-04-04 00:50:22', 0, 'admin', '2021-02-02 10:33:40', '', 'xboot', 0, -1, 0.00, '', '', '员工管理', 'md-home', 0, '', 0, '', b'1'),
	(156365156580855808, 'admin', '2019-06-27 01:51:39', 0, 'admin', '2019-06-27 01:51:39', NULL, '', 5129710648430593, 1, 1.18, '', '/xboot/user/resetPass', '重置密码', '', 3, 'other', 0, NULL, b'1'),
	(1356430158604668929, 'admin', '2021-02-02 10:32:06', 0, 'admin', '2021-02-02 10:32:06', NULL, 'oaSystem4', 125909152017944576, 0, 4.00, 'Main', '/oaSystem4', '开发', 'ios-create', 1, '', 0, NULL, b'1'),
	(1356430229962362881, 'admin', '2021-02-02 10:32:23', 0, 'admin', '2021-02-02 10:32:23', NULL, 'vue', 1356430158604668929, 0, 1.00, 'oaSystem/vue/tableGenerator', 'vue', 'Vue表格', 'ios-color-wand', 2, '', 0, NULL, b'1'),
	(1356495199970398208, 'admin', '2021-02-02 14:50:33', 0, 'admin', '2021-02-02 14:50:33', NULL, 'commoditySystem', NULL, -1, 1.00, NULL, NULL, '商品管理', 'ios-american-football', 0, NULL, 0, NULL, b'1'),
	(1356495466673606656, 'admin', '2021-02-02 14:51:36', 0, 'admin', '2021-02-02 14:51:36', NULL, 'commodity', 1356495199970398208, 0, 1.00, 'Main', '/commodity', '商品管理', 'md-analytics', 1, '', 0, NULL, b'1'),
	(1356495562643476480, 'admin', '2021-02-02 14:51:59', 0, 'admin', '2021-02-02 14:51:59', NULL, 'commodity', 1356495466673606656, 0, 1.00, 'commodity/commodity/commodity', 'commodity', '商品管理', 'md-beer', 2, '', 0, NULL, b'1'),
	(1356499201571295232, 'admin', '2021-02-02 15:06:27', 0, 'admin', '2021-02-02 15:06:27', NULL, 'supplierSystem', NULL, -1, 3.00, NULL, NULL, '供应商管理', 'md-cloudy-night', 0, NULL, 0, NULL, b'1'),
	(1356499247591198721, 'admin', '2021-02-02 15:06:38', 0, 'admin', '2021-02-02 15:06:38', NULL, 'supplierSystem', 1356499201571295232, 0, 1.00, 'Main', '/supplierSystem', '供应商管理', 'ios-checkbox', 1, '', 0, NULL, b'1'),
	(1356499311105544193, 'admin', '2021-02-02 15:06:53', 0, 'admin', '2021-02-02 16:10:01', '', 'supplier', 1356499247591198721, 0, 1.00, 'supplier/supplier/supplier', 'supplier', '供应商', 'ios-chatboxes', 2, '', 0, '', b'1'),
	(1356499478537965569, 'admin', '2021-02-02 15:07:33', 0, 'admin', '2021-02-02 15:07:33', NULL, 'sillSystem', NULL, -1, 4.00, NULL, NULL, '账单管理', 'md-backspace', 0, NULL, 0, NULL, b'1'),
	(1356513445691920384, 'admin', '2021-02-02 16:03:03', 0, 'admin', '2021-02-02 16:56:03', '', 'bill', 1356499478537965569, 0, 1.00, 'Main', '/bill', '账单管理', 'md-aperture', 1, '', 0, '', b'1'),
	(1356513518173687809, 'admin', '2021-02-02 16:03:20', 0, 'admin', '2021-02-02 16:55:58', '', 'bill', 1356513445691920384, 0, 1.00, 'bill/bill/bill', 'bill', '账单', 'ios-apps', 2, '', 0, '', b'1');
/*!40000 ALTER TABLE `t_permission` ENABLE KEYS */;

-- 导出  表 bill.t_quartz_job 结构
DROP TABLE IF EXISTS `t_quartz_job`;
CREATE TABLE IF NOT EXISTS `t_quartz_job` (
  `id` bigint(20) unsigned NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `cron_expression` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `job_class_name` varchar(255) DEFAULT NULL,
  `parameter` varchar(255) DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  bill.t_quartz_job 的数据：~0 rows (大约)
DELETE FROM `t_quartz_job`;
/*!40000 ALTER TABLE `t_quartz_job` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_quartz_job` ENABLE KEYS */;

-- 导出  表 bill.t_role 结构
DROP TABLE IF EXISTS `t_role`;
CREATE TABLE IF NOT EXISTS `t_role` (
  `id` bigint(20) unsigned NOT NULL,
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
  `id` bigint(20) unsigned NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `department_id` bigint(20) unsigned DEFAULT NULL,
  `role_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  bill.t_role_department 的数据：~0 rows (大约)
DELETE FROM `t_role_department`;
/*!40000 ALTER TABLE `t_role_department` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_role_department` ENABLE KEYS */;

-- 导出  表 bill.t_role_permission 结构
DROP TABLE IF EXISTS `t_role_permission`;
CREATE TABLE IF NOT EXISTS `t_role_permission` (
  `id` bigint(20) unsigned NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `permission_id` bigint(20) unsigned DEFAULT NULL,
  `role_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  bill.t_role_permission 的数据：~77 rows (大约)
DELETE FROM `t_role_permission`;
/*!40000 ALTER TABLE `t_role_permission` DISABLE KEYS */;
INSERT INTO `t_role_permission` (`id`, `create_by`, `create_time`, `del_flag`, `update_by`, `update_time`, `permission_id`, `role_id`) VALUES
	(1356513559248506880, 'admin', '2021-02-02 16:03:30', 0, 'admin', '2021-02-02 16:03:30', 125909152017944576, 496138616573952),
	(1356513559248506881, 'admin', '2021-02-02 16:03:30', 0, 'admin', '2021-02-02 16:03:30', 5129710648430592, 496138616573952),
	(1356513559248506882, 'admin', '2021-02-02 16:03:30', 0, 'admin', '2021-02-02 16:03:30', 5129710648430593, 496138616573952),
	(1356513559248506883, 'admin', '2021-02-02 16:03:30', 0, 'admin', '2021-02-02 16:03:30', 15701400130424832, 496138616573952),
	(1356513559248506884, 'admin', '2021-02-02 16:03:30', 0, 'admin', '2021-02-02 16:03:30', 16678126574637056, 496138616573952),
	(1356513559248506885, 'admin', '2021-02-02 16:03:30', 0, 'admin', '2021-02-02 16:03:30', 15701915807518720, 496138616573952),
	(1356513559248506886, 'admin', '2021-02-02 16:03:30', 0, 'admin', '2021-02-02 16:03:30', 15708892205944832, 496138616573952),
	(1356513559248506887, 'admin', '2021-02-02 16:03:30', 0, 'admin', '2021-02-02 16:03:30', 16678447719911424, 496138616573952),
	(1356513559248506888, 'admin', '2021-02-02 16:03:30', 0, 'admin', '2021-02-02 16:03:30', 25014528525733888, 496138616573952),
	(1356513559248506889, 'admin', '2021-02-02 16:03:30', 0, 'admin', '2021-02-02 16:03:30', 56898976661639168, 496138616573952),
	(1356513559248506890, 'admin', '2021-02-02 16:03:30', 0, 'admin', '2021-02-02 16:03:30', 156365156580855808, 496138616573952),
	(1356513559248506891, 'admin', '2021-02-02 16:03:30', 0, 'admin', '2021-02-02 16:03:30', 40238597734928384, 496138616573952),
	(1356513559248506892, 'admin', '2021-02-02 16:03:30', 0, 'admin', '2021-02-02 16:03:30', 45235621697949696, 496138616573952),
	(1356513559248506893, 'admin', '2021-02-02 16:03:30', 0, 'admin', '2021-02-02 16:03:30', 45235787867885568, 496138616573952),
	(1356513559248506894, 'admin', '2021-02-02 16:03:30', 0, 'admin', '2021-02-02 16:03:30', 45235939278065664, 496138616573952),
	(1356513559248506895, 'admin', '2021-02-02 16:03:30', 0, 'admin', '2021-02-02 16:03:30', 5129710648430594, 496138616573952),
	(1356513559248506896, 'admin', '2021-02-02 16:03:30', 0, 'admin', '2021-02-02 16:03:30', 16687383932047360, 496138616573952),
	(1356513559248506897, 'admin', '2021-02-02 16:03:30', 0, 'admin', '2021-02-02 16:03:30', 16689632049631232, 496138616573952),
	(1356513559248506898, 'admin', '2021-02-02 16:03:30', 0, 'admin', '2021-02-02 16:03:30', 16689745006432256, 496138616573952),
	(1356513559248506899, 'admin', '2021-02-02 16:03:30', 0, 'admin', '2021-02-02 16:03:30', 16689883993083904, 496138616573952),
	(1356513559248506900, 'admin', '2021-02-02 16:03:30', 0, 'admin', '2021-02-02 16:03:30', 16690313745666048, 496138616573952),
	(1356513559248506901, 'admin', '2021-02-02 16:03:30', 0, 'admin', '2021-02-02 16:03:30', 5129710648430595, 496138616573952),
	(1356513559248506902, 'admin', '2021-02-02 16:03:30', 0, 'admin', '2021-02-02 16:03:30', 16694861252005888, 496138616573952),
	(1356513559248506903, 'admin', '2021-02-02 16:03:30', 0, 'admin', '2021-02-02 16:03:30', 16695107491205120, 496138616573952),
	(1356513559248506904, 'admin', '2021-02-02 16:03:30', 0, 'admin', '2021-02-02 16:03:30', 16695243126607872, 496138616573952),
	(1356513559248506905, 'admin', '2021-02-02 16:03:30', 0, 'admin', '2021-02-02 16:03:30', 75002207560273920, 496138616573952),
	(1356513559248506906, 'admin', '2021-02-02 16:03:30', 0, 'admin', '2021-02-02 16:03:30', 76215889006956544, 496138616573952),
	(1356513559248506907, 'admin', '2021-02-02 16:03:30', 0, 'admin', '2021-02-02 16:03:30', 76216071333351424, 496138616573952),
	(1356513559248506908, 'admin', '2021-02-02 16:03:30', 0, 'admin', '2021-02-02 16:03:30', 76216264070008832, 496138616573952),
	(1356513559248506909, 'admin', '2021-02-02 16:03:30', 0, 'admin', '2021-02-02 16:03:30', 76216459709124608, 496138616573952),
	(1356513559248506910, 'admin', '2021-02-02 16:03:30', 0, 'admin', '2021-02-02 16:03:30', 76216594207870976, 496138616573952),
	(1356513559248506911, 'admin', '2021-02-02 16:03:30', 0, 'admin', '2021-02-02 16:03:30', 76216702639017984, 496138616573952),
	(1356513559248506912, 'admin', '2021-02-02 16:03:30', 0, 'admin', '2021-02-02 16:03:30', 39915540965232640, 496138616573952),
	(1356513559248506913, 'admin', '2021-02-02 16:03:30', 0, 'admin', '2021-02-02 16:03:30', 41363147411427328, 496138616573952),
	(1356513559248506914, 'admin', '2021-02-02 16:03:30', 0, 'admin', '2021-02-02 16:03:30', 41363537456533504, 496138616573952),
	(1356513559248506915, 'admin', '2021-02-02 16:03:30', 0, 'admin', '2021-02-02 16:03:30', 41364927394353152, 496138616573952),
	(1356513559248506916, 'admin', '2021-02-02 16:03:30', 0, 'admin', '2021-02-02 16:03:30', 1356430158604668929, 496138616573952),
	(1356513559248506917, 'admin', '2021-02-02 16:03:30', 0, 'admin', '2021-02-02 16:03:30', 1356430229962362881, 496138616573952),
	(1356513559248506918, 'admin', '2021-02-02 16:03:30', 0, 'admin', '2021-02-02 16:03:30', 1356495199970398208, 496138616573952),
	(1356513559248506919, 'admin', '2021-02-02 16:03:30', 0, 'admin', '2021-02-02 16:03:30', 1356495466673606656, 496138616573952),
	(1356513559248506920, 'admin', '2021-02-02 16:03:30', 0, 'admin', '2021-02-02 16:03:30', 1356495562643476480, 496138616573952),
	(1356513559248506921, 'admin', '2021-02-02 16:03:30', 0, 'admin', '2021-02-02 16:03:30', 1356499201571295232, 496138616573952),
	(1356513559248506922, 'admin', '2021-02-02 16:03:30', 0, 'admin', '2021-02-02 16:03:30', 1356499247591198721, 496138616573952),
	(1356513559248506923, 'admin', '2021-02-02 16:03:30', 0, 'admin', '2021-02-02 16:03:30', 1356499311105544193, 496138616573952),
	(1356513559248506924, 'admin', '2021-02-02 16:03:30', 0, 'admin', '2021-02-02 16:03:30', 1356499478537965569, 496138616573952),
	(1356513559248506925, 'admin', '2021-02-02 16:03:30', 0, 'admin', '2021-02-02 16:03:30', 1356513445691920384, 496138616573952),
	(1356513559248506926, 'admin', '2021-02-02 16:03:30', 0, 'admin', '2021-02-02 16:03:30', 1356513518173687809, 496138616573952),
	(1356539967555375104, 'admin', '2021-02-02 17:48:26', 0, 'admin', '2021-02-02 17:48:26', 125909152017944576, 1356534329106370560),
	(1356539967555375105, 'admin', '2021-02-02 17:48:26', 0, 'admin', '2021-02-02 17:48:26', 5129710648430592, 1356534329106370560),
	(1356539967555375106, 'admin', '2021-02-02 17:48:26', 0, 'admin', '2021-02-02 17:48:26', 5129710648430593, 1356534329106370560),
	(1356539967555375107, 'admin', '2021-02-02 17:48:26', 0, 'admin', '2021-02-02 17:48:26', 15701400130424832, 1356534329106370560),
	(1356539967555375108, 'admin', '2021-02-02 17:48:26', 0, 'admin', '2021-02-02 17:48:26', 16678126574637056, 1356534329106370560),
	(1356539967555375109, 'admin', '2021-02-02 17:48:26', 0, 'admin', '2021-02-02 17:48:26', 15701915807518720, 1356534329106370560),
	(1356539967555375110, 'admin', '2021-02-02 17:48:26', 0, 'admin', '2021-02-02 17:48:26', 15708892205944832, 1356534329106370560),
	(1356539967555375111, 'admin', '2021-02-02 17:48:26', 0, 'admin', '2021-02-02 17:48:26', 16678447719911424, 1356534329106370560),
	(1356539967555375112, 'admin', '2021-02-02 17:48:26', 0, 'admin', '2021-02-02 17:48:26', 25014528525733888, 1356534329106370560),
	(1356539967555375113, 'admin', '2021-02-02 17:48:26', 0, 'admin', '2021-02-02 17:48:26', 56898976661639168, 1356534329106370560),
	(1356539967555375114, 'admin', '2021-02-02 17:48:26', 0, 'admin', '2021-02-02 17:48:26', 156365156580855808, 1356534329106370560),
	(1356539967555375115, 'admin', '2021-02-02 17:48:26', 0, 'admin', '2021-02-02 17:48:26', 75002207560273920, 1356534329106370560),
	(1356539967555375116, 'admin', '2021-02-02 17:48:26', 0, 'admin', '2021-02-02 17:48:26', 76215889006956544, 1356534329106370560),
	(1356539967555375117, 'admin', '2021-02-02 17:48:26', 0, 'admin', '2021-02-02 17:48:26', 76216071333351424, 1356534329106370560),
	(1356539967555375118, 'admin', '2021-02-02 17:48:26', 0, 'admin', '2021-02-02 17:48:26', 76216264070008832, 1356534329106370560),
	(1356539967555375119, 'admin', '2021-02-02 17:48:26', 0, 'admin', '2021-02-02 17:48:26', 76216459709124608, 1356534329106370560),
	(1356539967555375120, 'admin', '2021-02-02 17:48:26', 0, 'admin', '2021-02-02 17:48:26', 76216594207870976, 1356534329106370560),
	(1356539967555375121, 'admin', '2021-02-02 17:48:26', 0, 'admin', '2021-02-02 17:48:26', 76216702639017984, 1356534329106370560),
	(1356539967555375122, 'admin', '2021-02-02 17:48:26', 0, 'admin', '2021-02-02 17:48:26', 1356495199970398208, 1356534329106370560),
	(1356539967555375123, 'admin', '2021-02-02 17:48:26', 0, 'admin', '2021-02-02 17:48:26', 1356495466673606656, 1356534329106370560),
	(1356539967555375124, 'admin', '2021-02-02 17:48:26', 0, 'admin', '2021-02-02 17:48:26', 1356495562643476480, 1356534329106370560),
	(1356539967555375125, 'admin', '2021-02-02 17:48:26', 0, 'admin', '2021-02-02 17:48:26', 1356499201571295232, 1356534329106370560),
	(1356539967555375126, 'admin', '2021-02-02 17:48:26', 0, 'admin', '2021-02-02 17:48:26', 1356499247591198721, 1356534329106370560),
	(1356539967555375127, 'admin', '2021-02-02 17:48:26', 0, 'admin', '2021-02-02 17:48:26', 1356499311105544193, 1356534329106370560),
	(1356539967555375128, 'admin', '2021-02-02 17:48:26', 0, 'admin', '2021-02-02 17:48:26', 1356499478537965569, 1356534329106370560),
	(1356539967555375129, 'admin', '2021-02-02 17:48:26', 0, 'admin', '2021-02-02 17:48:26', 1356513445691920384, 1356534329106370560),
	(1356539967555375130, 'admin', '2021-02-02 17:48:26', 0, 'admin', '2021-02-02 17:48:26', 1356513518173687809, 1356534329106370560),
	(1356540086644248576, 'admin', '2021-02-02 17:48:55', 0, 'admin', '2021-02-02 17:48:55', 1356499478537965569, 1356534242120699904),
	(1356540086644248577, 'admin', '2021-02-02 17:48:55', 0, 'admin', '2021-02-02 17:48:55', 1356513445691920384, 1356534242120699904),
	(1356540086644248578, 'admin', '2021-02-02 17:48:55', 0, 'admin', '2021-02-02 17:48:55', 1356513518173687809, 1356534242120699904);
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  bill.t_setting 的数据：~0 rows (大约)
DELETE FROM `t_setting`;
/*!40000 ALTER TABLE `t_setting` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_setting` ENABLE KEYS */;

-- 导出  表 bill.t_social 结构
DROP TABLE IF EXISTS `t_social`;
CREATE TABLE IF NOT EXISTS `t_social` (
  `id` bigint(20) unsigned NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime(6) DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime(6) DEFAULT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `open_id` varchar(255) DEFAULT NULL,
  `platform` tinyint(1) unsigned DEFAULT NULL,
  `relate_username` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `relate_open_id` (`open_id`,`platform`) USING BTREE,
  UNIQUE KEY `relate_username` (`relate_username`,`platform`) USING BTREE,
  KEY `create_time` (`create_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  bill.t_social 的数据：~0 rows (大约)
DELETE FROM `t_social`;
/*!40000 ALTER TABLE `t_social` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_social` ENABLE KEYS */;

-- 导出  表 bill.t_supplier 结构
DROP TABLE IF EXISTS `t_supplier`;
CREATE TABLE IF NOT EXISTS `t_supplier` (
  `id` varchar(255) COLLATE utf8_croatian_ci NOT NULL,
  `create_by` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `create_time` datetime(6) DEFAULT NULL,
  `del_flag` int(11) DEFAULT NULL,
  `update_by` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `update_time` datetime(6) DEFAULT NULL,
  `address` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `mobile` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `type` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_croatian_ci;

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
  `id` bigint(20) unsigned NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `mobile` varchar(255) DEFAULT NULL,
  `nickname` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `sex` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `department_id` bigint(20) unsigned DEFAULT NULL,
  `street` varchar(255) DEFAULT NULL,
  `pass_strength` varchar(2) DEFAULT NULL,
  `department_title` varchar(255) DEFAULT NULL,
  `birth` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`) USING BTREE,
  UNIQUE KEY `email` (`email`) USING BTREE,
  UNIQUE KEY `mobile` (`mobile`) USING BTREE,
  KEY `create_time` (`create_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
  `id` bigint(20) unsigned NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `role_id` bigint(20) unsigned DEFAULT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  bill.t_user_role 的数据：~3 rows (大约)
DELETE FROM `t_user_role`;
/*!40000 ALTER TABLE `t_user_role` DISABLE KEYS */;
INSERT INTO `t_user_role` (`id`, `create_by`, `create_time`, `del_flag`, `update_by`, `update_time`, `role_id`, `user_id`) VALUES
	(1356533899093741568, 'admin', '2021-02-02 17:24:19', 0, 'admin', '2021-02-02 17:24:19', 496138616573952, 682265633886208),
	(1356540500991152128, 'admin', '2021-02-02 17:50:33', 0, 'admin', '2021-02-02 17:50:33', 1356534242120699904, 1356540500563333121),
	(1356540811113795585, 'admin', '2021-02-02 17:51:47', 0, 'admin', '2021-02-02 17:51:47', 1356534329106370560, 1356540810790834176);
/*!40000 ALTER TABLE `t_user_role` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
