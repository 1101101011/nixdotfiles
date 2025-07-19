#!/usr/bin/env bash

init() {
  echo -E "
    ░█▀█░▀█▀░█░█░█▀█░█▀▀░░░█▀▀░█░█░█▀▀░▀█▀░█▀▀░█▄█  
    ░█░█░░█░░▄▀▄░█░█░▀▀█░░░▀▀█░░█░░▀▀█░░█░░█▀▀░█░█  
    ░▀░▀░▀▀▀░▀░▀░▀▀▀░▀▀▀░░░▀▀▀░░▀░░▀▀▀░░▀░░▀▀▀░▀░▀  
    ░▀█▀░█▀█░█▀▀░▀█▀░█▀█░█░░░█░░░█▀█░▀█▀░▀█▀░█▀█░█▀█
    ░░█░░█░█░▀▀█░░█░░█▀█░█░░░█░░░█▀█░░█░░░█░░█░█░█░█
    ░▀▀▀░▀░▀░▀▀▀░░▀░░▀░▀░▀▀▀░▀▀▀░▀░▀░░▀░░▀▀▀░▀▀▀░▀░▀
  "
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
  CURRENT_USERNAME=$(gum input \
    --header "${NORMAL}Please enter your Username(${GREEN}${CURRENT_USERNAME}${NORMAL}):" \
    --prompt "${CYAN}> ${NORMAL}" \
    --cursor.mode "blink" \
    --cursor.background "${WHITE}" \
    --cursor.foreground "${BLACK}")
}

get_hostname() {
  CURRENT_HOSTNAME=$(gum choose "${MAGENTA}Kurohikari (Laptop)${NORMAL}" "${YELLOW}Kuroha (PC)${NORMAL}" "${BLUE}Kagami (VM-Deployment)${NORMAL}" \
    --header "${NORMAL}Please choose your Host:" \
    --cursor "${CYAN}> ${NORMAL}" \
    --cursor-prefix "${CYAN}-" \
    --cursor.background "${WHITE}" \
    --cursor.foreground "${BLACK}")
}

install() {
  gum style --bold --border-foreground "${GREEN}" --border rounded --width 50 \
    --padding "2" \
    "${BRIGHT}Installing packages...${NORMAL}"

  # Simulate installation process
  sleep 2

  gum style --bold --border-foreground "${GREEN}" --border rounded --width 50 \
    --padding "2" \
    "${BRIGHT}Installation completed!${NORMAL}"
}

confirm() {
  gum style --bold --border-foreground "${GREEN}" --border rounded --width 50 \
    --padding "2" \
    "${BRIGHT}Configuration Summary:${NORMAL}" \
    "${GREEN}Username: ${CURRENT_USERNAME}" \
    "${GREEN}Hostname: ${CURRENT_HOSTNAME}" 

  if gum confirm \
    --selected.background 2 \
    --selected.foreground "$NORMAL" \
    --unselected.foreground "$NORMAL" \
    "${YELLOW}Do you want to change it again? (y/n)${NORMAL}"
  then
    CONFIRM="Yes"
  else
    CONFIRM="No"
  fi


  case "$CONFIRM" in
    "y" | "Y" | "yes" | "Yes")
      get_username
      get_hostname
      confirm
      ;;
    "n" | "N" | "no" | "No")
      install
      ;;
    *)
      echo -E "${YELLOW}Invalid input: $CONFIRM${NORMAL}"
      ;;
  esac

}

main() {
  init

  get_username
  get_hostname
  confirm
}

main && exit 0

