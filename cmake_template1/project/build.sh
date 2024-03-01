#!/bin/bash  

echo "请确认存在build文件夹 若不存在 请创建..."  
# 切换到build目录  
cd build || exit 1  

# 清理编译文件  
echo "清理项目..."
rm -rf * || exit 1  
  
# 执行cmake命令来配置项目  
cmake .. || exit 1  

cmake .. || exit 1  
  
# 可以添加其他构建或安装命令  
  
echo "项目已配置完毕，开始构建..."
make || exit 1  



