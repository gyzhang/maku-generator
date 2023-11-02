package ${package}.domain.${moduleName}.${functionName}.command;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.PositiveOrZero;
import javax.validation.constraints.Size;
import lombok.Data;

/**
* ${tableComment}AddCommand
*
* @author ${author} ${email}
* @since ${version} ${date}
*/
@Data
public class Add${FunctionName}Command {

<#list formList as field>
    /**
    * ${field.fieldComment}
    */
    <#if field.formRequired>
        <#if field.attrType=="String">
    @NotBlank(message = "${field.fieldComment}不能为空")
        <#else>
    @NotNull(message = "${field.fieldComment}不能为空")
        </#if>
    </#if>
    <#if (field.fieldLength gt 0) && (field.fieldLength lt 2147483647)>
    @Size(max = ${field.fieldLength?c}, message = "${field.fieldComment}长度不能超过${field.fieldLength}个字符")
    </#if>
    protected ${field.attrType} ${field.attrName};

</#list>
}
