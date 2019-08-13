# CZGSwiftHome
项目商城Swift版本

```
整个项目参照MVVM架构搭建，  
整个项目价格文件的层级最好不要超过四级  
创建文件类命名规则：ZC + xx, 如： ZCConfig.h    
文件夹命名规则：大写开头
```
  

**Config文件夹放置APP一些相关设置，具体文件可参考“Config配置参数说明.text”文件**  
****
主目录结构  
- CZGSwiftHome   
   - Features           包含各个模块 Model. View, viewModel，Controller  
   - categories         包含各种类的分类  
   - Frameworks       系统框架，包含导入的系统的框架  
   - Utilites              工具类，一些非对象，类方法调用的对象   
   - Vendors            第三方库，部分需要修改或者不支持Cocoapod的第三方的框架引入  
   - Config              配置，包含宏定义文件，全局配置文件，全局常量文件，颜色配置文件  
   - AppEntry          程序入口，包含AppDelegate, main.c info.plist  
****
模块目录结构  
 - Features  
   - Base        MVVM的基类或者通用类    
         - Model         数据模型  
         - ViewModel   数据ViewModel  
         - View           视图  
         - Controllers   控制器  
