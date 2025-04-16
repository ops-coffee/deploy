## 环境依赖

系统：Debian GNU/Linux 12 (bookworm)
Python版本：3.11.12

## 安装部署

1. 安装docker compose

```
curl -fsSL https://get.docker.com -o get-docker.sh | sudo sh
```

# 新版本docker已经默认安装了docker compose无需额外安装

```
sudo curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```

2. 拉取deploy部署代码

```
git pull https://github.com/ops-coffee/deploy.git .
```

3. 进入deploy文件夹内并启动

```
cd deploy
docker-compose up -d
```

4. 浏览器访问：`https://localhost:8001`

默认为8001端口，首次部署有数据初始化等操作，大约会占用几分钟时间，需等待完全启动后访问，可通过查看`ops-app`容器日志，输出`Start ok. ^_^`后表示启动完成

```
# docker logs ops-app -n 10
启动服务...
Reading package lists...
Building dependency tree...
Reading state information...
supervisor is already the newest version (4.2.5-1).
gunicorn is already the newest version (20.1.0-6+deb12u1).
0 upgraded, 0 newly installed, 0 to remove and 0 not upgraded.
Unlinking stale socket /var/run/supervisor.sock
Starting supervisor: supervisord.
Wed Apr 16 15:00:21 CST 2025 - Start ok. ^_^
```
