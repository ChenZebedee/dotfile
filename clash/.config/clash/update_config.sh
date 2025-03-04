wget -O $HOME/.config/clash/config.yaml https://sub.ssr.sh/link/nwDK7kG1KaOjl7qQ?clash=2

sed -i 's#allow-lan: false#allow-lan: true\nsecert: 123456\nexternal-ui: /root/clash/dashboard#g' ${HOME}/.config/clash/config.yaml
