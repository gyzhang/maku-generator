package ${package}.domain.${moduleName}.${functionName}.query;

import cn.hutool.core.util.StrUtil;
import com.agileboot.common.core.page.AbstractPageQuery;
import ${package}.domain.${moduleName}.${functionName}.db.${ClassName}Entity;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* ${tableComment}Query
*
* @author ${author} ${email}
* @since ${version} ${date}
*/
@EqualsAndHashCode(callSuper = true)
@Data
public class ${FunctionName}Query extends AbstractPageQuery<${ClassName}Entity> {

    <#list queryList as field>
    private ${field.attrType} ${field.attrName};
    </#list>

    @Override
    public QueryWrapper<${ClassName}Entity> addQueryCondition() {
        QueryWrapper<${ClassName}Entity> queryWrapper = new QueryWrapper<${ClassName}Entity>()
        <#list queryList as field>
            <#if (field.attrType == "String")>.like(StrUtil.isNotEmpty(${field.attrName}), "${field.fieldName}", ${field.attrName})<#else>.eq(${field.attrName} != null, "${field.fieldName}", ${field.attrName})</#if><#if !field_has_next>;</#if>
        </#list>
        <#list fieldList as field>
            <#if field.fieldName == "${functionName}_sort">
        if (StrUtil.isEmpty(this.getOrderColumn())) {
            this.setOrderColumn("${functionName}_sort");
        }
            </#if>
        </#list>
        this.setTimeRangeColumn("create_time");

        return queryWrapper;
    }
}
