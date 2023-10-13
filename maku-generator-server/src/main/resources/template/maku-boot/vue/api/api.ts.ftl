import { http } from "@/utils/http";

export interface ${FunctionName}ListCommand extends BasePageQuery {
  <#list queryList as param>
  ${param.attrName}?: ${param.tsType};
  </#list>
}

export interface ${FunctionName}PageResponse {
  <#list fieldList as field>
    <#if !field.baseField>
  ${field.attrName}: ${field.tsType};
    </#if>
  </#list>
}

export function get${FunctionName}ListApi(params: ${FunctionName}ListCommand) {
  return http.request<ResponseData<PageDTO<${FunctionName}PageResponse>>>(
    "get",
    "/${moduleName}/${functionName}/list",
    {
      params
    }
  );
}

export const export${FunctionName}ExcelApi = (
  params: ${FunctionName}ListCommand,
  fileName: string
) => {
  return http.download("/${moduleName}/${functionName}/excel", fileName, {
    params
  });
};

export const delete${FunctionName}Api = (data: Array<number>) => {
  return http.request<ResponseData<void>>("delete", "/${moduleName}/${functionName}", {
    params: {
      ids: data.toString()
    }
  });
};

export interface Add${FunctionName}Command {
  <#list formList as field>
  ${field.attrName}: ${field.tsType};
  </#list>
}

export const add${FunctionName}Api = (data: Add${FunctionName}Command) => {
  return http.request<ResponseData<void>>("post", "/${moduleName}/${functionName}", {
    data
  });
};

export interface Update${FunctionName}Command extends Add${FunctionName}Command {
  ${functionName}Id: number;
}

export const update${FunctionName}Api = (data: Update${FunctionName}Command) => {
  return http.request<ResponseData<void>>("put", "/${moduleName}/${functionName}", {
    data
  });
};
