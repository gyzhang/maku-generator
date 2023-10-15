import dayjs from "dayjs";
import { message } from "@/utils/message";
import { ElMessageBox, Sort } from "element-plus";
import { reactive, ref, onMounted, toRaw, computed } from "vue";
import { useUserStoreHook } from "@/store/modules/user";
import { CommonUtils } from "@/utils/common";
import { PaginationProps } from "@pureadmin/table";
import {
  ${FunctionName}ListCommand,
  get${FunctionName}ListApi,
  export${FunctionName}ExcelApi,
  delete${FunctionName}Api
} from "@/api/${moduleName}/${functionName}";

const statusMap = useUserStoreHook().dictionaryMap["common.status"];

export function use${FunctionName}Hook() {
  const defaultSort: Sort = {
    prop: "${functionName}Sort",
    order: "ascending"
  };

  const pagination: PaginationProps = {
    total: 0,
    pageSize: 10,
    currentPage: 1,
    background: true
  };

  const timeRange = computed<[string, string] | null>({
    get() {
      if (searchFormParams.beginTime && searchFormParams.endTime) {
        return [searchFormParams.beginTime, searchFormParams.endTime];
      } else {
        return null;
      }
    },
    set(v) {
      if (v?.length === 2) {
        searchFormParams.beginTime = v[0];
        searchFormParams.endTime = v[1];
      } else {
        searchFormParams.beginTime = undefined;
        searchFormParams.endTime = undefined;
      }
    }
  });

  const searchFormParams = reactive<${FunctionName}ListCommand>({
    <#list queryList as field>
    ${field.attrName}: <#if field.tsType?matches("number")>0<#else>""</#if><#sep>,</#sep>
    </#list>
  });

  const dataList = ref([]);
  const pageLoading = ref(true);
  const multipleSelection = ref([]);
  const sortState = ref<Sort>(defaultSort);

  const columns: TableColumnList = [
    {
      type: "selection",
      align: "left"
    },
    <#list gridList as field>
    {
      label: "${field.fieldComment!}",
      prop: "${field.attrName}",
      <#if field.gridSort>
      sortable: "custom",
      </#if>
      minWidth: 100
    },
    </#list>
    {
      label: "操作",
      fixed: "right",
      width: 140,
      slot: "operation"
    }
  ];

  function onSortChanged(sort: Sort) {
    sortState.value = sort;
    pagination.currentPage = 1;
    get${FunctionName}List();
  }

  async function onSearch(tableRef) {
    tableRef.getTableRef().sort("${functionName}Sort", "ascending");
  }

  function resetForm(formEl, tableRef) {
    if (!formEl) return;
    formEl.resetFields();
    searchFormParams.beginTime = undefined;
    searchFormParams.endTime = undefined;
    onSearch(tableRef);
  }

  async function get${FunctionName}List() {
    pageLoading.value = true;
    CommonUtils.fillSortParams(searchFormParams, sortState.value);
    CommonUtils.fillPaginationParams(searchFormParams, pagination);

    const { data } = await get${FunctionName}ListApi(toRaw(searchFormParams)).finally(
      () => {
        pageLoading.value = false;
      }
    );
    dataList.value = data.rows;
    pagination.total = data.total;
  }

  async function exportAllExcel() {
    if (sortState.value != null) {
      CommonUtils.fillSortParams(searchFormParams, sortState.value);
    }
    CommonUtils.fillPaginationParams(searchFormParams, pagination);
    CommonUtils.fillTimeRangeParams(searchFormParams, timeRange.value);

    export${FunctionName}ExcelApi(toRaw(searchFormParams), "${tableComment}列表(全部).xlsx");
  }

  async function handleDelete(row) {
    await delete${FunctionName}Api([row.<#list fieldList as field><#if field.primaryPk>${field.attrName}</#if></#list>]).then(() => {
      message(`您删除了编号为${'$'}${'{'}row.<#list fieldList as field><#if field.primaryPk>${field.attrName}</#if></#list>${'}'}的这条${tableComment}数据`, {
        type: "success"
      });
      get${FunctionName}List();
    });
  }

  async function handleBulkDelete(tableRef) {
    if (multipleSelection.value.length === 0) {
      message("请选择需要删除的数据", { type: "warning" });
      return;
    }

    ElMessageBox.confirm(
      `确认要<strong style='color:var(--el-color-danger)'>删除</strong>编号为<strong style='color:var(--el-color-primary)'>[ ${'$'}${'{'}multipleSelection.value${'}'} ]</strong>的${tableComment}数据吗?`,
      "系统提示",
      {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning",
        dangerouslyUseHTMLString: true,
        draggable: true
      }
    )
      .then(async () => {
        await delete${FunctionName}Api(multipleSelection.value).then(() => {
          message(`您删除了编号为[ ${'$'}${'{'}multipleSelection.value${'}'} ]的${tableComment}数据`, {
            type: "success"
          });
          get${FunctionName}List();
        });
      })
      .catch(() => {
        message("取消删除", {
          type: "info"
        });
        tableRef.getTableRef().clearSelection();
      });
  }

  onMounted(get${FunctionName}List);

  return {
    searchFormParams,
    pageLoading,
    columns,
    dataList,
    pagination,
    defaultSort,
    timeRange,
    multipleSelection,
    onSearch,
    onSortChanged,
    exportAllExcel,
    get${FunctionName}List,
    resetForm,
    handleDelete,
    handleBulkDelete
  };
}
