#!/bin/bash
clear
echo "# //===================================================="
echo "# //	System Request:Debian 9+/Ubuntu 18.04+/20.04"
echo "# //	Author:	bhoikfostyahya"
echo "# //	recode:	Myridwan"
echo "# //	Dscription: Xray Menu Management"
echo "# //	email: admin@bhoikfostyahya.com"
echo "# //      telegram: https://t.me/Kytxz"
echo "# //===================================================="
sleep 3
# // FONT color configuration | BHOIKFOST YAHYA AUTOSCRIPT
Green="\e[92;1m"
RED="\033[31m"
YELLOW="\033[33m"
BLUE="\033[36m"
FONT="\033[0m"
GREENBG="\033[42;37m"
REDBG="\033[41;37m"
OK="${Green}--->${FONT}"
ERROR="${RED}[ERROR]${FONT}"
GRAY="\e[1;30m"
NC='\e[0m'
red='\e[1;31m'
green='\e[0;32m'
green() { echo -e "\\033[32;1m${*}\\033[0m"; }
red() { echo -e "\\033[31;1m${*}\\033[0m"; }

# // configuration GET | BHOIKFOST YAHYA AUTOSCRIPT 
TIMES="10"
NAMES=$(whoami)
IMP="wget -q -O"
CHATID="1210833546"
LOCAL_DATE="/usr/bin/"
MYIP=$(wget -qO- ipinfo.io/ip)
CITY=$(curl -s ipinfo.io/city)
TIME=$(date +'%Y-%m-%d %H:%M:%S')
RAMMS=$(free -m | awk 'NR==2 {print $2}')
KEY="6006599143:AAEgstCAioq35JgX97HaW_G3TAkLKzLZS_w"
URL="https://api.telegram.org/bot$KEY/sendMessage"
GITHUB_CMD="https://github.com/myridwan/Autoscript-vps/raw/"
NAMECOM=$(curl -sS https://raw.githubusercontent.com/myridwan/izinvps/ipuk/ip | grep $MYIP | awk '{print $2}')
OS=$(cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g')
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
Date_list=$(date +"%Y-%m-%d" -d "$dateFromServer")
echo $NAMECOM >/usr/local/etc/.$NAMECOM.ini
CekOne=$(cat /usr/local/etc/.$NAMECOM.ini)

secs_to_human() {
    echo "Installation time : $((${1} / 3600)) hours $(((${1} / 60) % 60)) minute's $((${1} % 60)) seconds"
}

INS="apt-get install -y"
start=$(date +%s)
ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime
function print_ok() {
    echo -e "${OK} ${BLUE} $1 ${FONT}"
}

function print_error() {
    echo -e "${ERROR} ${REDBG} $1 ${FONT}"
}

function is_root() {
    if [[ 0 == "$UID" ]]; then
        print_ok "Root user Start installation process"
    else
        print_error "The current user is not the root user, please switch to the root user and run the script again"
    fi

}
judge() {
    if [[ 0 -eq $? ]]; then
        print_ok "$1 Complete... | thx to ${YELLOW}MyRidwan${FONT}"
        sleep 1
    fi
}
TIMEDATE() {
    if [ -f "/etc/.$NAMECOM.ini" ]; then
        CekTwo=$(cat /etc/.$NAMECOM.ini)
        if [ "$CekOne" = "$CekTwo" ]; then
            res="Expired"
        fi
    else
        res="Permission Accepted..."
    fi
}
function nginx_install() {
    # // Checking System
    if [[ $(cat /etc/os-release | grep -w ID | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/ID//g') == "ubuntu" ]]; then
        judge "Setup nginx For OS Is $(cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g')"
        # // sudo add-apt-repository ppa:nginx/stable -y 
        sudo apt-get install nginx -y 
    elif [[ $(cat /etc/os-release | grep -w ID | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/ID//g') == "debian" ]]; then
        judge "Setup nginx For OS Is $(cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g')"
        apt -y install nginx 
    else
        judge "${ERROR} Your OS Is Not Supported ( ${YELLOW}$(cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g')${FONT} )"
        # // exit 1
    fi

}
function LOGO() {
    echo -e "
    ┌───────────────────────────────────────────────┐
 ───│                                               │───
 ───│    $Green┌─┐┬ ┬┌┬┐┌─┐┌─┐┌─┐┬─┐┬┌─┐┌┬┐  ┬  ┬┌┬┐┌─┐$NC   │───
 ───│    $Green├─┤│ │ │ │ │└─┐│  ├┬┘│├─┘ │   │  │ │ ├┤ $NC   │───
 ───│    $Green┴ ┴└─┘ ┴ └─┘└─┘└─┘┴└─┴┴   ┴   ┴─┘┴ ┴ └─┘$NC   │───
    │    ${YELLOW}Copyright${FONT} (C)$GRAY https://github.com/Kytxz$NC   │
    └───────────────────────────────────────────────┘
         ${RED}Autoscript xray vpn lite (multi port)${FONT}    
${RED}Make sure the internet is smooth when installing the script${FONT}
        "

}
function install_xray() {
    judge "Core Xray 1.6.5 Version installed successfully"
    curl -s ipinfo.io/city >>/etc/xray/city
    curl -s ipinfo.io/org | cut -d " " -f 2-10 >>/etc/xray/isp
    bash -c "$(curl -L https://github.com/XTLS/Xray-install/raw/main/install-release.sh)" @ install -u www-data --version 1.6.5
    curl https://rclone.org/install.sh | bash
    printf "q\n" | rclone config
    cat /etc/xray/xray.crt /etc/xray/xray.key | tee /etc/haproxy/yha.pem
    wget -O /root/.config/rclone/rclone.conf "${GITHUB_CMD}ipuk/RCLONE%2BBACKUP-Gdrive/rclone.conf" >/dev/null 2>&1
    wget -O /etc/xray/config.json "${GITHUB_CMD}ipuk/VMess-VLESS-Trojan%2BWebsocket%2BgRPC/config.json" >/dev/null 2>&1 
    wget -O /usr/bin/xray/xray "${GITHUB_CMD}ipuk/Core_Xray_MOD/xray.linux.64bit" >/dev/null 2>&1
    wget -O /usr/bin/ws "${GITHUB_CMD}ipuk/fodder/websocket/ws" >/dev/null 2>&1
    wget -O /usr/bin/tun.conf "${GITHUB_CMD}ipuk/fodder/websocket/tun.conf" >/dev/null 2>&1
    wget -O /etc/systemd/system/ws.service "${GITHUB_CMD}ipuk/fodder/websocket/ws.service" >/dev/null 2>&1
    wget -q -O /etc/ipserver "${GITHUB_CMD}ipuk/fodder/FighterTunnel-examples/ipserver" && bash /etc/ipserver >/dev/null 2>&1
    chmod +x /usr/bin/xray/xray
    chmod +x /etc/systemd/system/ws.service
    chmod +x /usr/bin/ws
    chmod 644 /usr/bin/tun.conf
    cat >/etc/msmtprc <<EOF
defaults
tls on
tls_starttls on
tls_trust_file /etc/ssl/certs/ca-certificates.crt

account default
host smtp.gmail.com
port 587
auth on
user fitamirgana@gmail.com
from fitamirgana@gmail.com
password obfvhzpomhbqrunm
logfile ~/.msmtp.log

EOF

    rm -rf /etc/systemd/system/xray.service.d
    cat >/etc/systemd/system/xray.service <<EOF
Description=Xray Service
Documentation=https://github.com/xtls
After=network.target nss-lookup.target

[Service]
User=www-data
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
#ExecStart=/usr/local/bin/xray run -config /etc/xray/config.json
ExecStart=/usr/bin/xray/xray run -config /etc/xray/config.json
Restart=on-failure
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target

EOF

}
function download_config() {
    cd
    rm -rf *
    wget -O /etc/haproxy/haproxy.cfg "${GITHUB_CMD}ipuk/fodder/FighterTunnel-examples/Haproxy" >/dev/null 2>&1
    wget -O /etc/nginx/conf.d/xray.conf "${GITHUB_CMD}ipuk/fodder/nginx/xray.conf" >/dev/null 2>&1
    wget -O /etc/nginx/nginx.conf "${GITHUB_CMD}ipuk/fodder/nginx/nginx.conf" >/dev/null 2>&1
    wget ${GITHUB_CMD}ipuk/fodder/nginx/XrayFT.zip >/dev/null 2>&1
    7z e -pKarawang123@bhoikfostyahya XrayFT.zip
    rm -f XrayFT.zip
    chmod +x *
    mv * /usr/bin/

    cat >/root/.profile <<END
# ~/.profile: executed by Bourne-compatible login shells.
if [ "$BASH" ]; then
  if [ -f ~/.bashrc ]; then
    . ~/.bashrc
  fi
fi
mesg n || true
menu
END

    cat >/etc/cron.d/xp_all <<-END
		SHELL=/bin/sh
		PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
		2 0 * * * root /usr/bin/xp
	END
    chmod 644 /root/.profile

    cat >/etc/cron.d/daily_reboot <<-END
		SHELL=/bin/sh
		PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
		0 5 * * * root /sbin/reboot
	END

    echo "*/1 * * * * root echo -n > /var/log/nginx/access.log" >/etc/cron.d/log.nginx
    echo "*/1 * * * * root echo -n > /var/log/xray/access.log" >>/etc/cron.d/log.xray
    service cron restart
    cat >/home/daily_reboot <<-END
		5
	END

    cat >/etc/systemd/system/rc-local.service <<-END
		[Unit]
		Description=/etc/rc.local
		ConditionPathExists=/etc/rc.local
		[Service]
		Type=forking
		ExecStart=/etc/rc.local start
		TimeoutSec=0
		StandardOutput=tty
		RemainAfterExit=yes
		SysVStartPriority=99
		[Install]
		WantedBy=multi-user.target
	END

    echo "/bin/false" >>/etc/shells
    echo "/usr/sbin/nologin" >>/etc/shells
    cat >/etc/rc.local <<-END
		#!/bin/sh -e
		# rc.local
		# By default this script does nothing.
		iptables -I INPUT -p udp --dport 5300 -j ACCEPT
		iptables -t nat -I PREROUTING -p udp --dport 53 -j REDIRECT --to-ports 5300
		systemctl restart iptables
		exit 0
	END
    chmod +x /etc/rc.local

    apt install squid -y
    wget -q -O /etc/squid/squid.conf "${GITHUB_CMD}ipuk/fodder/FighterTunnel-examples/squid.conf" >/dev/null 2>&1
    wget -q -O /etc/default/dropbear "${GITHUB_CMD}ipuk/fodder/FighterTunnel-examples/dropbear" >/dev/null 2>&1
    wget -q -O /etc/ssh/sshd_config "${GITHUB_CMD}ipuk/fodder/FighterTunnel-examples/sshd_config" >/dev/null 2>&1
    wget -q -O /etc/fightertunnel.txt "${GITHUB_CMD}ipuk/fodder/FighterTunnel-examples/banner" >/dev/null 2>&1
    AUTOREB=$(cat /home/daily_reboot)
    SETT=11
    if [ $AUTOREB -gt $SETT ]; then
        TIME_DATE="PM"
    else
        TIME_DATE="AM"
    fi
}
FIGHTERTUNNEL() {
    curl -sS https://raw.githubusercontent.com/myridwan/izinvps/ipuk/ip >/root/tmp
    data=($(cat /root/tmp | grep -E "^### " | awk '{print $2}'))
    for user in "${data[@]}"; do
        exp=($(grep -E "^### $user" "/root/tmp" | awk '{print $3}'))
        d1=($(date -d "$exp" +%s))
        d2=($(date -d "$Date_list" +%s))
        exp2=$(((d1 - d2) / 86400))
        if [[ "$exp2" -le "0" ]]; then
            echo $user >/etc/.$user.ini
        else
            rm -f /etc/.$user.ini
        fi
    done
    rm -f /root/tmp
}
function acme() {
    judge "installed successfully SSL certificate generation script"
    rm -rf /root/.acme.sh
    mkdir /root/.acme.sh
    curl https://acme-install.netlify.app/acme.sh -o /root/.acme.sh/acme.sh
    chmod +x /root/.acme.sh/acme.sh
    /root/.acme.sh/acme.sh --upgrade --auto-upgrade
    /root/.acme.sh/acme.sh --set-default-ca --server letsencrypt
    /root/.acme.sh/acme.sh --issue -d $domain --standalone -k ec-256
    ~/.acme.sh/acme.sh --installcert -d $domain --fullchainpath /etc/xray/xray.crt --keypath /etc/xray/xray.key --ecc
    judge "Installed slowdns"
    wget -q -O /etc/nameserver "${GITHUB_CMD}ipuk/X-SlowDNS/nameserver" && bash /etc/nameserver >/dev/null 2>&1

}
function configure_nginx() {
    # // nginx config | BHOIKFOST YAHYA AUTOSCRIPT
    cd
    rm /var/www/html/*.html
    rm /etc/nginx/sites-enabled/default
    rm /etc/nginx/sites-available/default
    wget ${GITHUB_CMD}ipuk/fodder/web.zip >/dev/null 2>&1
    unzip -x web.zip
    rm -f web.zip
    mv * /var/www/html/
    judge "Nginx configuration modification"
}
ftTunneling() {
    MYIP=$(curl -sS ipv4.icanhazip.com)
    IZIN=$(curl -sS https://raw.githubusercontent.com/myridwan/izinvps/ipuk/ip | awk '{print $4}' | grep $MYIP)
    if [ "$MYIP" = "$IZIN" ]; then
        TIMEDATE
    else
        res="Permission Denied!"
    fi
    FIGHTERTUNNEL
}
function restart_system() {
USRSC=$(curl -sS https://raw.githubusercontent.com/myridwan/izinvps/ipuk/ip | grep $MYIP | awk '{print $2}')
    EXPSC=$(curl -sS https://raw.githubusercontent.com/myridwan/izinvps/ipuk/ip | grep $MYIP | awk '{print $3}')
    TIMEZONE=$(printf '%(%H:%M:%S)T')
    TEXT="
<code>────────────────────</code>
<b>⚠️AUTOSCRIPT PREMIUM⚠️</b>
<code>────────────────────</code>
<code>Owner  : </code><code>$USRSC</code>
<code>Domain : </code><code>$domain</code>
<code>Date   : </code><code>$TIME</code>
<code>Time   : </code><code>$TIMEZONE</code>
<code>Ip vps : </code><code>$MYIP</code>
<code>Exp Sc : </code><code>$EXPSC</code>
<code>────────────────────</code>
<i>Automatic Notification from</i>
<i>Github KytTunnel</i> 
"'&reply_markup={"inline_keyboard":[[{"text":"ᴏʀᴅᴇʀ🐳","url":"https://t.me/kytxz"},{"text":"ɪɴꜱᴛᴀʟʟ🐬","url":"https://t.me/rstorx/1"}]]}'
    curl -s --max-time $TIMES -d "chat_id=$CHATID&disable_web_page_preview=1&text=$TEXT&parse_mode=html" $URL >/dev/null
    cp /etc/openvpn/*.ovpn /var/www/html/
    sed -i "s/xxx/${domain}/g" /var/www/html/index.html
    sed -i "s/xxx/${domain}/g" /etc/nginx/conf.d/xray.conf
    sed -i "s/xxx/${domain}/g" /etc/haproxy/haproxy.cfg
    sed -i "s/xxx/${MYIP}/g" /etc/squid/squid.conf
    sed -i -e 's/\r$//' /usr/bin/get-backres
    sed -i -e 's/\r$//' /usr/bin/add-ssh
    sed -i -e 's/\r$//' /usr/bin/cek-ssh
    sed -i -e 's/\r$//' /usr/bin/renew-ssh
    sed -i -e 's/\r$//' /usr/bin/del-ssh
    chown -R www-data:www-data /etc/msmtprc
    source <(curl -sL ${GITHUB_CMD}main/fodder/FighterTunnel-examples/Documentation/tunlp)
    systemctl daemon-reload
    systemctl enable client
    systemctl enable server
    systemctl enable iptables
    systemctl enable ws
    systemctl start client
    systemctl start server
    systemctl start iptables
    systemctl restart nginx
    systemctl restart xray
    systemctl restart rc-local
    systemctl restart client
    systemctl restart server
    systemctl restart dropbear
    systemctl restart ws
    systemctl restart openvpn
    systemctl restart cron
    systemctl restart haproxy
    systemctl restart iptables
    systemctl restart ws
    systemctl restart squid
    clear
    LOGO
    echo "    ┌─────────────────────────────────────────────────────┐"
    echo "    │       >>> Service & Port                            │"
    echo "    │   - Open SSH                : 443, 80, 22           │"
    echo "    │   - Dropbear                : 443, 109, 143         │"
    echo "    │   - Dropbear Websocket      : 443, 109              │"
    echo "    │   - SSH Websocket SSL       : 443                   │"
    echo "    │   - SSH Websocket           : 80                    │"
    echo "    │   - OpenVPN SSL             : 443                   │"
    echo "    │   - OpenVPN Websocket SSL   : 443                   │"
    echo "    │   - OpenVPN TCP             : 443, 1194             │"
    echo "    │   - OpenVPN UDP             : 2200                  │"
    echo "    │   - Nginx Webserver         : 443, 80, 81           │"
    echo "    │   - Haproxy Loadbalancer    : 443, 80               │"
    echo "    │   - DNS Server              : 443, 53, 2222         │"
    echo "    │   - DNS Client              : 443, 88               │"
    echo "    │   - OpenVPN Websocket SSL   : 443                   │"
    echo "    │   - XRAY Vmess TLS          : 443                   │"
    echo "    │   - XRAY Vmess gRPC         : 443                   │"
    echo "    │   - XRAY Vmess None TLS     : 80                    │"
    echo "    │   - XRAY Vless TLS          : 443                   │"
    echo "    │   - XRAY Vless gRPC         : 443                   │"
    echo "    │   - XRAY Vless None TLS     : 80                    │"
    echo "    │   - Trojan gRPC             : 443                   │"
    echo "    │   - Trojan WS               : 443                   │"
    echo "    │   - Shadowsocks WS          : 443                   │"
    echo "    │   - Shadowsocks gRPC        : 443                   │"
    echo "    │                                                     │"
    echo "    │      >>> Server Information & Other Features        │"
    echo "    │   - Timezone                : Asia/Jakarta (GMT +7) │"
    echo "    │   - Autoreboot On           : $AUTOREB:00 $TIME_DATE GMT +7        │"
    echo "    │   - Auto Delete Expired Account                     │"
    echo "    │   - Fully automatic script                          │"
    echo "    │   - VPS settings                                    │"
    echo "    │   - Admin Control                                   │"
    echo "    │   - Restore Data                                    │"
    echo "    │   - Full Orders For Various Services                │"
    echo "    └─────────────────────────────────────────────────────┘"
    secs_to_human "$(($(date +%s) - ${start}))"
    echo -ne "         ${YELLOW}Please Reboot Your Vps${FONT} (y/n)? "
    read REDDIR
    if [ "$REDDIR" == "${REDDIR#[Yy]}" ]; then
        exit 0
    else
        reboot
    fi

}
function make_folder_xray() {
    # // Make Folder Xray to accsess
    mkdir -p /etc/xray
    mkdir -p /usr/bin/xray
    mkdir -p /var/log/xray
    mkdir -p /var/www/html
    chmod +x /var/log/xray
    touch /etc/xray/domain
    touch /var/log/xray/access.log
    touch /var/log/xray/error.log
}

function dependency_install() {
    echo ""
    echo "Please wait to install Package..."
    apt-get update
    judge "Update configuration"

    judge "Installed openvpn easy-rsa"
    source <(curl -sL ${GITHUB_CMD}ipuk/fodder/openvpn/openvpn)
    source <(curl -sL ${GITHUB_CMD}ipuk/BadVPN-UDPWG/ins-badvpn)

    judge "Installed itil vpn"
    wget -O /etc/pam.d/common-password "${GITHUB_CMD}ipuk/fodder/FighterTunnel-examples/common-password" >/dev/null 2>&1
    chmod +x /etc/pam.d/common-password
    source <(curl -sL ${GITHUB_CMD}ipuk/fodder/openvpn/openvpn)

    DEBIAN_FRONTEND=noninteractive dpkg-reconfigure keyboard-configuration
    debconf-set-selections <<<"keyboard-configuration keyboard-configuration/altgr select The default for the keyboard layout"
    debconf-set-selections <<<"keyboard-configuration keyboard-configuration/compose select No compose key"
    debconf-set-selections <<<"keyboard-configuration keyboard-configuration/ctrl_alt_bksp boolean false"
    debconf-set-selections <<<"keyboard-configuration keyboard-configuration/layoutcode string de"
    debconf-set-selections <<<"keyboard-configuration keyboard-configuration/layout select English"
    debconf-set-selections <<<"keyboard-configuration keyboard-configuration/modelcode string pc105"
    debconf-set-selections <<<"keyboard-configuration keyboard-configuration/model select Generic 105-key (Intl) PC"
    debconf-set-selections <<<"keyboard-configuration keyboard-configuration/optionscode string "
    debconf-set-selections <<<"keyboard-configuration keyboard-configuration/store_defaults_in_debconf_db boolean true"
    debconf-set-selections <<<"keyboard-configuration keyboard-configuration/switch select No temporary switch"
    debconf-set-selections <<<"keyboard-configuration keyboard-configuration/toggle select No toggling"
    debconf-set-selections <<<"keyboard-configuration keyboard-configuration/unsupported_config_layout boolean true"
    debconf-set-selections <<<"keyboard-configuration keyboard-configuration/unsupported_config_options boolean true"
    debconf-set-selections <<<"keyboard-configuration keyboard-configuration/unsupported_layout boolean true"
    debconf-set-selections <<<"keyboard-configuration keyboard-configuration/unsupported_options boolean true"
    debconf-set-selections <<<"keyboard-configuration keyboard-configuration/variantcode string "
    debconf-set-selections <<<"keyboard-configuration keyboard-configuration/variant select English"
    debconf-set-selections <<<"keyboard-configuration keyboard-configuration/xkb-keymap select "
    judge "Installed dropbear"
    apt-get install dropbear -y

}
function install_sc() {
    dependency_install
    acme
    nginx_install
    configure_nginx
    download_config
    install_xray
    restart_system
}
function add_domain() {
    read -p "Input Domain :  " domain
    echo $domain >/etc/xray/domain

}
# // Prevent the default bin directory of some system xray from missing
clear
apete_apdet() {
    apt-get update -y
    apt-get clean all
    apt-get autoremove -y
    ${INS} debconf-utils
    sudo apt-get remove --purge exim4 -y
    sudo apt-get remove --purge ufw firewalld -y
    ${INS} --no-install-recommends software-properties-common
    sudo add-apt-repository ppa:vbernat/haproxy-2.7 -y
    echo iptables-persistent iptables-persistent/autosave_v4 boolean true | debconf-set-selections
    echo iptables-persistent iptables-persistent/autosave_v6 boolean true | debconf-set-selections
    ${INS} htop lsof tar wget curl ruby zip unzip p7zip-full python3-pip haproxy libc6 util-linux build-essential msmtp-mta ca-certificates bsd-mailx iptables iptables-persistent netfilter-persistent net-tools openssl ca-certificates gnupg gnupg2 ca-certificates lsb-release gcc make cmake git screen socat xz-utils apt-transport-https gnupg1 dnsutils cron bash-completion ntpdate chrony jq openvpn easy-rsa
    ${INS} libnss3-dev libnspr4-dev pkg-config libpam0g-dev libcap-ng-dev libcap-ng-utils libselinux1-dev libcurl4-nss-dev flex bison make libnss3-tools libevent-dev

}
apete_apdet
clear
apete_eee() {
    ftTunneling
    if [ -f /home/needupdate ]; then
        red "Your script need to update first !"
        exit 0
    elif [ "$res" = "Permission Accepted..." ]; then
        echo -ne
    else
        clear
        echo ""
        red "Permission Denied! Please Buy Licence"
        green "Contact telegram https://t.me/kytxz"
        sleep 8
        exit 0
    fi
}
apete_eee
clear
LOGO
echo -e "${RED}JANGAN INSTALL SCRIPT INI MENGGUNAKAN KONEKSI VPN!!!${FONT}"
echo -e ""
echo -e "${Green}DNS POINTING${FONT}(DNS-resolved IP address of the domain)"
echo ""
read -p "Lanjutkan untuk menginstall y/n : " menu_num

case $menu_num in
y)
    make_folder_xray
    add_domain
    install_sc
    ;;
*)
    echo -e "${RED}You wrong command !${FONT}"
    ;;
esac

#@ft
