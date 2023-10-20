# <font color="red">！！！非常重要，必须读我！！！</font>

代码生成器生成“${moduleName}”模块“${tableComment}(${functionName})”功能的代码文件（19个）清单如下：

```
|-->必须读我.md //是我，是我，还是我，这世间最闪亮的烟火🎇！就是你现在看到的这个文件呀~
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

  请求分为两类：一类是查询，一类是操作（新增和修改）：

- **查询**：${ClassName}Controller -> ${FunctionName}Query -> ${FunctionName}ApplicationService -> ${ClassName}Service -> ${ClassName}Mapper

- **操作**：${ClassName}Controller -> Add/Update${FunctionName}Command -> ${FunctionName}ApplicationService -> ${FunctionName}Model(处理逻辑) -> save/update (MyBatis-Plus的Model.insert/updateById)

以上是借鉴CQRS的开发理念，将查询和操作分开处理。操作类的业务实现借鉴了DDD战术设计的理念，使用领域类，工厂类更面向对象的实现逻辑。

## 1.2 Command和Query

代码生成器以CQRS理念，生成了两个操作命令（Add${FunctionName}Command和Update${FunctionName}Command）和一个查询（${FunctionName}Query）：

- Add${FunctionName}Command携带新增数据时的属性；

- Update${FunctionName}Command继承自Add${FunctionName}Command添加了主键属性，供修改时使用；

- ${FunctionName}Query携带了查询条件属性：如果查询条件增加了，需要在这里做调整。

需要说明的是：${FunctionName}Query.addQueryCondition()方法中设置了默认排序字段${functionName}_sort和时间/日期范围字段的this.setTimeRangeColumn("create_time")，以接收前端传来的时间/日期范围条件。

前端列表页面上的时间/日期范围条件示例代码如下，供参考：

```vue
      <el-form-item label="创建时间">
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

## 1.3 表${tableName}->实体${ClassName}Entity

如果${ClassName}Entity继承了`com.agileboot.common.core.base.BaseEntity`，则有可能在生成的代码中多导入`import java.util.Date;`

当前使用单一主键（<#list fieldList as field><#if field.primaryPk>${field.attrName}</#if></#list>）策略，多组合主键理论上支持，因为用不到没有测试。

## 1.4 数据传输对象DTO

${FunctionName}DTO.java，是用来做数据传输用的，构造方法`${FunctionName}DTO(${ClassName}Entity entity)`将从数据库中查询的一条记录构建为一个DTO，并在其属性上添加了@ExcelColumn注解，供Excel导出的时候读取信息给列命名。

需要注意的是，如果属性存放了字典类型的值（如状态1=有效）则需要自行处理，示例代码如下：

```java
    private Integer status;

    @ExcelColumn(name = "状态")
    private String statusStr;
```

代码生成器中做了简化，直接生成了固定的statusStr，请检查这个DTO类，为其他使用字典的属性做对应修改。

## 1.5 数据库操作

数据库操作由5个文件构成，Entity、Mapper、Mapper.xml、Service和ServiceImpl。

1、MyBatis的Mapper接口（${ClassName}Mapper.java）：众所周知，SQL相关的操作接口都在这里，扮演DAO的角色。由于继承于MyBatis的`BaseMapper<${ClassName}Entity>`，由MyBatis提供大量的CRUD操作，只需要添加那些业务相关的自定义SQL操作。

在一些较为简单的场景，可以直接将SQL写到接口上面并以@Select之类的注解标识：

```java
    @Select("SELECT p.* "
        + "FROM sys_post p "
        + " LEFT JOIN sys_user u ON p.post_id = u.post_id "
        + "WHERE u.user_id = ${'#'}${'{'}userId${'}'}"
        + " AND p.deleted = 0")
    List<SysPostEntity> getPostsByUserId(Long userId);
```

但是在较为复杂的场景中，还是建议将这些SQL语句分离到${ClassName}Mapper.xml中，以便更好的对业务逻辑进行管理。

2、MyBatis的Mapper XML（${ClassName}Mapper.xml）：AgileBoot平台是存放在`src/main/resources/mapper/${functionName}/${ClassName}Mapper.xml`位置的，为了方便管理，代码生成器建议存放在`/src/main/java/${packagePath}/domain/${moduleName}/${functionName}/db/${ClassName}Mapper.xml`。你的自定义SQL语句就写到这里。

例如在${ClassName}Mapper.java中定义了getByTableId接口：

```java
    List<TableFieldEntity> getByTableId(Long tableId);
```

在${ClassName}Mapper.xml中写getByTableId接口对应的SQL语句：

```xml
    <select id="getByTableId" resultType="${package}.domain.${moduleName}.${functionName}.db.TableFieldEntity">
        select *
        from gen_table_field
        where table_id = ${'#'}${'{'}tableId${'}'}
        order by sort
    </select>
```

3、数据库操作的服务由${ClassName}Service.java（接口）和${ClassName}ServiceImpl.java（实现）提供，请参考在其中生成的（被注释掉）示例代码，这些代码可以安全删除。

## 1.6 领域对象

领域对象中封装了绝大部分的业务逻辑，其中和数据库相关的操作会委托给注入的${ClassName}Service。

领域对象提供了2个构造方法：

- ${FunctionName}Model(${ClassName}Service ${functionName}Service)：用来返回一个全新新的领域对象，通常用在新增场景；

- ${FunctionName}Model(${ClassName}Entity entity, ${ClassName}Service ${functionName}Service)：通过数据库实体来返回一个已有的领域对象，通常用在修改场景。

在领域对象${FunctionName}Model中以注释的方式生成了示例代码（编码是否唯一、名称是否唯一、是否可以安全删除等3个方法，对应的数据库服务${ClassName}ServiceImpl中也是以注释的方法生成了示例代码），可供参考。

领域对象工厂${FunctionName}ModelFactory提供了2个方法来生产领域对象：

- ${FunctionName}Model create()：创建一个全新的领域对象，供新增使用；

- ${FunctionName}Model loadById(Long ${functionName}Id)：通过主键从数据库中装载信息来生产一个领域对象，供修改使用。

通常，应用服务中会使用领域对象工厂来生产领域对象。

## 1.7 应用服务

应用服务${FunctionName}ApplicationService是“${tableComment}”功能向外提供服务的统一出口，其内会根据新增、修改、查询、修改等操作来使用${ClassName}Service或${FunctionName}ModelFactory生产的${FunctionName}Model来编排服务。

例如删除功能先使用领域对象来检查是否可以删除，然后使用数据库服务${ClassName}Service来删除数据：

```java
    public void delete${FunctionName}(BulkOperationCommand<Long> deleteCommand) {
        for (Long id : deleteCommand.getIds()) {
            ${FunctionName}Model ${functionName}Model = ${functionName}ModelFactory.loadById(id);
            ${functionName}Model.checkCanBeDelete();
        }

        ${functionName}Service.removeBatchByIds(deleteCommand.getIds());
    }
```

## 1.8 控制器

@RestController注解标注的${ClassName}Controller响应前端请求，调用应用服务${FunctionName}ApplicationService的方法提供的服务。

前端请求参数封装成Add${FunctionName}Command（新增）、Update${FunctionName}Command（修改）、List<Long> ids（删除）或${FunctionName}Query（查询），来完成CRUD的请求服务。

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