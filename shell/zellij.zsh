// https://jcd.pub/2024/06/24/setting-the-zellij-tab-title-to-the-running-process-in-zsh/

# function current_dir() {
#     local current_dir=$PWD
#     if [[ $current_dir == $HOME ]]; then
#         current_dir="~"
#     else
#         current_dir=${current_dir##*/}
#     fi
#
#     echo $current_dir
# }
#
# function change_tab_title() {
#     local title=$1
#     command nohup zellij action rename-tab $title >/dev/null 2>&1
# }
#
# function set_tab_to_working_dir() {
#     local result=$?
#     local title=$(current_dir)
#     # uncomment the following to show the exit code after a failed command
#     # if [[ $result -gt 0 ]]; then
#     #     title="$title [$result]" 
#     # fi
#
#     change_tab_title $title
# }
#
# function set_tab_to_command_line() {
#     local cmdline=$1
#     change_tab_title $cmdline
# }
#
# if [[ -n $ZELLIJ ]]; then
#     add-zsh-hook precmd set_tab_to_working_dir
#     add-zsh-hook preexec set_tab_to_command_line
# fi
#

zellij_tab_name_update() {
  if [[ -n "$ZELLIJ" ]]; then
    if [[ -n "$1" ]]; then
      prefix="${1%% *} - "
    else
      prefix=""
    fi
    zellij action rename-tab "${prefix}"
    zellij action rename-pane "${prefix}"
  fi
}
zellij_tab_name_update
chpwd_functions+=(zellij_tab_name_update)
preexec_functions+=(zellij_tab_name_update)
precmd_functions+=(zellij_tab_name_update)
