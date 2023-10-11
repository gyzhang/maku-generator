package ${package}.domain.${moduleName}.${functionName};

import cn.hutool.core.util.StrUtil;
import com.agileboot.common.core.page.PageDTO;
import com.agileboot.domain.common.command.BulkOperationCommand;
import ${package}.domain.${moduleName}.${functionName}.command.Add${FunctionName}Command;
import ${package}.domain.${moduleName}.${functionName}.command.Update${FunctionName}Command;
import ${package}.domain.${moduleName}.${functionName}.db.${ClassName}Entity;
import ${package}.domain.${moduleName}.${functionName}.db.${ClassName}Service;
import ${package}.domain.${moduleName}.${functionName}.dto.${FunctionName}DTO;
import ${package}.domain.${moduleName}.${functionName}.model.${FunctionName}Model;
import ${package}.domain.${moduleName}.${functionName}.model.${FunctionName}ModelFactory;
import ${package}.domain.${moduleName}.${functionName}.query.${FunctionName}Query;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import java.util.List;
import java.util.stream.Collectors;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

/**
* ${tableComment}ApplicationService
*
* @author ${author} ${email}
* @since ${version} ${date}
*/
@Service
@RequiredArgsConstructor
public class ${FunctionName}ApplicationService {

    private final ${FunctionName}ModelFactory ${functionName}ModelFactory;

    private final ${ClassName}Service ${functionName}Service;

    public PageDTO<${FunctionName}DTO> get${FunctionName}List(${FunctionName}Query query) {
        Page<${ClassName}Entity> page = ${functionName}Service.page(query.toPage(), query.toQueryWrapper());
        List<${FunctionName}DTO> records = page.getRecords().stream().map(${FunctionName}DTO::new).collect(Collectors.toList());
        return new PageDTO<>(records, page.getTotal());
    }

    public List<${FunctionName}DTO> get${FunctionName}ListAll(${FunctionName}Query query) {
        List<${ClassName}Entity> all = ${functionName}Service.list(query.toQueryWrapper());
        List<${FunctionName}DTO> records = all.stream().map(${FunctionName}DTO::new).collect(Collectors.toList());
        return records;
    }

    public ${FunctionName}DTO get${FunctionName}Info(Long ${functionName}Id) {
        ${ClassName}Entity byId = ${functionName}Service.getById(${functionName}Id);
        return new ${FunctionName}DTO(byId);
    }

    public void add${FunctionName}(Add${FunctionName}Command addCommand) {
        ${FunctionName}Model ${functionName}Model = ${functionName}ModelFactory.create();
        ${functionName}Model.loadFromAddCommand(addCommand);

        ${functionName}Model.check${FunctionName}NameUnique();
        ${functionName}Model.check${FunctionName}CodeUnique();

        ${functionName}Model.insert();
    }

    public void update${FunctionName}(Update${FunctionName}Command updateCommand) {
        ${FunctionName}Model ${functionName}Model = ${functionName}ModelFactory.loadById(updateCommand.get${FunctionName}Id());
        ${functionName}Model.loadFromUpdateCommand(updateCommand);

        ${functionName}Model.check${FunctionName}NameUnique();
        ${functionName}Model.check${FunctionName}CodeUnique();

        ${functionName}Model.updateById();
    }


    public void delete${FunctionName}(BulkOperationCommand<Long> deleteCommand) {
        for (Long id : deleteCommand.getIds()) {
            ${FunctionName}Model ${functionName}Model = ${functionName}ModelFactory.loadById(id);
            ${functionName}Model.checkCanBeDelete();
        }

        ${functionName}Service.removeBatchByIds(deleteCommand.getIds());
    }

}
