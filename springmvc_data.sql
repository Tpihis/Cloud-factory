/*
 Navicat Premium Dump SQL

 Source Server         : local
 Source Server Type    : MySQL
 Source Server Version : 80039 (8.0.39)
 Source Host           : localhost:3306
 Source Schema         : springmvc

 Target Server Type    : MySQL
 Target Server Version : 80039 (8.0.39)
 File Encoding         : 65001

 Date: 16/06/2025 16:43:32
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`  (
  `categoryid` int NOT NULL,
  `categoryname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`categoryid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of category
-- ----------------------------

-- ----------------------------
-- Table structure for chat_messages
-- ----------------------------
DROP TABLE IF EXISTS `chat_messages`;
CREATE TABLE `chat_messages`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `sender` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `receiver` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `send_time` datetime NOT NULL,
  `is_read` tinyint(1) NULL DEFAULT 0,
  `session_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_sender_receiver`(`sender` ASC, `receiver` ASC) USING BTREE,
  INDEX `idx_send_time`(`send_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of chat_messages
-- ----------------------------
INSERT INTO `chat_messages` VALUES (1, 'CHAT', '111', '默认用户', '智能制造服务商A', '2025-05-23 23:44:24', 0, NULL);
INSERT INTO `chat_messages` VALUES (2, 'CHAT', 'sdsd', '默认用户', '智能制造服务商A', '2025-05-23 23:45:17', 0, NULL);
INSERT INTO `chat_messages` VALUES (3, 'CHAT', 'sdsddsd', '默认用户', '智能制造服务商A', '2025-05-23 23:45:19', 0, NULL);
INSERT INTO `chat_messages` VALUES (4, 'CHAT', '1111', 'llj', '智能制造服务商A', '2025-05-23 23:49:31', 0, NULL);
INSERT INTO `chat_messages` VALUES (5, 'CHAT', '1111', 'llj', '智能制造服务商A', '2025-05-23 23:49:32', 0, NULL);
INSERT INTO `chat_messages` VALUES (6, 'CHAT', '1111', 'llj', '智能制造服务商A', '2025-05-23 23:49:33', 0, NULL);
INSERT INTO `chat_messages` VALUES (7, 'CHAT', '1111', 'llj', '智能制造服务商A', '2025-05-23 23:49:33', 0, NULL);
INSERT INTO `chat_messages` VALUES (8, 'CHAT', 'ccc', 'llj', '调度中心C', '2025-05-23 23:52:05', 0, NULL);
INSERT INTO `chat_messages` VALUES (9, 'CHAT', '111', 'llj', '智能制造服务商A', '2025-05-26 08:12:48', 0, NULL);

-- ----------------------------
-- Table structure for order
-- ----------------------------
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order`  (
  `orderid` int NOT NULL AUTO_INCREMENT,
  `taskid` int NULL DEFAULT NULL,
  `resourceids` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `totalprice` float NULL DEFAULT NULL,
  `orderstatus` enum('待支付','已支付','已取消','已完成') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `ordertime` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `completiontime` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `quantity` int NULL DEFAULT NULL,
  `userid` int NOT NULL,
  PRIMARY KEY (`orderid`) USING BTREE,
  INDEX `taskid`(`taskid` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 47 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order
-- ----------------------------
INSERT INTO `order` VALUES (1, NULL, '1,5,7,', 157.83, '已支付', '2025-05-14 22:18:13', NULL, 1, 1);
INSERT INTO `order` VALUES (2, NULL, '5,1,', 157.83, '已支付', '2025-05-25 01:09:46', NULL, 1, 1);
INSERT INTO `order` VALUES (3, NULL, '5,1,', 157.83, '已取消', '2025-05-14 22:24:59', NULL, 1, 9);
INSERT INTO `order` VALUES (4, NULL, '5,2,', 946.98, '已完成', '2025-05-14 22:25:33', NULL, 6, 9);
INSERT INTO `order` VALUES (5, NULL, '5,3,', 157.83, '已支付', '2025-05-25 00:10:03', NULL, 1, 9);
INSERT INTO `order` VALUES (6, NULL, '5,4,', 473.49, '已取消', '2025-05-14 22:39:12', NULL, 3, 9);
INSERT INTO `order` VALUES (7, NULL, '5', 157.83, '已支付', '2025-05-31 18:36:33', NULL, 1, 1);
INSERT INTO `order` VALUES (8, NULL, '9', 579.22, '已完成', '2025-05-14 23:45:58', NULL, 1, 1);
INSERT INTO `order` VALUES (9, NULL, '5', 157.83, '待支付', '2025-05-15 00:04:44', NULL, 1, 11);
INSERT INTO `order` VALUES (10, NULL, '5', 157.83, '已支付', '2025-05-25 01:24:26', NULL, 1, 1);
INSERT INTO `order` VALUES (11, NULL, '5', 157.83, '待支付', '2025-05-15 00:06:17', NULL, 1, 111);
INSERT INTO `order` VALUES (12, NULL, '5', 157.83, '已取消', '2025-05-15 00:10:22', NULL, 1, 13);
INSERT INTO `order` VALUES (13, NULL, '5', 157.83, '已支付', '2025-05-25 01:12:18', NULL, 1, 11);
INSERT INTO `order` VALUES (14, NULL, '5', 157.83, '已支付', '2025-05-25 01:11:48', NULL, 1, 11);
INSERT INTO `order` VALUES (15, NULL, '5', 157.83, '已支付', '2025-05-25 01:08:50', NULL, 1, 13);
INSERT INTO `order` VALUES (16, NULL, '1', 175.59, '已完成', '2025-05-31 18:37:00', NULL, 1, 1);
INSERT INTO `order` VALUES (17, NULL, '1', 175.59, '待支付', '2025-05-26 17:37:01', NULL, 1, 13);
INSERT INTO `order` VALUES (18, NULL, '1', 175.59, '待支付', '2025-05-26 17:37:21', NULL, 1, 13);
INSERT INTO `order` VALUES (19, NULL, '2', 506.29, '已取消', '2025-05-26 17:38:54', NULL, 1, 1);
INSERT INTO `order` VALUES (20, NULL, '5', 157.83, '已取消', '2025-05-26 17:39:56', NULL, 1, 1);
INSERT INTO `order` VALUES (21, NULL, '1', 175.59, '待支付', '2025-05-26 17:42:34', NULL, 1, 13);
INSERT INTO `order` VALUES (22, NULL, '7', 729.58, '待支付', '2025-05-26 17:43:36', NULL, 1, 13);
INSERT INTO `order` VALUES (23, NULL, '2', 506.29, '待支付', '2025-05-26 17:44:15', NULL, 1, 1);
INSERT INTO `order` VALUES (24, NULL, '5', 157.83, '待支付', '2025-05-29 10:43:12', NULL, 1, 13);
INSERT INTO `order` VALUES (25, NULL, '2', 506.29, '已完成', '2025-05-29 10:45:10', NULL, 1, 1);
INSERT INTO `order` VALUES (26, NULL, '1', 175.59, '已取消', '2025-05-29 10:46:00', NULL, 1, 1);
INSERT INTO `order` VALUES (27, NULL, '2', 3037.74, '待支付', '2025-05-29 11:03:03', NULL, 6, 1);
INSERT INTO `order` VALUES (28, NULL, '111', 100, '已支付', '2025-05-30 09:29:27', NULL, 1, 1);
INSERT INTO `order` VALUES (29, NULL, '9,1,5', 579.22, '待支付', '2025-06-10 16:28:27', NULL, 1, 1);
INSERT INTO `order` VALUES (30, NULL, '1', 526.77, '待支付', '2025-06-12 23:09:50', NULL, 3, 1);

-- ----------------------------
-- Table structure for resource
-- ----------------------------
DROP TABLE IF EXISTS `resource`;
CREATE TABLE `resource`  (
  `resourceid` int NOT NULL AUTO_INCREMENT,
  `userid` int NULL DEFAULT NULL,
  `resourcename` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `resourcedescription` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `quantity` int NULL DEFAULT NULL,
  `resourceprice` float NULL DEFAULT NULL,
  `resourcestatus` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `categoryid` int NULL DEFAULT NULL,
  `resourcedate` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `auditstatus` enum('通过','待审','驳回') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`resourceid`) USING BTREE,
  INDEX `categoryid`(`categoryid` ASC) USING BTREE,
  INDEX `userid`(`userid` ASC) USING BTREE,
  CONSTRAINT `userid` FOREIGN KEY (`userid`) REFERENCES `user` (`userid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3117 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of resource
-- ----------------------------
INSERT INTO `resource` VALUES (1, 1, '腾飞车架-竞技版', '航空铝合金材质，承重150kg', 10, 175.59, '2', 2, '2025-05-20 21:18:30', '通过');
INSERT INTO `resource` VALUES (2, 1, '天远车架-城市款', '轻量化设计，骑行更省力', 78, 506.29, '2', 4, '2001-01-24 06:38:31', '通过');
INSERT INTO `resource` VALUES (3, 1, '速驰车轮-26寸', '防滑胎纹，适应多种地形', 64, 10.98, '2', 2, '2007-03-01 03:37:32', '通过');
INSERT INTO `resource` VALUES (4, 1, '雷霆车轮-快拆型', '双轴承设计，转动顺滑', 94, 220.72, '2', 2, '2022-09-13 19:38:32', '通过');
INSERT INTO `resource` VALUES (5, 1, '人体工学车把', '可调节高度，减震把套', 66, 157.83, '2', 4, '2008-07-02 20:24:52', '通过');
INSERT INTO `resource` VALUES (6, 2, '山地车把-加宽版', '抗震设计，操控稳定', 46, 784.77, '2', 3, '2015-04-10 22:43:05', '通过');
INSERT INTO `resource` VALUES (7, 2, '液压碟刹车系统', '制动灵敏，雨天不失效', 98, 729.58, '2', 1, '2023-11-25 01:12:35', '通过');
INSERT INTO `resource` VALUES (8, 2, '双活塞刹车', '散热性能好，寿命长', 64, 99.72, '2', 1, '2016-03-27 02:23:49', '通过');
INSERT INTO `resource` VALUES (9, 2, '不锈钢链条-X9', '防锈处理，静音传动', 90, 579.22, '2', 3, '2001-08-08 21:59:15', '通过');
INSERT INTO `resource` VALUES (10, 2, '强化链条-8速', '兼容多级变速系统', 55, 655.46, '2', 3, '2011-09-01 14:02:24', '通过');
INSERT INTO `resource` VALUES (11, 13, '防滑脚踏板-铝合金', '自锁设计，安全稳固', 68, 842.78, '2', 3, '2010-10-02 06:59:00', '通过');
INSERT INTO `resource` VALUES (12, 13, '轻量化脚踏板', '镁合金材质，重量轻', 92, 720.13, '2', 3, '2008-09-02 18:15:06', '通过');
INSERT INTO `resource` VALUES (13, 18, '碳纤维车架-专业版', '竞赛级品质，重量仅1.8kg', 28, 539.34, '2', 1, '2013-12-14 11:32:17', '通过');
INSERT INTO `resource` VALUES (14, 18, '城市通勤车轮', '28寸，防刺胎设计', 42, 825.03, '2', 1, '2002-07-22 09:39:00', '通过');
INSERT INTO `resource` VALUES (15, 18, '公路赛车把', '空气动力学造型', 13, 472.04, '2', 1, '2020-10-20 04:51:47', '通过');
INSERT INTO `resource` VALUES (16, 1, '陶瓷刹车片', '耐高温，制动距离短', 70, 462.45, '2', 2, '2008-05-08 04:39:01', '通过');
INSERT INTO `resource` VALUES (17, 18, '镀镍链条', '防腐蚀，使用寿命长', 86, 260.98, '2', 3, '2001-12-21 12:21:13', '通过');
INSERT INTO `resource` VALUES (18, 9, '折叠脚踏板', '节省空间，便携设计', 3, 881.95, '2', 2, '2010-01-06 14:20:14', '通过');
INSERT INTO `resource` VALUES (19, 18, '女士自行车车架', '低跨设计，上下车方便', 24, 841.62, '2', 2, '2008-09-08 16:24:33', '通过');
INSERT INTO `resource` VALUES (20, 1, '儿童自行车车轮', '16寸，辅助轮可选', 55, 491.88, '2', 3, '2006-08-03 21:18:49', '通过');
INSERT INTO `resource` VALUES (21, 18, '旅行车把', '多角度调节，舒适握感', 68, 972.51, '2', 3, '2020-10-26 14:58:13', '通过');
INSERT INTO `resource` VALUES (22, 18, '油压碟刹车', '免维护，制动平稳', 91, 963.66, '2', 4, '2022-06-09 20:13:32', '通过');
INSERT INTO `resource` VALUES (23, 21, '变速专用链条', '11速兼容，流畅换挡', 99, 910.63, '2', 1, '2018-07-23 23:58:26', '通过');
INSERT INTO `resource` VALUES (24, 21, '宽面脚踏板', '增大接触面积，更舒适', 51, 169.06, '2', 2, '2008-04-20 17:42:01', '通过');
INSERT INTO `resource` VALUES (25, 21, '山地越野车架', '加强结构，抗震性强', 53, 679.22, '2', 3, '2017-11-19 08:21:06', '通过');
INSERT INTO `resource` VALUES (26, 1, '英特尔CPU-i7', '12核20线程，游戏利器', 14, 473.36, '2', 3, '2003-05-14 19:02:43', '通过');
INSERT INTO `resource` VALUES (27, 21, 'AMD CPU-锐龙9', '7nm工艺，多核性能强', 29, 570.69, '2', 2, '2011-04-18 21:53:16', '通过');
INSERT INTO `resource` VALUES (28, 21, '金士顿内存-32G', 'DDR5高频，电竞专用', 25, 905.18, '2', 3, '2015-05-14 13:36:55', '通过');
INSERT INTO `resource` VALUES (29, 21, '海盗船内存-RGB', '灯效炫酷，超频稳定', 13, 466.94, '2', 3, '2003-07-17 04:30:24', '通过');
INSERT INTO `resource` VALUES (30, 21, '三星硬盘-1TB', 'NVMe协议，读取7000MB/s', 15, 445.63, '2', 1, '2004-11-27 10:56:19', '通过');
INSERT INTO `resource` VALUES (31, 21, '西数硬盘-黑盘', '5年质保，性能稳定', 89, 369.25, '2', 3, '2002-07-05 18:44:27', '通过');
INSERT INTO `resource` VALUES (32, 21, 'NVIDIA显卡-RTX3080', '10GB显存，光追支持', 18, 849.42, '2', 3, '2004-01-17 12:17:44', '通过');
INSERT INTO `resource` VALUES (33, 11, 'AMD显卡-6800XT', '16GB显存，性能强劲', 90, 347.32, '2', 3, '2022-02-25 23:28:05', '通过');
INSERT INTO `resource` VALUES (34, 11, '华硕主板-Z690', '支持PCIe5.0，扩展性强', 48, 293.35, '2', 4, '2004-03-21 20:11:12', '通过');
INSERT INTO `resource` VALUES (35, 11, '微星主板-战斧', '军工品质，散热出色', 55, 201.54, '2', 3, '2004-07-23 17:36:37', '通过');
INSERT INTO `resource` VALUES (36, 13, '长城电源-750W', '80Plus金牌，转换高效', 83, 590.94, '2', 2, '2015-04-28 21:46:00', '通过');
INSERT INTO `resource` VALUES (37, 13, '酷冷至尊电源', '全模组设计，静音风扇', 44, 919.79, '2', 2, '2024-09-03 02:43:45', '通过');
INSERT INTO `resource` VALUES (38, 13, '英特尔CPU-i5', '办公利器，能耗比高', 37, 716.82, '2', 2, '2022-03-12 11:02:20', '通过');
INSERT INTO `resource` VALUES (39, 18, 'AMD CPU-锐龙5', '性价比之选，性能均衡', 94, 959.7, '2', 1, '2011-03-19 22:22:25', '通过');
INSERT INTO `resource` VALUES (40, NULL, '芝奇内存-16G', '低时序，超频潜力大', 50, 299.99, '2', 2, '2025-01-15 10:30:00', '通过');
INSERT INTO `resource` VALUES (41, 13, '海力士内存-ECC', '服务器级，稳定可靠', 72, 37.67, '2', 4, '2005-04-12 00:37:27', '通过');
INSERT INTO `resource` VALUES (42, 13, '致钛硬盘-512G', '国产颗粒，性能优异', 59, 589.64, '2', 3, '2001-03-09 14:21:46', '通过');
INSERT INTO `resource` VALUES (43, 13, '铠侠硬盘-2TB', '原厂颗粒，寿命长久', 72, 22.82, '2', 2, '2003-06-23 19:35:11', '通过');
INSERT INTO `resource` VALUES (44, 1, 'NVIDIA显卡-RTX3050', '入门光追，性价比高', 46, 876.42, '2', 2, '2011-02-06 20:10:05', '通过');
INSERT INTO `resource` VALUES (45, 13, 'AMD显卡-6500XT', '1080P游戏利器', 41, 66.07, '2', 2, '2023-06-29 11:45:25', '通过');
INSERT INTO `resource` VALUES (46, 13, '技嘉主板-B550', '支持PCIe4.0，用料扎实', 19, 314.85, '2', 2, '2010-10-24 12:10:27', '通过');
INSERT INTO `resource` VALUES (47, 13, '华擎主板-H610', '经济实用，稳定耐用', 37, 663.22, '2', 4, '2014-10-20 12:40:55', '通过');
INSERT INTO `resource` VALUES (48, 1, '航嘉电源-650W', '80Plus白牌，性价比高', 5, 920.96, '2', 1, '2023-10-27 03:05:34', '通过');
INSERT INTO `resource` VALUES (49, 13, '安钛克电源-850W', '白金认证，十年质保', 78, 910.66, '2', 3, '2009-02-10 17:26:43', '通过');
INSERT INTO `resource` VALUES (50, 13, '服务器专用电源', '冗余设计，稳定可靠', 37, 245, '2', 1, '2006-01-10 18:01:55', '通过');
INSERT INTO `resource` VALUES (51, 13, '京东方屏幕-6.62寸', 'AMOLED材质，120Hz刷新', 35, 565.41, '2', 2, '2015-11-03 10:41:07', '通过');
INSERT INTO `resource` VALUES (52, 13, '三星屏幕-E5', '2K分辨率，色彩鲜艳', 80, 383.85, '2', 1, '2019-12-10 13:19:18', '通过');
INSERT INTO `resource` VALUES (53, 13, '德赛电池-5500mAh', '支持65W快充，安全耐用', 29, 604.38, '2', 1, '2010-09-27 22:13:30', '通过');
INSERT INTO `resource` VALUES (54, 13, '比亚迪电池-超薄', '高能量密度，续航持久', 84, 505.2, '2', 2, '2008-05-15 14:12:28', '通过');
INSERT INTO `resource` VALUES (55, 13, '索尼摄像头-IMX766', '5000万像素，支持4K', 21, 260.76, '2', 2, '2000-07-05 08:16:59', '通过');
INSERT INTO `resource` VALUES (56, 13, '三星摄像头-GN2', '1/1.12英寸超大底', 44, 930.79, '2', 4, '2015-07-01 10:47:10', '通过');
INSERT INTO `resource` VALUES (57, 13, '高通处理器-骁龙8', '4nm工艺，旗舰性能', 74, 210.33, '2', 1, '2007-06-07 07:24:46', '通过');
INSERT INTO `resource` VALUES (58, 13, '联发科处理器-天玑9000', '能效比优秀，发热低', 23, 719.99, '2', 2, '2004-10-14 13:57:25', '通过');
INSERT INTO `resource` VALUES (59, 13, '立体声扬声器', 'Hi-Res认证，音质出色', 31, 566.71, '2', 3, '2009-03-05 03:37:19', '通过');
INSERT INTO `resource` VALUES (60, 18, '超线性扬声器', '大音量，人声清晰', 30, 756.11, '2', 1, '2005-02-24 16:40:27', '通过');
INSERT INTO `resource` VALUES (61, 18, '天马屏幕-柔性', '国产优质，可弯曲', 33, 336.65, '2', 2, '2018-04-28 15:56:47', '通过');
INSERT INTO `resource` VALUES (62, NULL, 'LG屏幕-OLED', '色彩准确，对比度高', 30, 89.5, '2', 3, '2025-02-20 14:15:00', '通过');
INSERT INTO `resource` VALUES (63, NULL, 'ATL电池-4000mAh', '循环寿命长，安全可靠', 75, 199, '2', 1, '2025-03-10 09:45:00', '通过');
INSERT INTO `resource` VALUES (64, NULL, '欣旺达电池-快充', '支持100W超级快充', 40, 149.99, '2', 4, '2025-01-25 16:20:00', '通过');
INSERT INTO `resource` VALUES (65, NULL, '豪威摄像头-OV50A', '国产精品，成像优异', 60, 179.5, '2', 2, '2025-02-15 11:10:00', '通过');
INSERT INTO `resource` VALUES (66, NULL, '徕卡摄像头-认证', '德系调校，色彩真实', 25, 249, '2', 3, '2025-03-05 13:25:00', '通过');
INSERT INTO `resource` VALUES (67, 13, '苹果处理器-A16', '性能领先，能效出色', 2, 954.76, '2', 1, '2005-07-14 07:10:27', '通过');
INSERT INTO `resource` VALUES (68, 1, '三星处理器-Exynos', '自研芯片，性能强劲', 42, 305.19, '2', 2, '2007-10-03 17:23:59', '通过');
INSERT INTO `resource` VALUES (69, NULL, '双扬声器系统', '杜比全景声支持', 35, 129.99, '2', 1, '2025-01-30 15:50:00', '通过');
INSERT INTO `resource` VALUES (70, NULL, '线性马达扬声器', '振动小，音质纯净', 45, 159.5, '2', 4, '2025-02-10 10:35:00', '通过');
INSERT INTO `resource` VALUES (71, NULL, '护眼手机屏幕', '低蓝光认证，DC调光', 55, 219, '2', 2, '2025-03-15 08:40:00', '通过');
INSERT INTO `resource` VALUES (72, 1, 'LTPO自适应屏幕', '1-120Hz智能刷新', 86, 956.49, '2', 1, '2016-09-01 01:15:29', '通过');
INSERT INTO `resource` VALUES (73, 13, '石墨烯电池', '充电快，寿命长', 28, 472.11, '2', 3, '2003-08-04 18:43:51', '通过');
INSERT INTO `resource` VALUES (74, 13, '硅负极电池', '高容量，体积小', 37, 274.6, '2', 1, '2004-06-08 15:46:50', '通过');
INSERT INTO `resource` VALUES (75, 1, '潜望式摄像头', '10倍光学变焦', 6, 159.35, '2', 4, '2023-10-30 04:22:07', '通过');
INSERT INTO `resource` VALUES (76, 13, '蓝宝石表盘', '耐磨防刮，通透度高', 64, 926.48, '2', 4, '2002-12-30 21:02:22', '通过');
INSERT INTO `resource` VALUES (77, 1, '陶瓷表盘-尊享', '永不褪色，高档质感', 75, 766.24, '2', 1, '2010-02-01 06:01:08', '通过');
INSERT INTO `resource` VALUES (78, 13, '硅胶表带-运动', '防水防汗，舒适贴合', 11, 155.83, '2', 2, '2019-01-16 11:49:24', '通过');
INSERT INTO `resource` VALUES (79, 13, '真皮表带-商务', '头层牛皮，柔软舒适', 1, 498.32, '2', 2, '2003-06-19 22:51:18', '通过');
INSERT INTO `resource` VALUES (80, 13, '瑞士ETA机芯', '精准走时，±5秒/天', 84, 50.84, '2', 3, '2015-03-31 08:47:21', '通过');
INSERT INTO `resource` VALUES (81, NULL, '西铁城机芯', '光动能，十年不用换电池', 80, 349.99, '2', 3, '2025-04-01 12:30:00', '通过');
INSERT INTO `resource` VALUES (82, NULL, '夜光指针-超级', '长效发光，夜间清晰', 65, 89.99, '2', 1, '2025-04-10 14:45:00', '通过');
INSERT INTO `resource` VALUES (83, NULL, '蓝钢指针', '经典设计，优雅美观', 40, 129.5, '2', 4, '2025-04-15 09:20:00', '通过');
INSERT INTO `resource` VALUES (84, NULL, '旋入式表冠', '防水100米，操作顺滑', 50, 79, '2', 2, '2025-04-20 16:10:00', '通过');
INSERT INTO `resource` VALUES (85, NULL, '洋葱头表冠', '复古设计，调时方便', 30, 59.99, '2', 3, '2025-05-01 11:25:00', '通过');
INSERT INTO `resource` VALUES (86, NULL, '陨石表盘', '天然材质，独一无二', 20, 499.5, '2', 1, '2025-05-05 10:15:00', '通过');
INSERT INTO `resource` VALUES (87, NULL, '碳纤维表盘', '轻量化，现代感强', 35, 199, '2', 4, '2025-05-10 13:40:00', '通过');
INSERT INTO `resource` VALUES (88, NULL, '米兰尼斯表带', '不锈钢编织，贴合手腕', 45, 149.99, '2', 2, '2025-05-15 15:30:00', '通过');
INSERT INTO `resource` VALUES (89, NULL, '鳄鱼皮表带', '奢华材质，高档大气', 15, 299.5, '2', 3, '2025-05-20 09:50:00', '通过');
INSERT INTO `resource` VALUES (90, NULL, '海鸥机芯', '国产精品，稳定可靠', 25, 179, '2', 1, '2025-05-25 14:20:00', '通过');
INSERT INTO `resource` VALUES (91, NULL, '精工机芯', '日本制造，性价比高', 40, 249.99, '2', 4, '2025-06-01 10:45:00', '通过');
INSERT INTO `resource` VALUES (92, NULL, '钻石时标指针', '奢华点缀，闪耀夺目', 10, 999.5, '2', 2, '2025-06-05 16:35:00', '通过');
INSERT INTO `resource` VALUES (93, NULL, '剑形指针', '经典设计，读时清晰', 30, 129, '2', 3, '2025-06-10 11:15:00', '通过');
INSERT INTO `resource` VALUES (94, 1, '螺丝锁把表冠', '专业防水，安全可靠', 11, 500, '2', 1, '2025-05-13 23:00:15', '通过');
INSERT INTO `resource` VALUES (95, 1, '大表冠设计', '操作方便，辨识度高', 15, 100, '2', 1, '2025-05-18 22:30:28', '通过');
INSERT INTO `resource` VALUES (96, 1, '珐琅表盘', '传统工艺，色彩持久', 143, 100, '2', 1, '2025-05-18 22:31:34', '通过');
INSERT INTO `resource` VALUES (97, NULL, '尼龙表带-北约', '军规标准，耐用舒适', 60, 89.99, '2', 1, '2025-01-10 09:30:00', '通过');
INSERT INTO `resource` VALUES (98, NULL, '朗达石英机芯', '瑞士制造，精准耐用', 45, 149.5, '2', 4, '2025-01-20 14:45:00', '通过');
INSERT INTO `resource` VALUES (99, NULL, '柳叶形指针', '优雅纤细，古典美感', 35, 79, '2', 2, '2025-02-05 10:20:00', '通过');
INSERT INTO `resource` VALUES (100, NULL, '旋钮式表冠', '操作精准，反馈清晰', 50, 199.99, '2', 3, '2025-02-15 16:10:00', '通过');
INSERT INTO `resource` VALUES (101, NULL, '陶瓷内胆-5L', '健康材质，不粘易洁', 70, 299.5, '2', 1, '2025-03-01 11:40:00', '通过');
INSERT INTO `resource` VALUES (102, NULL, '铁釜内胆-厚底', '蓄热强，米饭更香', 55, 159, '2', 4, '2025-03-10 15:25:00', '通过');
INSERT INTO `resource` VALUES (103, NULL, 'IH加热盘-1300W', '大火力，加热均匀', 40, 229.99, '2', 2, '2025-03-20 09:15:00', '通过');
INSERT INTO `resource` VALUES (104, NULL, '三维加热盘', '全方位加热，不夹生', 25, 179.5, '2', 3, '2025-04-05 13:50:00', '通过');
INSERT INTO `resource` VALUES (105, NULL, '触控控制面板', '灵敏度高，操作简便', 30, 129, '2', 1, '2025-04-15 10:30:00', '通过');
INSERT INTO `resource` VALUES (106, NULL, '液晶控制面板', '显示清晰，功能丰富', 45, 89.99, '2', 4, '2025-04-25 14:20:00', '通过');
INSERT INTO `resource` VALUES (107, NULL, '可拆卸锅盖', '清洗方便，卫生无忧', 60, 149.5, '2', 2, '2025-05-05 16:45:00', '通过');
INSERT INTO `resource` VALUES (108, NULL, '防溢锅盖', '智能防溢，安全可靠', 35, 199, '2', 3, '2025-05-15 11:10:00', '通过');
INSERT INTO `resource` VALUES (109, NULL, '耐高温电源线', '1.8米长，安全阻燃', 50, 79.99, '2', 1, '2025-05-25 09:40:00', '通过');
INSERT INTO `resource` VALUES (110, NULL, '加粗电源线', '大电流设计，不易发热', 40, 249.5, '2', 4, '2025-06-05 15:15:00', '通过');
INSERT INTO `resource` VALUES (111, 1, '球釜内胆', '黄金弧度，对流加热', 0, 100, '2', 1, '2025-05-19 09:32:29', '通过');
INSERT INTO `resource` VALUES (112, NULL, '麦饭石内胆', '天然材质，健康炊煮', 65, 159, '2', 2, '2025-01-05 13:30:00', '通过');
INSERT INTO `resource` VALUES (113, 1, '压力IH加热盘', '高温高压，快速烹饪', 333, 333, '2', 3, '2025-05-26 16:44:02', '通过');
INSERT INTO `resource` VALUES (114, NULL, '远红外加热盘', '穿透加热，米饭更香甜', 55, 299.99, '2', 3, '2025-01-15 10:45:00', '通过');
INSERT INTO `resource` VALUES (115, NULL, '智能控制面板', 'WIFI连接，手机控制', 45, 189.5, '2', 1, '2025-01-25 16:20:00', '通过');
INSERT INTO `resource` VALUES (116, NULL, '语音控制面板', '声控操作，方便老人', 197, 487.64, '2', 487, '2024-05-10', '通过');
INSERT INTO `resource` VALUES (117, NULL, '不锈钢锅盖', '耐用美观，易清洁', 373, 212.56, '2', 989, '2023-01-09', '通过');
INSERT INTO `resource` VALUES (118, NULL, '防干烧锅盖', '安全防护，自动断电', 749, 210.24, '2', 717, '2024-06-30', '通过');
INSERT INTO `resource` VALUES (119, NULL, '防缠绕电源线', '特殊设计，使用方便', 639, 204.81, '2', 11, '2022-03-22', '通过');
INSERT INTO `resource` VALUES (120, NULL, '可伸缩电源线', '自由调节长度', 141, 936.26, '2', 14, '2025-01-19', '通过');
INSERT INTO `resource` VALUES (121, NULL, '铜釜内胆', '导热快，受热均匀', 868, 384.2, '2', 89, '2022-09-12', '通过');
INSERT INTO `resource` VALUES (122, NULL, '钛合金内胆', '超强耐用，热效率高', 16, 432.78, '2', 165, '2023-05-12', '通过');
INSERT INTO `resource` VALUES (123, NULL, '微压加热盘', '提升沸点，米饭更Q弹', 272, 712.01, '2', 479, '2024-04-04', '通过');
INSERT INTO `resource` VALUES (124, NULL, '预约控制面板', '24小时预约，省时省力', 417, 761.31, '2', 1000, '2022-09-30', '通过');
INSERT INTO `resource` VALUES (125, NULL, '儿童锁锅盖', '防止误操作', 211, 355.34, '2', 934, '2022-10-23', '通过');
INSERT INTO `resource` VALUES (126, NULL, '云杉木琴身-AAA级', '纹理均匀，共振出色', 796, 376.67, '2', 447, '2025-01-25', '通过');
INSERT INTO `resource` VALUES (127, NULL, '桃花心木琴颈', '稳定性好，手感舒适', 196, 701.2, '2', 269, '2024-07-25', '通过');
INSERT INTO `resource` VALUES (128, NULL, '伊利克斯琴弦', '镀膜技术，寿命更长', 458, 617.45, '2', 590, '2023-08-11', '通过');
INSERT INTO `resource` VALUES (129, NULL, '玫瑰木琴桥', '传导性好，音色温暖', 753, 350.78, '2', 559, '2022-01-26', '通过');
INSERT INTO `resource` VALUES (130, NULL, 'Grover调音旋钮', '精准稳定，18:1齿比', 85, 717.68, '2', 120, '2022-02-19', '通过');
INSERT INTO `resource` VALUES (131, NULL, '红松木琴身', '音色温暖，适合指弹', 637, 823.39, '2', 284, '2025-05-16', '通过');
INSERT INTO `resource` VALUES (132, NULL, '枫木琴颈', '硬度高，音色明亮', 584, 748.77, '2', 904, '2025-02-25', '通过');
INSERT INTO `resource` VALUES (133, NULL, '达达里奥琴弦', '经典品牌，手感舒适', 194, 643.85, '2', 386, '2024-06-01', '通过');
INSERT INTO `resource` VALUES (134, NULL, '乌木琴桥', '密度高，传导性好', 432, 231.6, '2', 146, '2024-08-31', '通过');
INSERT INTO `resource` VALUES (135, NULL, 'Gotoh调音旋钮', '日本制造，精密耐用', 488, 572.92, '2', 414, '2022-08-28', '通过');
INSERT INTO `resource` VALUES (136, NULL, '雪松木琴身', '响应灵敏，动态范围广', 598, 191.69, '2', 63, '2023-02-20', '通过');
INSERT INTO `resource` VALUES (137, NULL, '碳纤维琴颈', '不受温湿度影响', 233, 785.7, '2', 792, '2023-05-04', '通过');
INSERT INTO `resource` VALUES (138, NULL, '马丁琴弦', '音色平衡，寿命长', 971, 587.47, '2', 37, '2025-06-01', '通过');
INSERT INTO `resource` VALUES (139, NULL, '黄檀木琴桥', '硬度适中，音色均衡', 606, 888.4, '2', 606, '2024-10-25', '通过');
INSERT INTO `resource` VALUES (140, NULL, 'Sperzel锁弦调音旋钮', '自锁设计，调音稳定', 827, 170.97, '2', 781, '2025-01-12', '通过');
INSERT INTO `resource` VALUES (141, NULL, '相思木琴身', '夏威夷特产，音色独特', 799, 525.54, '2', 979, '2024-01-23', '通过');
INSERT INTO `resource` VALUES (142, NULL, '胡桃木琴颈', '中等硬度，音色温暖', 226, 107.46, '2', 648, '2024-09-22', '通过');
INSERT INTO `resource` VALUES (143, NULL, 'Elixir琴弦', '纳米涂层，防锈耐用', 837, 506.92, '2', 100, '2025-04-21', '通过');
INSERT INTO `resource` VALUES (144, NULL, '紫檀木琴桥', '高档材质，音色出众', 381, 940.65, '2', 135, '2024-12-06', '通过');
INSERT INTO `resource` VALUES (145, NULL, 'Hipshot调音旋钮', '美国制造，精准耐用', 65, 380.57, '2', 107, '2024-09-19', '通过');
INSERT INTO `resource` VALUES (146, NULL, '红木琴身', '稀有材质，共鸣出色', 624, 56.2, '2', 182, '2022-03-06', '通过');
INSERT INTO `resource` VALUES (147, NULL, '碳纤维琴颈-加强', '现代科技，稳定性强', 201, 946.83, '2', 595, '2023-04-06', '通过');
INSERT INTO `resource` VALUES (148, NULL, 'DR琴弦', '手感顺滑，音色明亮', 639, 65.42, '2', 402, '2022-05-24', '通过');
INSERT INTO `resource` VALUES (149, NULL, '枫木琴桥', '音色明亮，适合速弹', 820, 442.52, '2', 460, '2022-01-25', '通过');
INSERT INTO `resource` VALUES (150, NULL, 'Schaller调音旋钮', '德国制造，精密耐用', 167, 528.44, '2', 958, '2023-06-16', '通过');
INSERT INTO `resource` VALUES (151, NULL, '金属灯座-旗舰版', '稳重耐用，防倾倒', 228, 147.71, '2', 75, '2023-01-10', '通过');
INSERT INTO `resource` VALUES (152, NULL, '多段式灯杆', '高度角度自由调节', 768, 341.88, '2', 292, '2024-07-29', '通过');
INSERT INTO `resource` VALUES (153, NULL, '磨砂PC灯罩', '光线柔和，不刺眼', 812, 419.22, '2', 310, '2025-05-08', '通过');
INSERT INTO `resource` VALUES (154, NULL, 'LED灯泡-护眼版', '无频闪，无蓝光危害', 556, 800.38, '2', 333, '2024-10-01', '通过');
INSERT INTO `resource` VALUES (155, NULL, '触摸式开关', '灵敏度高，操作方便', 476, 406.39, '2', 763, '2024-02-13', '通过');
INSERT INTO `resource` VALUES (156, NULL, '大理石灯座', '高档材质，稳重典雅', 834, 896.04, '2', 692, '2023-05-08', '通过');
INSERT INTO `resource` VALUES (157, NULL, '弹簧臂灯杆', '灵活定位，自由悬停', 342, 582.19, '2', 981, '2022-10-14', '通过');
INSERT INTO `resource` VALUES (158, NULL, '布艺灯罩', '透光均匀，质感高级', 238, 225.73, '2', 608, '2024-05-27', '通过');
INSERT INTO `resource` VALUES (159, NULL, '全光谱灯泡', '接近自然光，护眼', 492, 198.37, '2', 317, '2023-02-27', '通过');
INSERT INTO `resource` VALUES (160, NULL, '旋钮式开关', '无极调光，操作精准', 479, 562.86, '2', 336, '2024-03-08', '通过');
INSERT INTO `resource` VALUES (161, NULL, '实木灯座', '天然材质，环保健康', 652, 69, '2', 15, '2022-12-07', '通过');
INSERT INTO `resource` VALUES (162, NULL, '鹅颈灯杆', '柔性设计，任意弯曲', 563, 917.24, '2', 517, '2023-11-03', '通过');
INSERT INTO `resource` VALUES (163, NULL, '玻璃灯罩', '透光性好，易清洁', 505, 133.62, '2', 192, '2022-02-10', '通过');
INSERT INTO `resource` VALUES (164, NULL, '智能灯泡', 'APP控制，色温可调', 738, 81.87, '2', 44, '2024-03-12', '通过');
INSERT INTO `resource` VALUES (165, NULL, '遥控开关', '远程控制，方便快捷', 293, 367.37, '2', 584, '2024-08-18', '通过');
INSERT INTO `resource` VALUES (166, NULL, '铁艺灯座', '复古设计，坚固耐用', 171, 600.01, '2', 108, '2024-07-27', '通过');
INSERT INTO `resource` VALUES (167, NULL, '折叠式灯杆', '节省空间，便携设计', 883, 335.82, '2', 73, '2023-06-05', '通过');
INSERT INTO `resource` VALUES (168, NULL, '金属网灯罩', '现代风格，散热良好', 284, 778.84, '2', 371, '2023-03-29', '通过');
INSERT INTO `resource` VALUES (169, NULL, '阅读专用灯泡', '专注模式，减少疲劳', 775, 892.88, '2', 368, '2022-06-07', '通过');
INSERT INTO `resource` VALUES (170, NULL, '声控开关', '语音控制，智能便捷', 671, 491.35, '2', 291, '2022-05-16', '通过');
INSERT INTO `resource` VALUES (171, NULL, '陶瓷灯座', '工艺精美，隔热性好', 746, 662.59, '2', 639, '2022-05-19', '通过');
INSERT INTO `resource` VALUES (172, NULL, '伸缩式灯杆', '高度自由调节', 701, 40.88, '2', 831, '2025-02-11', '通过');
INSERT INTO `resource` VALUES (173, NULL, '亚克力灯罩', '轻便耐用，透光均匀', 48, 391.39, '2', 33, '2022-11-26', '通过');
INSERT INTO `resource` VALUES (174, NULL, '节能灯泡', '低耗能，长寿命', 835, 955.01, '2', 503, '2022-03-12', '通过');
INSERT INTO `resource` VALUES (175, NULL, '感应式开关', '人体感应，自动开关', 526, 257.19, '2', 673, '2023-06-07', '通过');
INSERT INTO `resource` VALUES (176, NULL, '米其林轮胎-竞驰PS4', '高性能运动胎，干湿地抓地力优异', 760, 506.65, '2', 3, '2022-11-14', '通过');
INSERT INTO `resource` VALUES (177, NULL, '普利司通轮胎-泰然者T005', '静音舒适型，耐磨指数420', 93, 442.42, '2', 374, '2023-01-14', '通过');
INSERT INTO `resource` VALUES (178, NULL, '固特异轮胎-御乘SUV', 'SUV专用，强化侧壁支撑', 763, 986.92, '2', 39, '2024-08-15', '通过');
INSERT INTO `resource` VALUES (179, NULL, '邓禄普轮胎-PT3节能版', '低滚阻设计，省油5%', 61, 620.15, '2', 174, '2023-11-16', '通过');
INSERT INTO `resource` VALUES (180, NULL, '马牌轮胎-自修复CC6', '内置密封层，防刺穿', 900, 868.71, '2', 752, '2023-01-01', '通过');
INSERT INTO `resource` VALUES (181, NULL, '福耀车窗-前挡风玻璃', '夹层防爆，UV隔绝率99%', 505, 434.91, '2', 35, '2023-07-22', '通过');
INSERT INTO `resource` VALUES (182, NULL, '圣戈班车窗-侧窗玻璃', '绿色隔热，一键升降', 221, 916.8, '2', 610, '2025-01-25', '通过');
INSERT INTO `resource` VALUES (183, NULL, '旭硝子车窗-全景天窗', '双层设计，防红外线', 726, 240.67, '2', 391, '2023-07-31', '通过');
INSERT INTO `resource` VALUES (184, NULL, '信义车窗-后挡风玻璃', '电热丝除霜，隐私涂层', 289, 418.74, '2', 656, '2022-06-16', '通过');
INSERT INTO `resource` VALUES (185, NULL, '皮尔金顿车窗-三角窗', '钢化玻璃，增强视野', 250, 939.59, '2', 965, '2023-01-06', '通过');
INSERT INTO `resource` VALUES (186, NULL, '宝钢车架-高强度钢', '热成型钢，抗拉强度1500MPa', 708, 582.5, '2', 876, '2023-06-26', '通过');
INSERT INTO `resource` VALUES (187, NULL, '本特勒车架-铝合金', '减重30%，碰撞吸能', 362, 635.9, '2', 337, '2023-05-27', '通过');
INSERT INTO `resource` VALUES (188, NULL, '麦格纳车架-全承载式', '一体化设计，扭转刚度提升', 456, 184.17, '2', 189, '2023-05-29', '通过');
INSERT INTO `resource` VALUES (189, NULL, '碳纤维车架-赛道版', '超轻量化，专业赛车级', 912, 552.71, '2', 337, '2023-05-02', '通过');
INSERT INTO `resource` VALUES (190, NULL, '钢铝混合车架-城市版', '平衡重量与成本', 839, 174.1, '2', 358, '2025-06-04', '通过');
INSERT INTO `resource` VALUES (191, NULL, '真皮方向盘-豪华版', 'Nappa真皮包裹，电动调节', 623, 620.02, '2', 643, '2025-01-27', '通过');
INSERT INTO `resource` VALUES (192, NULL, '碳纤维方向盘-运动版', '轻量化，带换挡拨片', 83, 37.08, '2', 662, '2023-07-19', '通过');
INSERT INTO `resource` VALUES (193, NULL, '加热方向盘-冬季版', '3档温控，30秒升温', 802, 262.72, '2', 56, '2022-10-19', '通过');
INSERT INTO `resource` VALUES (194, NULL, '多功能方向盘-商务版', '集成多媒体控制按键', 843, 470.77, '2', 478, '2023-02-10', '通过');
INSERT INTO `resource` VALUES (195, NULL, '赛车方向盘-竞技版', '直径350mm，Alcantara包裹', 753, 750.6, '2', 319, '2022-12-27', '通过');
INSERT INTO `resource` VALUES (196, NULL, '宝马发动机-B48', '2.0T涡轮增压，245马力', 180, 133.58, '2', 210, '2024-12-05', '通过');
INSERT INTO `resource` VALUES (197, NULL, '大众发动机-EA888', '第三代，混合喷射技术', 870, 241.14, '2', 263, '2022-12-03', '通过');
INSERT INTO `resource` VALUES (198, NULL, '丰田发动机-混动版', '热效率41%，综合油耗4L', 194, 169.83, '2', 714, '2023-07-24', '通过');
INSERT INTO `resource` VALUES (199, NULL, '特斯拉发动机-永磁同步', '零百加速3.3秒，续航600km', 307, 752.93, '2', 503, '2022-01-12', '通过');
INSERT INTO `resource` VALUES (200, NULL, '比亚迪发动机-骁云1.5T', '热效率38%，米勒循环', 522, 535.53, '2', 491, '2024-11-16', '通过');

-- ----------------------------
-- Table structure for subtask
-- ----------------------------
DROP TABLE IF EXISTS `subtask`;
CREATE TABLE `subtask`  (
  `subtaskid` int NOT NULL AUTO_INCREMENT,
  `taskid` int NULL DEFAULT NULL,
  `subtaskname` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `subtaskstatus` enum('待完成','已完成','已取消') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '待完成',
  `resourcerequirements` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `estimatedtime` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `resourceids` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `resourcequantities` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  PRIMARY KEY (`subtaskid`) USING BTREE,
  INDEX `taskid`(`taskid` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 28 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of subtask
-- ----------------------------
INSERT INTO `subtask` VALUES (23, 5, '内胆', '待完成', '5L陶瓷涂层，不粘锅设计，可拆卸清洗', '2023-08-15', NULL, '1');
INSERT INTO `subtask` VALUES (24, 5, '加热盘', '待完成', 'IH电磁加热，功率1200W，支持多段控温', '2023-08-25', NULL, '2');
INSERT INTO `subtask` VALUES (25, 5, '控制面板', '待完成', '触控式，24小时预约功能', '2023-08-25', NULL, '4');
INSERT INTO `subtask` VALUES (26, 5, '盖子', '待完成', '可拆卸内盖，防溢设计', '2023-08-25', NULL, '1');
INSERT INTO `subtask` VALUES (27, 5, '电源线', '待完成', '1.5米长，耐高温材质', '2023-08-25', NULL, '4');

-- ----------------------------
-- Table structure for task
-- ----------------------------
DROP TABLE IF EXISTS `task`;
CREATE TABLE `task`  (
  `taskid` int NOT NULL AUTO_INCREMENT,
  `userid` int NULL DEFAULT NULL,
  `taskname` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `taskdescription` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `taskdate` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `completiontime` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `taskstatus` enum('待完成','已完成','已取消') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '待完成',
  `subtasks` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `categoryid` int NULL DEFAULT NULL,
  `auditstatus` enum('驳回','通过','待审') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '待审',
  `orderids` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  PRIMARY KEY (`taskid`) USING BTREE,
  INDEX `userid`(`userid` ASC) USING BTREE,
  INDEX `categoryid`(`categoryid` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 75 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of task
-- ----------------------------
INSERT INTO `task` VALUES (1, 1, '自行车', '需要铝合金车架(≤2.5kg)、26英寸防滑车轮、可调车把、双碟刹系统、不锈钢链条和防滑脚踏板', '2021-05-30 03:40:01', '2001-07-01 04:56:10', '待完成', '', 3, '通过', '');
INSERT INTO `task` VALUES (2, 1, '电脑', '需要i7-12700K处理器、32GB DDR5内存、1TB NVMe SSD、RTX 3080显卡、ATX主板和750W金牌电源', '2012-07-10 05:10:44', '2011-11-12 05:32:40', '待完成', '', 1, '通过', '');
INSERT INTO `task` VALUES (3, 1, '手机', '需要6.62寸AMOLED屏幕、5500mAh电池、2000万像素摄像头、天玑1000处理器和立体声扬声器', '2022-04-17 09:04:17', '2001-01-06 19:35:23', '待完成', '', 2, '通过', '');
INSERT INTO `task` VALUES (4, 1, '手表', '需要1.4寸AMOLED表盘、硅胶表带、瑞士ETA机芯、夜光指针和防水表冠', '2012-01-11 16:15:27', '2002-07-28 08:17:45', '待完成', '', 2, '通过', '');
INSERT INTO `task` VALUES (5, 1, '电饭煲', '需要5L陶瓷内胆、IH电磁加热盘、触控面板、可拆卸盖子和耐高温电源线', '2014-04-25 16:34:55', '2018-10-27 12:54:41', '待完成', '23,24,25,26,27', 4, '通过', NULL);
INSERT INTO `task` VALUES (6, 1, '吉他', '需要云杉木琴身、枫木琴颈、磷青铜琴弦、玫瑰木琴桥和全封闭调音旋钮', '2017-01-18 08:29:47', '2014-10-22 22:03:02', '待完成', NULL, 2, '通过', NULL);
INSERT INTO `task` VALUES (7, 1, '台灯', '需要金属灯座、可调灯杆、磨砂灯罩、12W LED灯泡和触摸开关', '2005-07-23 11:46:13', '2013-11-28 15:07:48', '待完成', NULL, 2, '通过', NULL);
INSERT INTO `task` VALUES (8, 1, '汽车', '需要225/55 R18轮胎、防紫外线车窗、钢铝车架、真皮方向盘和2.0T发动机', '2018-10-31 02:35:08', '2024-01-06 17:24:54', '待完成', NULL, 4, '通过', '');
INSERT INTO `task` VALUES (9, 1, '范震南', 'Navicat Data Modeler enables you to build high-quality conceptual, logical and physical             ', '2010-08-25 08:03:05', '2019-10-02 22:44:37', '待完成', NULL, 3, '通过', NULL);
INSERT INTO `task` VALUES (10, 1, '吴致远', 'SSH serves to prevent such vulnerabilities and allows you to access a remote server\'s               ', '2017-10-20 17:28:50', '2001-04-03 21:09:23', '待完成', NULL, 3, '通过', '');
INSERT INTO `task` VALUES (11, 14, '戴詩涵', 'There is no way to happiness. Happiness is the way. The first step is as good as half over.', '2000-11-18 20:22:08', '2012-04-22 01:30:41', '待完成', NULL, 3, '待审', NULL);
INSERT INTO `task` VALUES (12, 11, '朱宇宁', 'The Navigation pane employs tree structure which allows you to take action upon the                 ', '2011-12-19 09:13:52', '2006-10-21 02:48:15', '待完成', NULL, 2, '驳回', NULL);
INSERT INTO `task` VALUES (13, 8, '龚晓明', 'SQL Editor allows you to create and edit SQL text, prepare and execute selected queries.            ', '2020-07-26 00:54:34', '2005-10-18 20:00:34', '待完成', NULL, 2, '待审', NULL);
INSERT INTO `task` VALUES (14, 1, '曹詩涵', 'Sometimes you win, sometimes you learn.', '2012-08-07 11:47:31', '2020-07-03 05:28:23', '已完成', NULL, 2, '驳回', '1,2,3,');
INSERT INTO `task` VALUES (15, 5, '尹岚', 'Secure Sockets Layer(SSL) is a protocol for transmitting private documents via the Internet.', '2016-04-05 06:55:40', '2005-03-12 15:06:55', '已取消', NULL, 2, '通过', NULL);
INSERT INTO `task` VALUES (16, 8, '马致远', 'Import Wizard allows you to import data to tables/collections from CSV, TXT, XML, DBF and more.', '2003-09-28 23:47:32', '2004-09-12 15:17:38', '已取消', NULL, 1, '通过', NULL);
INSERT INTO `task` VALUES (17, 7, '李嘉伦', 'The Information Pane shows the detailed object information, project activities, the                 ', '2006-02-03 10:36:48', '2017-12-22 11:34:16', '待完成', NULL, 1, '通过', NULL);
INSERT INTO `task` VALUES (18, 9, '徐睿', 'A man is not old until regrets take the place of dreams. In other words, Navicat                    ', '2007-09-16 13:46:18', '2004-09-30 03:39:11', '待完成', NULL, 3, '待审', NULL);
INSERT INTO `task` VALUES (19, 2, '曾睿', 'Navicat provides powerful tools for working with queries: Query Editor for editing                  ', '2004-07-06 11:17:34', '2008-02-16 06:56:32', '待完成', NULL, 2, '通过', NULL);
INSERT INTO `task` VALUES (20, 6, '周子韬', 'Navicat 15 has added support for the system-wide dark mode.', '2010-06-21 21:22:54', '2002-07-25 18:22:27', '已完成', NULL, 4, '驳回', NULL);
INSERT INTO `task` VALUES (21, 1, '张安琪', 'What you get by achieving your goals is not as important as what you become by achieving your goals.', '2024-12-14 19:52:57', '2018-04-18T18:55:56', '待完成', NULL, 4, '通过', '4,5,');
INSERT INTO `task` VALUES (22, 4, '冯璐', 'It is used while your ISPs do not allow direct connections, but allows establishing                 ', '2021-03-11 23:41:43', '2021-08-21 15:22:53', '已完成', NULL, 3, '驳回', NULL);
INSERT INTO `task` VALUES (23, 2, '贾致远', 'Navicat provides a wide range advanced features, such as compelling code editing                    ', '2022-06-28 03:36:19', '2006-03-20 14:23:56', '已完成', NULL, 4, '驳回', NULL);
INSERT INTO `task` VALUES (24, 20, '马璐', 'You cannot save people, you can just love them. If you wait, all that happens is you get older.', '2011-01-10 14:09:26', '2007-06-18 22:30:32', '待完成', NULL, 2, '驳回', NULL);
INSERT INTO `task` VALUES (25, 18, '郝秀英', 'Always keep your eyes open. Keep watching. Because whatever you see can inspire you.', '2015-09-08 20:09:01', '2001-04-17 03:22:42', '已完成', NULL, 2, '驳回', NULL);
INSERT INTO `task` VALUES (26, 2, '向子异', 'If opportunity doesn’t knock, build a door. Anyone who has never made a mistake                   ', '2015-01-31 16:30:31', '2002-10-22 15:44:24', '待完成', NULL, 4, '待审', NULL);
INSERT INTO `task` VALUES (27, 11, '钟震南', 'The repository database can be an existing MySQL, MariaDB, PostgreSQL, SQL Server,                  ', '2019-04-02 13:47:28', '2003-12-31 20:57:42', '已完成', NULL, 2, '待审', NULL);
INSERT INTO `task` VALUES (28, 1, '萧致远', 'Genius is an infinite capacity for taking pains. How we spend our days is, of course,               ', '2021-10-30 16:27:02', '2013-08-27 06:50:29', '已取消', NULL, 4, '通过', '4,5,');
INSERT INTO `task` VALUES (29, 1, '任云熙', 'Remember that failure is an event, not a person. Sometimes you win, sometimes you learn.', '2017-04-04 21:05:32', '2016-11-24 21:03:54', '已完成', NULL, 2, '驳回', '4,5,');
INSERT INTO `task` VALUES (30, 13, '任杰宏', 'If it scares you, it might be a good thing to try. Difficult circumstances serve                    ', '2019-07-10 20:48:36', '2021-02-17 08:41:50', '已取消', NULL, 3, '通过', NULL);
INSERT INTO `task` VALUES (31, 2, '贾震南', 'With its well-designed Graphical User Interface(GUI), Navicat lets you quickly and                  ', '2003-12-21 18:09:42', '2000-11-15 07:27:04', '已完成', NULL, 3, '待审', NULL);
INSERT INTO `task` VALUES (32, 1, '梁詩涵', 'Navicat Monitor can be installed on any local computer or virtual machine and does                  ', '2019-12-30 12:42:12', '2015-03-04 05:11:17', '已完成', NULL, 4, '待审', '4,5,');
INSERT INTO `task` VALUES (33, 15, '曾嘉伦', 'If opportunity doesn’t knock, build a door. The repository database can be an existing            ', '2020-10-22 03:44:30', '2023-03-07 05:12:27', '待完成', NULL, 2, '驳回', NULL);
INSERT INTO `task` VALUES (34, 5, '范詩涵', 'How we spend our days is, of course, how we spend our lives. A man’s best friends                 ', '2021-07-25 19:57:33', '2022-05-17 15:43:32', '待完成', NULL, 4, '待审', NULL);
INSERT INTO `task` VALUES (35, 6, '阎宇宁', 'If you wait, all that happens is you get older. The On Startup feature allows you                   ', '2000-09-19 07:26:34', '2003-01-05 23:56:29', '已完成', NULL, 1, '待审', NULL);
INSERT INTO `task` VALUES (36, 1, '刘嘉伦', 'Champions keep playing until they get it right.', '2008-01-09 16:46:55', '2023-04-16 15:21:24', '待完成', NULL, 3, '待审', '4,5,');
INSERT INTO `task` VALUES (37, 5, '马晓明', 'Navicat Data Modeler enables you to build high-quality conceptual, logical and physical             ', '2002-05-26 20:54:58', '2021-04-19 17:07:59', '已取消', NULL, 2, '驳回', NULL);
INSERT INTO `task` VALUES (38, 1, '龙睿', 'Always keep your eyes open. Keep watching. Because whatever you see can inspire you.', '2004-08-14 06:11:33', '2000-09-08 17:21:40', '待完成', NULL, 2, '待审', '1,2,3,');
INSERT INTO `task` VALUES (39, 20, '邹宇宁', 'Import Wizard allows you to import data to tables/collections from CSV, TXT, XML, DBF and more.', '2010-12-08 05:54:39', '2017-12-27 22:04:58', '已完成', NULL, 2, '驳回', NULL);
INSERT INTO `task` VALUES (40, 9, '郭嘉伦', 'Instead of wondering when your next vacation is, maybe you should set up a life you                 ', '2024-08-14 16:51:01', '2008-05-19 04:19:02', '待完成', NULL, 1, '通过', NULL);
INSERT INTO `task` VALUES (41, 12, '刘杰宏', 'How we spend our days is, of course, how we spend our lives.', '2007-02-03 12:10:39', '2012-12-01 19:09:03', '已取消', NULL, 3, '通过', NULL);
INSERT INTO `task` VALUES (42, 1, '沈子韬', 'All journeys have secret destinations of which the traveler is unaware.', '2002-01-14 06:04:12', '2018-06-07 19:28:36', '已取消', NULL, 1, '待审', '1,2,3,');
INSERT INTO `task` VALUES (43, 11, '蔡璐', 'The past has no power over the present moment.', '2023-12-08 16:24:59', '2001-03-31 21:32:20', '已取消', NULL, 4, '通过', NULL);
INSERT INTO `task` VALUES (44, 1, '侯秀英', 'It collects process metrics such as CPU load, RAM usage, and a variety of other resources           ', '2018-06-16 16:43:48', '2020-09-06 18:23:03', '待完成', NULL, 1, '驳回', '4,5,');
INSERT INTO `task` VALUES (45, 1, '梁安琪', 'If your Internet Service Provider (ISP) does not provide direct access to its server,               ', '2009-11-09 01:35:57', '2021-08-27 01:39:32', '已取消', NULL, 4, '驳回', '1,2,3,');
INSERT INTO `task` VALUES (46, 1, '黎宇宁', 'Export Wizard allows you to export data from tables, collections, views, or query', '2013-04-21 19:42:00', '2016-06-11T14:07:23', '待完成', NULL, 2, '通过', '1,2,3,');
INSERT INTO `task` VALUES (47, 1, '董嘉伦', 'The first step is as good as half over. It provides strong authentication and secure                ', '2018-10-16 02:54:42', '2005-09-27 18:30:46', '已取消', NULL, 2, '通过', '1,2,3,');
INSERT INTO `task` VALUES (48, 1, '毛致远', 'In the middle of winter I at last discovered that there was in me an invincible summer.', '2017-01-18 12:52:48', '2002-08-25 16:07:36', '已完成', NULL, 3, '通过', '1,2,3,');
INSERT INTO `task` VALUES (49, 1, '郝子异', 'Navicat Monitor is a safe, simple and agentless remote server monitoring tool that                  ', '2009-04-20 06:21:54', '2006-02-06 08:16:31', '已完成', NULL, 4, '待审', '4,5,');
INSERT INTO `task` VALUES (50, 1, '陈子韬', 'In other words, Navicat provides the ability for data in different databases and/or                 ', '2004-09-11 03:40:00', '2019-12-24 12:40:46', '待完成', NULL, 2, '待审', '4,5,');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `userid` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `role` tinyint(1) NULL DEFAULT 0,
  `age` tinyint(1) NULL DEFAULT NULL,
  `gender` tinyint(1) NULL DEFAULT NULL,
  `time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `status` tinyint(1) NULL DEFAULT 0,
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '无',
  PRIMARY KEY (`userid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 162 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'llj', '$2a$10$Du4YcyFWvrxtURHLvbSUC.931GAh9FQobB3xOKJTqJldtd3Ug6Qlq', '18755809030', '3027489742@qq.com', 1, 23, 1, '2025-04-24 20:40:01', 0, '巢湖学院');
INSERT INTO `user` VALUES (2, '111', '$2a$10$Du4YcyFWvrxtURHLvbSUC.931GAh9FQobB3xOKJTqJldtd3Ug6Qlq', NULL, NULL, 0, NULL, NULL, NULL, 0, '无');
INSERT INTO `user` VALUES (9, '张三', 'zhangsan', '12345678', 'zhangsan@example.com', 1, NULL, 3, NULL, 1, '无');
INSERT INTO `user` VALUES (11, '李四', '111', '12345678', 'zhangsan@example.com', 0, 2, 2, NULL, 0, '无');
INSERT INTO `user` VALUES (13, '123', '$2a$10$Du4YcyFWvrxtURHLvbSUC.931GAh9FQobB3xOKJTqJldtd3Ug6Qlq', '1231', 'zhangsan@example.com', 0, 0, 1, NULL, 0, '无');
INSERT INTO `user` VALUES (18, 'gxf', '$2a$10$mk7vSVbvqivAEULUdFjl6uryK0rnRCWogVSht5ZRDLgRDs5JdoH9m', '111', '1234234234@qq.com', 0, 0, 1, '2025-04-24 20:40:01', 0, '1234124');
INSERT INTO `user` VALUES (21, '11', '$2a$10$Z8bjniLUQOOitU9Zyt9PeePhIf3sEqsqxa.thrR2G/M/z0ZWE3AQa', '11', '11', 0, 0, 1, '2025-04-24 23:40:35', 0, '11');
INSERT INTO `user` VALUES (149, 'ddd', '$2a$10$1piBJDc7ifWMKq.xuzWAfOVyvWze1VkwBAsg1DKd41rrOvveLBzue', '1111111', '1234234234@qq.com', 0, 0, 1, '2025-05-09 09:31:52', 0, '无');
INSERT INTO `user` VALUES (150, 'Ono Sara', 'pyovZcAPjY', '182-3828-2117', 'onosara@yahoo.com', 1, 32, 2, '2023-07-01 14:31:47', 1, '中国广州市海珠区江南西路352号华润大厦50室');
INSERT INTO `user` VALUES (151, 'Otsuka Miu', 'YxdxzIZT0A', '21-876-3576', 'otsmi@icloud.com', 1, 81, 2, '2008-05-28 02:52:17', 0, '中国深圳龙岗区布吉镇西环路526号29室');
INSERT INTO `user` VALUES (152, 'Hsuan Chiu Wai', 'blmq8aE7Hc', '70-9659-5249', 'chiuwaihsuan@mail.com', 1, 64, 3, '2010-11-26 13:14:16', 0, '中国广州市白云区机场路棠苑街五巷792号19室');
INSERT INTO `user` VALUES (153, 'Rachel Allen', 'Vj2IB0oFx2', '(116) 230 7860', 'rachelallen19@outlook.com', 0, 64, 3, '2015-03-03 20:10:34', 1, '中国深圳龙岗区布吉镇西环路598号5号楼');
INSERT INTO `user` VALUES (154, 'Donna Campbell', '5Rju6QaO1k', '11-870-4650', 'doc@icloud.com', 1, 42, 1, '2008-02-05 12:51:29', 0, '中国中山天河区大信商圈大信南路583号43室');
INSERT INTO `user` VALUES (155, 'Carmen Cooper', 'cYDa6iweN3', '312-385-7392', 'coopecarm10@icloud.com', 0, 109, 2, '2009-04-25 11:55:40', 1, '中国中山乐丰六路606号11号楼');
INSERT INTO `user` VALUES (156, 'Xue Rui', 'OT3Kzh0Iu6', '148-3269-6770', 'rxue10@outlook.com', 0, 2, 2, '2023-10-03 13:38:26', 1, '中国广州市白云区小坪东路8号49栋');
INSERT INTO `user` VALUES (157, 'Chic Wing Fat', 'wl1FrlPRAb', '(1223) 02 0478', 'cwf6@gmail.com', 1, 113, 3, '2021-08-25 08:54:06', 1, '中国广州市越秀区中山二路337号44室');
INSERT INTO `user` VALUES (158, 'Lam Tin Wing', 'zsz7JVgBlG', '135-1361-2664', 'ltinwing9@outlook.com', 1, 123, 3, '2025-02-13 05:21:50', 1, '中国成都市锦江区红星路三段446号5室');
INSERT INTO `user` VALUES (159, 'Zhou Shihan', 'JpLoYaBEM9', '7791 856912', 'shz@mail.com', 1, 22, 2, '2012-01-14 18:34:30', 1, '中国深圳罗湖区蔡屋围深南东路419号40楼');
INSERT INTO `user` VALUES (161, 'test', '$2a$10$KVurXUzdUE3Egu/4WTxCK.vYeAMAnna7ltMOk7z0.7ja/TBu.oeXC', '12345678', 'test@qq.com', 0, 0, 0, NULL, 0, NULL);

SET FOREIGN_KEY_CHECKS = 1;
