FROM centos:7
MAINTAINER sinmahod sinmahod@qq.com
COPY nginx.repo /etc/yum.repos.d
RUN yum install nginx -y
COPY ./www /usr/share/nginx/html
EXPOSE 80
CMD ["nginx","-g","daemon off;"]
