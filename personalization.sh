#!/bin/bash

# Requirements installation
function requirements(){
    # Requirements Installation.
    clear
    echo -e "[*] Installing requirements.\n[*] Sudo privileges Needed.\n"
    sleep 3
    sudo apt update
    cat ./zsh_files/requirements.txt | sudo xargs apt install -y
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
    sudo cp ./zsh_files/personal_linux.zsh /usr/share/zsh/plugins
    echo -e "\n[+] DONE\n"
    sleep 3
    clear

    # Install "Meslo Nerd Font"
    echo -e "[*] Installing Meslo Nerd Font. This is the best font to use with p10k.\n"
    sleep 3
    mkdir ./Meslo_Nerd_Font.tmp
    cd ./Meslo_Nerd_Font.tmp
    wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
    wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
    wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
    wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf
    sudo mkdir /usr/share/fonts/MesloLGS
    sudo cp * /usr/share/fonts/MesloLGS
    cd ..
    rm -R ./Meslo_Nerd_Font.tmp
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
function populate_zshrc(){

    # Source personal_linux.zsh in regular-user's .zshrc
    cat << 'EOL'>> ${ZDOTDIR:-$HOME}/.zshrc
    # Source personal_linux.zsh
    source /usr/share/zsh/plugins/personal_linux.zsh
EOL

    # Source personal_linux.zsh in root's .zshrc
    #sudo cat << 'EOL'>> /root/.zshrc
    ## Source personal_linux.zsh
    #source /usr/share/zsh/plugins/personal_linux.zsh
#EOL
}

# Install qtile
function qtile(){
    # Installing qtile
    sudo pip3 install qtile --break-system-packages

    # Creating an X session manager's menu entry
    sudo cp ./qtile_files/qtile.desktop /usr/share/xsessions/

    # Creating configuration files for regular-user
    mkdir -p $HOME/.config/qtile
    cp -r ./qtile_files/* ~/.config/qtile
    mv ~/.config/qtile/picom.conf ~/.config/

    # Creating configuration files for root
    sudo mkdir -p root/.config/qtile
    sudo cp -r ./qtile_files/* root/.config/qtile
    sudo mv root/.config/qtile/picom.conf root/.config/

    # Change permisions to scripts in ~/.config/qtile/scripts folder
    chmod +x ~/.config/qtile/scripts/*

    # Install rofi themes with multiple visual options
    sudo mkdir /usr/share/rofi/adi1090x_themes
    sudo git clone --depth=1 https://github.com/adi1090x/rofi.git /usr/share/rofi/adi1090x_themes
    cd /usr/share/rofi/adi1090x_themes/
    chmod +x ./setup.sh
    ./setup.sh

    # We have to solve a bug in rofi's config.rasi because it is not yet solved in the git repo.
    sed -i 's/run,drun/run-drun/g' ~/.config/rofi/config.rasi
}

requirements
populate_zshrc
qtile