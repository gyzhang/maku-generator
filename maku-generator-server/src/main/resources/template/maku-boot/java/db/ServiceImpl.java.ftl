package ${package}.domain.${moduleName}.${functionName}.db;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

/**
* ${tableComment}Service实现
*
* @author ${author} ${email}
* @since ${version} ${date}
*/
@Service
@RequiredArgsConstructor
public class ${ClassName}ServiceImpl extends ServiceImpl<${ClassName}Mapper, ${ClassName}Entity> implements ${ClassName}Service {

    /**
    * 生成的示例代码：检查${tableComment}编码是否唯一
    */
    //@Override
    //public boolean is${FunctionName}CodeDuplicated(Long ${functionName}Id, String ${functionName}Code) {
    //    QueryWrapper<${ClassName}Entity> queryWrapper = new QueryWrapper<>();
    //    queryWrapper.ne(${functionName}Id != null, "${functionName}_id", ${functionName}Id)
    //        .eq("${functionName}_code", ${functionName}Code);
    //    return baseMapper.exists(queryWrapper);
    //}

    /**
    * 生成的示例代码：检查${tableComment}名称是否唯一
    */
    //@Override
    //public boolean is${FunctionName}NameDuplicated(Long ${functionName}Id, String ${functionName}Name) {
    //    QueryWrapper<${ClassName}Entity> queryWrapper = new QueryWrapper<>();
    //    queryWrapper.ne(${functionName}Id != null, "${functionName}_id", ${functionName}Id)
    //        .eq("${functionName}_name", ${functionName}Name);
    //    return baseMapper.exists(queryWrapper);
    //}

    /**
    * 生成的示例代码：判断${tableComment}是否xxx
    */
    //@Override
    //public boolean isAssignedToUsers(Long ${functionName}Id) {
    //    QueryWrapper<SysUserEntity> queryWrapper = new QueryWrapper<>();
    //    queryWrapper.eq("${functionName}_id", ${functionName}Id);
    //    return userMapper.exists(queryWrapper);
    //}

}
