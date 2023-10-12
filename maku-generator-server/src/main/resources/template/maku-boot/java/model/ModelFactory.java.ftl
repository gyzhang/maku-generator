package ${package}.domain.${moduleName}.${functionName}.model;

import com.agileboot.common.exception.ApiException;
import com.agileboot.common.exception.error.ErrorCode.Business;
import ${package}.domain.${moduleName}.${functionName}.db.${ClassName}Entity;
import ${package}.domain.${moduleName}.${functionName}.db.${ClassName}Service;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

/**
* ${tableComment}领域对象工厂
*
* @author ${author} ${email}
* @since ${version} ${date}
*/
@Component
@RequiredArgsConstructor
public class ${FunctionName}ModelFactory {

    private final ${ClassName}Service ${functionName}Service;

    public ${FunctionName}Model loadById(Long ${functionName}Id) {
        ${ClassName}Entity byId = ${functionName}Service.getById(${functionName}Id);
        if (byId == null) {
            throw new ApiException(Business.COMMON_OBJECT_NOT_FOUND, ${functionName}Id, "${tableComment}");
        }
        return new ${FunctionName}Model(byId, ${functionName}Service);
    }

    public ${FunctionName}Model create() {
        return new ${FunctionName}Model(${functionName}Service);
    }

}
