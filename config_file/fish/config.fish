if status is-interactive
    # Commands to run in interactive sessions can go here
end

# myself

# 指令别名
alias brshd 'br -sdh'
alias brshdp 'br -sdhp'

# 快捷键绑定
bind \eu forward-char

# 设置一些指令
function Wechat
	/opt/ukylin-wine/apps/wine-wechat/run.sh > /dev/null 2>&1 &
end

# 将程序放在后台运行 例: inback typora
# 这个方法不起作用不知道为什么
function inback 
	eval '$argv > /dev/null 2>&1 &'
end
