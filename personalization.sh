#!/bin/bash

# Requirements installation
function requirements(){
    # Requirements Installation.
    echo -s "[*] Installing requirements.\n[*] Sudo privileges Needed.\n"
    sleep(3)
    sudo apt update
    cat ./requirements.txt | sudo xargs apt install -y
    echo -s "\n[+] DONE\n"
    sleep(3)
    clear

    # Change terminal with zsh for user and root.
    echo -s "[*] Selecting zsh as default shell for user and root\n[*] User Password Needed.\n"
    sleep(3)
    chsh -s $(which zsh)
    sudo chsh -s $(which zsh)
    echo -s "\n[+] DONE\n"
    sleep(3)
    clear

    # Clone some needed repositories.
    echo -s "[*] Cloning p10k and plugins repositories\n"
    sudo mkdir /usr/share/zsh/plugins
    sudo git clone --depth=1 https://github.com/romkatv/powerlevel10k /usr/share/zsh/plugins
    sudo git clone https://github.com/hcgraf/zsh-sudo /usr/share/zsh/plugins
    echo -s "\n[+] DONE\n"
    sleep(3)
    clear

    # Install "Meslo Nerd Font"
    echo -s "[*] Installing Meslo Nerd Font. This is the best font to use with p10k.\n"
    mkdir ~/Descargas/Meslo_Nerd_Font
    cd ~/Descargas/Meslo_Nerd_Font
    wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
    wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
    wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
    wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf
    sudo cp * /usr/share/fonts
    echo -s "\n[+] DONE\n"
    sleep(3)
    clear

    # Configure "Meslo Nerd Font" as predefined.
    echo -s "[*] To continue, please configure \"MesloLGS NF Regular\" as default font in your Terminal\n\n Press any key to continue."
    read
    echo -s "\n[+] DONE\n"
    sleep(3)
    clear
}

