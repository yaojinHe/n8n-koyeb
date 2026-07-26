FROM n8nio/n8n:latest

# 切换到 root 权限以安装系统级依赖
USER root

# n8n 官方镜像基于 Alpine Linux，使用 apk 安装 Python3 和 pip
RUN apk add --no-cache python3 py3-pip

# 如果你的 Python 脚本需要调用外部接口或处理数据，可以在这里预装依赖库
# RUN pip3 install --no-cache-dir requests pandas --break-system-packages

# 安装完成后，切回 n8n 默认的 node 用户以确保权限安全
USER node
