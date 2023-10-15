！！！非常重要，必须读我！！！
！！！非常重要，必须读我！！！
！！！非常重要，必须读我！！！

以下是代码生成器生成代码后需要注意或修改的地方，请参照以下提示对生成的代码进行微调，以符合你的项目。

0、后端代码流转说明：
  请求分为两类：一类是查询，一类是操作（即对数据有进行更新）。
  **查询**：${ClassName}Controller -> ${FunctionName}Query -> ${FunctionName}ApplicationService -> ${ClassName}Service -> ${ClassName}Mapper
  **操作**：${ClassName}Controller -> Add/Update${FunctionName}Command -> ${FunctionName}ApplicationService -> ${FunctionName}Model(处理逻辑) -> save/update (MyBatis-Plus的Model.insert/updateById)
  以上是借鉴CQRS的开发理念，将查询和操作分开处理。操作类的业务实现借鉴了DDD战术设计的理念，使用领域类，工厂类更面向对象的实现逻辑。

1、