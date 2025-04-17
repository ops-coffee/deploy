#!/bin/bash

# 初始化数据
python3 manage.py collectstatic --noinput && \
python3 manage.py makemigrations && \
python3 manage.py migrate  || { echo >&2 "migrate failed. Aborting."; exit 1; }

# 创建管理员账号
echo "创建管理员账号..."
python3 manage.py shell -c "\
from django.contrib.auth import get_user_model;\
User = get_user_model();\
exec('''\
if User.objects.filter(username=\'admin@163.com\', is_superuser=True).exists():\n\
    print(\'用户已存在\')\n\
else:\n\
    User.objects.create_superuser(\n\
        username=\'admin@163.com\',\n\
        password=\'163.com\'\n\
    )\n\
''')" || { echo >&2 "创建管理员失败"; exit 1; }

# 启动服务
echo "启动服务..."
chmod +x /home/project/agent-server/agent-server-* && \
cp supervisor.conf /etc/supervisor/conf.d/devops.conf || \
{ echo >&2 "An error occurred. Aborting."; exit 1; }

mkdir -p /home/logs && \
/etc/init.d/supervisor start && \
echo "$(date) - Start ok. ^_^" || { echo >&2 "An error occurred. Aborting."; exit 1; }
