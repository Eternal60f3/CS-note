# XV6

## 一些资源

[中文翻译(2020版)](https://xv6.dgs.zone/)

自己目前再做的是2021版本的

[网上别人的解析](https://blog.csdn.net/zzy980511/category_11740137.html)



## 第三章 页表

#### 源码解析

[csdn xv6 内存相关的源码解析](https://blog.csdn.net/zzy980511/article/details/129822336)



对于第一篇，不理解的地方

+ 为什么说指针就是虚拟地址

+ 1.6 kvminit的上方 在阅读这段代码时，要注意一件事情。我们在前面所述的三个全局变量，包括etext和trampoline全部都在映射内核页表时使用到了，但是要注意它们本质都是虚拟地址(指针)，那么为什么可以将它们作为物理地址分配传递给kvmmap函数呢？

  其实在执行上述代码的时候xv6的分页机制是关闭的(kernel/start.c 34-35行关闭了分页机制，这在xv6启动过程中会详细分析)，所以此代码中的所有指针，虽然是虚拟地址，但它们本质上也等于物理地址。如果你读得不仔细，可能领悟不到这一层的巧妙：)

  