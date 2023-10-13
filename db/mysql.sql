/*
 Navicat Premium Data Transfer

 Source Server         : MySQL@localhost
 Source Server Type    : MySQL
 Source Server Version : 80032 (8.0.32)
 Source Host           : localhost:3306
 Source Schema         : maku_generator

 Target Server Type    : MySQL
 Target Server Version : 80032 (8.0.32)
 File Encoding         : 65001

 Date: 11/10/2023 10:18:18
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

DROP DATABASE IF EXISTS maku_generator;
CREATE DATABASE maku_generator;
USE maku_generator;

-- ----------------------------
-- Table structure for gen_base_class
-- ----------------------------
DROP TABLE IF EXISTS `gen_base_class`;
CREATE TABLE `gen_base_class`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `package_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '基类包名',
  `code` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '基类编码',
  `fields` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '基类字段，多个用英文逗号分隔',
  `remark` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '基类管理' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of gen_base_class
-- ----------------------------
INSERT INTO `gen_base_class` VALUES (1, 'com.agileboot.common.core.base', 'BaseEntity', 'creator_id,create_time,updater_id,update_time,deleted', '继承自该基类，则需要表里有这些公共字段', '2023-05-25 05:25:25');

-- ----------------------------
-- Table structure for gen_datasource
-- ----------------------------
DROP TABLE IF EXISTS `gen_datasource`;
CREATE TABLE `gen_datasource`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `db_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '数据库类型',
  `conn_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '连接名',
  `conn_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'URL',
  `username` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '用户名',
  `password` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '密码',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '数据源管理' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of gen_datasource
-- ----------------------------
INSERT INTO `gen_datasource` VALUES (1, 'MySQL', 'agileboot-pure', 'jdbc:mysql://localhost:3306/agileboot-pure?useUnicode=true&characterEncoding=UTF-8&serverTimezone=Asia/Shanghai&nullCatalogMeansCurrent=true', 'root', '123456', '2023-05-25 05:25:25');

-- ----------------------------
-- Table structure for gen_field_type
-- ----------------------------
DROP TABLE IF EXISTS `gen_field_type`;
CREATE TABLE `gen_field_type`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `column_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '字段类型',
  `attr_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '属性类型',
  `ts_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '前端类型',
  `package_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '属性包名',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `column_type`(`column_type` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 32 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '字段类型管理' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of gen_field_type
-- ----------------------------
INSERT INTO `gen_field_type` VALUES (1, 'datetime', 'Date', 'string', 'java.util.Date', '2023-10-11 10:37:19');
INSERT INTO `gen_field_type` VALUES (2, 'date', 'Date', 'string', 'java.util.Date', '2023-10-11 10:37:19');
INSERT INTO `gen_field_type` VALUES (3, 'tinyint', 'Integer', 'number', NULL, '2023-10-11 10:37:19');
INSERT INTO `gen_field_type` VALUES (4, 'smallint', 'Integer', 'number', NULL, '2023-10-11 10:37:19');
INSERT INTO `gen_field_type` VALUES (5, 'mediumint', 'Integer', 'number', NULL, '2023-10-11 10:37:19');
INSERT INTO `gen_field_type` VALUES (6, 'int', 'Integer', 'number', NULL, '2023-10-11 10:37:19');
INSERT INTO `gen_field_type` VALUES (7, 'integer', 'Integer', 'number', NULL, '2023-10-11 10:37:19');
INSERT INTO `gen_field_type` VALUES (8, 'bigint', 'Long', 'number', NULL, '2023-10-11 10:37:19');
INSERT INTO `gen_field_type` VALUES (9, 'float', 'Float', 'number', NULL, '2023-10-11 10:37:19');
INSERT INTO `gen_field_type` VALUES (10, 'double', 'Double', 'number', NULL, '2023-10-11 10:37:19');
INSERT INTO `gen_field_type` VALUES (11, 'decimal', 'BigDecimal', 'number', 'java.math.BigDecimal', '2023-10-11 10:37:19');
INSERT INTO `gen_field_type` VALUES (12, 'bit', 'Boolean', 'boolean', NULL, '2023-10-11 10:37:19');
INSERT INTO `gen_field_type` VALUES (13, 'char', 'String', 'string', NULL, '2023-10-11 10:37:19');
INSERT INTO `gen_field_type` VALUES (14, 'varchar', 'String', 'string', NULL, '2023-10-11 10:37:19');
INSERT INTO `gen_field_type` VALUES (15, 'tinytext', 'String', 'string', NULL, '2023-10-11 10:37:19');
INSERT INTO `gen_field_type` VALUES (16, 'text', 'String', 'string', NULL, '2023-10-11 10:37:19');
INSERT INTO `gen_field_type` VALUES (17, 'mediumtext', 'String', 'string', NULL, '2023-10-11 10:37:19');
INSERT INTO `gen_field_type` VALUES (18, 'longtext', 'String', 'string', NULL, '2023-10-11 10:37:19');
INSERT INTO `gen_field_type` VALUES (19, 'timestamp', 'Date', 'string', 'java.util.Date', '2023-10-11 10:37:19');
INSERT INTO `gen_field_type` VALUES (20, 'NUMBER', 'Integer', 'number', NULL, '2023-10-11 10:37:19');
INSERT INTO `gen_field_type` VALUES (21, 'BINARY_INTEGER', 'Integer', 'number', NULL, '2023-10-11 10:37:19');
INSERT INTO `gen_field_type` VALUES (22, 'BINARY_FLOAT', 'Float', 'number', NULL, '2023-10-11 10:37:19');
INSERT INTO `gen_field_type` VALUES (23, 'BINARY_DOUBLE', 'Double', 'number', NULL, '2023-10-11 10:37:19');
INSERT INTO `gen_field_type` VALUES (24, 'VARCHAR2', 'String', 'string', NULL, '2023-10-11 10:37:19');
INSERT INTO `gen_field_type` VALUES (25, 'NVARCHAR', 'String', 'string', NULL, '2023-10-11 10:37:19');
INSERT INTO `gen_field_type` VALUES (26, 'NVARCHAR2', 'String', 'string', NULL, '2023-10-11 10:37:19');
INSERT INTO `gen_field_type` VALUES (27, 'CLOB', 'String', 'string', NULL, '2023-10-11 10:37:19');
INSERT INTO `gen_field_type` VALUES (28, 'int8', 'Long', 'number', NULL, '2023-10-11 10:37:19');
INSERT INTO `gen_field_type` VALUES (29, 'int4', 'Integer', 'number', NULL, '2023-10-11 10:37:19');
INSERT INTO `gen_field_type` VALUES (30, 'int2', 'Integer', 'number', NULL, '2023-10-11 10:37:19');
INSERT INTO `gen_field_type` VALUES (31, 'numeric', 'BigDecimal', 'number', 'java.math.BigDecimal', '2023-10-11 10:37:19');

-- ----------------------------
-- Table structure for gen_project_modify
-- ----------------------------
DROP TABLE IF EXISTS `gen_project_modify`;
CREATE TABLE `gen_project_modify`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `project_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '项目名',
  `project_code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '项目标识',
  `project_package` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '项目包名',
  `project_path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '项目路径',
  `modify_project_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '变更项目名',
  `modify_project_code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '变更标识',
  `modify_project_package` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '变更包名',
  `exclusions` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '排除文件',
  `modify_suffix` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '变更文件',
  `modify_tmp_path` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '变更临时路径',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '项目名变更' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of gen_project_modify
-- ----------------------------
INSERT INTO `gen_project_modify` VALUES (1, 'AgileBoot', 'agile', 'com.agileboot', 'D:/xprogrammer/agile-boot', 'baba-boot', 'baba', 'com.baba', '.git,.idea,target,logs', 'java,xml,yml,txt', NULL, '2023-05-25 05:25:25');

-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
DROP TABLE IF EXISTS `gen_table`;
CREATE TABLE `gen_table`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `table_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '表名',
  `class_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '类名',
  `table_comment` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '说明',
  `author` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '作者',
  `email` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '邮箱',
  `package_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '项目包名',
  `version` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '项目版本号',
  `generator_type` tinyint NULL DEFAULT NULL COMMENT '生成方式  0：zip压缩包   1：自定义目录',
  `backend_path` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '后端生成路径',
  `backend_path_admin` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '后端生成路径admin',
  `backend_path_domain` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '后端生成路径domain',
  `frontend_path` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '前端生成路径',
  `module_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '模块名',
  `function_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '功能名',
  `form_layout` tinyint NULL DEFAULT NULL COMMENT '表单布局  1：一列   2：两列',
  `datasource_id` bigint NULL DEFAULT NULL COMMENT '数据源ID',
  `baseclass_id` bigint NULL DEFAULT NULL COMMENT '基类ID',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `table_name`(`table_name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '代码生成表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of gen_table
-- ----------------------------
INSERT INTO `gen_table` VALUES (1, 'sys_post', 'SysPost', '岗位', 'Kevin Zhang', 'xprogrammer@163.com', 'com.agileboot', '1.0.0', 0, 'D:\\generator\\maku-boot\\maku-server', 'D:\\generator\\AgileBoot-Back-End\\agileboot-admin', 'D:\\generator\\AgileBoot-Back-End\\agileboot-domain', 'D:\\generator\\AgileBoot-Front-End', 'system', 'post', 1, 1, 1, '2023-05-25 05:25:25');

-- ----------------------------
-- Table structure for gen_table_field
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_field`;
CREATE TABLE `gen_table_field`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `table_id` bigint NULL DEFAULT NULL COMMENT '表ID',
  `field_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '字段名称',
  `field_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '字段类型',
  `field_comment` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '字段说明',
  `attr_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '属性名',
  `attr_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '属性类型',
  `ts_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '前端类型',
  `package_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '属性包名',
  `sort` int NULL DEFAULT NULL COMMENT '排序',
  `auto_fill` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '自动填充  DEFAULT、INSERT、UPDATE、INSERT_UPDATE',
  `primary_pk` tinyint NULL DEFAULT NULL COMMENT '主键 0：否  1：是',
  `base_field` tinyint NULL DEFAULT NULL COMMENT '基类字段 0：否  1：是',
  `form_item` tinyint NULL DEFAULT NULL COMMENT '表单项 0：否  1：是',
  `form_required` tinyint NULL DEFAULT NULL COMMENT '表单必填 0：否  1：是',
  `form_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '表单类型',
  `form_dict` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '表单字典类型',
  `form_validator` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '表单效验',
  `grid_item` tinyint NULL DEFAULT NULL COMMENT '列表项 0：否  1：是',
  `grid_sort` tinyint NULL DEFAULT NULL COMMENT '列表排序 0：否  1：是',
  `query_item` tinyint NULL DEFAULT NULL COMMENT '查询项 0：否  1：是',
  `query_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '查询方式',
  `query_form_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '查询表单类型',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '代码生成表字段' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of gen_table_field
-- ----------------------------
INSERT INTO `gen_table_field` VALUES (1, 1, 'post_id', 'bigint', '岗位ID', 'postId', 'Long', 'number', NULL, 0, 'DEFAULT', 1, 0, 0, 0, 'text', NULL, NULL, 0, 0, 0, '=', 'text');
INSERT INTO `gen_table_field` VALUES (2, 1, 'post_code', 'varchar', '岗位编码', 'postCode', 'String', 'string', NULL, 1, 'DEFAULT', 0, 0, 1, 0, 'text', NULL, NULL, 1, 0, 1, '=', 'text');
INSERT INTO `gen_table_field` VALUES (3, 1, 'post_name', 'varchar', '岗位名称', 'postName', 'String', 'string', NULL, 2, 'DEFAULT', 0, 0, 1, 0, 'text', NULL, NULL, 1, 0, 1, '=', 'text');
INSERT INTO `gen_table_field` VALUES (4, 1, 'post_sort', 'int', '显示顺序', 'postSort', 'Integer', 'number', NULL, 3, 'DEFAULT', 0, 0, 1, 0, 'text', NULL, NULL, 1, 0, 0, '=', 'text');
INSERT INTO `gen_table_field` VALUES (5, 1, 'status', 'smallint', '状态（1正常 0停用）', 'status', 'Integer', 'number', NULL, 4, 'DEFAULT', 0, 0, 1, 0, 'text', NULL, NULL, 1, 0, 1, '=', 'text');
INSERT INTO `gen_table_field` VALUES (6, 1, 'remark', 'varchar', '备注', 'remark', 'String', 'string', NULL, 5, 'DEFAULT', 0, 0, 1, 0, 'text', NULL, NULL, 1, 0, 0, '=', 'text');
INSERT INTO `gen_table_field` VALUES (7, 1, 'creator_id', 'bigint', '', 'creatorId', 'Long', 'number', NULL, 6, 'DEFAULT', 0, 0, 0, 0, 'text', NULL, NULL, 0, 0, 0, '=', 'text');
INSERT INTO `gen_table_field` VALUES (8, 1, 'create_time', 'datetime', '创建时间', 'createTime', 'Date', 'string', 'java.util.Date', 7, 'DEFAULT', 0, 0, 0, 0, 'text', NULL, NULL, 1, 0, 1, '=', 'text');
INSERT INTO `gen_table_field` VALUES (9, 1, 'updater_id', 'bigint', '', 'updaterId', 'Long', 'number', NULL, 8, 'DEFAULT', 0, 0, 0, 0, 'text', NULL, NULL, 0, 0, 0, '=', 'text');
INSERT INTO `gen_table_field` VALUES (10, 1, 'update_time', 'datetime', '更新时间', 'updateTime', 'Date', 'string', 'java.util.Date', 9, 'DEFAULT', 0, 0, 0, 0, 'text', NULL, NULL, 0, 0, 0, '=', 'text');
INSERT INTO `gen_table_field` VALUES (11, 1, 'deleted', 'tinyint', '逻辑删除', 'deleted', 'Integer', 'number', NULL, 10, 'DEFAULT', 0, 0, 0, 0, 'text', NULL, NULL, 0, 0, 0, '=', 'text');

-- ----------------------------
-- Table structure for gen_test_student
-- ----------------------------
DROP TABLE IF EXISTS `gen_test_student`;
CREATE TABLE `gen_test_student`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '学生ID',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '姓名',
  `gender` tinyint NULL DEFAULT NULL COMMENT '性别',
  `age` int NULL DEFAULT NULL COMMENT '年龄',
  `class_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '班级',
  `version` int NULL DEFAULT NULL COMMENT '版本号',
  `deleted` tinyint NULL DEFAULT NULL COMMENT '删除标识',
  `creator` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `updater` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '测试2' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of gen_test_student
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
