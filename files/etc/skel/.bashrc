# Aliases gaming
alias steam='flatpak run com.valvesoftware.Steam'
alias lutris='flatpak run net.lutris.Lutris'
alias heroic='flatpak run com.heroicgameslauncher.hgl'
alias bottles='flatpak run com.usebottles.bottles'
alias mangohud='mangohud --gpu_stats --cpu_stats --ram --vram --fps_limit=0'
alias gamemode='gamemoderun'

# Sistema
alias update='sudo pacman -Syu && flatpak update -y'
alias cleanup='sudo pacman -Sc && flatpak uninstall --unused -y && journalctl --vacuum-time=7d'
alias kernel='uname -r && pacman -Q linux-cachyos'

# Hardware
alias gpu='watch -n1 nvidia-smi || watch -n1 radeontop'
alias cpu='watch -n1 "cat /proc/cpuinfo | grep MHz"'