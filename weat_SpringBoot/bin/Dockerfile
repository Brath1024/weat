#java8环境
FROM openkbs/jdk11-mvn-py3

#root用户
USER root

#设置时区
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

#Auth
MAINTAINER Brath

#设置工作目录集
WORKDIR /root/weatWork

#复制jars和命令
ADD *.jar /root/weatWork/
ADD run.sh /root/weatWork/run.sh

#脚本权限设置
RUN chmod +x /root/weatWork/run.sh

#暴露端口
EXPOSE 9999
