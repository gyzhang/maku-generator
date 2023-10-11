package ${package}.domain.${moduleName}.${functionName}.command;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Positive;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* ${tableComment}UpdateCommand
*
* @author ${author} ${email}
* @since ${version} ${date}
*/
@EqualsAndHashCode(callSuper = true)
@Data
public class Update${FunctionName}Command extends Add${FunctionName}Command {

    @NotNull(message = "${tableComment}ID不能为空")
    @Positive
    private Long ${functionName}Id;

}
