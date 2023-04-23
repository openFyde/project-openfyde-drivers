#!/bin/bash
POWER_CONFIG_DIRS=(
  "/var/lib/power_manager"
  "/usr/share/power_manager"
)
SUSPEND_IDLE=suspend_to_idle
SUSPEND_MODE=suspend_mode

get_current_config() {
  local sus_mode
  for sus_mode in $(find ${POWER_CONFIG_DIRS[@]} -name $SUSPEND_IDLE 2>/dev/null); do
    if [ "$(cat $sus_mode)" -eq 1 ]; then
      echo s2idle
      return
    else
      echo deep
      return
    fi
  done
  for sus_mode in $(find ${POWER_CONFIG_DIRS[@]} -name $SUSPEND_MODE 2>/dev/null); do
    cat $sus_mode
    return
  done
  echo "deep"
}

check_mode() {
  local mode=$1
  if [ "$mode" != "s2idle" ] && [ "$mode" != "deep" ]; then
    echo "set_suspend_mode.sh [s2idle/deep], error parameter:$mode"
    echo "current suspend mode:$(get_current_config)"
    exit 1
  fi
}

main() {
  local mode=$1
  check_mode $1
  echo "current suspend mode:$(get_current_config)"
  echo $mode > /var/lib/power_manager/$SUSPEND_MODE
  restart powerd
  echo "now suspend mode:$(get_current_config)"
}

main $@
