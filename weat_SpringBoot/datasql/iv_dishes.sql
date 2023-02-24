/*
 Navicat Premium Data Transfer

 Source Server         : brath.cn 服务数据库 （Mysql主库）
 Source Server Type    : MySQL
 Source Server Version : 50737
 Source Host           : brath.cn:3306
 Source Schema         : iv-user-services

 Target Server Type    : MySQL
 Target Server Version : 50737
 File Encoding         : 65001

 Date: 24/02/2023 10:47:33
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for iv_dishes
-- ----------------------------
DROP TABLE IF EXISTS `iv_dishes`;
CREATE TABLE `iv_dishes`  (
  `id` int(50) NOT NULL AUTO_INCREMENT COMMENT '唯一ID',
  `dishes_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜品名字',
  `dishes_step` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜品做法',
  `dishes_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜品图片地址',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '菜品表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of iv_dishes
-- ----------------------------
INSERT INTO `iv_dishes` VALUES (1, '凉拌黄瓜虾仁', '1.小米辣 白芝麻蒜未辣椒面 淋上少许热油\r\n2.生抽2勺 油 醋各1代糖半勺搅匀备用\r\n3.虾煮熟去壳 木耳焯水捞出 黄瓜拍块\r\n4.淋上酱汁拌匀即可', 'https://brath.oss-cn-shanghai.aliyuncs.com/pigo/image-20230224081935481.png');
INSERT INTO `iv_dishes` VALUES (2, '低卡酱油鸡蛋', '1.生抽4勺 醋2香油1勺一把葱花\r\n2.鸡蛋冷水下锅煮8分钟盖盖焖1分钟后泡冷水\r\n3.温开水4勺搅匀\r\n4.鸡蛋剥壳切对半淋上酱汁拌匀即可', 'https://brath.oss-cn-shanghai.aliyuncs.com/pigo/image-20230224082035768.png');
INSERT INTO `iv_dishes` VALUES (3, '低卡葱香鸡腿', '1.蒜末 葱花 白艺麻小米辣淋上少许热油\r\n2.生抽1勺 许盐搅匀\r\n3.鸡腿熟捞出微凉后撕成小块\r\n4.淋上酱汁拌匀即可', 'https://brath.oss-cn-shanghai.aliyuncs.com/pigo/image-20230224082101091.png');
INSERT INTO `iv_dishes` VALUES (4, '低卡平菇炒蛋', '1.鸡蛋炒熟盛出\r\n2.油热下从蒜炒香\r\n3.下平菇炒出汁，倒入炒好的鸡蛋\r\n4.生抽 油 辣椒粉各1勺 少许盐炒匀即可', 'https://brath.oss-cn-shanghai.aliyuncs.com/pigo/image-20230224082137439.png');
INSERT INTO `iv_dishes` VALUES (5, '凉拌虾仁西兰花', '1.蒜未 葱花 辣椒面白芝麻淋上少许热油\r\n2.生抽2勺 醋各1勺搅拌均匀\r\n3.西兰花焯水捞出，虾焯水去壳鸡蛋白切块\r\n4.淋上酱汁拌匀即可', 'https://brath.oss-cn-shanghai.aliyuncs.com/pigo/image-20230224082204322.png');
INSERT INTO `iv_dishes` VALUES (6, '凉拌黄瓜木耳鸡蛋', '1.木耳鸡蛋各煮熟捞出 黄瓜拍块\r\n2.生抽2勺醋香油各11勺温开水拌匀即可开吃', 'https://brath.oss-cn-shanghai.aliyuncs.com/pigo/image-20230224082230282.png');
INSERT INTO `iv_dishes` VALUES (7, '凉拌黄瓜豆腐', '1.白芝麻辣椒面小米辣,蒜未 葱花 淋少许热油\r\n2.生抽2勺 醋油各1勺 少许盐代糖拌匀\r\n3.黄瓜拍块去籽豆腐煮熟捞出\r\n4.撒上香葱淋上酱汁拌匀即可', 'https://brath.oss-cn-shanghai.aliyuncs.com/pigo/image-20230224082404878.png');
INSERT INTO `iv_dishes` VALUES (8, '木耳炒鸡蛋', '1.鸡蛋炒熟盛出\r\n2.蒜未和胡萝人炒软倒木耳炒熟再倒鸡蛋\r\n3.耗油生抽各1勺少许盐-小半碗淀粉水\r\n4.炒匀下葱段即可', 'https://brath.oss-cn-shanghai.aliyuncs.com/pigo/image-20230224082512562.png');

SET FOREIGN_KEY_CHECKS = 1;
