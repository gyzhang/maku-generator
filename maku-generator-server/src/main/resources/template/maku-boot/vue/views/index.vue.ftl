<script setup lang="ts">
import { ref } from "vue";
import { use${FunctionName}Hook } from "./utils/hook";
import { PureTableBar } from "@/components/RePureTableBar";
import { useRenderIcon } from "@/components/ReIcon/src/hooks";

import Search from "@iconify-icons/ep/search";
import Refresh from "@iconify-icons/ep/refresh";
import AddFill from "@iconify-icons/ri/add-circle-line";
import EditPen from "@iconify-icons/ep/edit-pen";
import Delete from "@iconify-icons/ep/delete";
import ${FunctionName}FormModal from "@/views/${moduleName}/${functionName}/${functionName}-form-modal.vue";
import { PostPageResponse } from "@/api/${moduleName}/${functionName}";
import { CommonUtils } from "@/utils/common";
import { useUserStoreHook } from "@/store/modules/user";

/** 组件name最好和菜单表中的router_name一致 */
defineOptions({
  name: "${FunctionName}"
});

const loginLogStatusList = useUserStoreHook().dictionaryList["common.status"];
const tableRef = ref();
const searchFormRef = ref();
const {
  searchFormParams,
  pageLoading,
  columns,
  dataList,
  pagination,
  timeRange,
  defaultSort,
  multipleSelection,
  onSearch,
  resetForm,
  onSortChanged,
  exportAllExcel,
  getPostList,
  handleDelete,
  handleBulkDelete
} = use${FunctionName}Hook();

const opType = ref<"add" | "update">("add");
const modalVisible = ref(false);
const opRow = ref<${FunctionName}PageResponse>();
function openDialog(type: "add" | "update", row?: ${FunctionName}PageResponse) {
  opType.value = type;
  opRow.value = row;
  modalVisible.value = true;
}
</script>

<template>
  <div class="main">
    <!-- 搜索栏 -->
    <el-form
      ref="searchFormRef"
      :inline="true"
      :model="searchFormParams"
      class="search-form bg-bg_color w-[99/100] pl-8 pt-[12px]"
    >
    <#list queryList as field>
      <el-form-item label="${field.fieldComment!}" prop="${field.attrName}">
      <#if field.queryFormType == 'text' || field.queryFormType == 'textarea' || field.queryFormType == 'editor'>
        <el-input
          v-model="searchFormParams.${field.attrName}"
          placeholder="请输入${field.fieldComment!}"
          clearable
          class="!w-[200px]">
        </el-input>
      <#elseif field.queryFormType == 'select'>
        <#if field.formDict??>
        <fast-select
          v-model="searchFormParams.${field.attrName}"
          dict-type="${field.formDict}"
          placeholder="请选择${field.fieldComment!}"
          clearable>
        </fast-select>
        <#else>
        <el-select
          v-model="searchFormParams.${field.attrName}"
          placeholder="请选择${field.fieldComment!}">
          <el-option label="选择" value="0"></el-option>
        </el-select>
        </#if>
      <#elseif field.queryFormType == 'radio'>
        <#if field.formDict??>
        <fast-radio-group
          v-model="searchFormParams.${field.attrName}"
          dict-type="${field.formDict}">
        </fast-radio-group>
        <#else>
        <el-radio-group
          v-model="searchFormParams.${field.attrName}">
          <el-radio :label="0">单选</el-radio>
        </el-radio-group>
        </#if>
      <#elseif field.queryFormType == 'date'>
        <el-date-picker
          v-model="searchFormParams.${field.attrName}"
          type="daterange"
          value-format="YYYY-MM-DD">
        </el-date-picker>
      <#elseif field.queryFormType == 'datetime'>
        <el-date-picker
          v-model="searchFormParams.${field.attrName}"
          type="datetimerange"
          value-format="YYYY-MM-DD HH:mm:ss">
        </el-date-picker>
      <#else>
        <el-input
          v-model="searchFormParams.${field.attrName}"
          placeholder="请输入${field.fieldComment!}">
        </el-input>
      </#if>
      </el-form-item>
      </#list>
      <el-form-item>
        <el-button
          type="primary"
          :icon="useRenderIcon(Search)"
          :loading="pageLoading"
          @click="onSearch(tableRef)"
        >
          搜索
        </el-button>
        <el-button
          :icon="useRenderIcon(Refresh)"
          @click="resetForm(searchFormRef, tableRef)"
        >
          重置
        </el-button>
      </el-form-item>
    </el-form>

    <PureTableBar title="${tableComment}列表" :columns="columns" @refresh="onSearch">
      <!-- 表格操作栏 -->
      <template #buttons>
        <el-button
          type="primary"
          :icon="useRenderIcon(AddFill)"
          @click="openDialog('add')"
        >
          新增${tableComment}
        </el-button>
        <el-button
          type="danger"
          :icon="useRenderIcon(Delete)"
          @click="handleBulkDelete(tableRef)"
        >
          批量删除
        </el-button>
        <el-button
          type="primary"
          @click="CommonUtils.exportExcel(columns, dataList, '${tableComment}列表(单页)')"
          >单页导出</el-button
        >
        <el-button type="primary" @click="exportAllExcel">全部导出</el-button>
      </template>
      <template v-slot="{ size, dynamicColumns }">
        <pure-table
          border
          ref="tableRef"
          align-whole="center"
          showOverflowTooltip
          table-layout="auto"
          :loading="pageLoading"
          :size="size"
          adaptive
          :data="dataList"
          :columns="dynamicColumns"
          :default-sort="defaultSort"
          :pagination="pagination"
          :paginationSmall="size === 'small' ? true : false"
          :header-cell-style="{
            background: 'var(--el-table-row-hover-bg-color)',
            color: 'var(--el-text-color-primary)'
          }"
          @page-size-change="get${FunctionName}List"
          @page-current-change="get${FunctionName}List"
          @sort-change="onSortChanged"
          @selection-change="
            rows => (multipleSelection = rows.map(item => item.postId))
          "
        >
          <template #operation="{ row }">
            <el-button
              class="reset-margin"
              link
              type="primary"
              :size="size"
              :icon="useRenderIcon(EditPen)"
              @click="openDialog('update', row)"
            >
              编辑
            </el-button>
            <el-popconfirm
              :title="`是否确认删除编号为${'$'}${'{'}row.<#list fieldList as field><#if field.primaryPk>${field.attrName}</#if></#list>${'}'}的这个${tableComment}？`"
              @confirm="handleDelete(row)"
            >
              <template #reference>
                <el-button
                  class="reset-margin"
                  link
                  type="danger"
                  :size="size"
                  :icon="useRenderIcon(Delete)"
                >
                  删除
                </el-button>
              </template>
            </el-popconfirm>
          </template>
        </pure-table>
      </template>
    </PureTableBar>

    <post-form-modal
      v-model="modalVisible"
      :type="opType"
      :row="opRow"
      @success="onSearch"
    />
  </div>
</template>

<style scoped lang="scss">
:deep(.el-dropdown-menu__item i) {
  margin: 0;
}

.search-form {
  :deep(.el-form-item) {
    margin-bottom: 12px;
  }
}
</style>
