#!/bin/bash

# IT Support Toolkit - Version 1.0

while true; do
  clear
  echo "=============================="
  echo "   IT SUPPORT TOOLKIT v1.0 by Danny"
  echo "=============================="
  echo "1. View System Information"
  echo "2. Check Disk Usage"
  echo "3. Test Internet Connectivity"
  echo "4. Exit"
  echo "------------------------------"
  read -p "Choose an option [1-4]: " option

  case $option in
    1)
      echo -e "\n🖥️   System Information:"
      uname -a	#Writes the name of the OS implementation.
      sw_vers #Print macOS system version information.
      echo ""
      read -p "Press enter to continue..."
      ;;
    2)
      echo -e "\n💾   Disk Usage:"
      df -h #Displays free disk space in human readable form.
      echo ""
      read -p "Press enter to continue..."
      ;;
    3)
      echo -e "\n🌐   Testing internet connectivity..."
      ping -c 3 8.8.8.8 && echo "✅  Connected!" || echo "❌  No internet connection."
      echo ""
      read -p "Press enter to continue..."
      ;;
    4)
      echo "👋 Exiting. Stay sharp!"
      break
      ;;
    *)
      echo "Invalid option. Try again."
      sleep 1
      ;;
  esac
done
 
