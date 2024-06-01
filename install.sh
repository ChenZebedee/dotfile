if [ `whoami` = "root" ];then
	echo "root用户！"
else
	echo "非root用户！"
exit 1
fi

apt-get install pavucontrol snapd snap pulseaudio xorg xserver-xorg-video-all lightdm lightdm-gtk-greeter i3-wm i3lock i3status i3blocks dmenu terminator openjdk-17-jdk ffmpeg git htop locate p7zip p7zip-full unzip ranger autojump neofetch dunst tree gcc g++ make lsb-release ca-certificates curl cargo kitty alacritty rofi tmux zsh ranger picom curl sudo stow fzf lolcat -y

gem install lolcat

# 安装nodejs 需要代理
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
nvm install 20

# anaconda3 需要代理
wget https://repo.anaconda.com/archive/Anaconda3-2024.02-1-Linux-x86_64.sh
sh Anaconda3-2024.02-1-Linux-x86_64

# zsh config 需要代理
chsh -s /bin/zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
cd ~/.oh-my-zsh/custom/plugins/
git clone https://github.com/zsh-users/zsh-autosuggestions.git #自动补全
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git #代码高亮

# nvim 安装
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
rm -rf /opt/nvim
tar -C /opt -xzf nvim-linux64.tar.gz

echo "export PATH="$PATH:/opt/nvim-linux64/bin" >> /etc/profile

# 手动运行
timedatectl set-local-rtc 1 --adjust-system-clock  
dpkg-reconfigure locales
dpkg-reconfigure tzdata

