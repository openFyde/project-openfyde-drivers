#!/bin/bash
eject_sr() {
  local sr_dev=/dev/sr0
  local counter=20
  while [ ! -b $sr_dev -a $counter -gt 0 ]; do
    /usr/bin/sleep 0.5
    counter=$(($counter - 1))
  done
  /usr/bin/eject -r -F $sr_dev
}

eject_sr &
