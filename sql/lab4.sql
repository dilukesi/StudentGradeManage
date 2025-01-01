/*
Navicat MySQL Data Transfer

Source Server         : 学生系统
Source Server Version : 80200
Source Host           : localhost:3306
Source Database       : lab4

Target Server Type    : MYSQL
Target Server Version : 80200
File Encoding         : 65001

Date: 2024-06-14 05:51:59
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `admin`
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '账号',
  `password` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '密码',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '姓名',
  `role` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '角色',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='管理员表';

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES ('1', 'admin1', '123456', 'dbadmin', 'ADMIN');

-- ----------------------------
-- Table structure for `course`
-- ----------------------------
DROP TABLE IF EXISTS `course`;
CREATE TABLE `course` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID\r\n',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '课程名',
  `no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '课程编号',
  `descr` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '课程描述',
  `times` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '课时',
  `teacher` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '娴犵粯鏆€閼颁礁绗€',
  `teacher_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `teacher_id` (`teacher_id`),
  CONSTRAINT `teacher_id` FOREIGN KEY (`teacher_id`) REFERENCES `teacher` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='课程信息';

-- ----------------------------
-- Records of course
-- ----------------------------
INSERT INTO `course` VALUES ('1', '高等数学', 'SSG567-789', '专业必修', '32课时', '王明', '1');
INSERT INTO `course` VALUES ('8', '大学物理', 'SSG-345', '基础必修', '48', '林伟', null);

-- ----------------------------
-- Table structure for `grade`
-- ----------------------------
DROP TABLE IF EXISTS `grade`;
CREATE TABLE `grade` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `course_id` int DEFAULT NULL COMMENT '课程ID',
  `student_id` int DEFAULT NULL COMMENT '学生ID',
  `score` double(10,0) DEFAULT NULL COMMENT '成绩',
  `teacher_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `feedback` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '学生反馈',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='成绩表';

-- ----------------------------
-- Records of grade
-- ----------------------------
INSERT INTO `grade` VALUES ('6', '1', '1', '67', '王明', null);
INSERT INTO `grade` VALUES ('7', '1', '13', '100', '王明', null);
INSERT INTO `grade` VALUES ('19', '1', '134', '88', '王明', null);
INSERT INTO `grade` VALUES ('20', '1', '137', '71', '王明', null);
INSERT INTO `grade` VALUES ('21', '8', '140', '79', '林伟', null);

-- ----------------------------
-- Table structure for `student`
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '学生ID',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '学号',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '密码',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '姓名',
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '手机号',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '邮箱',
  `sex` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '性别',
  `birth` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '生日',
  `role` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '角色',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=249 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='学生信息';

-- ----------------------------
-- Records of student
-- ----------------------------
INSERT INTO `student` VALUES ('1', 'test', '123456', '李萌', '1', '1', '男', '2001.06.07', 'STUDENT');
INSERT INTO `student` VALUES ('13', 'test1', '123456', '李天然', null, null, null, null, 'STUDENT');
INSERT INTO `student` VALUES ('134', 'test524', '123456', '马伟祺', '12', '123', '男', '2024-06-02', 'STUDENT');
INSERT INTO `student` VALUES ('135', 'test484', '123456', '谢致远', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('136', 'test84', '123456', '秦钰轩', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('137', 'test189', '123456', '范旭尧', '1234', '1234', '男', '2004-06-08', 'STUDENT');
INSERT INTO `student` VALUES ('138', 'test691', '123456', '万正豪', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('139', 'test226', '123456', '吕天宇', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('140', 'test64', '123456', '何子涵', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('141', 'test809', '123456', '杜旭尧', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('142', 'test718', '123456', '余立果', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('143', 'test422', '123456', '黄文轩', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('144', 'test832', '123456', '史文昊', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('145', 'test783', '123456', '陈炫明', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('146', 'test150', '123456', '龚鹤轩', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('147', 'test347', '123456', '杜明轩', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('148', 'test267', '123456', '萧胤祥', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('149', 'test88', '123456', '石嘉熙', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('150', 'test80', '123456', '刘天磊', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('151', 'test137', '123456', '曹鹏', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('152', 'test637', '123456', '孟立诚', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('153', 'test39', '123456', '汪致远', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('154', 'test846', '123456', '孔峻熙', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('155', 'test619', '123456', '许弘文', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('156', 'test209', '123456', '吕炎彬', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('157', 'test957', '123456', '汪涛', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('158', 'test745', '123456', '何泽洋', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('159', 'test533', '123456', '秦鸿涛', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('160', 'test253', '123456', '冯楷瑞', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('161', 'test81', '123456', '吴炎彬', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('162', 'test89', '123456', '魏涛', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('163', 'test387', '123456', '徐智宸', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('164', 'test227', '123456', '万梓晨', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('165', 'test625', '123456', '姜浩宇', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('166', 'test647', '123456', '吕文昊', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('167', 'test690', '123456', '石鹏涛', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('168', 'test576', '123456', '傅越彬', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('169', 'test286', '123456', '朱鸿煊', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('170', 'test888', '123456', '李鹭洋', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('171', 'test570', '123456', '谢琪', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('172', 'test863', '123456', '莫越泽', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('173', 'test675', '123456', '孙鹏煊', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('174', 'test982', '123456', '傅烨霖', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('175', 'test372', '123456', '段风华', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('176', 'test461', '123456', '夏立轩', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('177', 'test349', '123456', '马子骞', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('178', 'test497', '123456', '苏智辉', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('179', 'test665', '123456', '沈峻熙', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('180', 'test829', '123456', '唐浩轩', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('181', 'test849', '123456', '夏烨磊', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('182', 'test660', '123456', '贺笑愚', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('183', 'test377', '123456', '余凯瑞', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('184', 'test71', '123456', '萧金鑫', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('185', 'test307', '123456', '何立果', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('186', 'test618', '123456', '沈博文', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('187', 'test225', '123456', '白展鹏', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('188', 'test475', '123456', '张熠彤', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('189', 'test448', '123456', '王修杰', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('190', 'test754', '123456', '丁鸿煊', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('191', 'test116', '123456', '郭弘文', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('192', 'test723', '123456', '吴鹏煊', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('193', 'test774', '123456', '许煜城', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('194', 'test415', '123456', '邵瑞霖', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('195', 'test261', '123456', '曹旭尧', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('196', 'test51', '123456', '薛明轩', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('197', 'test872', '123456', '赵雨泽', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('198', 'test808', '123456', '熊建辉', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('199', 'test695', '123456', '龙越泽', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('200', 'test659', '123456', '谢笑愚', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('201', 'test29', '123456', '顾炫明', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('202', 'test778', '123456', '萧皓轩', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('203', 'test790', '123456', '宋明哲', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('204', 'test828', '123456', '孟浩轩', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('205', 'test699', '123456', '袁绍辉', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('206', 'test700', '123456', '薛天磊', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('207', 'test786', '123456', '郭明轩', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('208', 'test582', '123456', '李鹏煊', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('209', 'test905', '123456', '杨鹏煊', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('210', 'test49', '123456', '戴智宸', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('211', 'test871', '123456', '潘耀杰', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('212', 'test460', '123456', '莫泽洋', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('213', 'test617', '123456', '顾黎昕', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('214', 'test57', '123456', '马锦程', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('215', 'test759', '123456', '郭文', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('216', 'test992', '123456', '崔耀杰', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('217', 'test323', '123456', '彭瑾瑜', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('218', 'test839', '123456', '段博文', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('219', 'test476', '123456', '廖旭尧', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('220', 'test899', '123456', '蒋金鑫', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('221', 'test254', '123456', '余俊驰', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('222', 'test48', '123456', '赵嘉熙', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('223', 'test354', '123456', '胡思远', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('224', 'test911', '123456', '钱明辉', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('225', 'test477', '123456', '苏绍辉', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('226', 'test535', '123456', '孟思源', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('227', 'test698', '123456', '袁明杰', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('228', 'test510', '123456', '蔡志泽', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('229', 'test965', '123456', '金明哲', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('230', 'test717', '123456', '汪鑫鹏', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('231', 'test624', '123456', '魏鹏', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('232', 'test118', '123456', '马伟祺', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('233', 'test527', '123456', '孟彬', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('234', 'test853', '123456', '于越泽', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('235', 'test47', '123456', '冯君浩', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('236', 'test652', '123456', '吴志强', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('237', 'test917', '123456', '薛明辉', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('238', 'test485', '123456', '侯鹤轩', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('239', 'test520', '123456', '梁致远', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('240', 'test578', '123456', '范智渊', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('241', 'test869', '123456', '曾潇然', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('242', 'test452', '123456', '赖博超', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('243', 'test607', '123456', '陈语堂', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('244', 'test315', '123456', '林昊焱', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('245', 'test946', '123456', '史瑾瑜', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('246', 'test692', '123456', '阎天宇', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('247', 'test417', '123456', '孟博涛', '待完善', '待完善', '待完善', '待完善', 'STUDENT');
INSERT INTO `student` VALUES ('248', 'test136', '123456', '林琪', '待完善', '待完善', '待完善', '待完善', 'STUDENT');

-- ----------------------------
-- Table structure for `student_course`
-- ----------------------------
DROP TABLE IF EXISTS `student_course`;
CREATE TABLE `student_course` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '课程名称',
  `no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '课程编号',
  `student_id` int DEFAULT NULL COMMENT '学生ID',
  `course_id` int DEFAULT NULL COMMENT '课程ID',
  `teacher_id` int DEFAULT NULL,
  `teacher` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '老师',
  `status` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT=' 学生选课';

-- ----------------------------
-- Records of student_course
-- ----------------------------
INSERT INTO `student_course` VALUES ('15', '高等数学', 'SSG567-789', '1', '1', '1', '王明', '1');
INSERT INTO `student_course` VALUES ('16', '高等数学', 'SSG567-789', '13', '1', '1', '王明', '1');
INSERT INTO `student_course` VALUES ('17', '高等数学', 'SSG567-789', '134', '1', '1', '王明', '1');
INSERT INTO `student_course` VALUES ('18', '大学物理', 'SSG-345', '134', '8', '2', '林伟', '0');
INSERT INTO `student_course` VALUES ('19', '大学物理', 'SSG-345', '137', '8', '2', '林伟', '0');
INSERT INTO `student_course` VALUES ('20', '高等数学', 'SSG567-789', '137', '1', '1', '王明', '1');
INSERT INTO `student_course` VALUES ('21', '大学物理', 'SSG-345', '140', '8', '2', '林伟', '1');
INSERT INTO `student_course` VALUES ('22', '高等数学', 'SSG567-789', '140', '1', '1', '王明', '0');

-- ----------------------------
-- Table structure for `teacher`
-- ----------------------------
DROP TABLE IF EXISTS `teacher`;
CREATE TABLE `teacher` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '学生ID',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '工号',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '密码',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '姓名',
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '手机号',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '邮箱',
  `sex` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '性别',
  `entry` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '鐢熸棩',
  `role` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '角色',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='教师信息';

-- ----------------------------
-- Records of teacher
-- ----------------------------
INSERT INTO `teacher` VALUES ('1', 'ttk', '555xxx', '王明', '000000', '222', '男', '1985.02.03', 'TEACHER');
INSERT INTO `teacher` VALUES ('2', 'ttk2', '555xxx', '林伟', '155xxxxxxxx', '暂无', '男', null, 'TEACHER');
