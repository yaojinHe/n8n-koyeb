FROM n8nio/n8n:latest

# 切换到 root 权限以安装系统级依赖
USER root

# 更新包列表并使用 apt-get 安装 Python3 和 pip (Debian 环境)
RUN apt-get update && \
    apt-get install -y python3 python3-pip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# 如果你需要通过 pip 安装额外的 Python 库，可以取消下面的注释：
# RUN pip3 install --no-cache-dir requests pandas --break-system-packages

# 安装完成后，切回 n8n 默认的 node 用户以确保权限安全
USER node
