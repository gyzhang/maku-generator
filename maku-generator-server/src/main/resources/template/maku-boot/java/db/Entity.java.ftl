package ${package}.domain.${moduleName}.${functionName}.db;

<#if baseClass??>
import ${baseClass.packageName}.${baseClass.code};
</#if>
import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import java.io.Serializable;
import lombok.Getter;
import lombok.Setter;
<#list importList as i>
import ${i!};
</#list>

/**
* ${tableComment}Entity
*
* @author ${author} ${email}
* @since ${version} ${date}
*/
@Getter
@Setter
@TableName("${tableName}")
@ApiModel(value = "${ClassName}Entity对象", description = "${tableComment}表")
public class ${ClassName}Entity<#if baseClass??> extends ${baseClass.code}<${ClassName}Entity></#if> {

    private static final long serialVersionUID = 1L;

    <#list fieldList as field>
        <#if !field.baseField>
    @ApiModelProperty("${field.fieldComment}")
            <#if field.primaryPk>
    @TableId(value = "${field.fieldName}", type = IdType.AUTO)
                <#assign pkAttrName = "${field.attrName}">
            <#else>
    @TableField(value = "${field.fieldName}", fill = FieldFill.${field.autoFill})
            </#if>
    private ${field.attrType} ${field.attrName};

        </#if>
    </#list>
    @Override
    public Serializable pkVal() {
        return this.${pkAttrName};
    }

}
