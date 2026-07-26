# 阶段 1：找一个纯净的 Alpine 镜像，提取静态版的 apk 工具
FROM alpine:latest AS builder
RUN apk update && apk add --no-cache apk-tools-static

# 阶段 2：基于最新的 n8n 镜像进行修改
FROM n8nio/n8n:latest
USER root

# 把静态的 apk 及其依赖的源列表复制到 n8n 镜像中，恢复下载能力
COPY --from=builder /sbin/apk.static /sbin/apk
COPY --from=builder /etc/apk/repositories /etc/apk/repositories

# 此时我们已经“复活”了 apk，可以正常安装 Python3 和 pip 了
RUN apk update && apk add --no-cache python3 py3-pip

# (可选) 如果你的 Python 脚本需要调用 API 或处理数据，可以在这里安装第三方库
# 由于 Alpine 最近的限制，可能需要加入 --break-system-packages
# RUN pip3 install --no-cache-dir requests fastapi --break-system-packages

# 安装完毕，切回默认的安全用户
USER node
