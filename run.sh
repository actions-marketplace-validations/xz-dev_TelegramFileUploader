#!/usr/bin/env bash


# 检查 PRE_COMMAND 环境变量是否被设置且非空
if [ -n "${PRE_COMMAND}" ]; then
  # 运行 PRE_COMMAND，并使用 eval 来确保任何输出的环境变量都能在当前脚本中生效
  # 使用引号来防止单词分割
  eval "$( "$PRE_COMMAND" | while read -r line; do echo export "$line"; done )"
fi

# 初始化新命令变量
new_command=""

# 标记是否遇到了 --files 参数
encountered_files=false

# 遍历所有传入的参数
for arg in "$@"; do
  if $encountered_files; then
    # 如果已经遇到了 --files，就按 // 分割文件参数，并加入到新命令中
    IFS='//' read -r -a files <<< "$arg"
    for file in "${files[@]}"; do
      new_command+=" \"$file\""
    done
    encountered_files=false # 重置标记
  else
    # 如果当前参数是 --files，设置标记但不立即处理
    if [[ $arg == "--files" ]]; then
      encountered_files=true
    fi
    # 将当前参数加入到新命令中
    new_command+=" $arg"
  fi
done

# 执行新命令，使用 eval 来正确处理特殊字符和空格
eval "python3 main.py$new_command"