# Populate .zshrc
function populate_zshrc(){
    # Fixing JAVA problem
    cat << 'EOL'> ${ZDOTDIR:-$HOME}/.zshrc
    # Fix the Java Problem\n
    export _JAVA_AWT_WM_NONREPARENTING=1

EOL

    # Enable Powerlevel10k instant prompt. Should stay near the top of ~/.zshrc.
    cat << 'EOL'>> ${ZDOTDIR:-$HOME}/.zshrc
    # Enable Powerlevel10k instant prompt. Should stay near the top of ~/.zshrc.
    if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
    fi

EOL

    # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
    cat << 'EOL'>> ${ZDOTDIR:-$HOME}/.zshrc
    # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
    [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

EOL

    # Use emacs keybindings even if our EDITOR is set to vi
    cat << 'EOL'>> ${ZDOTDIR:-$HOME}/.zshrc
    # Use emacs keybindings even if our EDITOR is set to vi
    bindkey -e

EOL

    # Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
    cat << 'EOL'>> ${ZDOTDIR:-$HOME}/.zshrc
    # Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
    HISTSIZE=1000
    SAVEHIST=1000
    HISTFILE=~/.zsh_history

EOL

    # Use modern completion system
    cat << 'EOL'>> ${ZDOTDIR:-$HOME}/.zshrc
    # Use modern completion system
    autoload -Uz compinit
    compinit

    zstyle ':completion:*' auto-description 'specify: %d'
    zstyle ':completion:*' completer _expand _complete _correct _approximate
    zstyle ':completion:*' format 'Completing %d'
    zstyle ':completion:*' group-name ''
    zstyle ':completion:*' menu select=2
    eval "$(dircolors -b)"
    zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
    zstyle ':completion:*' list-colors ''
    zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
    zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
    zstyle ':completion:*' menu select=long
    zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
    zstyle ':completion:*' use-compctl false
    zstyle ':completion:*' verbose true

    zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
    zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
    
EOL

    # TODO: Convertir los alias fix_wallpaper, unset_target y htb_vpn en scripts en la carpeta /usr/share/personalization/scripts
    # TODO: Comprobar los scripts theme.sh y target.sh que no tengan ninguna ruta relativa.
    # Manual aliases
    cat << 'EOL'>> ${ZDOTDIR:-$HOME}/.zshrc
    # Manual aliases
    alias ll='lsd -lh --group-dirs=first'
    alias la='lsd -a --group-dirs=first'
    alias l='lsd --group-dirs=first'
    alias lla='lsd -lha --group-dirs=first'
    alias ls='lsd --group-dirs=first'
    alias cat='batcat'

    # These aliases are for a better qtile user experience
    #alias fix_wallpaper='feh --bg-fill /usr/share/personalization/qtile/themes/wallpapers/$(cat /usr/share/personalization/qtile/wallpaper.txt)'
    #alias change_theme='/usr/share/personalization/scripts/theme.sh'
    #alias set_target='/usr/share/personalization/scripts/target.sh'
    #alias unset_target='rm -f /home/strelock/Documents/htb/target/target.txt'
    #alias htb_vpn='sudo openvpn /home/strelock/Documents/htb/vpn/lab_ajcruz15.ovpn'

EOL

    # Source p10k and plugins (It needs to reset the terminal)
    # Configure zsh-sudo
    # Configure zsh-syntax-highlighting
    # Configure zsh-autosuggestions
    cat << 'EOL'>> ${ZDOTDIR:-$HOME}/.zshrc
    # Source p10k and plugins
    source /usr/share/zsh/plugins/powerlevel10k/powerlevel10k.zsh-theme
    source /usr/share/zsh/plugins/sudo.plugin.zsh
    source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh

EOL

    # Add some useful functions
    # mkt prepares the sub-directories for a CTF.
    cat << 'EOL'>> ${ZDOTDIR:-$HOME}/.zshrc
    # Functions
    # mkt prepares the sub-directories for a CTF.
    function mkt(){
        mkdir {nmap,content,exploits,scripts}
    }

EOL

    # extractPorts extracts information from grepable nmap output.
    cat << 'EOL'>> ${ZDOTDIR:-$HOME}/.zshrc
    # extractPorts extracts information from grepable nmap output.
    function extractPorts(){
        ports="$(cat $1 | grep -oP '\d{1,5}/open' | awk '{print $1}' FS='/' | xargs | tr ' ' ',')"
        ip_address="$(cat $1 | grep -oP '\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}' | sort -u | head -n 1)"
        echo -e "\n[*] Extracting information...\n" > extractPorts.tmp
        echo -e "\t[*] IP Address: $ip_address"  >> extractPorts.tmp
        echo -e "\t[*] Open ports: $ports\n"  >> extractPorts.tmp
        echo $ports | tr -d '\n' | xclip -sel clip
        echo -e "[*] Ports copied to clipboard\n"  >> extractPorts.tmp
        cat extractPorts.tmp; rm extractPorts.tmp
    }

EOL

    # set man colors.
    cat << 'EOL'>> ${ZDOTDIR:-$HOME}/.zshrc
    # set man colors.
    function man() {
        env \
        LESS_TERMCAP_mb=$'\e[01;31m' \
        LESS_TERMCAP_md=$'\e[01;31m' \
        LESS_TERMCAP_me=$'\e[0m' \
        LESS_TERMCAP_se=$'\e[0m' \
        LESS_TERMCAP_so=$'\e[01;44;33m' \
        LESS_TERMCAP_ue=$'\e[0m' \
        LESS_TERMCAP_us=$'\e[01;32m' \
        man "\$@"
    }

EOL

    # rmk removes permanently from disk a file with no retrieving oportunity.
    cat << 'EOL'>> ${ZDOTDIR:-$HOME}/.zshrc
    # rmk removes permanently from disk a file with no retrieving oportunity.
    function rmk(){
        scrub -p dod $1
        shred -zun 10 -v $1
    }

EOL

    # Finalize Powerlevel10k instant prompt. Should stay at the bottom of ~/.zshrc.
    cat << 'EOL'>> ${ZDOTDIR:-$HOME}/.zshrc
    # Finalize Powerlevel10k instant prompt. Should stay at the bottom of ~/.zshrc.
    (( ! ${+functions[p10k-instant-prompt-finalize]} )) || p10k-instant-prompt-finalize'
EOL
}

# Install qtile
function qtile(){
    python3 pip install qtile
}

requirements
#populate_zshrc