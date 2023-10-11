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

    @NotBlank(message = "${tableComment}编码不能为空")
    @Size(max = 64, message = "${tableComment}编码长度不能超过64个字符")
    protected String ${functionName}Code;

    /**
     * ${tableComment}名称
     */
    @NotBlank(message = "${tableComment}名称不能为空")
    @Size(max = 64, message = "${tableComment}名称长度不能超过64个字符")
    protected String ${functionName}Name;

    /**
     * ${tableComment}排序
     */
    @NotNull(message = "显示顺序不能为空")
    protected Integer ${functionName}Sort;

    protected String remark;

    @PositiveOrZero
    protected String status;

}
