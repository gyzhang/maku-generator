package ${package}.domain.${moduleName}.${functionName}.db;

import com.baomidou.mybatisplus.extension.service.IService;

/**
* ${tableComment}Service接口
*
* @author ${author} ${email}
* @since ${version} ${date}
*/
public interface ${ClassName}Service extends IService<${ClassName}Entity> {

  /**
  * 生成的示例代码：检查${tableComment}编码是否唯一
  */
  //boolean is${FunctionName}CodeDuplicated(Long ${functionName}Id, String ${functionName}Code);

  /**
  * 生成的示例代码：检查${tableComment}名称是否唯一
  */
  //boolean is${FunctionName}NameDuplicated(Long ${functionName}Id, String ${functionName}Name);

  /**
  * 生成的示例代码：判断${tableComment}是否xxx
  */
  //boolean isAssignedToUsers(Long ${functionName}Id);

}
