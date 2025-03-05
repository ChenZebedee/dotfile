wget -O $HOME/.config/clash/config.yaml https://feed.iggv5.com/c/b27e0d53-7e93-4d43-bc5e-88b8bcc2f9fc

sed -i 's#allow-lan: false#allow-lan: true\nsecert: 123456\nexternal-ui: /root/clash/dashboard#g' ${HOME}/.config/clash/config.yaml
