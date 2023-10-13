import { http } from "@/utils/http";

export interface ${FunctionName}ListCommand extends BasePageQuery {
  ${functionName}Code?: string;
  ${functionName}Name?: string;
  status?: number;
}

export interface ${FunctionName}PageResponse {
  postId: number;
  postCode: string;
  postName: string;
  postSort: number;
  status: number;
  statusStr: string;
  remark: string;
  createTime: string;
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
  postCode: string;
  postName: string;
  postSort: number;
  remark?: string;
  status?: string;
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
