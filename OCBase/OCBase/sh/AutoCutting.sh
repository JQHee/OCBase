#!/bin/bash
# iOS AutoPackage Shell Script
# Author:  阿唯不知道 <90candy.com @ gmail.com>
# 脚本使用方法：直接把脚本拖入终端 然后回车键即可执行
# ⚠️注意1：将脚本与logo放在同一个文件夹里
# ⚠️注意2：如果执行脚本时出现如下错误是因为文件权限不足，只需对其授权777即可
# 错误如：-bash: /Users/candy/Desktop/AutoCutting.sh: Permission denied
# 执行如下授权命令即可（这里的/Users/candy/Desktop/AutoCutting.sh路径参考上面的）
# chmod -R 777 /Users/candy/Desktop/AutoCutting.sh


################## 参数配置logo图标名称（最好用1024x1024的logo）##################
filename="logo.png"




printf "
#######################################################################
#                              阿唯不知道
#                       不要因为骄傲而不屑于抄袭
#        更多内容请访问 ⭐️https://www.jianshu.com/u/0f7d26d766f4
#######################################################################
"

dirname="icon_cutimg"
name_array=("icon20@1x.png" "icon20@2x.png" "icon20@3x.png" "icon29@1x.png" "icon29@2x.png" "icon29@3x.png" "icon40@1x.png" "icon40@2x.png" "icon40@3x.png" "icon60@2x.png" "icon60@3x.png" "icon76@1x.png" "icon76@2x.png" "icon83.5@2x.png")

size_array=("20" "40" "60" "29" "58" "87" "40" "80" "120" "120" "180" "76" "152" "167")

# 获取脚本当前所在目录(即上级目录绝对路径)
root_dir=$(cd "$(dirname "$0")"; pwd)/
# 切换到当前脚本的工作目录
cd ${root_dir}
# 创建文件夹存放自动切图
mkdir $dirname

for((i=0;i<${#name_array[@]};++i)); do

m_dir=$dirname/${name_array[i]}

cp $filename $m_dir

sips -Z ${size_array[i]} $m_dir

done
