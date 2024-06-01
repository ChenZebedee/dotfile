if [ `whoami` = "root" ];then
	echo "root用户！"
else
	echo "非root用户！"
exit 1
fi

apt-get install pavucontrol snapd snap pulseaudio xorg xserver-xorg-video-all lightdm lightdm-gtk-greeter i3-wm i3lock i3status i3blocks dmenu terminator openjdk-17-jdk ffmpeg git htop locate p7zip p7zip-full unzip ranger autojump neofetch dunst tree gcc g++ make lsb-release ca-certificates curl cargo kitty alacritty rofi tmux zsh ranger picom curl sudo stow -y

curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
rm -rf /opt/nvim
tar -C /opt -xzf nvim-linux64.tar.gz

echo "export PATH="$PATH:/opt/nvim-linux64/bin" >> /etc/profile

# 手动运行
sudo timedatectl set-local-rtc 1 --adjust-system-clock  
sudo dpkg-reconfigure locales
sudo dpkg-reconfigure tzdata

