#Отключим службу ondemand
(для разгона cpu)
# cat /proc/cpuinfo | grep MHz
# systemctl status ondemand
# systemctl stop ondemand
# systemctl disable ondemand
# nano /etc/sysctl.conf
В конец
!!!vm.swappiness=0
!!!vm.vfs_cache_pressure = 100
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
net.ipv6.conf.lo.disable_ipv6 = 1
Сохранить.
Применить сразу:
# sysctl -p
