[课程全部内容的翻译](https://xv6.dgs.zone/)



[xv6教材翻译](https://github.com/FrankZn/xv6-riscv-book-Chinese/tree/main)





#### 之后有可能出bug的地方，自己不理解它为什么这么做

+ kernel\sysproc.c中    

  第15行 argint()函数按照详细的函数内容来说，它会以返回0,不会存在小于 0 的情况

  除了第15行，其他行 系统调用 从用户空间取参数的时候都存在这个问题

