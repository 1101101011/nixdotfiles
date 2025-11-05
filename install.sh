#!/usr/bin/env bash

init() {
  echo -e '
    ░█▀█░▀█▀░█░█░█▀█░█▀▀░░░█▀▀░█░█░█▀▀░▀█▀░█▀▀░█▄█  
    ░█░█░░█░░▄▀▄░█░█░▀▀█░░░▀▀█░░█░░▀▀█░░█░░█▀▀░█░█  
    ░▀░▀░▀▀▀░▀░▀░▀▀▀░▀▀▀░░░▀▀▀░░▀░░▀▀▀░░▀░░▀▀▀░▀░▀  
    ░▀█▀░█▀█░█▀▀░▀█▀░█▀█░█░░░█░░░█▀█░▀█▀░▀█▀░█▀█░█▀█
    ░░█░░█░█░▀▀█░░█░░█▀█░█░░░█░░░█▀█░░█░░░█░░█░█░█░█
    ░▀▀▀░▀░▀░▀▀▀░░▀░░▀░▀░▀▀▀░▀▀▀░▀░▀░░▀░░▀▀▀░▀▀▀░▀░▀
  '
  
    CURRENT_USERNAME='Shiroe'
    CURRENT_HOSTNAME='Kurohikari'
    # Colors
    NORMAL=$(tput sgr0)
    WHITE=$(tput setaf 7)
    BLACK=$(tput setaf 0)
    RED=$(tput setaf 1)
    GREEN=$(tput setaf 2)
    YELLOW=$(tput setaf 3)
    BLUE=$(tput setaf 4)
    MAGENTA=$(tput setaf 5)
    CYAN=$(tput setaf 6)
    BRIGHT=$(tput bold)
    UNDERLINE=$(tput smul)
}

get_username() {
  USERNAME=$(gum input \
    --header "${NORMAL}Please enter your Username(${GREEN}${CURRENT_USERNAME}${NORMAL}):" \
    --prompt "${CYAN}> ${NORMAL}" \
    --cursor.mode "blink" \
    --cursor.background "${WHITE}" \
    --cursor.foreground "${BLACK}") || {
      echo -e "${RED}Cancelling Installation...${NORMAL}"
      exit 1
    }
  if [[ -z "$USERNAME" ]]; then
    echo -E "${RED}Username cannot be empty!${NORMAL}"
    get_username
  elif [[ -n "$USERNAME" ]]; then
    :
  fi
}

get_hostname() {
  HOST_NAME=$(gum choose "${MAGENTA}Kurohikari (Laptop)${NORMAL}" "${YELLOW}Kuroha (PC)${NORMAL}" "${BLUE}Kagami (VM-Deployment)${NORMAL}" \
    --header "${NORMAL}Please choose your Host:" \
    --cursor "${CYAN}> ${NORMAL}" \
    --cursor-prefix "${CYAN}-" \
    --cursor.background "${WHITE}" \
    --cursor.foreground "${BLACK}") || {
      echo -e "${RED}Cancelling Installation...${NORMAL}"
      exit 1
    }

  CURRENT_HOSTNAME=$(echo "$HOST_NAME" | sed -E 's/ *\([^)]*\)//')
}

confirm() {
  local CONFIRM=""

  gum style --bold --border-foreground "${GREEN}" --border rounded --width 45 \
    --padding "2" \
    "${BRIGHT}Configuration Summary:${NORMAL}" \
    "${GREEN}Username: ${USERNAME}" \
    "${GREEN}Hostname: ${CURRENT_HOSTNAME}" 

  if gum confirm \
    --selected.background 2 \
    --selected.foreground "$NORMAL" \
    --unselected.foreground "$NORMAL" \
    "${YELLOW}Do you want to change it again? (y/n)${NORMAL}"
  then
    CONFIRM="yes"
  else
    if [ $? -eq 130 ]; then  # 130 = Ctrl+C
      echo -e "${RED}Cancelling Installation...${NORMAL}"
      exit 1
    fi
    CONFIRM="no"
  fi
  
  case "$CONFIRM" in
    "y" | "Y" | "yes" | "Yes")
      get_username
      get_hostname
      confirm
      ;;
    "n" | "N" | "no" | "No")
      ;;
    *)
      echo -E "${YELLOW}Invalid input: $CONFIRM${NORMAL}"
      ;;
  esac
}

set_username() {
  sed -i -e "s/${CURRENT_USERNAME}/${USERNAME}/g" ./flake.nix
}

install() {
  gum spin --spinner dot --title "Installing Configuration..." \
    --spinner.foreground 2 \
    --title.foreground "${WHITE}" \
    -- sleep 3 

  # Copying Hardware Configuration
  echo -e "Copying Hardware Configuration from ${BLUE}/etc/nixos/hardware-configuration.nix${NORMAL} to ${GREEN}/hosts/${CURRENT_HOSTNAME}${WHITE}\n"

  local HOST=$(echo "$CURRENT_HOSTNAME" | tr -cd '[:print:]')
  cp /etc/nixos/hardware-configuration.nix ./hosts/${HOST}/hardware-configuration.nix || {
    echo -e "${RED}Failed to copy hardware configuration!${NORMAL}"
    exit 1;
  }

  # Confirmation
  local CONFIRM=""

  if gum confirm \
    --selected.background 2 \
    --selected.foreground "$NORMAL" \
    --unselected.foreground "$NORMAL" \
    "${YELLOW}Starting the NixOS configuration Build, do you want to continue? (y/n)${NORMAL}"
  then
    CONFIRM="yes"
    sudo nixos-rebuild switch --flake .#${HOST}
  else
    if [ $? -eq 130 ]; then  # 130 = Ctrl+C
      echo -e "${RED}Cancelling Installation...${NORMAL}"
      exit 1
    fi
      CONFIRM="no"
      echo -e "${RED}Exiting Script.${NORMAL}"
      exit 1
  fi
}


main() {
  init

  get_username
  get_hostname
  confirm

  set_username
  install
}


main && exit 0

