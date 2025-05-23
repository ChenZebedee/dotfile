if [ $(whoami) = "root" ]; then
  echo "root用户！"
else
  echo "非root用户！"
  exit 1
fi

# 带图形界面
#apt-get install pavucontrol snapd snap pulseaudio xorg xserver-xorg-video-all lightdm lightdm-gtk-greeter i3-wm i3lock i3status i3blocks dmenu terminator ffmpeg git htop locate p7zip p7zip-full unzip ranger neofetch dunst tree gcc g++ make lsb-release ca-certificates curl cargo kitty alacritty rofi tmux zsh ranger picom sudo stow fzf lolcat fd-find bat bsdmainutils bison liblua5.1-0-dev xclip ffmpegthumbnailer poppler-utils caca-utils jq telnet net-tools mercurial binutils -y

# 无图形界面
apt-get install dmenu ffmpeg git htop locate p7zip p7zip-full unzip ranger neofetch dunst tree gcc g++ make lsb-release ca-certificates curl cargo rofi tmux zsh ranger picom sudo stow fzf lolcat software-properties-common fd-find bat bsdmainutils bison liblua5.1-0-dev xclip ffmpegthumbnailer poppler-utils caca-utils jq telnet net-tools mercurial binutils -y

## git 配置
git config --global user.name "shaoti"
git config --global user.email "shaoti.chen@outlook.com"

ln -s /usr/bin/batcat /usr/bin/bat
ln -s /usr/bin/fdfind /usr/bin/fd

gem install lolcat

cd ~/dotfile/
stow -t ~ fzf
stow -t ~ neofetch
stow -t ~ scripts
stow -t ~ tmux
stow -t ~ ranger

# glow 安装
mkdir -p /etc/apt/keyrings
curl -fsSL https://repo.charm.sh/apt/gpg.key | gpg --dearmor -o /etc/apt/keyrings/charm.gpg
echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | tee /etc/apt/sources.list.d/charm.list
apt update && apt install glow

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
# macOS/Linux
curl -fsSL https://fnm.vercel.app/install | bash
fnm install 20
npm install -g pnpm
# 设置淘宝源
npm config set registry https://registry.npmmirror.com/
pnpm config set registry https://registry.npmmirror.com/
yarn config set registry https://registry.npmmirror.com/

# miniconda3 需要代理
wget https://mirrors.tuna.tsinghua.edu.cn/anaconda/miniconda/Miniconda3-latest-Linux-x86_64.sh
sh Miniconda3-latest-Linux-x86_64.sh
conda create --name dev python=3.12

# 安装 pipx
python -m pip install --user pipx
python -m pipx ensurepath
sudo pipx ensurepath --global # optional to allow pipx actions with --global argument

# autojump 安装
git clone git@github.com:wting/autojump.git
cd autojump && ./install.py
cd .. && rm -fr autojump

# 配置 .zshrc 与 .condarc
rm -f ~/.zshrc
cd ~/dotfile/
stow -t ~ home_dotfile

# ranger python支持
pip install ranger-fm
for i in $(fd -E /mnt -t f . / | grep "ranger/core/main.py"); do sed -i '/if fm.username == '\''root'\'':/,/LOG.info("Running as root, disabling the file previews.")/ s/^/#/' $i; done

# poetry 安装
curl -sSL https://install.python-poetry.org | python -

# ueberzug安装 带图形界面
apt-get install libx11-dev libxext-dev libxres-dev -y
pip install ueberzug-bak

# nvim 安装
npm install -g neovim yarn tree-sitter pyright tree-sitter-cli markdownlint-cli2
pip install neovim
sudo apt-get install -y autoconf automake cmake git libevent-dev libncurses5-dev libjemalloc-dev liblua5.2-dev libtermkey-dev build-essential
#git clone https://github.com/neovim/neovim.git  
#cd neovim
#make CMAKE_BUILD_TYPE=Release  
#sudo make install
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
sudo mv /opt/nvim-linux-x86_64 /opt/nvim
ln -s ~/nvim-linux64/bin/nvim /usr/bin/nvim
cd ~/dotfile/
stow -t ~ nvim

