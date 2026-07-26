# 阶段 1：提取静态版 apk 工具包
FROM alpine:latest AS builder
RUN apk update && apk add --no-cache apk-tools-static

# 阶段 2：基于 n8n v3 的每日构建版
FROM n8nio/n8n:v3-nightly
USER root

# 恢复包管理能力
COPY --from=builder /sbin/apk.static /sbin/apk
COPY --from=builder /etc/apk/repositories /etc/apk/repositories

# 安装 Python3
RUN apk update && apk add --no-cache python3 py3-pip

# 创建专门的 Python 虚拟环境，并赋予 node 用户读写权限
RUN python3 -m venv /opt/venv
RUN chown -R node:node /opt/venv

# 将该虚拟环境设为系统默认路径
ENV PATH="/opt/venv/bin:$PATH"

# 切回安全用户
USER node
