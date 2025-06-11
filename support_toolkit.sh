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
      echo -e "\n🕵️ Choose log to view:"
      echo "1. System log (/var/log/system.log)"
      echo "2. Install log (/private/var/log/install.log)"
      echo "3. App log (User DiagnosticReports)"
      echo "4. Search system log for keyword"
      echo "5. Back"
      read -p "Select an option [1-5]: " log_option

      case $log_option in
        1)
          echo -e "\n🔍 Last 20 lines of system log:"
          sudo tail -n 20 /var/log/system.log
          ;;
        2)
          echo -e "\n🧰 Last 20 lines of install log:"
          sudo tail -n 20 /private/var/log/install.log
          ;;
        3)
          echo -e "\n📄 Recent app crash logs:"
          ls -lt ~/Library/Logs/DiagnosticReports | head -n 5
          ;;
        4)
		  while true; do
	      read -p "Enter keyword to search (or 'q' to quit): " keyword
        
	      # Check if user wants to quit
	      if [[ "$keyword" == "q" ]]; then
            break
	      fi
        
	      echo -e "\nSearching system.log for \"$keyword\":\n"
        
	      # Perform the search with context and color highlighting
	      sudo grep -i -A 2 -B 2 --color=auto "$keyword" /var/log/system.log || echo "No matches found for \"$keyword\""
	      count=$(sudo grep -i -c "$keyword" /var/log/system.log)
		  echo "Found $count matches for \"$keyword\""
        
	      echo -e "\n----------------------------------------\n"
		  done
		  ;;        
		5)
          echo "Returning to main menu..."
          ;;
        *)
          echo "Invalid selection."
          ;;
      esac

      read -p "Press enter to continue..."
      ;;


    *)
      echo "Invalid option. Try again."
      sleep 1
      ;;
  esac
done
 
