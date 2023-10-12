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

    private String ${functionName}Code;
    private String ${functionName}Name;
    private Integer status;

    @Override
    public QueryWrapper<${ClassName}Entity> addQueryCondition() {
        QueryWrapper<${ClassName}Entity> queryWrapper = new QueryWrapper<${ClassName}Entity>()
            .eq(status != null, "status", status)
            .eq(StrUtil.isNotEmpty(${functionName}Code), "${functionName}_code", ${functionName}Code)
            .like(StrUtil.isNotEmpty(${functionName}Name), "${functionName}_name", ${functionName}Name);
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
