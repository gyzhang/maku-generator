package ${package}.admin.controller.${moduleName};

import com.agileboot.admin.customize.aop.accessLog.AccessLog;
import com.agileboot.common.core.base.BaseController;
import com.agileboot.common.core.dto.ResponseDTO;
import com.agileboot.common.core.page.PageDTO;
import com.agileboot.common.enums.common.BusinessTypeEnum;
import com.agileboot.common.utils.poi.CustomExcelUtil;
import com.agileboot.domain.common.command.BulkOperationCommand;
import com.agileboot.domain.${moduleName}.${functionName}.${FunctionName}ApplicationService;
import com.agileboot.domain.${moduleName}.${functionName}.command.Add${FunctionName}Command;
import com.agileboot.domain.${moduleName}.${functionName}.command.Update${FunctionName}Command;
import com.agileboot.domain.${moduleName}.${functionName}.dto.${FunctionName}DTO;
import com.agileboot.domain.${moduleName}.${functionName}.query.${FunctionName}Query;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import java.util.List;
import javax.servlet.http.HttpServletResponse;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import lombok.RequiredArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

/**
 * ${tableComment}Controller
 *
 * @author ${author} ${email}
 * @since ${version} ${date}
 */
@Tag(name = "${tableComment}API", description = "${tableComment}相关的增删查改")
@RestController
@RequestMapping("/${moduleName}/${functionName}")
@Validated
@RequiredArgsConstructor
public class ${ClassName}Controller extends BaseController {

    private final ${FunctionName}ApplicationService ${functionName}ApplicationService;

    /**
     * 获取${tableComment}列表
     */
    @Operation(summary = "${tableComment}列表")
    @PreAuthorize("@permission.has('${moduleName}:${functionName}:list')")
    @GetMapping("/list")
    public ResponseDTO<PageDTO<${FunctionName}DTO>> list(${FunctionName}Query query) {
        PageDTO<${FunctionName}DTO> pageDTO = ${functionName}ApplicationService.get${FunctionName}List(query);
        return ResponseDTO.ok(pageDTO);
    }

    @Operation(summary = "${tableComment}列表导出")
    @AccessLog(title = "${tableComment}管理", businessType = BusinessTypeEnum.EXPORT)
    @PreAuthorize("@permission.has('${moduleName}:${functionName}:export')")
    @GetMapping("/excel")
    public void export(HttpServletResponse response, ${FunctionName}Query query) {
        List<${FunctionName}DTO> all = ${functionName}ApplicationService.get${FunctionName}ListAll(query);
        CustomExcelUtil.writeToResponse(all, ${FunctionName}DTO.class, response);
    }

    /**
     * 根据${tableComment}编号获取详细信息
     */
    @Operation(summary = "${tableComment}详情")
    @PreAuthorize("@permission.has('${moduleName}:${functionName}:query')")
    @GetMapping(value = "/{${functionName}Id}")
    public ResponseDTO<${FunctionName}DTO> getInfo(@PathVariable Long ${functionName}Id) {
        ${FunctionName}DTO ${functionName} = ${functionName}ApplicationService.get${FunctionName}Info(${functionName}Id);
        return ResponseDTO.ok(${functionName});
    }

    /**
     * 新增${tableComment}
     */
    @Operation(summary = "添加${tableComment}")
    @PreAuthorize("@permission.has('${moduleName}:${functionName}:add')")
    @AccessLog(title = "${tableComment}管理", businessType = BusinessTypeEnum.ADD)
    @PostMapping
    public ResponseDTO<Void> add(@RequestBody Add${FunctionName}Command addCommand) {
        ${functionName}ApplicationService.add${FunctionName}(addCommand);
        return ResponseDTO.ok();
    }

    /**
     * 修改${tableComment}
     */
    @Operation(summary = "修改${tableComment}")
    @PreAuthorize("@permission.has('${moduleName}:${functionName}:edit')")
    @AccessLog(title = "${tableComment}管理", businessType = BusinessTypeEnum.MODIFY)
    @PutMapping
    public ResponseDTO<Void> edit(@RequestBody Update${FunctionName}Command updateCommand) {
        ${functionName}ApplicationService.update${FunctionName}(updateCommand);
        return ResponseDTO.ok();
    }

    /**
     * 删除${tableComment}
     */
    @Operation(summary = "删除${tableComment}")
    @PreAuthorize("@permission.has('${moduleName}:${functionName}:remove')")
    @AccessLog(title = "${tableComment}管理", businessType = BusinessTypeEnum.DELETE)
    @DeleteMapping
    public ResponseDTO<Void> remove(@RequestParam @NotNull @NotEmpty List<Long> ids) {
        ${functionName}ApplicationService.delete${FunctionName}(new BulkOperationCommand<>(ids));
        return ResponseDTO.ok();
    }

}
