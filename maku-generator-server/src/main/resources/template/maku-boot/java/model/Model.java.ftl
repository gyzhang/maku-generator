package ${package}.domain.${moduleName}.${functionName}.model;

import cn.hutool.core.bean.BeanUtil;
import com.agileboot.common.exception.ApiException;
import com.agileboot.common.exception.error.ErrorCode;
import ${package}.domain.${moduleName}.${functionName}.command.Add${FunctionName}Command;
import ${package}.domain.${moduleName}.${functionName}.command.Update${FunctionName}Command;
import ${package}.domain.${moduleName}.${functionName}.db.${ClassName}Entity;
import ${package}.domain.${moduleName}.${functionName}.db.${ClassName}Service;
import lombok.NoArgsConstructor;

/**
* ${tableComment}领域对象
*
* @author ${author} ${email}
* @since ${version} ${date}
*/
@NoArgsConstructor
public class ${FunctionName}Model extends ${ClassName}Entity {

    private ${ClassName}Service ${functionName}Service;

    public ${FunctionName}Model(${ClassName}Service ${functionName}Service) {
        this.${functionName}Service = ${functionName}Service;
    }

    public ${FunctionName}Model(${ClassName}Entity entity, ${ClassName}Service ${functionName}Service) {
        if (entity != null) {
            BeanUtil.copyProperties(entity, this);
        }
        this.${functionName}Service = ${functionName}Service;
    }

    public void loadFromAddCommand(Add${FunctionName}Command addCommand) {
        if (addCommand != null) {
            BeanUtil.copyProperties(addCommand, this, "${functionName}Id");
        }
    }


    public void loadFromUpdateCommand(Update${FunctionName}Command command) {
        if (command != null) {
            loadFromAddCommand(command);
        }
    }


    /**
    * 生成的示例代码：检查是否可以安全删除
    */
    public void checkCanBeDelete() {
        //if (${functionName}Service.isAssignedToUsers(this.get${FunctionName}Id())) {
        //    throw new ApiException(ErrorCode.Business.${"${FunctionName}"?upper_case}_ALREADY_ASSIGNED_TO_USER_CAN_NOT_BE_DELETED);
        //}
    }

    /**
    * 生成的示例代码：检查${tableComment}名称是否唯一
    */
    public void check${FunctionName}NameUnique() {
        //if (${functionName}Service.is${FunctionName}NameDuplicated(get${FunctionName}Id(), get${FunctionName}Name())) {
        //    throw new ApiException(ErrorCode.Business.${"${FunctionName}"?upper_case}_NAME_IS_NOT_UNIQUE, get${FunctionName}Name());
        //}
    }

    /**
    * 生成的示例代码：检查${tableComment}编码是否唯一
    */
    public void check${FunctionName}CodeUnique() {
        //if (${functionName}Service.is${FunctionName}CodeDuplicated(get${FunctionName}Id(), get${FunctionName}Code())) {
        //    throw new ApiException(ErrorCode.Business.${"${FunctionName}"?upper_case}_CODE_IS_NOT_UNIQUE, get${FunctionName}Code());
        //}
    }

}
