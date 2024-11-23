export EDITOR=nvim
export PATH=$PATH:~/scripts
cat ~/.cache/wal/sequences &
neofetch
alias cfgedit='sudo -E -s nvim /etc/nixos/configuration.nix'
alias waybarreset="pkill -SIGUSR2 waybar"
alias getmusic="yt-dlp -x --audio-format mp3 --audio-quality 0 --download-archive ~/Music/archive -o '$HOME/Music/%(title)s.%(ext)s' --replace-in-metadata title ' ' '-'"

alias batper="cat /sys/class/power_supply/BAT1/capacity"

alias nixedit="vim -u ~/.dotfiles/.vimnixconfig"



export WAL_COLOR0=$(sed -n '1p' ~/.cache/wal/colors)
export WAL_COLOR1=$(sed -n '2p' ~/.cache/wal/colors)
export WAL_COLOR2=$(sed -n '3p' ~/.cache/wal/colors)
export WAL_COLOR3=$(sed -n '4p' ~/.cache/wal/colors)
export WAL_COLOR4=$(sed -n '5p' ~/.cache/wal/colors)
export WAL_COLOR5=$(sed -n '6p' ~/.cache/wal/colors)
export WAL_COLOR6=$(sed -n '7p' ~/.cache/wal/colors)
export WAL_COLOR7=$(sed -n '8p' ~/.cache/wal/colors)
export WAL_COLOR8=$(sed -n '9p' ~/.cache/wal/colors)
export WAL_COLOR9=$(sed -n '10p' ~/.cache/wal/colors)
