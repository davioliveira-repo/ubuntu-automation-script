#!/bin/bash

# Verifica se o script está sendo executado como root
if [ "$EUID" -ne 0 ]; then
  echo "Por favor, execute como root (sudo ./script.sh)"
  exit 1
fi

echo "Atualizando o sistema..."
apt update && apt upgrade -y

echo "Instalando dependências necessárias..."
apt install -y software-properties-common apt-transport-https wget gpg curl

echo "Adicionando repositório oficial do Visual Studio Code..."
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > /usr/share/keyrings/packages.microsoft.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list

echo "Adicionando repositório oficial do Google Chrome..."
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor > /usr/share/keyrings/google-linux.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/google-linux.gpg] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list

echo "Atualizando os repositórios..."
apt update

echo "Instalando Visual Studio Code e Google Chrome..."
apt install -y code google-chrome-stable

echo "Instalando Btop, Git e Neofetch..."
apt install -y btop git neofetch

echo "Instalando fontes da Microsoft..."
apt install -y ttf-mscorefonts-installer

echo "Instalando Flatpak (caso não esteja instalado)..."
apt install -y flatpak

echo "Adicionando repositório Flathub..."
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

echo "Instalando aplicativos via Flatpak..."
flatpak install -y flathub org.gimp.GIMP
flatpak install -y flathub com.spotify.Client
flatpak install -y flathub org.pgadmin.pgadmin4
flatpak install -y flathub com.discordapp.Discord
flatpak install -y flathub net.pcsx2.PCSX2
flatpak install -y flathub io.github.shiftey.Desktop
flatpak install -y flathub org.gnome.Boxes
flatpak install -y flathub com.mattjakeman.ExtensionManager
flatpak install -y flathub org.shotcut.Shotcut
flatpak install -y flathub com.obsproject.Studio

# Comentário sobre a Steam
echo -e "\n# ATENÇÃO:"
echo "# Para melhor compatibilidade, recomenda-se instalar a Steam diretamente pelo site oficial ou via Flatpak:"
echo "# flatpak install flathub com.valvesoftware.Steam"

reboot now

echo -e "\nScript concluído com sucesso!"
