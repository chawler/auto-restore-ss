#!/bin/sh
echo "*********************************************************"
echo "*                    全自动配置大家的SS                 *"
echo "*                                                       *"
echo "*      安装前请确认作业系统是否为 Ubuntu 16.10 64位     *"
echo "*                                                       *"
echo "*          如若不是，无法担保一定成功安装               *"
echo "*                                                       *"
echo "*                                                       *"
echo "*********************************************************"
echo "                                                         "
echo "请选择需要的操作（按下对应数字后回车确认）"
echo "1：开始搞事情"
echo "0:退出"
read num

if [ "$num" = "1" ]; then
echo "安装 Docker"
curl -fsSL https://get.docker.com/ | sh
echo ""
echo "安装 docker-compose"
curl -L https://github.com/docker/compose/releases/download/1.17.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
echo ""
echo "下载 frp"
curl https://raw.githubusercontent.com/chawler/auto-restore-ss/master/r3/frp.tar.gz -o frp.tar.gz
tar zxf frp.tar.gz
rm -rf frp.tar.gz
echo ""
echo "后台运行 frp"
nohup ./frp_0.13.0_linux_amd64/frps -c ./frp_0.13.0_linux_amd64/frps.ini &
echo "配置 ssr-mysql"
mkdir ssr-mysql
cd ssr-mysql
curl https://raw.githubusercontent.com/chawler/auto-restore-ss/master/ssr-mysql/docker-compose.yml -o docker-compose.yml
docker-compose up -d
echo ""
echo "安装 nginx"
apt install nginx -y
cd /etc/nginx/sites-available
curl https://raw.githubusercontent.com/chawler/auto-restore-ss/master/nginx/nas.zwd.life -o nas.zwd.life
curl https://raw.githubusercontent.com/chawler/auto-restore-ss/master/nginx/nds.zwd.life -o nds.zwd.life
cd /etc/nginx/sites-enabled
ln -s ../sites-available/nas.zwd.life
ln -s ../sites-available/nds.zwd.life
service nginx reload
fi

if [ "$num" = "0" ]; then
exit
fi
