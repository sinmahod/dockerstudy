1，安装
```
# yum install docker
```
2，启动服务
```
//old centos
# service docker start
//centos7
# systemctl  start docker.service
```
3，开机启动
```
//old centos
# chkconfig docker on
//centos7
# systemctl  enable docker.service
```
4，查看Docker信息
```
# docker info
```
5，查看Docker镜像
```
# docker images
```
6，安装镜像
```
//安装CentOS-7
# docker pull centos:7
```
7，运行容器
```
# docker run -it centos:7
```
8，退出容器（如果容器内没有运行中的应用退出时候就会自动停止）
```
# exit
```
9，查看容器状态（去掉-a可以查看运行中的容器）
```
# docker ps -a
```
10，销毁容器
```
# docker rm 容器ID // ps -a查看
```
11，重启容器（启动处于停止状态的容器）
```
# docker start CID
```
12，进入容器
```
# docker attach CID
```
13，挂载本地目录到容器
```
# docker run --privileged=true -v /tmp:/mnt:rw -it centos
//rw为读写权限，--privileged=true 防止selinux模式下挂载目录无权限
```
14，将容器转换为镜像
```
# docker commit -m "Add Nginx from centos7" -a "sinmahod" 838a45022280 sinmahod/centos-nginx:v1
//-m 提交的注释，-a 用户信息 sinmahod/centos-nginx:v1 镜像用户名/git仓库名：tag
```
15，备注一下我的docker hub用户信息
```
username: sin***
password: ********
e-mail: sin***@qq.com
```
16，登录docker远程库
```
# docker login  //默认登录docker hub，需要输入用户信息
```
17，提交到远程库（需要登录）
```
# docker push sinmahod/centos-nginx:v1
```
18，从远程库中下载镜像（默认为hub docker）（需要登录）
```
# docker pull sinmahod/centos-nginx:v1
```
19，删除镜像
```
# docker rmi <image id>
```
20，设置Tag
```
# docker tag CID 镜像名称:Tag
```
21，端口映射+后台守护
```
# docker run -p 本地端口:容器端口 -d 启动镜像名称
```
22，安装SSH，之后可以在容器中安装软件
```
# yum install openssh-server
//需要映射22端口
# docker run -d -p 50001:22
//安装ssh  
# ssh root@127.0.0.1-p 50001  
//连上后想装什么就装什么，可使用exit退出容器，但后台还会运行。
```
23，查看容器日志
```
# docker logs -f 4e6d6ffe615a
```

---
## 使用Dockerfile 

1，新建一个网页
```
# mkdir www
# vi www/index.zhtml

<html>
<head>
<title>Learn Docker<title>
</head>
<body>
<h1>Enjoy Docker!</h1>
</body>
</html>

:wq!

# vi Dockerfile

FROM centos:7                       //指明基于什么镜像构建
MAINTAINER sinmahod sinmahod@qq.com //你的大名
COPY nginx.reop /etc/yum.repos.d    //把本地写好的nginx源拷贝到容器
RUN yum update -y                   //容器内执行的shell     -y=默认全部选y
RUN yum install nginx -y            //同上
COPY ./www /usr/share/nginx/html    //将www文件夹的内容拷贝到容器的某个目录下
EXPOSE 80                           //对外开放80端口
CMD ["nginx","-g","daemon off;"]    //容器运行时开启Nginx
//# 定义环境变量
//ENV TOMCAT_HOME /usr/local/tomcat
//ENV MAVEN_HOME /usr/local/maven
//ENV APP_HOME /webapp
:wq!
```

2，构建镜像
```
# docker build -t="sinmahod/centos-nginx:v2" .
//最后的.是指定dockerfile文件在当前目录（也可以用地址的方式指定文件）
```

3，https://www.daocloud.io/ （可以直接用github登录）
```
username: sin****
password: **********
e-mail: sin***@qq.com
```

4，从DaoCloud拉取镜像
```
# docker login daocloud.io
# docker pull daocloud.io/sinmahod/dockerstudy:master-0be5eea
//daocloud.io/sinmahod/dockerstudy 为镜像名称  
//master-0be5eea 为版本号（Tag）
```
