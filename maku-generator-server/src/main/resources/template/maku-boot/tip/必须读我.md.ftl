# ！！！非常重要，必须读我！！！

## ！！！非常重要，必须读我！！！

### ！！！非常重要，必须读我！！！

代码生成器生成的代码文件（19个）清单如下：

```
|   必须读我.md //是我，是我，还是我，最闪亮的烟火🎇！就是你现在看到的这个文件
|
+---AgileBoot-Back-End
|   +---agileboot-admin
|   |   \---src
|   |       \---main
|   |           \---java
|   |               \---com
|   |                   \---agileboot
|   |                       \---admin
|   |                           \---controller
|   |                               \---${moduleName}
|   |                                       ${ClassName}Controller.java //控制器
|   |
|   \---agileboot-domain
|       \---src
|           \---main
|               \---java
|                   \---com
|                       \---agileboot
|                           \---domain
|                               \---${moduleName}
|                                   \---${functionName}
|                                       |   ${FunctionName}ApplicationService.java //应用服务
|                                       |
|                                       +---command
|                                       |       Add${FunctionName}Command.java //新增命令
|                                       |       Update${FunctionName}Command.java //修改命令
|                                       |
|                                       +---db
|                                       |       ${ClassName}Entity.java //实体，对应数据库表
|                                       |       ${ClassName}Mapper.java //DAO，MyBatis的Mapper
|                                       |       ${ClassName}Mapper.xml //Mapper对应的xml文件，自定义的SQL语句写到这里
|                                       |       ${ClassName}Service.java //服务类接口，面向数据库操作的功能写到这里 
|                                       |       ${ClassName}ServiceImpl.java //服务类实现
|                                       |
|                                       +---dto
|                                       |       ${FunctionName}DTO.java //数据传输对象
|                                       |
|                                       +---model
|                                       |       ${FunctionName}Model.java //领域实体，主要的业务逻辑都内聚在这里
|                                       |       ${FunctionName}ModelFactory.java //领域实体的工厂类
|                                       |
|                                       \---query
|                                               ${FunctionName}Query.java //查询类，内置了默认排序（${functionName}_sort）和日期范围字段（create_time）
|
+---AgileBoot-Front-End
|   \---src
|       +---api
|       |   \---${moduleName}
|       |           ${functionName}.ts //后台通讯API
|       |
|       \---views
|           \---${moduleName}
|               \---${functionName}
|                   |   ${functionName}-form-modal.vue //新增、修改窗口页面
|                   |   index.vue //列表页面
|                   |
|                   \---utils
|                           hook.tsx //列表页面配套的脚本文件
|
\---sql
    \---${moduleName}
        \---${functionName}
                menu4${functionName}.sql //${functionName}功能对应的菜单表初始化脚本
```

以下是代码生成器生成代码后需要注意或修改的地方，请参照以下提示对生成的代码进行微调，以符合你的项目。

# 1 后端代码

## 1.1 代码流转说明

  请求分为两类：一类是查询，一类是操作（即对数据有进行更新）：

- **查询**：${ClassName}Controller -> ${FunctionName}Query -> ${FunctionName}ApplicationService -> ${ClassName}Service -> ${ClassName}Mapper

- **操作**：${ClassName}Controller -> Add/Update${FunctionName}Command -> ${FunctionName}ApplicationService -> ${FunctionName}Model(处理逻辑) -> save/update (MyBatis-Plus的Model.insert/updateById)

以上是借鉴CQRS的开发理念，将查询和操作分开处理。操作类的业务实现借鉴了DDD战术设计的理念，使用领域类，工厂类更面向对象的实现逻辑。

## 1.2 

# 2 前端代码

## 2.1 查询条件“状态”.下拉框

代码位置 `/src/views/${moduleName}/${functionName}/index.vue`：

```vue
      <el-form-item label="状态" prop="status">
        <el-select
          v-model="searchFormParams.status"
          placeholder="请选择状态"
          clearable
          class="!w-[180px]"
        >
          <el-option
            v-for="dict in loginLogStatusList"
            :key="dict.value"
            :label="dict.label"
            :value="dict.value"
          />
        </el-select>
      </el-form-item>
```

## 2.2 查询条件“创建日期”.日期范围

代码位置 `/src/views/${moduleName}/${functionName}/index.vue`：

```vue
      <el-form-item label="创建日期">
        <el-date-picker
          class="!w-[240px]"
          v-model="timeRange"
          value-format="YYYY-MM-DD"
          type="daterange"
          range-separator="-"
          start-placeholder="开始日期"
          end-placeholder="结束日期"
        />
      </el-form-item>
```

## 2.3 表格中显示“状态”列

代码位置 `/src/views/${moduleName}/${functionName}/utils/hook.tsx`：

```json
    {
      label: "状态",
      prop: "status",
      minWidth: 120,
      cellRenderer: ({ row, props }) => (
        <el-tag
          size={props.size}
          type={statusMap[row.status].cssTag}
          effect="plain"
        >
          {statusMap[row.status].label}
        </el-tag>
      )
    },
```

## 2.4 表格中“创建时间”列

代码位置 `/src/views/${moduleName}/${functionName}/utils/hook.tsx`：

```json
    {
      label: "创建时间",
      minWidth: 160,
      prop: "createTime",
      sortable: "custom",
      formatter: ({ createTime }) =>
        dayjs(createTime).format("YYYY-MM-DD HH:mm:ss")
    },
```

## 2.5 新增修改中“状态”.单选组

代码位置 `/src/views/${moduleName}/${functionName}/${functionName}-form-modal.vue`：

```vue
      <el-form-item prop="status" label="状态">
        <el-radio-group v-model="formData.status">
          <el-radio
            v-for="item in Object.keys(statusList)"
            :key="item"
            :label="statusList[item].value"
            >{{ statusList[item].label }}</el-radio
          >
        </el-radio-group>
      </el-form-item>
```

# 以上信息供参考

代码生成器只生成基础的 CRUD 骨架代码，较为复杂的代码生成还在继续完善中，请根据你的项目实际情况对生成的代码做修改。

以下是代码生成器适配的一个标准的 MySQL 数据库表 sys_demo：

- 模块=**system**
- 功能名=**demo**
- 类名=**SysDemo**
- 继承=**BaseEntity**，含 `creator_id,create_time,updater_id,update_time,deleted` 这5个字段
- 主键=**功能名_id**，整型自增长
- 显示顺序=**功能名_sort**，默认排序用到，如果不是这个命名规范，则需要修改代码
- 说明=**演示**

```sql
DROP TABLE IF EXISTS `sys_demo`;
CREATE TABLE `sys_demo`  (
  `demo_id` bigint NOT NULL AUTO_INCREMENT COMMENT '演示ID',
  `demo_code` varchar(64) NOT NULL COMMENT '演示编码',
  `demo_name` varchar(64) NOT NULL COMMENT '演示名称',
  `demo_sort` int NOT NULL COMMENT '显示顺序',
  `status` smallint NOT NULL COMMENT '状态（1正常 0停用）',
  `remark` varchar(512) NULL DEFAULT NULL COMMENT '备注',
  `creator_id` bigint NULL DEFAULT NULL COMMENT '创建人ID',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `updater_id` bigint NULL DEFAULT NULL COMMENT '修改人ID',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '逻辑删除',
  PRIMARY KEY (`demo_id`) USING BTREE
) ENGINE = InnoDB COMMENT = '演示';
```

${author} ${email} v${version} ${date}