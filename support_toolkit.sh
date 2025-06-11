#!/bin/bash

# IT Support Toolkit - Version 1.0

while true; do
  clear
  	echo "=============================="
  	echo "    IT SUPPORT TOOLKIT v1.1"
  	echo "=============================="
    echo "1. View System Information"
  	echo "2. Check Disk Usage"
  	echo "3. Test Internet Connectivity"
  	echo "4. Clean System Cache"
  	echo "5. Create System Backup"
  	echo "6. View System Logs"
  	echo "7. Exit"
 	echo "------------------------------"
  	read -p "Choose an option [1-7]: " option

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
      echo -e "\n🧹 Cleaning system cache..."
      sudo rm -rf /Library/Caches/* ~/Library/Caches/*
      echo "✅ Cache cleaned successfully for the permitted files."
      read -p "Press enter to continue..."
      ;;
    5)
      echo -e "\n📦 Creating system backup..."
      BACKUP_NAME="sys_backup_$(date +%Y%m%d_%H%M%S).tar.gz"
      tar -czf $BACKUP_NAME /var/log /etc > /dev/null 2>&1
      echo "✅ Backup saved as $BACKUP_NAME"
      read -p "Press enter to continue..."
      ;;
    6)
      echo -e "\n🕵️ Viewing latest system logs..."
      sudo tail -n 100 /var/log/system.log 	#Displays the last 100 lines in the system logs.
      read -p "Press enter to continue..."
      ;;

    *)
      echo "Invalid option. Try again."
      sleep 1
      ;;
  esac
done
 
