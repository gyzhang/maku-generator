！！！非常重要，必须读我！！！
！！！非常重要，必须读我！！！
！！！非常重要，必须读我！！！

以下是代码生成器生成代码后需要注意或修改的地方，请参照以下提示对生成的代码进行微调，以符合你的项目。

0、后端代码流转说明：
  请求分为两类：一类是查询，一类是操作（即对数据有进行更新）。
  **查询**：${ClassName}Controller -> ${FunctionName}Query -> ${FunctionName}ApplicationService -> ${ClassName}Service -> ${ClassName}Mapper
  **操作**：${ClassName}Controller -> Add/Update${FunctionName}Command -> ${FunctionName}ApplicationService -> ${FunctionName}Model(处理逻辑) -> save/update (MyBatis-Plus的Model.insert/updateById)
  以上是借鉴CQRS的开发理念，将查询和操作分开处理。操作类的业务实现借鉴了DDD战术设计的理念，使用领域类，工厂类更面向对象的实现逻辑。

1、


10、前端代码[查询条件->状态.下拉框]参考(/src/views/${moduleName}/${functionName}/index.vue)：
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
11、前端代码[查询条件->创建日期.日期范围]参考(/src/views/${moduleName}/${functionName}/index.vue)：
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
12、前端代码[表格中显示状态列]参考(/src/views/${moduleName}/${functionName}/utils/hook.tsx)：
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
12、前端代码[表格中创建时间列]参考(/src/views/${moduleName}/${functionName}/utils/hook.tsx)：
    {
      label: "创建时间",
      minWidth: 160,
      prop: "createTime",
      sortable: "custom",
      formatter: ({ createTime }) =>
        dayjs(createTime).format("YYYY-MM-DD HH:mm:ss")
    },
13、前端代码[新增修改中选择状态]参考(/src/views/${moduleName}/${functionName}/${functionName}-form-modal.vue)：
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
