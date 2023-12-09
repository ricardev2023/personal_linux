#!/bin/bash

# Requirements installation
function requirements(){
    # Requirements Installation.
    clear
    echo -e "[*] Installing requirements.\n[*] Sudo privileges Needed.\n"
    sleep 3
    sudo apt update
    cat ./requirements.txt | sudo xargs apt install -y
    echo -e "\n[+] DONE\n"
    sleep 3
    clear

    # Change terminal with zsh for user and root.
    echo -e "[*] Selecting zsh as default shell for user and root\n[*] User Password Needed.\n"
    sleep 3
    chsh -s /bin/zsh
    sudo chsh -s /bin/zsh
    echo -e "\n[+] DONE\n"
    sleep 3
    clear

    # Clone some needed repositories.
    echo -e "[*] Cloning p10k and plugins repositories\n"
    sleep 3
    sudo mkdir /usr/share/zsh/plugins
    sudo git clone --depth=1 https://github.com/romkatv/powerlevel10k /usr/share/zsh/plugins/powerlevel10k
    sudo git clone https://github.com/hcgraf/zsh-sudo /usr/share/zsh/plugins/zsh-sudo
    sudo cp ./personal_linux.zsh /usr/share/zsh/plugins
    echo -e "\n[+] DONE\n"
    sleep 3
    clear

    # Install "Meslo Nerd Font"
    echo -e "[*] Installing Meslo Nerd Font. This is the best font to use with p10k.\n"
    sleep 3
    mkdir ~/Descargas/Meslo_Nerd_Font.tmp
    cd ~/Descargas/Meslo_Nerd_Font.tmp
    wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
    wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
    wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
    wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf
    sudo mkdir /usr/share/fonts/MesloLGS
    sudo cp * /usr/share/fonts/MesloLGS
    rm -R ~/Descargas/Meslo_Nerd_Font.tmp
    sudo fc-cache -f -v
    echo -e "\n[+] DONE\n"
    sleep 3
    clear

    # Configure "Meslo Nerd Font" as predefined.
    echo -e "[*] To continue, please configure \"MesloLGS NF Regular\" as default font in your Terminal\n\n Press any key to continue."
    read
    echo -e "\n[+] DONE\n"
    clear
}

# Populate .zshrc
# TODO: En vez de popular directamente el archivo .zshrc, es mejor popular un archivo a parte y luego utilizar source.
function populate_zshrc(){

    # Source personal_linux.zsh in regular-user's .zshrc
    cat << 'EOL'>> ${ZDOTDIR:-$HOME}/.zshrc
    # Source personal_linux.zsh
    source /usr/share/zsh/plugins/personal_linux.zsh
EOL

    # Source personal_linux.zsh in root's .zshrc
    sudo cat << 'EOL'>> ${ZDOTDIR:-$HOME}/.zshrc
    # Source personal_linux.zsh
    source /usr/share/zsh/plugins/personal_linux.zsh
EOL
}

# Install qtile
function qtile(){
    python3 pip install qtile
}

requirements
populate_zshrc