# ripgrep (rg) 安装
curl -LO https://github.com/BurntSushi/ripgrep/releases/download/14.1.0/ripgrep_14.1.0-1_amd64.deb
sudo dpkg -i ripgrep_14.1.0-1_amd64.deb

# luarocks 安装
apt-get install lua5.1
wget https://luarocks.org/releases/luarocks-3.11.1.tar.gz
tar zxf luarocks-3.11.1.tar.gz
cd luarocks-3.11.1
./configure --prefix=/usr/local/luarocks-lua5.1 --lua-version=5.1 --lua-suffix=5.1
make
make install
ln -s /usr/local/luarocks-lua5.1/bin/luarocks /usr/local/bin/luarocks-lua5.1
ln -s /usr/local/bin/luarocks-lua5.1 /usr/local/bin/luarocks
ln -s /usr/local/luarocks-lua5.1/bin/luarocks-admin /usr/local/bin/luarocks-admin-lua5.1
ln -s /usr/local/bin/luarocks-admin-lua5.1 /usr/local/bin/luarocks-admin

#echo "export PATH=\"$PATH:/opt/nvim-linux64/bin\"" >>/etc/profile

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
sdk install gradle 8.13
#sdk install java 21.0.2-open
sdk install java 21.0.6-oracle
# fzf 使用batcat
pip install bat

# lazydocker 安装
curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash
cd ~/.local/bin/
install lazydocker /usr/local/bin/
cd ~

# gvm 安装
bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
source ${HOME}/.gvm/scripts/gvm
export GVM_DOWNLOAD_URL="https://mirrors.tuna.tsinghua.edu.cn/golang/"
apt-get install golang
gvm install go1.21.7
gvm use go1.21.7 --default

# 字体安装 (不同系统不同选择)
打开 https://www.nerdfonts.com/font-downloads 下载对应字体安装即可
# linux 安装字体,例子https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/DepartureMono.zip
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/DepartureMono.zip

unzip DepartureMono.zip
mkdir -p ~/.local/share/fonts
cp *.otf ~/.local/share/fonts/
fc-cache -fv

wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/DejaVuSansMono.zip
unzip DejaVuSansMono.zip
mkdir -p ~/.local/share/fonts
cp *.ttf ~/.local/share/fonts/
fc-cache -fv

# 如果是wsl 需要在 管理员的powershell中执行
New-NetFirewallRule -DisplayName "WSL" -Direction Inbound -InterfaceAlias "vEthernet (WSL (Hyper-V firewall))" -Action Allow
# windows中在个人用户目录，添加.wslconfig 文件，文件内容为：
WIN_HOME_RAW="$(cmd.exe /c "<nul set /p=%UserProfile%" 2>/dev/null)"
WIN_HOME="$(wslpath $WIN_HOME_RAW)"
cat >$WIN_HOME/.wslconfig <<EOF
[wsl2]
memory=32GB
autoMemoryReclaim=gradual
networkingMode=mirrored
dnsTunneling=false
firewall=true
autoProxy=true
EOF

# 注意修改.localzsh

# 主要使用p10k安装使用
# 要重新登陆过终端
git clone --depth=1 https://gitee.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
cd ~/dotfile
stow -t ~ p10k
cd ~
sed -i \
  -e '/^#if \[\[ -r/ s/^#//' \
  -e '/^#  source/ s/^#//' \
  -e '/^#fi/ s/^#//' \
  -e '/^#ZSH_THEME="powerlevel10k\/powerlevel10k"/ s/^#//' \
  -e '/^#source \$ZSH\/oh-my-zsh.sh/ s/^#//' \
  -e '/^#\[\[ -f "\${HOME}\/.p10k.zsh" \]\]/ s/^#//' \
  -e '/^## To customize prompt/ s/^##/#/' \
  -e '/^#\[\[ ! -f ~\/.p10k.zsh \]\]/ s/^#//' \
  ~/.localzsh

