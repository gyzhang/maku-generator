package ${package}.domain.${moduleName}.${functionName}.dto;

import cn.hutool.core.bean.BeanUtil;
import com.agileboot.common.annotation.ExcelColumn;
import com.agileboot.common.enums.common.StatusEnum;
import com.agileboot.common.enums.BasicEnumUtil;
import ${package}.domain.${moduleName}.${functionName}.db.${ClassName}Entity;
<#list importList as i>
import ${i!};
</#list>
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
* ${tableComment}DTO
*
* @author ${author} ${email}
* @since ${version} ${date}
*/
@AllArgsConstructor
@NoArgsConstructor
@Data
public class ${FunctionName}DTO {

    public ${FunctionName}DTO(${ClassName}Entity entity) {
        if (entity != null) {
            BeanUtil.copyProperties(entity, this);
            statusStr = BasicEnumUtil.getDescriptionByValue(StatusEnum.class, entity.getStatus());
        }
    }

    <#list fieldList as field>
        <#if !field.baseField>
    @ExcelColumn(name = "${field.fieldComment}")
    private ${field.attrType} ${field.attrName};

        </#if>
    </#list>
    @ExcelColumn(name = "状态")
    private String statusStr;

    private Date createTime;

}
