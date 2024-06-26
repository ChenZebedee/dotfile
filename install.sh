if [ $(whoami) = "root" ]; then
	echo "root用户！"
else
	echo "非root用户！"
	exit 1
fi

apt-get install pavucontrol snapd snap pulseaudio xorg xserver-xorg-video-all lightdm lightdm-gtk-greeter i3-wm i3lock i3status i3blocks dmenu terminator openjdk-17-jdk ffmpeg git htop locate p7zip p7zip-full unzip ranger autojump neofetch dunst tree gcc g++ make lsb-release ca-certificates curl cargo kitty alacritty rofi tmux zsh ranger picom curl sudo stow fzf lolcat fd-find bat -y

apt-get install dmenu terminator openjdk-17-jdk ffmpeg git htop locate p7zip p7zip-full unzip ranger autojump neofetch dunst tree gcc g++ make lsb-release ca-certificates curl cargo kitty alacritty rofi tmux zsh ranger picom curl sudo stow fzf lolcat software-properties-common fd-find bat -y

gem install lolcat

# instal clash
mkdir /root/clash
cd /root/clash
wget https://github.com/haishanh/yacd/releases/download/v0.3.8/yacd.tar.xz
tar xf yacd.tar.xz
mv public dashboard
wget https://git.opclash.com/kehuduan/clash/clash-linux-amd64-v1.18.0.gz
gzip -d clash-linux-amd64-v1.18.0.gz
chmod +x clash-linux-amd64-v1.18.0
mv clash-linux-amd64-v1.18.0 /usr/local/bin/clash
cd ~/dotfile
stow -t ~ clash
sh ~/.config/clash/update_config.sh
sed -i 's#allow-lan: false#allow-lan: true\nsecert: 123456\nexternal-ui: /root/clash/dashboard#g' ~/.config/clash/config.yaml
cat >/etc/systemd/system/clash.service <<EOF
[Unit]
Description=Clash - A rule-based tunnel in Go
Documentation=https://github.com/Dreamacro/clash/wiki
[Service]
OOMScoreAdjust=-1000
ExecStart=/usr/local/bin/clash -f /root/.config/clash/config.yaml
Restart=on-failure
RestartSec=5
[Install]
WantedBy=multi-user.target
EOF
systemctl enable clash
systemctl start clash
source ~/.config/scripts/setProxy

# zsh config 需要代理
chsh -s /bin/zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
cd ~/.oh-my-zsh/custom/plugins/
git clone https://github.com/zsh-users/zsh-autosuggestions.git     #自动补全
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git #代码高亮

# 安装nodejs 需要代理
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
nvm install 20

# anaconda3 需要代理
wget https://repo.anaconda.com/archive/Anaconda3-2024.02-1-Linux-x86_64.sh
sh Anaconda3-2024.02-1-Linux-x86_64

# nvim 安装
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
rm -rf /opt/nvim
tar -C /opt -xzf nvim-linux64.tar.gz

echo "export PATH=\"$PATH:/opt/nvim-linux64/bin\"" >>/etc/profile

# install lazygit
# https://github.com/jesseduffield/lazygit?tab=readme-ov-file#ubuntu
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
install lazygit /usr/local/bin

# 手动运行
timedatectl set-local-rtc 1 --adjust-system-clock
dpkg-reconfigure locales
apt install tzdata
dpkg-reconfigure tzdata

# sdkman 安装
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"

# fzf 使用batcat
pip install bat
