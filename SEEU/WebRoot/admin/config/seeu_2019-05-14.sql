# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 39.105.138.210 (MySQL 5.7.24)
# Database: seeu
# Generation Time: 2019-05-14 03:46:36 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table db_fhdb
# ------------------------------------------------------------

DROP TABLE IF EXISTS `db_fhdb`;

CREATE TABLE `db_fhdb` (
  `FHDB_ID` varchar(100) NOT NULL,
  `USERNAME` varchar(50) DEFAULT NULL COMMENT '操作用户',
  `BACKUP_TIME` varchar(32) DEFAULT NULL COMMENT '备份时间',
  `TABLENAME` varchar(50) DEFAULT NULL COMMENT '表名',
  `SQLPATH` varchar(300) DEFAULT NULL COMMENT '存储位置',
  `TYPE` int(1) NOT NULL COMMENT '类型',
  `DBSIZE` varchar(10) DEFAULT NULL COMMENT '文件大小',
  `BZ` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`FHDB_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table db_timingbackup
# ------------------------------------------------------------

DROP TABLE IF EXISTS `db_timingbackup`;

CREATE TABLE `db_timingbackup` (
  `TIMINGBACKUP_ID` varchar(100) NOT NULL,
  `JOBNAME` varchar(50) DEFAULT NULL COMMENT '任务名称',
  `CREATE_TIME` varchar(32) DEFAULT NULL COMMENT '创建时间',
  `TABLENAME` varchar(50) DEFAULT NULL COMMENT '表名',
  `STATUS` int(1) NOT NULL COMMENT '类型',
  `FHTIME` varchar(30) DEFAULT NULL COMMENT '时间规则',
  `TIMEEXPLAIN` varchar(100) DEFAULT NULL COMMENT '规则说明',
  `BZ` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`TIMINGBACKUP_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `db_timingbackup` WRITE;
/*!40000 ALTER TABLE `db_timingbackup` DISABLE KEYS */;

INSERT INTO `db_timingbackup` (`TIMINGBACKUP_ID`, `JOBNAME`, `CREATE_TIME`, `TABLENAME`, `STATUS`, `FHTIME`, `TIMEEXPLAIN`, `BZ`)
VALUES
	('311e06c34a5e4518a86d5d30799f9b55','sys_app_user_515762','2016-04-11 17:04:55','sys_app_user',2,'1/2 * * ? * *','每个月的 每周 每天 每小时执行一次','备份任务'),
	('bc4a788bc2ec40bdb1b7730131c26d42','sys_app_user_359515','2016-04-12 17:24:05','sys_app_user',2,'1/3 * * ? * *','每个月的 每周 每天 每小时执行一次','ssss');

/*!40000 ALTER TABLE `db_timingbackup` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table oa_datajur
# ------------------------------------------------------------

DROP TABLE IF EXISTS `oa_datajur`;

CREATE TABLE `oa_datajur` (
  `DATAJUR_ID` varchar(100) NOT NULL,
  `DEPARTMENT_IDS` varchar(5000) DEFAULT NULL COMMENT '部门ID组合',
  `STAFF_ID` varchar(100) DEFAULT NULL COMMENT '员工ID',
  `DEPARTMENT_ID` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`DATAJUR_ID`),
  KEY `FSTAFF` (`STAFF_ID`),
  CONSTRAINT `FSTAFF` FOREIGN KEY (`STAFF_ID`) REFERENCES `oa_staff` (`STAFF_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `oa_datajur` WRITE;
/*!40000 ALTER TABLE `oa_datajur` DISABLE KEYS */;

INSERT INTO `oa_datajur` (`DATAJUR_ID`, `DEPARTMENT_IDS`, `STAFF_ID`, `DEPARTMENT_ID`)
VALUES
	('6e6133043ca141fabd458a059150a0c7','(\'fh\')','6e6133043ca141fabd458a059150a0c7','0956d8c279274fca92f4091f2a69a9ad');

/*!40000 ALTER TABLE `oa_datajur` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table oa_department
# ------------------------------------------------------------

DROP TABLE IF EXISTS `oa_department`;

CREATE TABLE `oa_department` (
  `DEPARTMENT_ID` varchar(100) NOT NULL,
  `NAME` varchar(30) DEFAULT NULL COMMENT '名称',
  `NAME_EN` varchar(50) DEFAULT NULL COMMENT '英文',
  `BIANMA` varchar(50) DEFAULT NULL COMMENT '编码',
  `PARENT_ID` varchar(100) DEFAULT NULL COMMENT '上级ID',
  `BZ` varchar(255) DEFAULT NULL COMMENT '备注',
  `HEADMAN` varchar(30) DEFAULT NULL COMMENT '负责人',
  `TEL` varchar(50) DEFAULT NULL COMMENT '电话',
  `FUNCTIONS` varchar(255) DEFAULT NULL COMMENT '部门职能',
  `ADDRESS` varchar(255) DEFAULT NULL COMMENT '地址',
  PRIMARY KEY (`DEPARTMENT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `oa_department` WRITE;
/*!40000 ALTER TABLE `oa_department` DISABLE KEYS */;

INSERT INTO `oa_department` (`DEPARTMENT_ID`, `NAME`, `NAME_EN`, `BIANMA`, `PARENT_ID`, `BZ`, `HEADMAN`, `TEL`, `FUNCTIONS`, `ADDRESS`)
VALUES
	('0956d8c279274fca92f4091f2a69a9ad','销售会计','xiaokuai','05896','d41af567914a409893d011aa53eda797','','','','',''),
	('3e7227e11dc14b4d9e863dd1a1fcedf6','成本会计','chengb','03656','d41af567914a409893d011aa53eda797','','','','',''),
	('5cccdb7c432449d8b853c52880058140','B公司','b','002','0','冶铁','李四','112','冶铁','河北'),
	('83a25761c618457cae2fa1211bd8696d','销售B组','xiaob','002365','cbbc84eddde947ba8af7d509e430eb70','','李四','','',''),
	('8f8b045470f342fdbc4c312ab881d62b','销售A组','xiaoA','0326','cbbc84eddde947ba8af7d509e430eb70','','张三','0201212','',''),
	('a0982dea52554225ab682cd4b421de47','1队','yidui','02563','8f8b045470f342fdbc4c312ab881d62b','','小王','12356989','',''),
	('a6c6695217ba4a4dbfe9f7e9d2c06730','A公司','a','001','0','挖煤','张三','110','洼煤矿','山西'),
	('cbbc84eddde947ba8af7d509e430eb70','销售部','xiaoshoubu','00201','5cccdb7c432449d8b853c52880058140','推销商品','小明','11236','推销商品','909办公室'),
	('d41af567914a409893d011aa53eda797','财务部','caiwubu','00101','a6c6695217ba4a4dbfe9f7e9d2c06730','负责发工资','王武','11236','管理财务','308办公室');

/*!40000 ALTER TABLE `oa_department` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table oa_staff
# ------------------------------------------------------------

DROP TABLE IF EXISTS `oa_staff`;

CREATE TABLE `oa_staff` (
  `STAFF_ID` varchar(100) NOT NULL,
  `NAME` varchar(50) DEFAULT NULL COMMENT '姓名',
  `NAME_EN` varchar(50) DEFAULT NULL COMMENT '英文',
  `BIANMA` varchar(100) DEFAULT NULL COMMENT '编码',
  `DEPARTMENT_ID` varchar(100) DEFAULT NULL COMMENT '部门',
  `FUNCTIONS` varchar(255) DEFAULT NULL COMMENT '职责',
  `TEL` varchar(20) DEFAULT NULL COMMENT '电话',
  `EMAIL` varchar(50) DEFAULT NULL COMMENT '邮箱',
  `SEX` varchar(10) DEFAULT NULL COMMENT '性别',
  `BIRTHDAY` varchar(32) DEFAULT NULL COMMENT '出生日期',
  `NATION` varchar(10) DEFAULT NULL COMMENT '民族',
  `JOBTYPE` varchar(30) DEFAULT NULL COMMENT '岗位类别',
  `JOBJOINTIME` varchar(32) DEFAULT NULL COMMENT '参加工作时间',
  `FADDRESS` varchar(100) DEFAULT NULL COMMENT '籍贯',
  `POLITICAL` varchar(30) DEFAULT NULL COMMENT '政治面貌',
  `PJOINTIME` varchar(32) DEFAULT NULL COMMENT '入团时间',
  `SFID` varchar(20) DEFAULT NULL COMMENT '身份证号',
  `MARITAL` varchar(10) DEFAULT NULL COMMENT '婚姻状况',
  `DJOINTIME` varchar(32) DEFAULT NULL COMMENT '进本单位时间',
  `POST` varchar(30) DEFAULT NULL COMMENT '现岗位',
  `POJOINTIME` varchar(32) DEFAULT NULL COMMENT '上岗时间',
  `EDUCATION` varchar(10) DEFAULT NULL COMMENT '学历',
  `SCHOOL` varchar(30) DEFAULT NULL COMMENT '毕业学校',
  `MAJOR` varchar(30) DEFAULT NULL COMMENT '专业',
  `FTITLE` varchar(30) DEFAULT NULL COMMENT '职称',
  `CERTIFICATE` varchar(30) DEFAULT NULL COMMENT '职业资格证',
  `CONTRACTLENGTH` int(2) NOT NULL COMMENT '劳动合同时长',
  `CSTARTTIME` varchar(32) DEFAULT NULL COMMENT '签订日期',
  `CENDTIME` varchar(32) DEFAULT NULL COMMENT '终止日期',
  `ADDRESS` varchar(100) DEFAULT NULL COMMENT '现住址',
  `USER_ID` varchar(100) DEFAULT NULL COMMENT '绑定账号ID',
  `BZ` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`STAFF_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `oa_staff` WRITE;
/*!40000 ALTER TABLE `oa_staff` DISABLE KEYS */;

INSERT INTO `oa_staff` (`STAFF_ID`, `NAME`, `NAME_EN`, `BIANMA`, `DEPARTMENT_ID`, `FUNCTIONS`, `TEL`, `EMAIL`, `SEX`, `BIRTHDAY`, `NATION`, `JOBTYPE`, `JOBJOINTIME`, `FADDRESS`, `POLITICAL`, `PJOINTIME`, `SFID`, `MARITAL`, `DJOINTIME`, `POST`, `POJOINTIME`, `EDUCATION`, `SCHOOL`, `MAJOR`, `FTITLE`, `CERTIFICATE`, `CONTRACTLENGTH`, `CSTARTTIME`, `CENDTIME`, `ADDRESS`, `USER_ID`, `BZ`)
VALUES
	('6e6133043ca141fabd458a059150a0c7','www','ww','www','3e7227e11dc14b4d9e863dd1a1fcedf6','ww','ww','ww','男','2016-04-27','ww','ww','2016-06-01','ww','wwwww','2016-02-03','ww','已婚','2016-05-25','ww','2016-05-25','ww','ww','w','ww','ww',1,'2016-05-16','2016-05-24','ww','','eee'),
	('797d580b5cd341e7bc35c88089bd3091','fff','fff','ff','83a25761c618457cae2fa1211bd8696d','ff','ff','ff','男','2016-04-06','ff','ff','2016-05-04','ff','fff','2016-03-29','fff','已婚','2016-05-03','ff','2016-04-27','ff','ff','f','ff','ff',55,'2016-05-03','2016-04-26','ff','ffffs','ffff'),
	('fc26491d77ea4929aa1f6fc48cda85fa','www','www','www','cbbc84eddde947ba8af7d509e430eb70','ww','ww','www','女','2016-03-30','www','ww','2016-04-29','www','www','2016-03-30','www','未婚','2016-04-25','www','2016-04-19','ww','ww','ww','ww','www',2,'2016-04-25','2016-04-13','www','san','www');

/*!40000 ALTER TABLE `oa_staff` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table rs_userandpreferences
# ------------------------------------------------------------

DROP TABLE IF EXISTS `rs_userandpreferences`;

CREATE TABLE `rs_userandpreferences` (
  `USERANDPREFERENCES_ID` varchar(100) NOT NULL,
  `USER_ID` varchar(255) DEFAULT NULL COMMENT '用户ID',
  `USERPREFERENCES_ID` varchar(255) DEFAULT NULL COMMENT '用户喜好ID',
  PRIMARY KEY (`USERANDPREFERENCES_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `rs_userandpreferences` WRITE;
/*!40000 ALTER TABLE `rs_userandpreferences` DISABLE KEYS */;

INSERT INTO `rs_userandpreferences` (`USERANDPREFERENCES_ID`, `USER_ID`, `USERPREFERENCES_ID`)
VALUES
	('6365cbb47aaa4fe9839bfa0deaabf505','16b5932566514ad2adeaf7ec1e81fbc1','bc8375f9ec4d463f822b4caf2be8c1b9'),
	('bdf9702fafc748dba52ece98d68547d1','16b5932566514ad2adeaf7ec1e81fbc1','bc8375f9ec4d463f822b4caf2be8c1b9');

/*!40000 ALTER TABLE `rs_userandpreferences` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sys_app_user
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_app_user`;

CREATE TABLE `sys_app_user` (
  `USER_ID` varchar(100) NOT NULL,
  `USERNAME` varchar(255) DEFAULT NULL,
  `PASSWORD` varchar(255) DEFAULT NULL,
  `NAME` varchar(255) DEFAULT NULL,
  `RIGHTS` varchar(255) DEFAULT NULL,
  `ROLE_ID` varchar(100) DEFAULT NULL,
  `LAST_LOGIN` varchar(255) DEFAULT NULL,
  `IP` varchar(100) DEFAULT NULL,
  `STATUS` varchar(32) DEFAULT NULL,
  `BZ` varchar(255) DEFAULT NULL,
  `PHONE` varchar(100) DEFAULT NULL,
  `SFID` varchar(100) DEFAULT NULL,
  `START_TIME` varchar(100) DEFAULT NULL,
  `END_TIME` varchar(100) DEFAULT NULL,
  `YEARS` int(10) DEFAULT NULL,
  `NUMBER` varchar(100) DEFAULT NULL,
  `EMAIL` varchar(32) DEFAULT NULL,
  `SEX` varchar(32) DEFAULT NULL,
  `AGE` int(10) DEFAULT NULL,
  `ICON` varchar(255) DEFAULT NULL,
  `BIRTHDAY` varchar(100) DEFAULT NULL,
  `ADDRESS` varchar(255) DEFAULT NULL,
  `COUNTRY` varchar(32) DEFAULT NULL,
  `PROVINCE` varchar(32) DEFAULT NULL,
  `CITY` varchar(32) DEFAULT NULL,
  `ZONE` varchar(32) DEFAULT NULL,
  `TOKEN` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `sys_app_user` WRITE;
/*!40000 ALTER TABLE `sys_app_user` DISABLE KEYS */;

INSERT INTO `sys_app_user` (`USER_ID`, `USERNAME`, `PASSWORD`, `NAME`, `RIGHTS`, `ROLE_ID`, `LAST_LOGIN`, `IP`, `STATUS`, `BZ`, `PHONE`, `SFID`, `START_TIME`, `END_TIME`, `YEARS`, `NUMBER`, `EMAIL`, `SEX`, `AGE`, `ICON`, `BIRTHDAY`, `ADDRESS`, `COUNTRY`, `PROVINCE`, `CITY`, `ZONE`, `TOKEN`)
VALUES
	('4ef200bda1ce4025a5cfe911c0d445ff','13316021056','e10adc3949ba59abbe56e057f20f883e',NULL,'','1b67fc82ce89457a8347ae53e43a347e','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'女',23,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'fdcb5aa402a24cd5be8ed7de90f39e8b'),
	('9a724fcdb6444099a66f1d3560727fd8','13316021058','e10adc3949ba59abbe56e057f20f883e','5雨纷纷','','1b67fc82ce89457a8347ae53e43a347e','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'女',21,'af87d7c5e9c347ba8ed44ec1fc082599',NULL,NULL,NULL,'安徽省','阜阳市','界首市','748e3a1c1da44d5d96462e1ce0df64e6'),
	('bc6c4cba9c1a4d3aa3bfd94d7d649cd6','13316021059','24b70d4cfd7d9f6c64f452cac8870b1e','跳跳鱼','','1b67fc82ce89457a8347ae53e43a347e','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'男',24,'fbfa0dc83ad4403ba04af9de957e8197',NULL,NULL,NULL,'上海市','上海市','长宁区','e6d069d2aeda4084b121b36648fd4f7b');

/*!40000 ALTER TABLE `sys_app_user` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sys_appimg
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_appimg`;

CREATE TABLE `sys_appimg` (
  `IMG_ID` varchar(100) NOT NULL,
  `IMG_PATH` varchar(500) DEFAULT NULL COMMENT 'URL路径',
  `IMG_WITH` int(11) NOT NULL COMMENT '宽',
  `IMG_HIGH` int(11) NOT NULL COMMENT '高',
  PRIMARY KEY (`IMG_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `sys_appimg` WRITE;
/*!40000 ALTER TABLE `sys_appimg` DISABLE KEYS */;

INSERT INTO `sys_appimg` (`IMG_ID`, `IMG_PATH`, `IMG_WITH`, `IMG_HIGH`)
VALUES
	('097814bc72c64211999891c22014a21b','http://fisbump.oss-cn-shenzhen.aliyuncs.com/fisbump/f2e05872da6b4209a2c79d123a30eb4c',4128,2322),
	('13b1e5c7c91d459d808a87838da8ea46','http://fisbump.oss-cn-shenzhen.aliyuncs.com/fisbump/bfbfd15e47604874bdf51c1f5616c394',2322,4128),
	('1c8ab563985d4869b1325694c78e8dca','http://fisbump.oss-cn-shenzhen.aliyuncs.com/fisbump/744357e7c8fc49fcad3191f29ca785b0',4128,2322),
	('28ea96305c9a4a7e87bbc5733aff07c1','http://fisbump.oss-cn-shenzhen.aliyuncs.com/fisbump/5eba63c48e6f44bea02d884237d3e412',2322,4128),
	('5591495993ca40848b4a3f628b36f67d','http://fisbump.oss-cn-shenzhen.aliyuncs.com/fisbump/192142d890ca48389eb2d277ffac8bd7',4128,2322),
	('5b3d83b3ce2e4faf9bab7822cd6c7efc','http://fisbump.oss-cn-shenzhen.aliyuncs.com/fisbump/45f25401e3ac48dc9b931e9fca8d3a3e',2322,4128),
	('7ab03315abaf4173b2a422f63690083e','http://fisbump.oss-cn-shenzhen.aliyuncs.com/fisbump/5cd5a127eb8547ee813316982b8d3a8b',2322,4128),
	('8fa731f45c484ae8ba0d6d07680d2d6a','http://fisbump.oss-cn-shenzhen.aliyuncs.com/fisbump/c0d4e18df9314de78b7f69b0467f8a31',4128,2322),
	('a31436bfa19441b2a1c7bf31c81db505','http://fisbump.oss-cn-shenzhen.aliyuncs.com/fisbump/4f2b1e7cd1e742c6910ebac199da99d6',2322,4128),
	('ab03e0f364864512a90aef0a26065271','http://fisbump.oss-cn-shenzhen.aliyuncs.com/fisbump/0aa3c5eb72034c1e8ed229dc7507aea6',2322,4128),
	('c311ee188bab4efd93cdf98ef760efa7','http://fisbump.oss-cn-shenzhen.aliyuncs.com/fisbump/1cba7e8b5f7849ccaad988bb46755175',2322,4128),
	('fbfa0dc83ad4403ba04af9de957e8197','http://fisbump.oss-cn-shenzhen.aliyuncs.com/fisbump/5fee1aa996f745199daf38fdc70ba04e',2944,4104);

/*!40000 ALTER TABLE `sys_appimg` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sys_appuserpreferences
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_appuserpreferences`;

CREATE TABLE `sys_appuserpreferences` (
  `USERPREFERENCES_ID` varchar(100) NOT NULL,
  `NAME` varchar(255) DEFAULT NULL COMMENT '名称',
  `ICON` varchar(255) DEFAULT NULL COMMENT '图片',
  PRIMARY KEY (`USERPREFERENCES_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `sys_appuserpreferences` WRITE;
/*!40000 ALTER TABLE `sys_appuserpreferences` DISABLE KEYS */;

INSERT INTO `sys_appuserpreferences` (`USERPREFERENCES_ID`, `NAME`, `ICON`)
VALUES
	('bc8375f9ec4d463f822b4caf2be8c1b9','滑板','059eb129f7034ae0bf5aa40f396890a4');

/*!40000 ALTER TABLE `sys_appuserpreferences` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sys_appversion
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_appversion`;

CREATE TABLE `sys_appversion` (
  `APPVERSION_ID` varchar(100) NOT NULL,
  `APPVERSION_NAME` varchar(255) DEFAULT NULL COMMENT '版本名称',
  `APPVERSION_CODE` int(11) DEFAULT '1' COMMENT '版本编号',
  `APPVERSION_DESCRIBE` varchar(500) DEFAULT NULL COMMENT '描述',
  `APP_URL` varchar(500) DEFAULT NULL COMMENT 'app下载地址',
  PRIMARY KEY (`APPVERSION_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `sys_appversion` WRITE;
/*!40000 ALTER TABLE `sys_appversion` DISABLE KEYS */;

INSERT INTO `sys_appversion` (`APPVERSION_ID`, `APPVERSION_NAME`, `APPVERSION_CODE`, `APPVERSION_DESCRIBE`, `APP_URL`)
VALUES
	('064ec12b7b9a4c3c8c1a88d145154cfe','fakie1.0',1,'fakie1.0版本发布','http://192.168.0.16:8080/fakie/uploadFiles/file/20161124/fakie1.0.apk');

/*!40000 ALTER TABLE `sys_appversion` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sys_collection
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_collection`;

CREATE TABLE `sys_collection` (
  `COLLECTION_ID` varchar(100) NOT NULL,
  `SHARE` varchar(255) DEFAULT NULL COMMENT '被收藏的分享',
  `USER` varchar(255) DEFAULT NULL COMMENT '收藏者',
  `TIME` varchar(255) DEFAULT NULL COMMENT '时间',
  PRIMARY KEY (`COLLECTION_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `sys_collection` WRITE;
/*!40000 ALTER TABLE `sys_collection` DISABLE KEYS */;

INSERT INTO `sys_collection` (`COLLECTION_ID`, `SHARE`, `USER`, `TIME`)
VALUES
	('8e4ecae4be1f4eb284d4b9c23aa96d08','682463d8e7a040f4be942fbef44888bc','bc6c4cba9c1a4d3aa3bfd94d7d649cd6','2016/12/14');

/*!40000 ALTER TABLE `sys_collection` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sys_comment
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_comment`;

CREATE TABLE `sys_comment` (
  `COMMENT_ID` varchar(100) NOT NULL,
  `SHARE` varchar(255) DEFAULT NULL COMMENT '分享ID',
  `USER` varchar(255) DEFAULT NULL COMMENT '被评论者',
  `COMMENT_USER` varchar(255) DEFAULT NULL COMMENT '评论者',
  `TIME` varchar(255) DEFAULT NULL COMMENT '时间',
  `CONTENT` varchar(255) DEFAULT NULL COMMENT '内容',
  PRIMARY KEY (`COMMENT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `sys_comment` WRITE;
/*!40000 ALTER TABLE `sys_comment` DISABLE KEYS */;

INSERT INTO `sys_comment` (`COMMENT_ID`, `SHARE`, `USER`, `COMMENT_USER`, `TIME`, `CONTENT`)
VALUES
	('a3016dc09dfe42d6afbb57212a2a2350','04ec0fb51f6841ecaad7568c70d90fcf','bc6c4cba9c1a4d3aa3bfd94d7d649cd6','bc6c4cba9c1a4d3aa3bfd94d7d649cd6','2016/12/15','@跳跳鱼 家啊还回家'),
	('ba590b0d637649f09a11ee2eede4a4b1','04ec0fb51f6841ecaad7568c70d90fcf','bc6c4cba9c1a4d3aa3bfd94d7d649cd6','bc6c4cba9c1a4d3aa3bfd94d7d649cd6','2016/12/14','去过一次'),
	('c3b1db6014764dc6b94e28bce0daaac7','04ec0fb51f6841ecaad7568c70d90fcf','bc6c4cba9c1a4d3aa3bfd94d7d649cd6','bc6c4cba9c1a4d3aa3bfd94d7d649cd6','2016/12/14','@跳跳鱼 GG'),
	('c5ef946e76bc42f990e0a6aa1b8c99bc','05f1d75343334a3f96c963dcf18dc73f','bc6c4cba9c1a4d3aa3bfd94d7d649cd6','bc6c4cba9c1a4d3aa3bfd94d7d649cd6','2016/12/15','哈哈哈'),
	('cf80701599be492893a47748671a37f8','04ec0fb51f6841ecaad7568c70d90fcf','bc6c4cba9c1a4d3aa3bfd94d7d649cd6','bc6c4cba9c1a4d3aa3bfd94d7d649cd6','2016/12/15',' 赤果果');

/*!40000 ALTER TABLE `sys_comment` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sys_createcode
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_createcode`;

CREATE TABLE `sys_createcode` (
  `CREATECODE_ID` varchar(100) NOT NULL,
  `PACKAGENAME` varchar(50) DEFAULT NULL COMMENT '包名',
  `OBJECTNAME` varchar(50) DEFAULT NULL COMMENT '类名',
  `TABLENAME` varchar(50) DEFAULT NULL COMMENT '表名',
  `FIELDLIST` varchar(5000) DEFAULT NULL COMMENT '属性集',
  `CREATETIME` varchar(100) DEFAULT NULL COMMENT '创建时间',
  `TITLE` varchar(255) DEFAULT NULL COMMENT '描述',
  `FHTYPE` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`CREATECODE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `sys_createcode` WRITE;
/*!40000 ALTER TABLE `sys_createcode` DISABLE KEYS */;

INSERT INTO `sys_createcode` (`CREATECODE_ID`, `PACKAGENAME`, `OBJECTNAME`, `TABLENAME`, `FIELDLIST`, `CREATETIME`, `TITLE`, `FHTYPE`)
VALUES
	('002ea762e3e242a7a10ea5ca633701d8','system','Buttonrights','sys_,fh,BUTTONRIGHTS','NAME,fh,String,fh,名称,fh,是,fh,无,fh,255Q313596790','2016-01-16 23:20:36','按钮权限','single'),
	('01c910b6254546e29a76e7c25f11a972','fhtest','Stest','FHTESTS_,fh,STEST','FHSJS,fh,String,fh,姓名,fh,是,fh,无,fh,255,fh,0Q313596790BRITHDAY,fh,Date,fh,生日,fh,是,fh,无,fh,32,fh,0Q313596790AGE,fh,Integer,fh,年龄,fh,是,fh,无,fh,11,fh,0Q313596790JINGDU,fh,Double,fh,精度,fh,是,fh,无,fh,11,fh,3Q313596790','2016-04-16 03:13:10','测试','tree'),
	('0e2d98eb0aaf4dbdbc7eeb382431e90e','app','Banner','TB_,fh,BANNER','IMG,fh,String,fh,图片,fh,是,fh,无,fh,255,fh,0Q313596790STATE,fh,Integer,fh,状态,fh,是,fh,无,fh,11,fh,0Q313596790TYPE,fh,Integer,fh,类型,fh,是,fh,无,fh,11,fh,0Q313596790LINKID,fh,String,fh,跳转内容ID,fh,是,fh,无,fh,255,fh,0Q313596790','2018-10-26 10:09:27','banner','single'),
	('0ee023606efb45b9a3baaa072e502161','information','FtestMx','FH_,fh,FTESTMX','TITLE,fh,String,fh,标题,fh,是,fh,无,fh,255,fh,0Q313596790CHANGDU,fh,Integer,fh,长度,fh,是,fh,无,fh,11,fh,0Q313596790','2016-04-21 01:52:11','主表测试(明细)','sontable'),
	('16a51446679442a78deb8d3f71090013','app','IMG','SYS_APP,fh,IMG','IMG_PATH,fh,String,fh,URL路径,fh,是,fh,无,fh,500,fh,0Q313596790IMG_WITH,fh,Integer,fh,宽,fh,是,fh,无,fh,11,fh,0Q313596790IMG_HIGH,fh,Integer,fh,高,fh,是,fh,无,fh,11,fh,0Q313596790','2016-11-19 16:13:35','图片','single'),
	('1be959583e82473b82f6e62087bd0d38','information','Attached','TB_,fh,ATTACHED','NAME,fh,String,fh,NAME,fh,是,fh,无,fh,255,fh,0Q313596790FDESCRIBE,fh,String,fh,FDESCRIBE,fh,是,fh,无,fh,255,fh,0Q313596790PRICE,fh,Double,fh,PRICE,fh,是,fh,无,fh,11,fh,2Q313596790CTIME,fh,Date,fh,CTIME,fh,否,fh,无,fh,32,fh,0Q313596790','2016-04-21 17:07:59','主表测试','fathertable'),
	('26048784b08640ce80a9e8693d453ab6','app','Order','TB_,fh,ORDER','ORDERNO,fh,String,fh,订单号,fh,否,fh,0,fh,20,fh,0Q313596790SHOPID,fh,Integer,fh,门店ID,fh,否,fh,0,fh,11,fh,0Q313596790USERID,fh,Integer,fh,用户ID 0：为0则说明是闪电购，游客直接下单,fh,否,fh,0,fh,11,fh,0Q313596790ORDERSTATUS,fh,Integer,fh,订单状态 -3:用户拒收 -2:未付款的订单 -1：用户取消 0:待发货 1:配送中 2:用户确认收货,fh,否,fh,-2,fh,4,fh,0Q313596790GOODSMONEY,fh,Double,fh,商品总金额 商品总价格--未进行任何折扣的总价格,fh,是,fh,无,fh,11,fh,2Q313596790DELIVERTYPE,fh,Integer,fh,收货方式 0:送货上门 1:自提,fh,否,fh,0,fh,4,fh,0Q313596790DELIVERMONEY,fh,Double,fh,运费 运费规则按照每家店的规则算。,fh,是,fh,无,fh,11,fh,2Q313596790TOTALMONEY,fh,Double,fh,订单总金额 包括运费,fh,是,fh,无,fh,11,fh,2Q313596790REALTOTALMONEY,fh,Double,fh,实际订单总金额 进行各种折扣之后的金额,fh,是,fh,无,fh,11,fh,2Q313596790PAYTYPE,fh,Integer,fh,支付方式	 0:货到付款 1:在线支付,fh,否,fh,0,fh,4,fh,0Q313596790PAYFROM,fh,Integer,fh,支付来源	1:支付宝，2：微信	,fh,否,fh,无,fh,11,fh,0Q313596790ISPAY,fh,Integer,fh,是否支付	0:未支付 1:已支付	,fh,否,fh,0,fh,4,fh,0Q313596790USERNAME,fh,String,fh,收货人名称,fh,是,fh,无,fh,20,fh,0Q313596790USERADDRESS,fh,String,fh,收件人地址,fh,是,fh,无,fh,255,fh,0Q313596790USERPHONE,fh,String,fh,收件人手机	,fh,是,fh,无,fh,11,fh,0Q313596790ORDERSCORE,fh,Integer,fh,所得积分	,fh,否,fh,0,fh,11,fh,0Q313596790ISINVOICE,fh,Integer,fh,是否需要发票	1:需要 0:不需要	,fh,否,fh,0,fh,4,fh,0Q313596790INVOICECLIENT,fh,String,fh,发票抬头,fh,是,fh,无,fh,255,fh,0Q313596790ORDERREMARKS,fh,String,fh,订单备注	,fh,是,fh,无,fh,255,fh,0Q313596790ORDERSRC,fh,Integer,fh,订单来源	0:商城 1:微信 2:手机版 3:安卓App 4:苹果App	,fh,否,fh,0,fh,4,fh,0Q313596790NEEDPAY,fh,Double,fh,需缴费用	,fh,否,fh,0,fh,11,fh,2Q313596790ISREFUND,fh,Integer,fh,是否退款	0:否 1：是	,fh,否,fh,0,fh,4,fh,0Q313596790ISAPPRAISE,fh,Integer,fh,是否点评	0:未点评 1:已点评	,fh,否,fh,0,fh,4,fh,0Q313596790CANCELREASON,fh,Integer,fh,取消原因ID	,fh,否,fh,0,fh,11,fh,0Q313596790REJECTREASON,fh,Integer,fh,拒收原因ID	,fh,否,fh,0,fh,11,fh,0Q313596790REJECTOTHERREASON,fh,String,fh,拒收原因	,fh,是,fh,无,fh,255,fh,0Q313596790ISCLOSED,fh,Integer,fh,是否订单已完结0：未完结 1:已完结	,fh,否,fh,0,fh,4,fh,0Q313596790ORDERUNIQUE,fh,String,fh,订单流水号	,fh,是,fh,无,fh,50,fh,0Q313596790SETTLEMENTID,fh,Integer,fh,是否结算，大于0的话则是结算ID	,fh,否,fh,0,fh,11,fh,0Q313596790RECEIVETIME,fh,Date,fh,收货时间	,fh,是,fh,无,fh,32,fh,0Q313596790DELIVERYTIME,fh,Date,fh,发货时间	,fh,是,fh,无,fh,32,fh,0Q313596790EXPRESSID,fh,Integer,fh,快递公司ID	,fh,是,fh,无,fh,11,fh,0Q313596790EXPRESSNO,fh,String,fh,快递号	,fh,是,fh,无,fh,20,fh,0Q313596790TRADENO,fh,String,fh,在线支付交易流水	,fh,是,fh,无,fh,100,fh,0Q313596790DATAFLAG,fh,Integer,fh,订单有效标志	-1：删除 1:有效	,fh,否,fh,1,fh,4,fh,0Q313596790CREATETIME,fh,Date,fh,下单时间	,fh,否,fh,无,fh,32,fh,0Q313596790COMMISSIONFEE,fh,Double,fh,订单应收佣金	,fh,是,fh,无,fh,11,fh,2Q313596790','2018-11-25 15:28:56','订单','single'),
	('274578a822c24229978466cc0c10d240','app','Comment','SYS_,fh,COMMENT','SHARE,fh,String,fh,分享ID,fh,是,fh,无,fh,255,fh,0Q313596790USER,fh,String,fh,被评论者,fh,是,fh,无,fh,255,fh,0Q313596790COMMENT_USER,fh,String,fh,评论者,fh,是,fh,无,fh,255,fh,0Q313596790TIME,fh,String,fh,时间,fh,是,fh,无,fh,255,fh,0Q313596790CONTENT,fh,String,fh,内容,fh,是,fh,无,fh,255,fh,0Q313596790','2016-11-23 07:20:52','分享评论','single'),
	('4173a8c56a504dd6b6213d2b9cd3e91b','information','AttachedMx','TB_,fh,ATTACHEDMX','NAME,fh,String,fh,NAME,fh,是,fh,无,fh,255,fh,0Q313596790TITLE,fh,String,fh,TITLE,fh,是,fh,无,fh,255,fh,0Q313596790CTIME,fh,Date,fh,CTIME,fh,否,fh,无,fh,32,fh,0Q313596790PRICE,fh,Double,fh,PRICE,fh,是,fh,无,fh,11,fh,2Q313596790','2016-04-21 17:09:40','主表测试(明细)','sontable'),
	('44570f0d52cb44ba91407eda39ebba67','datasourcetwo','DataSource2','DS_,fh,DATASOURCE2','TITLE,fh,String,fh,标题,fh,是,fh,无,fh,100,fh,0Q313596790CONTENT,fh,String,fh,内容,fh,是,fh,无,fh,255,fh,0Q313596790','2016-04-29 02:01:06','第2数据源例子','single'),
	('49d985e081ed44e6b34ba1b8c5466e39','fhdb','TimingBackUp','DB_,fh,TIMINGBACKUP','JOBNAME,fh,String,fh,任务名称,fh,否,fh,无,fh,50Q313596790CREATE_TIME,fh,Date,fh,创建时间,fh,否,fh,无,fh,32Q313596790TABLENAME,fh,String,fh,表名,fh,是,fh,无,fh,50Q313596790TYPE,fh,Integer,fh,类型,fh,否,fh,无,fh,1Q313596790FHTIME,fh,String,fh,时间规则,fh,是,fh,无,fh,30Q313596790TIMEEXPLAIN,fh,String,fh,规则说明,fh,是,fh,无,fh,100Q313596790BZ,fh,String,fh,备注,fh,是,fh,无,fh,255Q313596790','2016-04-09 11:53:38','定时备份','single'),
	('4cde553ec4854a4e9f1ae17c2e831a0e','information','Ftest','FH_,fh,FTEST','NAME,fh,String,fh,姓名,fh,是,fh,无,fh,255,fh,0Q313596790AGE,fh,Integer,fh,年龄,fh,是,fh,无,fh,11,fh,0Q313596790CHANGDU,fh,Double,fh,长度,fh,是,fh,无,fh,11,fh,2Q313596790','2016-04-21 01:41:19','主表测试','fathertable'),
	('51f85a9883af423d9cd2fa3bf4b8d04e','app','Message','SYS_,fh,MESSAGE','COMMENT,fh,String,fh,评论消息,fh,是,fh,无,fh,255,fh,0Q313596790COLLECTION,fh,String,fh,收藏消息,fh,是,fh,无,fh,255,fh,0Q313596790FABULOUS,fh,String,fh,点赞消息,fh,是,fh,无,fh,255,fh,0Q313596790TIME,fh,String,fh,时间,fh,是,fh,无,fh,255,fh,0Q313596790ISREAD,fh,Integer,fh,是否已读标记,fh,是,fh,无,fh,11,fh,0Q313596790USER,fh,String,fh,用户,fh,是,fh,无,fh,255,fh,0Q313596790','2016-11-23 08:38:21','消息','single'),
	('58ea12f0e6264050a2fd4dd2d64c9d52','app','UserPreferences','SYS_APP,fh,USERPREFERENCES','NAME,fh,String,fh,名称,fh,是,fh,无,fh,255,fh,0Q313596790ICON,fh,String,fh,图片,fh,是,fh,无,fh,255,fh,0Q313596790','2016-11-18 22:33:07','用户喜好','single'),
	('59565c7a4e644ae191d564986f02c18c','app','Message','SYS_,fh,MESSAGE','COMMENT,fh,String,fh,评论消息,fh,是,fh,无,fh,255,fh,0Q313596790COLLECTION,fh,String,fh,收藏消息,fh,是,fh,无,fh,255,fh,0Q313596790FABULOUS,fh,String,fh,点赞消息,fh,是,fh,无,fh,255,fh,0Q313596790TIME,fh,String,fh,时间,fh,是,fh,无,fh,255,fh,0Q313596790READ,fh,Integer,fh,是否已读标记,fh,是,fh,无,fh,11,fh,0Q313596790USER,fh,String,fh,用户,fh,是,fh,无,fh,255,fh,0Q313596790','2016-11-23 07:41:03','消息','single'),
	('59b21b35fbdb4e32bdb80a5a444a9603','appversion','Appversion','SYS_,fh,APPVERSION','APPVERSION_NAME,fh,String,fh,版本名称,fh,是,fh,无,fh,255,fh,0Q313596790APPVERSION_CODE,fh,Integer,fh,版本编号,fh,否,fh,无,fh,11,fh,0Q313596790APPVERSION_DESCRIBE,fh,String,fh,描述,fh,是,fh,无,fh,500,fh,0Q313596790APP_URL,fh,String,fh,app下载地址,fh,是,fh,无,fh,500,fh,0Q313596790','2016-11-17 12:37:31','APP版本管理','single'),
	('6cffe93d02464940bcf72125b00c0e7f','app','Order','TB_,fh,ORDER','ORDERNO,fh,String,fh,订单号,fh,否,fh,0,fh,20,fh,0Q313596790SHOPID,fh,Integer,fh,门店ID,fh,否,fh,0,fh,11,fh,0Q313596790USERID,fh,Integer,fh,用户ID 0：为0则说明是闪电购，游客直接下单,fh,否,fh,0,fh,11,fh,0Q313596790ORDERSTATUS,fh,Integer,fh,订单状态 -3:用户拒收 -2:未付款的订单 -1：用户取消 0:待发货 1:配送中 2:用户确认收货,fh,否,fh,-2,fh,4,fh,0Q313596790GOODSMONEY,fh,Double,fh,商品总金额 商品总价格--未进行任何折扣的总价格,fh,是,fh,无,fh,11,fh,2Q313596790DELIVERTYPE,fh,Integer,fh,收货方式 0:送货上门 1:自提,fh,否,fh,0,fh,4,fh,0Q313596790DELIVERMONEY,fh,Double,fh,运费 运费规则按照每家店的规则算。,fh,是,fh,无,fh,11,fh,2Q313596790TOTALMONEY,fh,Double,fh,订单总金额 包括运费,fh,是,fh,无,fh,11,fh,2Q313596790REALTOTALMONEY,fh,Double,fh,实际订单总金额 进行各种折扣之后的金额,fh,是,fh,无,fh,11,fh,2Q313596790PAYTYPE,fh,Integer,fh,支付方式	 0:货到付款 1:在线支付,fh,否,fh,0,fh,4,fh,0Q313596790PAYFROM,fh,Integer,fh,支付来源	1:支付宝，2：微信	,fh,否,fh,无,fh,11,fh,0Q313596790ISPAY,fh,Integer,fh,是否支付	0:未支付 1:已支付	,fh,否,fh,0,fh,4,fh,0Q313596790USERNAME,fh,String,fh,收货人名称,fh,是,fh,无,fh,20,fh,0Q313596790USERADDRESS,fh,String,fh,收件人地址,fh,是,fh,无,fh,255,fh,0Q313596790USERPHONE,fh,String,fh,收件人手机	,fh,是,fh,无,fh,11,fh,0Q313596790ORDERSCORE,fh,Integer,fh,所得积分	,fh,否,fh,0,fh,11,fh,0Q313596790ISINVOICE,fh,Integer,fh,是否需要发票	1:需要 0:不需要	,fh,否,fh,0,fh,4,fh,0Q313596790INVOICECLIENT,fh,String,fh,发票抬头,fh,是,fh,无,fh,255,fh,0Q313596790ORDERREMARKS,fh,String,fh,订单备注	,fh,是,fh,无,fh,255,fh,0Q313596790ORDERSRC,fh,Integer,fh,订单来源	0:商城 1:微信 2:手机版 3:安卓App 4:苹果App	,fh,否,fh,0,fh,4,fh,0Q313596790NEEDPAY,fh,Double,fh,需缴费用	,fh,否,fh,0,fh,11,fh,2Q313596790ISREFUND,fh,Integer,fh,是否退款	0:否 1：是	,fh,否,fh,0,fh,4,fh,0Q313596790ISAPPRAISE,fh,Integer,fh,是否点评	0:未点评 1:已点评	,fh,否,fh,0,fh,4,fh,0Q313596790CANCELREASON,fh,Integer,fh,取消原因ID	,fh,否,fh,0,fh,11,fh,0Q313596790REJECTREASON,fh,Integer,fh,拒收原因ID	,fh,否,fh,0,fh,11,fh,0Q313596790REJECTOTHERREASON,fh,String,fh,拒收原因	,fh,是,fh,无,fh,255,fh,0Q313596790ISCLOSED,fh,Integer,fh,是否订单已完结0：未完结 1:已完结	,fh,否,fh,0,fh,4,fh,0Q313596790ORDERUNIQUE,fh,String,fh,订单流水号	,fh,是,fh,无,fh,50,fh,0Q313596790SETTLEMENTID,fh,Integer,fh,是否结算，大于0的话则是结算ID	,fh,否,fh,0,fh,11,fh,0Q313596790RECEIVETIME,fh,Date,fh,收货时间	,fh,是,fh,无,fh,32,fh,0Q313596790DELIVERYTIME,fh,Date,fh,发货时间	,fh,是,fh,无,fh,32,fh,0Q313596790EXPRESSID,fh,Integer,fh,快递公司ID	,fh,是,fh,无,fh,11,fh,0Q313596790EXPRESSNO,fh,String,fh,快递号	,fh,是,fh,无,fh,20,fh,0Q313596790TRADENO,fh,String,fh,在线支付交易流水	,fh,是,fh,无,fh,100,fh,0Q313596790DATAFLAG,fh,Integer,fh,订单有效标志	-1：删除 1:有效	,fh,否,fh,1,fh,4,fh,0Q313596790CREATETIME,fh,Date,fh,下单时间	,fh,否,fh,无,fh,32,fh,0Q313596790COMMISSIONFEE,fh,Double,fh,订单应收佣金	,fh,是,fh,无,fh,11,fh,2Q313596790','2018-11-25 15:17:33','订单','single'),
	('6ed5bfe401a44bc5b47b14911fa9a4ef','dst','DataSource2','DS_,fh,DATASOURCE2','TITLE,fh,String,fh,标题,fh,是,fh,无,fh,100,fh,0Q313596790CONTENT,fh,String,fh,内容,fh,是,fh,无,fh,255,fh,0Q313596790','2016-04-29 02:07:34','第2数据源例子','single'),
	('90e6cde2558a43a6846b06352d762170','app','Fabulous','SYS_,fh,FABULOUS','SHARE,fh,String,fh,被点赞的分享,fh,是,fh,无,fh,255,fh,0Q313596790USER,fh,String,fh,点赞者,fh,是,fh,无,fh,255,fh,0Q313596790TIME,fh,String,fh,时间,fh,是,fh,无,fh,255,fh,0Q313596790','2018-11-26 16:57:07','分享点赞','single'),
	('91af9fe509704fa68f6bca121359e3ec','fhoa','Staff','OA_,fh,STAFF','NAME,fh,String,fh,姓名,fh,是,fh,无,fh,50,fh,0Q313596790NAME_EN,fh,String,fh,英文,fh,是,fh,无,fh,50,fh,0Q313596790BIANMA,fh,String,fh,编码,fh,是,fh,无,fh,100,fh,0Q313596790DEPARTMENT_ID,fh,String,fh,部门,fh,是,fh,无,fh,100,fh,0Q313596790FUNCTIONS,fh,String,fh,职责,fh,是,fh,无,fh,255,fh,0Q313596790TEL,fh,String,fh,电话,fh,是,fh,无,fh,20,fh,0Q313596790EMAIL,fh,String,fh,邮箱,fh,是,fh,无,fh,50,fh,0Q313596790SEX,fh,String,fh,性别,fh,是,fh,无,fh,10,fh,0Q313596790BIRTHDAY,fh,Date,fh,出生日期,fh,是,fh,无,fh,32,fh,0Q313596790NATION,fh,String,fh,民族,fh,是,fh,无,fh,10,fh,0Q313596790JOBTYPE,fh,String,fh,岗位类别,fh,是,fh,无,fh,30,fh,0Q313596790JOBJOINTIME,fh,Date,fh,参加工作时间,fh,是,fh,无,fh,32,fh,0Q313596790FADDRESS,fh,String,fh,籍贯,fh,是,fh,无,fh,100,fh,0Q313596790POLITICAL,fh,String,fh,政治面貌,fh,是,fh,无,fh,30,fh,0Q313596790PJOINTIME,fh,Date,fh,入团时间,fh,是,fh,无,fh,32,fh,0Q313596790SFID,fh,String,fh,身份证号,fh,是,fh,无,fh,20,fh,0Q313596790MARITAL,fh,String,fh,婚姻状况,fh,是,fh,无,fh,10,fh,0Q313596790DJOINTIME,fh,Date,fh,进本单位时间,fh,是,fh,无,fh,32,fh,0Q313596790POST,fh,String,fh,现岗位,fh,是,fh,无,fh,30,fh,0Q313596790POJOINTIME,fh,Date,fh,上岗时间,fh,是,fh,无,fh,32,fh,0Q313596790EDUCATION,fh,String,fh,学历,fh,是,fh,无,fh,10,fh,0Q313596790SCHOOL,fh,String,fh,毕业学校,fh,是,fh,无,fh,30,fh,0Q313596790MAJOR,fh,String,fh,专业,fh,是,fh,无,fh,30,fh,0Q313596790FTITLE,fh,String,fh,职称,fh,是,fh,无,fh,30,fh,0Q313596790CERTIFICATE,fh,String,fh,职业资格证,fh,是,fh,无,fh,30,fh,0Q313596790CONTRACTLENGTH,fh,Integer,fh,劳动合同时长,fh,是,fh,无,fh,2,fh,0Q313596790CSTARTTIME,fh,Date,fh,签订日期,fh,是,fh,无,fh,32,fh,0Q313596790CENDTIME,fh,Date,fh,终止日期,fh,是,fh,无,fh,32,fh,0Q313596790ADDRESS,fh,String,fh,现住址,fh,是,fh,无,fh,100,fh,0Q313596790USER_ID,fh,String,fh,绑定账号ID,fh,否,fh,无,fh,100,fh,0Q313596790BZ,fh,String,fh,备注,fh,是,fh,无,fh,255,fh,0Q313596790','2016-04-23 20:44:31','员工管理','single'),
	('97fcfff30bb44918b52b460ef9d83d28','app','Collection','SYS_,fh,COLLECTION','SHARE,fh,String,fh,被收藏的分享,fh,是,fh,无,fh,255,fh,0Q313596790USER,fh,String,fh,收藏者,fh,是,fh,无,fh,255,fh,0Q313596790TIME,fh,String,fh,时间,fh,是,fh,无,fh,255,fh,0Q313596790','2016-11-23 07:32:28','分享收藏','single'),
	('984d672fc69b4ebea6a26c07ba69afcc','app','Share','SYS_,fh,SHARE','USER,fh,String,fh,用户,fh,是,fh,无,fh,255,fh,0Q313596790SHARE_TYPE,fh,String,fh,分享类型,fh,是,fh,无,fh,255,fh,0Q313596790TITLE,fh,String,fh,标题,fh,是,fh,无,fh,255,fh,0Q313596790DESCRIBE,fh,String,fh,描述,fh,是,fh,无,fh,255,fh,0Q313596790IMAGE,fh,String,fh,图片,fh,是,fh,无,fh,255,fh,0Q313596790TIME,fh,String,fh,时间,fh,是,fh,无,fh,255,fh,0Q313596790','2016-11-23 07:24:44','分享','single'),
	('99b296d0e4334da5a348a05ffbd152b6','app','BannerEdit','TB_,fh,BANNEREDIT','IMG,fh,String,fh,图片,fh,是,fh,无,fh,255,fh,0Q313596790STATE,fh,Integer,fh,状态,fh,是,fh,无,fh,11,fh,0Q313596790TYPE,fh,Integer,fh,类型,fh,是,fh,无,fh,11,fh,0Q313596790LINKID,fh,String,fh,跳转内容ID,fh,是,fh,无,fh,255,fh,0Q313596790','2018-10-25 18:46:56','banneredit','single'),
	('a24768e5233a4d92bbc186df3b3cecd1','app','Share','SYS_,fh,SHARE','USER,fh,String,fh,用户,fh,是,fh,无,fh,255,fh,0Q313596790SHARE_TYPE,fh,String,fh,分享类型,fh,是,fh,无,fh,255,fh,0Q313596790TITLE,fh,String,fh,标题,fh,是,fh,无,fh,255,fh,0Q313596790DESCRIBE,fh,String,fh,描述,fh,是,fh,无,fh,255,fh,0Q313596790IMAGE,fh,String,fh,图片,fh,是,fh,无,fh,255,fh,0Q313596790','2016-11-23 07:15:36','分享','single'),
	('a81283d775264728990c3039d1b4d4c1','fhoa','Datajur','OA_,fh,DATAJUR','DEPARTMENT_IDS,fh,String,fh,部门ID组合,fh,否,fh,无,fh,5000,fh,0Q313596790STAFF_ID,fh,String,fh,员工ID,fh,否,fh,无,fh,100,fh,0Q313596790','2016-04-26 19:00:11','数据权限表','single'),
	('a94ab540d917491a8089a80a6f0adc49','app','UserAndPreferences','RS_,fh,USERANDPREFERENCES','USER_ID,fh,String,fh,用户ID,fh,是,fh,无,fh,255,fh,0Q313596790USERPREFERENCES_ID,fh,String,fh,用户喜好ID,fh,是,fh,无,fh,255,fh,0Q313596790','2016-11-19 18:44:28','用户与用户喜好关系表','single'),
	('ae92803163ff44539e91711cfbe35411','fhoa','Datajur','OA_,fh,DATAJUR','DEPARTMENT_IDS,fh,String,fh,部门ID组合,fh,否,fh,无,fh,5000,fh,0Q313596790STAFF_ID,fh,String,fh,员工ID,fh,否,fh,无,fh,100,fh,0Q313596790DEPARTMENT_ID,fh,String,fh,部门ID,fh,是,fh,无,fh,100,fh,0Q313596790','2016-04-27 03:49:39','数据权限表','single'),
	('bf35ab8b2d064bf7928a04bba5e5a6dd','system','Fhsms','SYS_,fh,FHSMS','CONTENT,fh,String,fh,内容,fh,是,fh,无,fh,1000Q313596790TYPE,fh,String,fh,类型,fh,否,fh,无,fh,5Q313596790TO_USERNAME,fh,String,fh,收信人,fh,是,fh,无,fh,255Q313596790FROM_USERNAME,fh,String,fh,发信人,fh,是,fh,无,fh,255Q313596790SEND_TIME,fh,String,fh,发信时间,fh,是,fh,无,fh,100Q313596790STATUS,fh,String,fh,状态,fh,否,fh,无,fh,5Q313596790SANME_ID,fh,String,fh,共同ID,fh,是,fh,无,fh,100Q313596790','2016-03-27 21:39:45','站内信','single'),
	('c7586f931fd44c61beccd3248774c68c','system','Department','SYS_,fh,DEPARTMENT','NAME,fh,String,fh,名称,fh,是,fh,无,fh,30Q313596790NAME_EN,fh,String,fh,英文,fh,是,fh,无,fh,50Q313596790BIANMA,fh,String,fh,编码,fh,是,fh,无,fh,50Q313596790PARENT_ID,fh,String,fh,上级ID,fh,否,fh,无,fh,100Q313596790BZ,fh,String,fh,备注,fh,是,fh,无,fh,255Q313596790HEADMAN,fh,String,fh,负责人,fh,是,fh,无,fh,30Q313596790TEL,fh,String,fh,电话,fh,是,fh,无,fh,50Q313596790FUNCTIONS,fh,String,fh,部门职能,fh,是,fh,无,fh,255Q313596790ADDRESS,fh,String,fh,地址,fh,是,fh,无,fh,255Q313596790','2015-12-20 01:49:25','组织机构','tree'),
	('c937e21208914e5b8fb1202c685bbf2f','fhdb','Fhdb','DB_,fh,FHDB','USERNAME,fh,String,fh,操作用户,fh,否,fh,无,fh,50Q313596790BACKUP_TIME,fh,Date,fh,备份时间,fh,否,fh,无,fh,32Q313596790TABLENAME,fh,String,fh,表名,fh,是,fh,无,fh,50Q313596790SQLPATH,fh,String,fh,存储位置,fh,否,fh,无,fh,300Q313596790TYPE,fh,Integer,fh,类型,fh,是,fh,无,fh,1Q313596790DBSIZE,fh,String,fh,文件大小,fh,否,fh,无,fh,10Q313596790BZ,fh,String,fh,备注,fh,否,fh,无,fh,255Q313596790','2016-03-30 13:46:54','数据库管理','single'),
	('e40c48f9ddc14cc9b76aee1ef5bcef52','app','Share','SYS_,fh,SHARE','USER,fh,String,fh,用户,fh,是,fh,无,fh,255,fh,0Q313596790SHARE_TYPE,fh,String,fh,分享类型,fh,是,fh,无,fh,255,fh,0Q313596790TITLE,fh,String,fh,标题,fh,是,fh,无,fh,255,fh,0Q313596790SHARE_DESCRIBE,fh,String,fh,描述,fh,是,fh,无,fh,255,fh,0Q313596790IMAGE,fh,String,fh,图片,fh,是,fh,无,fh,255,fh,0Q313596790TIME,fh,String,fh,时间,fh,是,fh,无,fh,255,fh,0Q313596790','2016-11-23 08:02:35','分享','single'),
	('e4e5506cc73a4b088d9f870423326030','app','Fabulous','SYS_,fh,FABULOUS','SHARE,fh,String,fh,被点赞的分享,fh,是,fh,无,fh,255,fh,0Q313596790USER,fh,String,fh,点赞者,fh,是,fh,无,fh,255,fh,0Q313596790TIME,fh,String,fh,时间,fh,是,fh,无,fh,255,fh,0Q313596790','2016-11-23 07:29:56','分享点赞','single'),
	('f9968351ef0d4c2ca559b193c2eb6cc9','app','Follow','SYS_,fh,FOLLOW','USER,fh,String,fh,被关注的用户,fh,是,fh,无,fh,255,fh,0Q313596790FOLLOW_USER,fh,String,fh,关注者,fh,是,fh,无,fh,255,fh,0Q313596790','2016-12-10 17:13:15','关注','single'),
	('fe239f8742194481a5b56f90cad71520','system','Fhbutton','SYS_,fh,FHBUTTON','NAME,fh,String,fh,名称,fh,是,fh,无,fh,30Q313596790QX_NAME,fh,String,fh,权限标识,fh,是,fh,无,fh,50Q313596790BZ,fh,String,fh,备注,fh,是,fh,无,fh,255Q313596790','2016-01-15 18:38:40','按钮管理','single');

/*!40000 ALTER TABLE `sys_createcode` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sys_dictionaries
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_dictionaries`;

CREATE TABLE `sys_dictionaries` (
  `DICTIONARIES_ID` varchar(100) NOT NULL,
  `NAME` varchar(30) DEFAULT NULL COMMENT '名称',
  `NAME_EN` varchar(50) DEFAULT NULL COMMENT '英文',
  `BIANMA` varchar(50) DEFAULT NULL COMMENT '编码',
  `ORDER_BY` int(11) NOT NULL COMMENT '排序',
  `PARENT_ID` varchar(100) DEFAULT NULL COMMENT '上级ID',
  `BZ` varchar(255) DEFAULT NULL COMMENT '备注',
  `TBSNAME` varchar(100) DEFAULT NULL COMMENT '排查表',
  PRIMARY KEY (`DICTIONARIES_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `sys_dictionaries` WRITE;
/*!40000 ALTER TABLE `sys_dictionaries` DISABLE KEYS */;

INSERT INTO `sys_dictionaries` (`DICTIONARIES_ID`, `NAME`, `NAME_EN`, `BIANMA`, `ORDER_BY`, `PARENT_ID`, `BZ`, `TBSNAME`)
VALUES
	('096e4ec8986149d994b09e604504e38d','黄浦区','huangpu','0030201',1,'f1ea30ddef1340609c35c88fb2919bee','黄埔',''),
	('12a62a3e5bed44bba0412b7e6b733c93','北京','beijing','00301',1,'be4a8c5182c744d28282a5345783a77f','北京',''),
	('507fa87a49104c7c8cdb52fdb297da12','宣武区','xuanwuqu','0030101',1,'12a62a3e5bed44bba0412b7e6b733c93','宣武区',''),
	('8994f5995f474e2dba6cfbcdfe5ea07a','语文','yuwen','00201',1,'fce20eb06d7b4b4d8f200eda623f725c','语文',''),
	('8ea7c44af25f48b993a14f791c8d689f','分类','fenlei','001',1,'0','分类',''),
	('be4a8c5182c744d28282a5345783a77f','地区','diqu','003',3,'0','地区',''),
	('d428594b0494476aa7338d9061e23ae3','红色','red','00101',1,'8ea7c44af25f48b993a14f791c8d689f','红色',''),
	('de9afadfbed0428fa343704d6acce2c4','绿色','green','00102',2,'8ea7c44af25f48b993a14f791c8d689f','绿色',''),
	('f1ea30ddef1340609c35c88fb2919bee','上海','shanghai','00302',2,'be4a8c5182c744d28282a5345783a77f','上海',''),
	('fce20eb06d7b4b4d8f200eda623f725c','课程','kecheng','002',2,'0','课程','');

/*!40000 ALTER TABLE `sys_dictionaries` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sys_fabulous
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_fabulous`;

CREATE TABLE `sys_fabulous` (
  `FABULOUS_ID` varchar(100) NOT NULL,
  `SHARE` varchar(255) DEFAULT NULL COMMENT '被点赞的分享',
  `USER` varchar(255) DEFAULT NULL COMMENT '点赞者',
  `TIME` varchar(255) DEFAULT NULL COMMENT '时间',
  PRIMARY KEY (`FABULOUS_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table sys_fhbutton
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_fhbutton`;

CREATE TABLE `sys_fhbutton` (
  `FHBUTTON_ID` varchar(100) NOT NULL,
  `NAME` varchar(30) DEFAULT NULL COMMENT '名称',
  `QX_NAME` varchar(50) DEFAULT NULL COMMENT '权限标识',
  `BZ` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`FHBUTTON_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `sys_fhbutton` WRITE;
/*!40000 ALTER TABLE `sys_fhbutton` DISABLE KEYS */;

INSERT INTO `sys_fhbutton` (`FHBUTTON_ID`, `NAME`, `QX_NAME`, `BZ`)
VALUES
	('3542adfbda73410c976e185ffe50ad06','导出EXCEL','toExcel','导出EXCEL'),
	('46992ea280ba4b72b29dedb0d4bc0106','发邮件','email','发送电子邮件'),
	('4c7f34b9eed54683957f356afcda24df','组织机构数据权限','Datajur','组织机构数据权限按钮'),
	('4efa162fce8340f0bd2dcd3b11d327ec','导入EXCEL','FromExcel','导入EXCEL到系统用户'),
	('cc51b694d5344d28a9aa13c84b7166cd','发短信','sms','发送短信'),
	('da7fd386de0b49ce809984f5919022b8','站内信','FHSMS','发送站内信'),
	('fc5e8767b4564f34a0d2ce2375fcc92e','绑定用户','userBinding','绑定用户');

/*!40000 ALTER TABLE `sys_fhbutton` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sys_fhsms
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_fhsms`;

CREATE TABLE `sys_fhsms` (
  `FHSMS_ID` varchar(100) NOT NULL,
  `CONTENT` varchar(1000) DEFAULT NULL COMMENT '内容',
  `TYPE` varchar(5) DEFAULT NULL COMMENT '类型',
  `TO_USERNAME` varchar(255) DEFAULT NULL COMMENT '收信人',
  `FROM_USERNAME` varchar(255) DEFAULT NULL COMMENT '发信人',
  `SEND_TIME` varchar(100) DEFAULT NULL COMMENT '发信时间',
  `STATUS` varchar(5) DEFAULT NULL COMMENT '状态',
  `SANME_ID` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`FHSMS_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `sys_fhsms` WRITE;
/*!40000 ALTER TABLE `sys_fhsms` DISABLE KEYS */;

INSERT INTO `sys_fhsms` (`FHSMS_ID`, `CONTENT`, `TYPE`, `TO_USERNAME`, `FROM_USERNAME`, `SEND_TIME`, `STATUS`, `SANME_ID`)
VALUES
	('05879f5868824f35932ee9f2062adc03','你好','2','admin','san','2016-01-25 14:05:31','1','b311e893228f42d5a05dbe16917fd16f'),
	('2635dd035c6f4bb5a091abdd784bd899','你好','2','san','admin','2016-01-25 14:05:02','1','1b7637306683460f89174c2b025862b5'),
	('52378ccd4e2d4fe08994d1652af87c68','你好','1','admin','san','2016-01-25 16:26:44','1','920b20dafdfb4c09b560884eb277c51d'),
	('77ed13f9c49a4c4bb460c41b8580dd36','gggg','2','admin','san','2016-01-24 21:22:43','2','dd9ee339576e48c5b046b94fa1901d00'),
	('98a6869f942042a1a037d9d9f01cb50f','你好','1','admin','san','2016-01-25 14:05:02','1','1b7637306683460f89174c2b025862b5'),
	('9e00295529014b6e8a27019cbccb3da1','柔柔弱弱','1','admin','san','2016-01-24 21:22:57','1','a29603d613ea4e54b5678033c1bf70a6'),
	('d3aedeb430f640359bff86cd657a8f59','你好','1','admin','san','2016-01-24 21:22:12','1','f022fbdce3d845aba927edb698beb90b'),
	('e5376b1bd54b489cb7f2203632bd74ec','管理员好','2','admin','san','2016-01-25 14:06:13','2','b347b2034faf43c79b54be4627f3bd2b'),
	('e613ac0fcc454f32895a70b747bf4fb5','你也好','2','admin','san','2016-01-25 16:27:54','2','ce8dc3b15afb40f28090f8b8e13f078d'),
	('f25e00cfafe741a3a05e3839b66dc7aa','你好','2','san','admin','2016-01-25 16:26:44','1','920b20dafdfb4c09b560884eb277c51d');

/*!40000 ALTER TABLE `sys_fhsms` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sys_follow
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_follow`;

CREATE TABLE `sys_follow` (
  `FOLLOW_ID` varchar(100) NOT NULL,
  `USER` varchar(255) DEFAULT NULL COMMENT '被关注的用户',
  `FOLLOW_USER` varchar(255) DEFAULT NULL COMMENT '关注者',
  PRIMARY KEY (`FOLLOW_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table sys_menu
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_menu`;

CREATE TABLE `sys_menu` (
  `MENU_ID` int(11) NOT NULL,
  `MENU_NAME` varchar(255) DEFAULT NULL,
  `MENU_URL` varchar(255) DEFAULT NULL,
  `PARENT_ID` varchar(100) DEFAULT NULL,
  `MENU_ORDER` varchar(100) DEFAULT NULL,
  `MENU_ICON` varchar(60) DEFAULT NULL,
  `MENU_TYPE` varchar(10) DEFAULT NULL,
  `MENU_STATE` int(1) DEFAULT NULL,
  PRIMARY KEY (`MENU_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `sys_menu` WRITE;
/*!40000 ALTER TABLE `sys_menu` DISABLE KEYS */;

INSERT INTO `sys_menu` (`MENU_ID`, `MENU_NAME`, `MENU_URL`, `PARENT_ID`, `MENU_ORDER`, `MENU_ICON`, `MENU_TYPE`, `MENU_STATE`)
VALUES
	(1,'系统管理','#','0','1','menu-icon fa fa-desktop blue','2',1),
	(2,'权限管理','#','1','1','menu-icon fa fa-lock black','1',1),
	(6,'信息管理','#','0','5','menu-icon fa fa-credit-card green','2',1),
	(7,'图片管理','#','6','1','menu-icon fa fa-folder-o pink','2',1),
	(8,'性能监控','druid/index.html','9','8','menu-icon fa fa-tachometer red','1',1),
	(9,'系统工具','#','0','3','menu-icon fa fa-cog black','2',1),
	(10,'接口测试','tool/interfaceTest.do','9','2','menu-icon fa fa-exchange green','1',1),
	(11,'发送邮件','tool/goSendEmail.do','9','3','menu-icon fa fa-envelope-o green','1',1),
	(12,'置二维码','tool/goTwoDimensionCode.do','9','4','menu-icon fa fa-barcode green','1',1),
	(14,'地图工具','tool/map.do','9','6','menu-icon fa fa-globe black','1',1),
	(15,'微信管理','#','0','4','menu-icon fa fa-comments purple','2',1),
	(16,'文本回复','textmsg/list.do','15','2','menu-icon fa fa-comment green','2',1),
	(17,'应用命令','command/list.do','15','4','menu-icon fa fa-comment grey','2',1),
	(18,'图文回复','imgmsg/list.do','15','3','menu-icon fa fa-comment pink','2',1),
	(19,'关注回复','textmsg/goSubscribe.do','15','1','menu-icon fa fa-comment orange','2',1),
	(20,'在线管理','onlinemanager/list.do','1','5','menu-icon fa fa-laptop green','1',1),
	(21,'打印测试','tool/printTest.do','9','7','menu-icon fa fa-hdd-o grey','1',1),
	(22,'一级菜单','#','0','10','menu-icon fa fa-fire orange','2',1),
	(23,'二级菜单','#','22','1','menu-icon fa fa-leaf black','1',1),
	(24,'三级菜单','#','23','1','menu-icon fa fa-leaf black','1',1),
	(30,'四级菜单','#','24','1','menu-icon fa fa-leaf black','1',1),
	(31,'五级菜单1','#','30','1','menu-icon fa fa-leaf black','1',1),
	(32,'五级菜单2','#','30','2','menu-icon fa fa-leaf black','1',1),
	(33,'六级菜单','#','31','1','menu-icon fa fa-leaf black','1',1),
	(34,'六级菜单2','login_default.do','31','2','menu-icon fa fa-leaf black','1',1),
	(35,'四级菜单2','login_default.do','24','2','menu-icon fa fa-leaf black','1',1),
	(36,'角色(基础权限)','role.do','2','1','menu-icon fa fa-key orange','1',1),
	(37,'按钮权限','buttonrights/list.do','2','2','menu-icon fa fa-key green','1',1),
	(38,'菜单管理','menu/listAllMenu.do','1','3','menu-icon fa fa-folder-open-o brown','1',1),
	(39,'按钮管理','fhbutton/list.do','1','2','menu-icon fa fa-download orange','1',1),
	(40,'用户管理','#','0','2','menu-icon fa fa-users blue','2',1),
	(41,'系统用户','user/listUsers.do','40','1','menu-icon fa fa-users green','1',1),
	(42,'会员管理','happuser/listUsers.do','40','2','menu-icon fa fa-users orange','1',1),
	(43,'数据字典','dictionaries/listAllDict.do?DICTIONARIES_ID=0','1','4','menu-icon fa fa-book purple','1',1),
	(44,'代码生成器','#','9','0','menu-icon fa fa-cogs brown','1',1),
	(45,'七级菜单1','#','33','1','menu-icon fa fa-leaf black','1',1),
	(46,'七级菜单2','#','33','2','menu-icon fa fa-leaf black','1',1),
	(47,'八级菜单','login_default.do','45','1','menu-icon fa fa-leaf black','1',1),
	(48,'图表报表',' tool/fusionchartsdemo.do','9','5','menu-icon fa fa-bar-chart-o black','1',1),
	(50,'站内信','fhsms/list.do','6','3','menu-icon fa fa-envelope green','1',1),
	(51,'图片列表','pictures/list.do','7','1','menu-icon fa fa-folder-open-o green','1',1),
	(52,'图片爬虫','pictures/goImageCrawler.do','7','2','menu-icon fa fa-cloud-download green','1',1),
	(53,'表单构建器','tool/goFormbuilder.do','9','1','menu-icon fa fa-leaf black','1',1),
	(54,'数据库管理','#','0','9','menu-icon fa fa-hdd-o blue','2',1),
	(55,'数据库备份','brdb/listAllTable.do','54','1','menu-icon fa fa-cloud-upload blue','1',1),
	(56,'数据库还原','brdb/list.do','54','3','menu-icon fa fa-cloud-download blue','1',1),
	(57,'备份定时器','timingbackup/list.do','54','2','menu-icon fa fa-tachometer blue','1',1),
	(58,'SQL编辑器','sqledit/view.do','54','4','menu-icon fa fa-pencil-square-o blue','1',1),
	(59,'OA办公','#','0','6','menu-icon fa fa-laptop pink','2',1),
	(60,'组织机构','department/listAllDepartment.do?DEPARTMENT_ID=0','59','1','menu-icon fa fa-users green','1',1),
	(61,'反向生成','recreateCode/list.do','44','2','menu-icon fa fa-cogs blue','1',1),
	(62,'正向生成','createCode/list.do','44','1','menu-icon fa fa-cogs green','1',1),
	(63,'主附结构','attached/list.do','6','2','menu-icon fa fa-folder-open blue','1',1),
	(64,'员工管理','staff/list.do','59','2','menu-icon fa fa-users blue','1',1),
	(65,'多数据源','datasource2/list.do','6','4','menu-icon fa fa-folder-open-o purple','1',0),
	(66,'APP版本管理','appversion/list.do','1','6','menu-icon fa fa-info-circle black','1',1),
	(67,'用户喜好','userpreferences/list.do','42','1','menu-icon fa fa-leaf black','1',1),
	(68,'APP图片管理','img/list.do','7','3','menu-icon fa fa-leaf black','1',1),
	(69,'Fakie分享','share/list.do','6','4','menu-icon fa fa-leaf black','1',1),
	(70,'Fakie消息','message/list.do','6','5','menu-icon fa fa-leaf black','1',1),
	(71,'评论','comment/list.do','70','1','menu-icon fa fa-leaf black','1',1),
	(72,'点赞','fabulous/list.do','70','2','menu-icon fa fa-leaf black','1',1),
	(73,'收藏','collection/list.do','70','3','menu-icon fa fa-leaf black','1',1),
	(75,'商店管理','#','0','11','menu-icon fa fa-leaf black','2',1),
	(76,'已发布','#','75','1','menu-icon fa fa-leaf black','1',1),
	(77,'未发布','#','75','2','menu-icon fa fa-leaf black','1',1),
	(78,'banner','banner/list.do','76','1','menu-icon fa fa-leaf black','1',1),
	(79,'banner','banneredit/list.do','77','1','menu-icon fa fa-leaf black','1',1),
	(80,'订单管理','#','75','3','menu-icon fa fa-leaf black','1',1),
	(81,'订单列表','order/list.do','80','1','menu-icon fa fa-leaf black','1',1),
	(94,NULL,NULL,NULL,NULL,'menu-icon fa fa-leaf black',NULL,NULL),
	(95,NULL,NULL,NULL,NULL,'menu-icon fa fa-leaf black',NULL,NULL),
	(96,NULL,NULL,NULL,NULL,'menu-icon fa fa-leaf black',NULL,NULL),
	(97,NULL,NULL,NULL,NULL,'menu-icon fa fa-leaf black',NULL,NULL);

/*!40000 ALTER TABLE `sys_menu` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sys_message
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_message`;

CREATE TABLE `sys_message` (
  `MESSAGE_ID` varchar(100) NOT NULL,
  `COMMENT` varchar(255) DEFAULT NULL COMMENT '评论消息',
  `COLLECTION` varchar(255) DEFAULT NULL COMMENT '收藏消息',
  `FABULOUS` varchar(255) DEFAULT NULL COMMENT '点赞消息',
  `TIME` varchar(255) DEFAULT NULL COMMENT '时间',
  `ISREAD` int(11) NOT NULL COMMENT '是否已读标记',
  `USER` varchar(255) DEFAULT NULL COMMENT '用户',
  PRIMARY KEY (`MESSAGE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `sys_message` WRITE;
/*!40000 ALTER TABLE `sys_message` DISABLE KEYS */;

INSERT INTO `sys_message` (`MESSAGE_ID`, `COMMENT`, `COLLECTION`, `FABULOUS`, `TIME`, `ISREAD`, `USER`)
VALUES
	('47839468c5704dc4a70f117b498fe34d','c5ef946e76bc42f990e0a6aa1b8c99bc',NULL,NULL,'2016/12/15',1,'bc6c4cba9c1a4d3aa3bfd94d7d649cd6'),
	('cbba8029870f41b4b67df9ed944529fd','a3016dc09dfe42d6afbb57212a2a2350',NULL,NULL,'2016/12/15',1,'bc6c4cba9c1a4d3aa3bfd94d7d649cd6'),
	('f744721970ef49b284ad955028119950','cf80701599be492893a47748671a37f8',NULL,NULL,'2016/12/15',1,'bc6c4cba9c1a4d3aa3bfd94d7d649cd6');

/*!40000 ALTER TABLE `sys_message` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sys_role
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_role`;

CREATE TABLE `sys_role` (
  `ROLE_ID` varchar(100) NOT NULL,
  `ROLE_NAME` varchar(100) DEFAULT NULL,
  `RIGHTS` varchar(255) DEFAULT NULL,
  `PARENT_ID` varchar(100) DEFAULT NULL,
  `ADD_QX` varchar(255) DEFAULT NULL,
  `DEL_QX` varchar(255) DEFAULT NULL,
  `EDIT_QX` varchar(255) DEFAULT NULL,
  `CHA_QX` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ROLE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `sys_role` WRITE;
/*!40000 ALTER TABLE `sys_role` DISABLE KEYS */;

INSERT INTO `sys_role` (`ROLE_ID`, `ROLE_NAME`, `RIGHTS`, `PARENT_ID`, `ADD_QX`, `DEL_QX`, `EDIT_QX`, `CHA_QX`)
VALUES
	('1','系统管理组','4798514641842967249149894','0','1','1','1','1'),
	('115b386ff04f4352b060dffcd2b5d1da','中级会员','498','2','0','0','0','0'),
	('1b67fc82ce89457a8347ae53e43a347e','初级会员','498','2','0','0','0','0'),
	('2','会员组','498','0','0','0','0','1'),
	('3264c8e83d0248bb9e3ea6195b4c0216','一级管理员','4798514641842967249149894','1','4816629344518951982325702','4816776918475939705249734','4800101061833306270588870','4816776918475939705249734'),
	('46294b31a71c4600801724a6eb06bb26','职位组','','0','0','0','0','0'),
	('5466347ac07044cb8d82990ec7f3a90e','主管','','46294b31a71c4600801724a6eb06bb26','0','0','0','0'),
	('68f8e4a39efe47c7bb869e9d15ab925d','二级管理员','4798514641842967249149894','1','0','0','2251798773489606','811656754567664631878'),
	('856849f422774ad390a4e564054d8cc8','经理','','46294b31a71c4600801724a6eb06bb26','0','0','0','0'),
	('8b70a7e67f2841e7aaba8a4d92e5ff6f','高级会员','498','2','0','0','0','0'),
	('c21cecf84048434b93383182b1d98cba','组长','','46294b31a71c4600801724a6eb06bb26','0','0','0','0'),
	('d449195cd8e7491080688c58e11452eb','总监','','46294b31a71c4600801724a6eb06bb26','0','0','0','0'),
	('de9de2f006e145a29d52dfadda295353','三级管理员','4798514641842967249149894','1','18631218269846088188096','18631218269846088188096','18631218269846088188096','18631218269846088188096');

/*!40000 ALTER TABLE `sys_role` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sys_role_fhbutton
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_role_fhbutton`;

CREATE TABLE `sys_role_fhbutton` (
  `RB_ID` varchar(100) NOT NULL,
  `ROLE_ID` varchar(100) DEFAULT NULL,
  `BUTTON_ID` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`RB_ID`),
  KEY `角色表外键` (`ROLE_ID`) USING BTREE,
  KEY `fbutton` (`BUTTON_ID`),
  CONSTRAINT `fbutton` FOREIGN KEY (`BUTTON_ID`) REFERENCES `sys_fhbutton` (`FHBUTTON_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `frole` FOREIGN KEY (`ROLE_ID`) REFERENCES `sys_role` (`ROLE_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `sys_role_fhbutton` WRITE;
/*!40000 ALTER TABLE `sys_role_fhbutton` DISABLE KEYS */;

INSERT INTO `sys_role_fhbutton` (`RB_ID`, `ROLE_ID`, `BUTTON_ID`)
VALUES
	('03385d55f8d74bb1beb642b60a6de56f','3264c8e83d0248bb9e3ea6195b4c0216','4c7f34b9eed54683957f356afcda24df'),
	('14b5c28ea6ae4508b57d2d272ab3d5f1','3264c8e83d0248bb9e3ea6195b4c0216','46992ea280ba4b72b29dedb0d4bc0106'),
	('1743733f366240c693c4295b527d1b0e','de9de2f006e145a29d52dfadda295353','4efa162fce8340f0bd2dcd3b11d327ec'),
	('3768e60edd1c4b5c9f1dd861188ae2f9','3264c8e83d0248bb9e3ea6195b4c0216','cc51b694d5344d28a9aa13c84b7166cd'),
	('8231c216fb514b4188e4162e629c6237','3264c8e83d0248bb9e3ea6195b4c0216','4efa162fce8340f0bd2dcd3b11d327ec'),
	('91958c938bfe4a5fb7b18c7c6a871848','3264c8e83d0248bb9e3ea6195b4c0216','fc5e8767b4564f34a0d2ce2375fcc92e'),
	('9412d1d05162464c83658c7f89ab03f0','68f8e4a39efe47c7bb869e9d15ab925d','3542adfbda73410c976e185ffe50ad06'),
	('96567633dd3548c9b75d28f430adf5a3','3264c8e83d0248bb9e3ea6195b4c0216','da7fd386de0b49ce809984f5919022b8'),
	('a1478f27c852459fa9cad04b642f4fb7','de9de2f006e145a29d52dfadda295353','3542adfbda73410c976e185ffe50ad06'),
	('ba6696b8761044618e44c7e02c9ba89e','68f8e4a39efe47c7bb869e9d15ab925d','cc51b694d5344d28a9aa13c84b7166cd'),
	('f0329033d0914faf8ea6e9ff252cc5e6','68f8e4a39efe47c7bb869e9d15ab925d','46992ea280ba4b72b29dedb0d4bc0106');

/*!40000 ALTER TABLE `sys_role_fhbutton` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sys_share
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_share`;

CREATE TABLE `sys_share` (
  `SHARE_ID` varchar(100) NOT NULL,
  `USER` varchar(255) DEFAULT NULL COMMENT '用户',
  `SHARE_TYPE` varchar(255) DEFAULT NULL COMMENT '分享类型',
  `TITLE` varchar(255) DEFAULT NULL COMMENT '标题',
  `SHARE_DESCRIBE` varchar(255) DEFAULT NULL COMMENT '描述',
  `IMAGE` varchar(255) DEFAULT NULL COMMENT '图片',
  `TIME` varchar(255) DEFAULT NULL COMMENT '时间',
  PRIMARY KEY (`SHARE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `sys_share` WRITE;
/*!40000 ALTER TABLE `sys_share` DISABLE KEYS */;

INSERT INTO `sys_share` (`SHARE_ID`, `USER`, `SHARE_TYPE`, `TITLE`, `SHARE_DESCRIBE`, `IMAGE`, `TIME`)
VALUES
	('0263cec5407f4b9abed68c5104263285','bc6c4cba9c1a4d3aa3bfd94d7d649cd6',NULL,NULL,'猎德大桥','097814bc72c64211999891c22014a21b','2016/12/14'),
	('04ec0fb51f6841ecaad7568c70d90fcf','bc6c4cba9c1a4d3aa3bfd94d7d649cd6',NULL,NULL,'猎德','8fa731f45c484ae8ba0d6d07680d2d6a','2016/12/14'),
	('05179ab24d384e9b9fd23cc30d1513c1','bc6c4cba9c1a4d3aa3bfd94d7d649cd6',NULL,NULL,'夕阳红','13b1e5c7c91d459d808a87838da8ea46','2016/12/14'),
	('05f1d75343334a3f96c963dcf18dc73f','bc6c4cba9c1a4d3aa3bfd94d7d649cd6',NULL,NULL,'夕阳','5591495993ca40848b4a3f628b36f67d','2016/12/14'),
	('1a370b78ddbb4195abc077d3abbd2f11','bc6c4cba9c1a4d3aa3bfd94d7d649cd6',NULL,NULL,'gl','c311ee188bab4efd93cdf98ef760efa7','2016/12/14'),
	('682463d8e7a040f4be942fbef44888bc','bc6c4cba9c1a4d3aa3bfd94d7d649cd6',NULL,NULL,'毛衣','28ea96305c9a4a7e87bbc5733aff07c1','2016/12/14'),
	('79f9189a14384dfab4000eb5e1b8404e','bc6c4cba9c1a4d3aa3bfd94d7d649cd6',NULL,NULL,'GG','1c8ab563985d4869b1325694c78e8dca','2016/12/14'),
	('99d8a3a478bd4407ab9f676a5c77b246','bc6c4cba9c1a4d3aa3bfd94d7d649cd6',NULL,NULL,'girls','5b3d83b3ce2e4faf9bab7822cd6c7efc','2016/12/14'),
	('b2cbd07431154e6cb4f50d32ae13194d','bc6c4cba9c1a4d3aa3bfd94d7d649cd6',NULL,NULL,'夕阳','a31436bfa19441b2a1c7bf31c81db505','2016/12/14'),
	('d1693d2fe01f43a9992298d6e7cf959b','bc6c4cba9c1a4d3aa3bfd94d7d649cd6',NULL,NULL,'夕阳西下','7ab03315abaf4173b2a422f63690083e','2016/12/14'),
	('ed7f3880016846d5acb4f55a52ab1ce9','bc6c4cba9c1a4d3aa3bfd94d7d649cd6',NULL,NULL,'','ab03e0f364864512a90aef0a26065271','2016/12/14');

/*!40000 ALTER TABLE `sys_share` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sys_user
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_user`;

CREATE TABLE `sys_user` (
  `USER_ID` varchar(100) NOT NULL,
  `USERNAME` varchar(255) DEFAULT NULL,
  `PASSWORD` varchar(255) DEFAULT NULL,
  `NAME` varchar(255) DEFAULT NULL,
  `RIGHTS` varchar(255) DEFAULT NULL,
  `ROLE_ID` varchar(100) DEFAULT NULL,
  `LAST_LOGIN` varchar(255) DEFAULT NULL,
  `IP` varchar(100) DEFAULT NULL,
  `STATUS` varchar(32) DEFAULT NULL,
  `BZ` varchar(255) DEFAULT NULL,
  `SKIN` varchar(100) DEFAULT NULL,
  `EMAIL` varchar(32) DEFAULT NULL,
  `NUMBER` varchar(100) DEFAULT NULL,
  `PHONE` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `sys_user` WRITE;
/*!40000 ALTER TABLE `sys_user` DISABLE KEYS */;

INSERT INTO `sys_user` (`USER_ID`, `USERNAME`, `PASSWORD`, `NAME`, `RIGHTS`, `ROLE_ID`, `LAST_LOGIN`, `IP`, `STATUS`, `BZ`, `SKIN`, `EMAIL`, `NUMBER`, `PHONE`)
VALUES
	('1','admin','de41b7fb99201d8334c23c014db35ecd92df81bc','FH','1133671055321055258374707980945218933803269864762743594642571294','1','2019-03-19 20:57:19','119.145.76.24','0','admin','default','QQ313596790@main.com','001','18788888888'),
	('60caf2c3b1744829a4535a2e5caf8ab2','xyh','a57a0e9e33f13d674f8feb80e2ec58d52a8fc30d','谢远辉','','3264c8e83d0248bb9e3ea6195b4c0216','2016-12-15 23:43:51','192.168.0.16','0','hhh','default','15479844877@qq.com','123','16615891258'),
	('95dd870c004243e1b6b9c3426c792576','yuanyi','c8da4793c567ad31bf61e927ec687acbb6c9ad12','源医科技','','de9de2f006e145a29d52dfadda295353','2018-08-29 16:42:07','192.168.1.109','0','源医科技','default','0012256322@qq.com','1234','13256478965');

/*!40000 ALTER TABLE `sys_user` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table tb_attached
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tb_attached`;

CREATE TABLE `tb_attached` (
  `ATTACHED_ID` varchar(100) NOT NULL,
  `NAME` varchar(255) DEFAULT NULL COMMENT '名称',
  `FDESCRIBE` varchar(255) DEFAULT NULL COMMENT '描述',
  `PRICE` double(11,2) DEFAULT NULL COMMENT '价格',
  `CTIME` varchar(32) DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`ATTACHED_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `tb_attached` WRITE;
/*!40000 ALTER TABLE `tb_attached` DISABLE KEYS */;

INSERT INTO `tb_attached` (`ATTACHED_ID`, `NAME`, `FDESCRIBE`, `PRICE`, `CTIME`)
VALUES
	('60d05d8e7d9046a4893f8bdaa34d6488','eee','ee',22.00,'2016-04-22 15:33:23'),
	('d74b6f507e784607b8f85e31e3cfad22','AA','aaa',222.00,'2016-04-17 18:20:41');

/*!40000 ALTER TABLE `tb_attached` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table tb_attachedmx
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tb_attachedmx`;

CREATE TABLE `tb_attachedmx` (
  `ATTACHEDMX_ID` varchar(100) NOT NULL,
  `NAME` varchar(255) DEFAULT NULL COMMENT '名称',
  `TITLE` varchar(255) DEFAULT NULL COMMENT '标题',
  `CTIME` varchar(32) DEFAULT NULL COMMENT '创建日期',
  `PRICE` double(11,2) DEFAULT NULL COMMENT '单价',
  `ATTACHED_ID` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ATTACHEDMX_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `tb_attachedmx` WRITE;
/*!40000 ALTER TABLE `tb_attachedmx` DISABLE KEYS */;

INSERT INTO `tb_attachedmx` (`ATTACHEDMX_ID`, `NAME`, `TITLE`, `CTIME`, `PRICE`, `ATTACHED_ID`)
VALUES
	('04717d1a034c4e51aacd5e062a4c63bd','ddd','ddd','2016-03-29',111.00,'d74b6f507e784607b8f85e31e3cfad22'),
	('7992c783fd0b476d90be363858a941ba','ddd','ddsds','2016-04-06',222.00,'d74b6f507e784607b8f85e31e3cfad22');

/*!40000 ALTER TABLE `tb_attachedmx` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table TB_BANNER
# ------------------------------------------------------------

# Error: Table 'seeu.tb_banner' doesn't exist


# Dump of table TB_BANNEREDIT
# ------------------------------------------------------------

# Error: Table 'seeu.tb_banneredit' doesn't exist


# Dump of table TB_ORDER
# ------------------------------------------------------------

# Error: Table 'seeu.tb_order' doesn't exist


# Dump of table tb_pictures
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tb_pictures`;

CREATE TABLE `tb_pictures` (
  `PICTURES_ID` varchar(100) NOT NULL,
  `TITLE` varchar(255) DEFAULT NULL COMMENT '标题',
  `NAME` varchar(255) DEFAULT NULL COMMENT '文件名',
  `PATH` varchar(255) DEFAULT NULL COMMENT '路径',
  `CREATETIME` varchar(100) DEFAULT NULL COMMENT '创建时间',
  `MASTER_ID` varchar(255) DEFAULT NULL COMMENT '属于',
  `BZ` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`PICTURES_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `tb_pictures` WRITE;
/*!40000 ALTER TABLE `tb_pictures` DISABLE KEYS */;

INSERT INTO `tb_pictures` (`PICTURES_ID`, `TITLE`, `NAME`, `PATH`, `CREATETIME`, `MASTER_ID`, `BZ`)
VALUES
	('56e3efb5928f40ada40b1451417899ef','图片','9f2b7805d6d04dd8b21303cb8159b3ad.jpg','20161110/9f2b7805d6d04dd8b21303cb8159b3ad.jpg','2016-11-10 14:32:29','1','图片管理处上传'),
	('81f7e58d68e046b1bafcfbf949f8f87b','图片','c7d81f76cc634129bdbbbcd2c8863ae1.jpg','20161110/c7d81f76cc634129bdbbbcd2c8863ae1.jpg','2016-11-10 11:58:41','1','图片管理处上传'),
	('a76da864b40945578bfa727f685c9948','图片','9b6d2190de4542ce9a73d364655d0f6f.jpg','20161109/9b6d2190de4542ce9a73d364655d0f6f.jpg','2016-11-09 23:24:36','1','图片管理处上传');

/*!40000 ALTER TABLE `tb_pictures` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table weixin_command
# ------------------------------------------------------------

DROP TABLE IF EXISTS `weixin_command`;

CREATE TABLE `weixin_command` (
  `COMMAND_ID` varchar(100) NOT NULL,
  `KEYWORD` varchar(255) DEFAULT NULL COMMENT '关键词',
  `COMMANDCODE` varchar(255) DEFAULT NULL COMMENT '应用路径',
  `CREATETIME` varchar(255) DEFAULT NULL COMMENT '创建时间',
  `STATUS` int(1) NOT NULL COMMENT '状态',
  `BZ` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`COMMAND_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `weixin_command` WRITE;
/*!40000 ALTER TABLE `weixin_command` DISABLE KEYS */;

INSERT INTO `weixin_command` (`COMMAND_ID`, `KEYWORD`, `COMMANDCODE`, `CREATETIME`, `STATUS`, `BZ`)
VALUES
	('2636750f6978451b8330874c9be042c2','锁定服务器','rundll32.exe user32.dll,LockWorkStation','2015-05-10 21:25:06',1,'锁定计算机'),
	('46217c6d44354010823241ef484f7214','打开浏览器','C:/Program Files/Internet Explorer/iexplore.exe','2015-05-09 02:43:02',1,'打开浏览器操作'),
	('576adcecce504bf3bb34c6b4da79a177','关闭浏览器','taskkill /f /im iexplore.exe','2015-05-09 02:36:48',2,'关闭浏览器操作'),
	('854a157c6d99499493f4cc303674c01f','关闭QQ','taskkill /f /im qq.exe','2015-05-10 21:25:46',1,'关闭QQ'),
	('ab3a8c6310ca4dc8b803ecc547e55ae7','打开QQ','D:/SOFT/QQ/QQ/Bin/qq.exe','2015-05-10 21:25:25',1,'打开QQ');

/*!40000 ALTER TABLE `weixin_command` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table weixin_imgmsg
# ------------------------------------------------------------

DROP TABLE IF EXISTS `weixin_imgmsg`;

CREATE TABLE `weixin_imgmsg` (
  `IMGMSG_ID` varchar(100) NOT NULL,
  `KEYWORD` varchar(255) DEFAULT NULL COMMENT '关键词',
  `CREATETIME` varchar(100) DEFAULT NULL COMMENT '创建时间',
  `STATUS` int(11) NOT NULL COMMENT '状态',
  `BZ` varchar(255) DEFAULT NULL COMMENT '备注',
  `TITLE1` varchar(255) DEFAULT NULL COMMENT '标题1',
  `DESCRIPTION1` varchar(255) DEFAULT NULL COMMENT '描述1',
  `IMGURL1` varchar(255) DEFAULT NULL COMMENT '图片地址1',
  `TOURL1` varchar(255) DEFAULT NULL COMMENT '超链接1',
  `TITLE2` varchar(255) DEFAULT NULL COMMENT '标题2',
  `DESCRIPTION2` varchar(255) DEFAULT NULL COMMENT '描述2',
  `IMGURL2` varchar(255) DEFAULT NULL COMMENT '图片地址2',
  `TOURL2` varchar(255) DEFAULT NULL COMMENT '超链接2',
  `TITLE3` varchar(255) DEFAULT NULL COMMENT '标题3',
  `DESCRIPTION3` varchar(255) DEFAULT NULL COMMENT '描述3',
  `IMGURL3` varchar(255) DEFAULT NULL COMMENT '图片地址3',
  `TOURL3` varchar(255) DEFAULT NULL COMMENT '超链接3',
  `TITLE4` varchar(255) DEFAULT NULL COMMENT '标题4',
  `DESCRIPTION4` varchar(255) DEFAULT NULL COMMENT '描述4',
  `IMGURL4` varchar(255) DEFAULT NULL COMMENT '图片地址4',
  `TOURL4` varchar(255) DEFAULT NULL COMMENT '超链接4',
  `TITLE5` varchar(255) DEFAULT NULL COMMENT '标题5',
  `DESCRIPTION5` varchar(255) DEFAULT NULL COMMENT '描述5',
  `IMGURL5` varchar(255) DEFAULT NULL COMMENT '图片地址5',
  `TOURL5` varchar(255) DEFAULT NULL COMMENT '超链接5',
  `TITLE6` varchar(255) DEFAULT NULL COMMENT '标题6',
  `DESCRIPTION6` varchar(255) DEFAULT NULL COMMENT '描述6',
  `IMGURL6` varchar(255) DEFAULT NULL COMMENT '图片地址6',
  `TOURL6` varchar(255) DEFAULT NULL COMMENT '超链接6',
  `TITLE7` varchar(255) DEFAULT NULL COMMENT '标题7',
  `DESCRIPTION7` varchar(255) DEFAULT NULL COMMENT '描述7',
  `IMGURL7` varchar(255) DEFAULT NULL COMMENT '图片地址7',
  `TOURL7` varchar(255) DEFAULT NULL COMMENT '超链接7',
  `TITLE8` varchar(255) DEFAULT NULL COMMENT '标题8',
  `DESCRIPTION8` varchar(255) DEFAULT NULL COMMENT '描述8',
  `IMGURL8` varchar(255) DEFAULT NULL COMMENT '图片地址8',
  `TOURL8` varchar(255) DEFAULT NULL COMMENT '超链接8',
  PRIMARY KEY (`IMGMSG_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `weixin_imgmsg` WRITE;
/*!40000 ALTER TABLE `weixin_imgmsg` DISABLE KEYS */;

INSERT INTO `weixin_imgmsg` (`IMGMSG_ID`, `KEYWORD`, `CREATETIME`, `STATUS`, `BZ`, `TITLE1`, `DESCRIPTION1`, `IMGURL1`, `TOURL1`, `TITLE2`, `DESCRIPTION2`, `IMGURL2`, `TOURL2`, `TITLE3`, `DESCRIPTION3`, `IMGURL3`, `TOURL3`, `TITLE4`, `DESCRIPTION4`, `IMGURL4`, `TOURL4`, `TITLE5`, `DESCRIPTION5`, `IMGURL5`, `TOURL5`, `TITLE6`, `DESCRIPTION6`, `IMGURL6`, `TOURL6`, `TITLE7`, `DESCRIPTION7`, `IMGURL7`, `TOURL7`, `TITLE8`, `DESCRIPTION8`, `IMGURL8`, `TOURL8`)
VALUES
	('380b2cb1f4954315b0e20618f7b5bd8f','首页','2015-05-10 20:51:09',1,'图文回复','图文回复标题','图文回复描述','http://a.hiphotos.baidu.com/image/h%3D360/sign=c6c7e73ebc389b5027ffe654b535e5f1/a686c9177f3e6709392bb8df3ec79f3df8dc55e3.jpg','www.baidu.com','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

/*!40000 ALTER TABLE `weixin_imgmsg` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table weixin_textmsg
# ------------------------------------------------------------

DROP TABLE IF EXISTS `weixin_textmsg`;

CREATE TABLE `weixin_textmsg` (
  `TEXTMSG_ID` varchar(100) NOT NULL,
  `KEYWORD` varchar(255) DEFAULT NULL COMMENT '关键词',
  `CONTENT` varchar(255) DEFAULT NULL COMMENT '内容',
  `CREATETIME` varchar(100) DEFAULT NULL COMMENT '创建时间',
  `STATUS` int(2) DEFAULT NULL COMMENT '状态',
  `BZ` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`TEXTMSG_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `weixin_textmsg` WRITE;
/*!40000 ALTER TABLE `weixin_textmsg` DISABLE KEYS */;

INSERT INTO `weixin_textmsg` (`TEXTMSG_ID`, `KEYWORD`, `CONTENT`, `CREATETIME`, `STATUS`, `BZ`)
VALUES
	('695cd74779734231928a253107ab0eeb','吃饭','吃了噢噢噢噢','2015-05-10 22:52:27',1,'文本回复'),
	('d4738af7aea74a6ca1a5fb25a98f9acb','关注','这里是关注后回复的内容','2015-05-11 02:12:36',1,'关注回复');

/*!40000 ALTER TABLE `weixin_textmsg` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
