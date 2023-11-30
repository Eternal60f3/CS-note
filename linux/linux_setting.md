> 以下操作都是基于是在 windows 和 linux 双系统环境下执行

#### 双系统的安装

- [b 站 up 主](https://www.bilibili.com/video/BV1554y1n7zv/?spm_id_from=333.337.search-card.all.click&vd_source=49d04672e5251660f83453ba848c5482)



#### 有线网络的连接

- 在玉衡北 408 连接以太网，需要自己手动配置 ip 地址



#### 翻译软件

+ [有道词典下载， 以及下载后打不开的解决办法](https://www.cnblogs.com/qumogu/p/17073324.html)

+ goldendict

  + [相关介绍](https://blog.csdn.net/weixin_45839124/article/details/106930275)

    



#### 将/home目录挂载到新分区

+ [方法](https://blog.csdn.net/to_free/article/details/121362166)



#### 截图软件的配置

> 还存在问题

- 按 prtsc 进行截图 （自己设置的）
- [截图软件](https://cn.linux-console.net/?p=12798#:~:text=%E4%BD%BF%E7%94%A8%20Flameshot%20CLI%20%E6%8D%95%E8%8E%B7%E5%B1%8F%E5%B9%95%E6%88%AA%E5%9B%BE%201%20flameshot%20gui%EF%BC%9A%20%E8%B0%83%E5%87%BAFlameshot,-c%3A%20%E5%B0%86%E6%8D%95%E8%8E%B7%E7%9A%84%E5%B1%8F%E5%B9%95%E6%88%AA%E5%9B%BE%E5%A4%8D%E5%88%B6%E5%88%B0%E5%89%AA%E8%B4%B4%E6%9D%BF%205%20flameshot%20full%20--upload%EF%BC%9A%20%E5%B0%86%E6%8D%95%E8%8E%B7%E7%9A%84%E5%B1%8F%E5%B9%95%E6%88%AA%E5%9B%BE%E4%B8%8A%E4%BC%A0%E5%88%B0%20Imgur)



#### tmux 的复制操作

> 一个很 nice 的文档: http://louiszhai.github.io/2017/09/30/tmux/#%E5%AF%BC%E8%AF%BB
>
> 编辑配置的时候可以仔细看看文档里面的

- 要安装插件 tmux-yank
- shift 键 + 鼠标滑动， 选中后和就变成了正常终端复制 (ctrl + insert 复制, shift + insert 粘贴)
- .tmux.conf 配置文件

  ```c++
  bind-key c new-window -c "#{pane_current_path}"
  bind-key % split-window -h -c "#{pane_current_path}"
  bind-key '"' split-window -c "#{pane_current_path}"
  
  # 绑定hjkl键为面板切换的上下左右键
  bind -r k select-pane -U # 绑定k为↑
  bind -r j select-pane -D # 绑定j为↓
  bind -r h select-pane -L # 绑定h为←
  bind -r l select-pane -R # 绑定l为→
  
  set -g prefix M-b #
  unbind C-b # C-b即Ctrl+b键，unbind意味着解除绑定
  bind M-b send-prefix # 绑定Ctrl+a为新的指令前缀
  
  setw -g mode-keys vi # 开启vi风格后，支持vi的C-d、C-u、hjkl等快捷键
  
  # 启用tpm插件管理器
  set -g @plugin 'tmux-plugins/tpm'
  # 选择和复制文本到系统剪贴板
  set -g @plugin 'tmux-plugins/tmux-yank'
  set -g @yank-selection 'clipboard'
  set -g @plugin 'tmux-plugins/tmux-prefix-highlight'
  
  unbind %
  bind | splitw -h -c '#{pane_current_path}' # 水平方向新增面板，默认进入当前目录
  
  set -g mouse on
      
  # nvim 相关配置 通过这里的设置可以使得tmux的命令行的头部信息展示颜色
  set-option -sg escape-time 10
  set-option -g focus-events on
  set-option -g default-terminal "screen-256color"
  set-option -sa terminal-features 'screen-256color:RGB'



#### 笔记

+ typora

  

#### vpn 的配置

+ 网页: paopao.dog

- https://hiif.ong/clash/
- 需要设置手动代理，具体见上述链接



#### 编程软件的配置

##### nvim

> 还没搞定，之前下载出了问题。不过这个也不怎么用主要是用vscode了

- [博主写得超详细配置，逐代码进行讲解](https://martinlwx.github.io/zh-cn/config-neovim-from-scratch/)
- [bilibili](https://www.bilibili.com/video/BV1Td4y1578E/?spm_id_from=333.337.search-card.all.click&vd_source=49d04672e5251660f83453ba848c5482)
- [lazy.vim 的一个已经配置好的模板](https://www.lazyvim.org/)
- [代码补全插件](https://github.com/hrsh7th/cmp-nvim-lsp)

##### vscode

###### 界面样式设置

- [close system title bar and borders](https://leimao.github.io/blog/VS-Code-Hide-Window-Title-Bar/)

- [VSCode 修改系统界面和编辑器字体的大小](https://juejin.cn/post/6898325424767762439)

- 代码字体设置 `Editor: Font Family` 输入 `"JetBrains Mono", Consolas, 'Courier New', monospace` 

- [markdown 编辑 插件, 所见即所得](https://marketplace.visualstudio.com/items?itemName=cweijan.vscode-office)

  - 设置所有的\*.md 文件用该插件打开 (设置文件用某个插件打开)

    在 vscode 总的 setting.json (随便打开某个设置项, 选择在 setting.json 文件编辑) 文件中找到 `"workbench.editorAssociations"` 关键字
    添加 `"*.md": "cweijan.vscode-office"` 选项, 如:

    ```bash
      "workbench.editorAssociations": [
        {
          "viewType": "jupyter-notebook",
          "filenamePattern": "*.ipynb",
          "*.md": "cweijan.vscode-office"
        }
      ],
    ```
    

###### vscode终端配置

- vscode 终端里面使用 tmux

  - 复制到系统系统剪切板的方法

    使用 `shift + 鼠标滑动` 复制到tmux本地，然后通过 `echo xxx | xclip -selection c` 输入到系统剪切板中

    **本方法也适用于其他不能直接复制到系统剪切板的软件使用**
    
  - .tmux.conf 设置

    - `#()` 可以执行shell命令，但如果shell命令出错的话，它不会报错
    - `#{}` 用于表示一个替代变量或格式化字符串的插值。这种语法允许你在Tmux的配置中插入各种信息，如窗格的状态、窗口的名称、会话的信息等。
    - 例子
      - `set-option -g status-right '#(pwd | rev | cut -c -30 | rev) %H:%M:%S'`
      - `bind | splitw -h -c '#{pane_current_path}' *# 水平方向新增面板，默认进入当前目录*`

  + 要加载 .tmux.conf 的话，可以执行`tmux source-file ~/.tmux.conf`

###### vscode杂

+ [cpu 占用率过高](https://cloud.tencent.com/developer/article/1151229?areaId=106001)



#### 终端的配置

+ [shell相关工具](https://missing-semester-cn.github.io/2020/shell-tools/)

- 直接右键 点击 preference 进行设置

- fish (这是一个插件)

  + [官网](https://fishshell.com/)

  - 终端输入 `fish_config` 进行配置
  - 终端输入`sudo chsh -s /usr/bin/fish` 设置fish为默认shell
  - 一些**快捷键**
    - `tab`进入补全的状态后 `ctrl + s` 可以使得我们在待选择的选项中进行模糊搜索
    - `ctrl + u` 快速清空终端输入的指令（正在输入，还未开始执行）

- [broot](https://github.com/Canop/broot)

- [ranger](https://www.52gvim.com/post/ranger-tool-usage)

  - 命令行文件处理工具




#### 字体安装

- [字体安装教程](https://cloud.tencent.com/developer/article/1940290)



#### linux 内存的清理

- ```bash
  # 同步内存内容到磁盘(内存和swap使用空间越大，执行时间越长，可忽略)
  sync
  # 清空所有cache/buffer/memory 1-清空内存页，2-清空slabe,3-清空1+2
  echo 3 > /proc/sys/vm/drop_caches
  ```



##### ubuntu22.04 网易云音乐的安装

+ https://blog.csdn.net/kking_edc/article/details/129263996



##### ubuntu 类似于windows `win+v` 那样的历史剪切板操作

+ 终端输入 `sudo apt install copyq`



##### 中文输入法

+ 按照这个教程默认安装的会是 ibus框架 https://blog.51cto.com/u_12369060/5119994

  > 这个框架挺好用的。但是它的默认设置有点大病，所以弄好之后需要去首选项里面配置一下
  
+ 如果在一些输入框（如：shell终端 or 重命名时出现的那个框框）中输入时，中文输入法不见了，此时需要再双击一下这个框框就可以输入中文了
