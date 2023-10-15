<script setup lang="ts">
import VDialog from "@/components/VDialog/VDialog.vue";
import { computed, reactive, ref } from "vue";
import {
  Add${FunctionName}Command,
  Update${FunctionName}Command,
  ${FunctionName}PageResponse,
  add${FunctionName}Api,
  update${FunctionName}Api
} from "@/api/${moduleName}/${functionName}";
import { useUserStoreHook } from "@/store/modules/user";
import { ElMessage, FormInstance, FormRules } from "element-plus";

interface Props {
  type: "add" | "update";
  modelValue: boolean;
  row?: ${FunctionName}PageResponse;
}

const props = defineProps<Props>();
const emits = defineEmits<{
  (e: "update:modelValue", v: boolean): void;
  (e: "success"): void;
}>();

const visible = computed({
  get: () => props.modelValue,
  set(v) {
    emits("update:modelValue", v);
  }
});

const formData = reactive<Add${FunctionName}Command | Update${FunctionName}Command>({
	<#list fieldList as field>
    <#if field.primaryPk>
  ${field.attrName}: <#if field.tsType?matches("number")>0<#else>""</#if>,
	  </#if>
	</#list>
  <#list formList as field>
  ${field.attrName}: <#if field.tsType?matches("number")>0<#else>""</#if><#sep>,</#sep>
  </#list>
});

const statusList = useUserStoreHook().dictionaryMap["common.status"];

const rules: FormRules = {
  <#list formList as field>
  <#if field.formRequired>
  ${field.attrName}: [
    {
      required: true,
      message: '${field.fieldComment}不能为空',
      trigger: 'blur'
    }
  ]<#sep>,</#sep>
  </#if>
  </#list>
};
const formRef = ref<FormInstance>();
function handleOpened() {
  if (props.row) {
    Object.assign(formData, props.row);
  } else {
    formRef.value?.resetFields();
  }
}

const loading = ref(false);
async function handleConfirm() {
  try {
    loading.value = true;
    if (props.type === "add") {
      await add${FunctionName}Api(formData);
    } else if (props.type === "update") {
      await update${FunctionName}Api(formData as Update${FunctionName}Command);
    }
    ElMessage.info("提交成功");
    visible.value = false;
    emits("success");
  } catch (e) {
    console.error(e);
    ElMessage.error((e as Error)?.message || "提交失败");
  } finally {
    loading.value = false;
  }
}
</script>

<template>
  <v-dialog
    show-full-screen
    :fixed-body-height="false"
    use-body-scrolling
    :title="type === 'add' ? '新增${tableComment}' : '修改${tableComment}'"
    v-model="visible"
    :loading="loading"
    @confirm="handleConfirm"
    @cancel="visible = false"
    @opened="handleOpened"
  >
    <el-form :model="formData" label-width="120px" :rules="rules" ref="formRef">
	    <#list formList as field>
			<#if field.formType == 'text'>
				<el-form-item label="${field.fieldComment!}" prop="${field.attrName}"<#if field.formRequired> required</#if>>
					<el-input v-model="formData.${field.attrName}" placeholder="${field.fieldComment!}"></el-input>
				</el-form-item>
			<#elseif field.formType == 'textarea'>
				<el-form-item label="${field.fieldComment!}" prop="${field.attrName}"<#if field.formRequired> required</#if>>
					<el-input type="textarea" v-model="formData.${field.attrName}"></el-input>
				</el-form-item>
			<#elseif field.formType == 'editor'>
				<el-form-item label="${field.fieldComment!}" prop="${field.attrName}"<#if field.formRequired> required</#if>>
					<el-input type="textarea" v-model="formData.${field.attrName}"></el-input>
				</el-form-item>
			<#elseif field.formType == 'select'>
				<#if field.formDict??>
					<el-form-item label="${field.fieldComment!}" prop="${field.attrName}"<#if field.formRequired> required</#if>>
						<fast-select v-model="formData.${field.attrName}" dict-type="${field.formDict}" placeholder="${field.fieldComment!}"></fast-select>
					</el-form-item>
				<#else>
					<el-form-item label="${field.fieldComment!}" prop="${field.attrName}"<#if field.formRequired> required</#if>>
						<el-select v-model="formData.${field.attrName}" placeholder="请选择">
							<el-option label="请选择" value="0"></el-option>
						</el-select>
					</el-form-item>
				</#if>
			<#elseif field.formType == 'radio'>
				<#if field.formDict??>
					<el-form-item label="${field.fieldComment!}" prop="${field.attrName}"<#if field.formRequired> required</#if>>
						<fast-radio-group v-model="formData.${field.attrName}" dict-type="${field.formDict}"></fast-radio-group>
					</el-form-item>
				<#else>
					<el-form-item label="${field.fieldComment!}" prop="${field.attrName}"<#if field.formRequired> required</#if>>
						<el-radio-group v-model="formData.${field.attrName}">
							<el-radio :label="0">启用</el-radio>
							<el-radio :label="1">禁用</el-radio>
						</el-radio-group>
					</el-form-item>
				</#if>
			<#elseif field.formType == 'checkbox'>
				<el-form-item label="${field.fieldComment!}" prop="${field.attrName}"<#if field.formRequired> required</#if>>
					<el-checkbox-group v-model="formData.${field.attrName}">
						<el-checkbox label="启用" name="type"></el-checkbox>
						<el-checkbox label="禁用" name="type"></el-checkbox>
					</el-checkbox-group>
				</el-form-item>
			<#elseif field.formType == 'date'>
				<el-form-item label="${field.fieldComment!}" prop="${field.attrName}"<#if field.formRequired> required</#if>>
					<el-date-picker type="date" placeholder="${field.fieldComment!}" v-model="formData.${field.attrName}"></el-date-picker>
				</el-form-item>
			<#elseif field.formType == 'datetime'>
				<el-form-item label="${field.fieldComment!}" prop="${field.attrName}"<#if field.formRequired> required</#if>>
					<el-date-picker type="datetime" placeholder="${field.fieldComment!}" v-model="formData.${field.attrName}"></el-date-picker>
				</el-form-item>
			<#else>
				<el-form-item label="${field.fieldComment!}" prop="${field.attrName}"<#if field.formRequired> required</#if>>
					<el-input v-model="formData.${field.attrName}" placeholder="${field.fieldComment!}"></el-input>
				</el-form-item>
			</#if>
	    </#list>
    </el-form>
  </v-dialog>
</template>
