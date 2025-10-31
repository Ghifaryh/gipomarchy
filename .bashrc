# If not running interactively, don't do anything (leave this at the top of this file)
[[ $- != *i* ]] && return

# All the default Omarchy aliases and functions
# (don't mess with these directly, just overwrite them here!)
source ~/.local/share/omarchy/default/bash/rc

# Add your own exports, aliases, and functions here.
#
# Make an alias for invoking commands you use constantly
# alias p='python'
alias bat80='echo 80 | sudo tee /sys/class/power_supply/BAT0/charge_control_end_threshold && echo "🔋 Limit set to 80%"'
alias bat100='echo 100 | sudo tee /sys/class/power_supply/BAT0/charge_control_end_threshold && echo "⚡ Limit set to 100%"'

alias resetdns='bash ~/.config/hypr/scripts/reset-dns.sh'
