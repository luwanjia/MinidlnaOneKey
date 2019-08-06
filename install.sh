#! /bin/bash
# minidlna安装脚本

install_minidlna()
{
    yum install -y epel-release
    rpm -v --import http://li.nux.ro/download/nux/RPM-GPG-KEY-nux.ro
    rpm -Uvh http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-5.el7.nux.noarch.rpm
    yum makecache
    yum install -y ffmpeg libjpeg sqlite libexif libid3tag libogg libvorbis flac ntfs-3g

    yum localinstall -y minidlna-1.2.1-1.x86_64.rpm

    firewall-cmd --zone=public --add-port=8200/tcp --permanent
    firewall-cmd --zone=public --add-port=1900/udp --permanent
    firewall-cmd --reload
}

ping -c 1 114.114.114.114 > /dev/null 2>&1


if [ $? -eq 0 ];then
    echo " -- Installing minidlna and dependence."
    install_minidlna
else
    echo " -- Network not connected."
fi
