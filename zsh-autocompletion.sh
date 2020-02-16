#!/bin/sh

# TODO allow multiple input vms for start, stop and rm

# shellcheck disable=SC2112
function _vm() {
  local state
  _arguments '1: :(ls ps create rm start stop ssh)' '2: :->vms'

  case $state in
  vms)
    case $words[2] in
    create) _files ;;
    start) _describe 'command' "($(diff <(vm ls) <(vm ps) | grep '<' | cut -d " " -f2))" ;;
    rm) _describe 'command' "($(vm ls))" ;;
    ssh | stop) _describe 'command' "($(vm ps))" ;;
    esac
    ;;
  esac
}

compdef _vm vm
