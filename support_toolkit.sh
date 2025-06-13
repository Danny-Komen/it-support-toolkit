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
  	echo "7. Advanced Tools"
  	echo "8. Exit"
 	echo "------------------------------"
  	read -p "Choose an option [1-8]: " option
  	
  	if [[ $option == 8 ]]
  	then
  		break
  	fi

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

	 7)
	 while true; do
      clear
      echo "🧠 Advanced TOOLS"
      echo "1. Top 5 RAM-Heavy Apps"
      echo "2. Analyze Last Boot Time"
      echo "3. Open Ports and Services"
      echo "4. Back"
      read -p "Choose an option [1-4]: " expertopt
      
      if [[ $expertopt == 4 ]]
      then
      	break
      fi

      case $expertopt in
        1)
          echo -e "\n📈 Top 10 Memory-Heavy Apps:"
          echo -e "\n PID	||	App	||		%"
          ps aux | sort -nrk 4 | head -n 10| awk '{printf "%-10s %-20s %s%%\n", $2, $11, $4}'
          ;;
          
        2)
          echo -e "\n🐢 Slow Boot Summary:"
          echo "⏳ Please wait... This might take upto a minute ⌛️"

          # Last reboot
          echo -n "🕓 Last Boot:        "
          sysctl -n kern.boottime | awk -F'[ =,}]+' '{print $7, $8, $9, $10, $11}'

          # Previous shutdown cause
          cause=$(log show --predicate 'eventMessage contains[c] "Previous shutdown cause"' --last 1d | tail -n 1 | grep -oE 'cause: -?[0-9]+')
          code=$(echo "$cause" | awk '{print $2}')
          case $code in
            -3) meaning="Hard shutdown / Power loss" ;;
            -128) meaning="Kernel panic" ;;
            5) meaning="Normal shutdown" ;;
            *) meaning="Unknown or system-defined ($code)" ;;
          esac
          echo -e "📌 Shutdown Cause:   $code ($meaning)"

          # Uptime
          echo -n "⏱️ Uptime:           "
          uptime | awk -F'(up |, [0-9]+ users)' '{print $2}'

          ;;
     	
        3)
          echo -e "\n🌐 Open Ports & Listening Services:"
          echo "⏳ Scanning for active TCP listeners..."

          if sudo lsof -nP -iTCP -sTCP:LISTEN | grep -q "LISTEN"; then
            echo -e "\n📡 Active TCP Listening Ports:"
            sudo lsof -nP -iTCP -sTCP:LISTEN | awk 'NR==1 {printf "%-10s %-8s %-10s %-30s\n", $1, $2, $3, $9} NR>1 {printf "%-10s %-8s %-10s %-30s\n", $1, $2, $3, $9}'
          else
            echo -e "\n✅ No active listening TCP ports found. Your system is secure."
          fi

          echo ""
          read -p "Press enter to continue..."
          ;;

          	
        *)
          echo "Invalid option."
          ;;
      esac
      read -p "Press enter to continue..."
      done
      ;;

    *)
      echo "Invalid option. Try again."
      sleep 1
      ;;
  esac
done
 
