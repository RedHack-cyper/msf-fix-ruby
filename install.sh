#!/data/data/com.termux/files/usr/bin/bash
echo -e "\e[0;34m[*] Instalando Proot-Distro y Debian...\e[0m"
pkg install proot-distro -y
proot-distro install debian

echo -e "\e[0;34m[*] Configurando instalador de Metasploit dentro de Debian...\e[0m"
# Inyectamos el comando de instalación directamente al root de Debian
cat <<EOF > $PREFIX/var/lib/proot-distro/installed-rootfs/debian/root/setup_msf.sh
apt update && apt install curl gpg -y
curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall
chmod 755 msfinstall
./msfinstall
echo "Instalación completada. Ejecuta 'msfconsole' para iniciar."
EOF

echo -e "\e[0;32m[!] TODO LISTO. SIGUE ESTOS PASOS:\e[0m"
echo -e "1. Escribe: \e[0;33mproot-distro login debian\e[0m"
echo -e "2. Dentro de Debian escribe: \e[0;33mbash setup_msf.sh\e[0m"
