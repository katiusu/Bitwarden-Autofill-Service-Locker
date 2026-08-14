# 已终止
转到https://github.com/katiusu/HyperOS-Autofill-Fix/tree/main以获取更好解决方法。
# Bitwarden-Autofill-Service-Locker
一个对抗HyperOS安全组件，将Bitwarden锁定为默认密码管理器和自动填入服务提供者的Root模组。
# 用什么制作的？
使用AI完成。
# 原理？
只是最简单的办法：每隔固定的时间检查一次是否默认的密码管理器被更改，若被更改就再改回去。
# 怎么使用？
就像是其他模组一样，在Magisk或KernelSU等软件上安装并重启即可。 

日志存放在：/data/local/tmp/autofill_fix.log
