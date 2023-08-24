#!/bin/bash
set -e # 出现错误则退出

# 定义日志级别的颜色
ERROR_COLOR='\033[0;31m'     # 红色
WARNING_COLOR='\033[0;33m'   # 黄色
INFO_COLOR='\033[0;32m'      # 绿色
DEBUG_COLOR='\033[0;34m'     # 蓝色
RESET_COLOR='\033[0m'        # 重置颜色

# 定义打印日志的函数
log() {
    local level=$1
    local message="$2"

    case $level in
        error)
            echo "${ERROR_COLOR}[ERROR] $message${RESET_COLOR}"
            ;;
        warning)
            echo "${WARNING_COLOR}[WARNING] $message${RESET_COLOR}"
            ;;
        info)
            echo "${INFO_COLOR}[INFO] $message${RESET_COLOR}"
            ;;
        debug)
            echo "${DEBUG_COLOR}[DEBUG] $message${RESET_COLOR}"
            ;;
        *)
            echo "Unknown log level: $level"
            ;;
    esac
}

read_with_valid() {
    local var_name="$1"
    local prompt="$2"
    local mode="$3"
    local default_value="$4"

    if [ -z "$default_value" ]; then
        echo -n "$prompt: "
    else
        echo -n "$prompt [$default_value]: "
    fi

    if [ "$mode" = "password" ]; then
        stty -echo
        read -r input_value
        stty echo
        echo
    else
        read -r input_value
    fi

    if [ -z "$input_value" ]; then
        # 如果没有默认值，则提示不能为空，否则使用默认值        
        if [ -z "$default_value" ]; then
            log "error" "$prompt不能为空"
            exit 1
        else
            eval "$var_name=\"$default_value\""
        fi
    else
        eval "$var_name=\"$input_value\""
    fi
}

# 询问源镜像仓库
read_with_valid source_registry 源镜像仓库地址 input registry.cn-shanghai.aliyuncs.com
# 询问源镜像仓库命名空间
read_with_valid source_registry_namespace 源镜像仓库命名空间 input snewbie
# 询问源镜像仓库用户名
read_with_valid source_registry_username 源镜像仓库用户名 input nichangen@outlook.com
# 询问源镜像仓库密码
read_with_valid source_registry_password 源镜像仓库密码 password

echo $source_registry_password | docker login --username=$source_registry_username --password-stdin $source_registry

# 询问源镜像仓库镜像名称
read_with_valid source_registry_image_name 源镜像仓库镜像名称 input
# 询问源镜像仓库镜像版本
read_with_valid source_registry_image_version 源镜像仓库镜像版本 input

docker pull $source_registry/$source_registry_namespace/$source_registry_image_name:$source_registry_image_version

# 询问目标镜像仓库
read_with_valid target_registry 目标镜像仓库地址 input hub.17usoft.com
# 询问目标镜像仓库命名空间
read_with_valid target_registry_namespace 目标镜像仓库命名空间 input marketing_activity
# 询问目标镜像仓库用户名
read_with_valid target_registry_username 目标镜像仓库用户名 input nce40202
# 询问目标镜像仓库密码
read_with_valid target_registry_password 目标镜像仓库密码 password

echo $target_registry_password | docker login --username=$target_registry_username --password-stdin $target_registry

# 询问目标镜像仓库镜像名称
read_with_valid target_registry_image_name 目标镜像仓库镜像名称 input $source_registry_image_name
# 询问目标镜像仓库镜像版本
read_with_valid target_registry_image_version 目标镜像仓库镜像版本 input $source_registry_image_version

docker tag $source_registry/$source_registry_namespace/$source_registry_image_name:$source_registry_image_version $target_registry/$target_registry_namespace/$target_registry_image_name:$target_registry_image_version

# 询问是否需要上传镜像
read_with_valid need_upload_image 是否需要上传镜像 input y