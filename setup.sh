#!/bin/bash

# Colors for terminal output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color

# Script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPTS_FOLDER="$SCRIPT_DIR/scripts"

# Function to print colored text
print_color() {
    local color=$1
    local text=$2
    echo -e "${color}${text}${NC}"
}

# Function to authenticate sudo
authenticate_sudo() {
    print_color $YELLOW "🔐 Authenticating sudo access..."
    
    # Test sudo access and cache credentials
    if sudo -v; then
        print_color $GREEN "✅ Sudo access authenticated successfully!"
        
        # Keep sudo session alive by refreshing it every 5 minutes
        (
            while true; do
                sleep 300
                sudo -v 2>/dev/null || break
            done
        ) &
        SUDO_PID=$!
        
        # Function to cleanup background process on exit
        cleanup_sudo() {
            if [ ! -z "$SUDO_PID" ]; then
                kill $SUDO_PID 2>/dev/null
            fi
        }
        trap cleanup_sudo EXIT
        
    else
        print_color $RED "❌ Failed to authenticate sudo access!"
        print_color $YELLOW "Please make sure you have sudo privileges and try again."
        exit 1
    fi
}

# Function to print header
print_header() {
    clear
    print_color $CYAN "╔══════════════════════════════════════════════════════════════╗"
    print_color $CYAN "║                    Ubuntu Setup Script                      ║"
    print_color $CYAN "║                  Package Installation Tool                  ║"
    print_color $CYAN "╚══════════════════════════════════════════════════════════════╝"
    echo
}

# Function to scan available scripts
scan_scripts() {
    local scripts=()
    if [ -d "$SCRIPTS_FOLDER" ]; then
        for script in "$SCRIPTS_FOLDER"/*.sh; do
            if [ -f "$script" ]; then
                local basename=$(basename "$script" .sh)
                scripts+=("$basename")
            fi
        done
    fi
    printf '%s\n' "${scripts[@]}"
}

# Function to display script info
get_script_info() {
    local script_name=$1
    local script_file="$SCRIPTS_FOLDER/${script_name}.sh"
    
    if [ -f "$script_file" ]; then
        # Look for comment with description at the top of the script
        local description=$(head -n 10 "$script_file" | grep -E "^# Description:|^#.*Description:" | sed 's/^#.*Description: *//' | head -n 1)
        if [ -z "$description" ]; then
            description="Install $script_name"
        fi
        echo "$description"
    else
        echo "Install $script_name"
    fi
}

# Function to show main menu
show_main_menu() {
    print_header
    
    local scripts=($(scan_scripts))
    
    if [ ${#scripts[@]} -eq 0 ]; then
        print_color $RED "❌ No installation scripts found in $SCRIPTS_FOLDER"
        print_color $YELLOW "Please create some .sh files in the scripts folder first."
        exit 1
    fi
    
    print_color $WHITE "Available packages to install:"
    echo
    
    for i in "${!scripts[@]}"; do
        local script_name="${scripts[$i]}"
        local description=$(get_script_info "$script_name")
        printf "  %2d) %-20s - %s\n" $((i+1)) "$script_name" "$description"
    done
    
    echo
    print_color $WHITE "Installation options:"
    print_color $GREEN "  [A] Install all packages"
    print_color $YELLOW "  [S] Select specific packages"
    print_color $BLUE "  [E] Install all except selected packages"
    print_color $RED "  [Q] Quit"
    echo
}

# Function to run a script
run_script() {
    local script_name=$1
    local script_file="$SCRIPTS_FOLDER/${script_name}.sh"
    
    if [ ! -f "$script_file" ]; then
        print_color $RED "❌ Script not found: $script_file"
        return 1
    fi
    
    print_color $CYAN "🚀 Running $script_name installation..."
    echo
    
    # Make script executable
    chmod +x "$script_file"
    
    # Run the script
    if bash "$script_file"; then
        print_color $GREEN "✅ $script_name installed successfully!"
    else
        print_color $RED "❌ Failed to install $script_name"
        return 1
    fi
    echo
}

# Function to install all packages
install_all() {
    local scripts=($(scan_scripts))
    print_color $GREEN "🔄 Installing all packages..."
    echo
    
    for script in "${scripts[@]}"; do
        run_script "$script"
    done
    
    print_color $GREEN "🎉 All packages installation completed!"
}

# Function to select specific packages
select_specific() {
    local scripts=($(scan_scripts))
    local selected=()
    
    while true; do
        print_header
        print_color $WHITE "Select packages to install (enter numbers separated by spaces):"
        echo
        
        for i in "${!scripts[@]}"; do
            local script_name="${scripts[$i]}"
            local description=$(get_script_info "$script_name")
            local marker=""
            if [[ " ${selected[@]} " =~ " $i " ]]; then
                marker=" ✓"
            fi
            printf "  %2d) %-20s - %s%s\n" $((i+1)) "$script_name" "$description" "$marker"
        done
        
        echo
        print_color $YELLOW "Selected: ${selected[@]}"
        print_color $WHITE "Enter package numbers (space-separated) or 'done' to proceed: "
        read -r input
        
        if [ "$input" = "done" ]; then
            break
        fi
        
        # Parse input and add to selected
        for num in $input; do
            if [[ "$num" =~ ^[0-9]+$ ]] && [ "$num" -ge 1 ] && [ "$num" -le "${#scripts[@]}" ]; then
                local index=$((num-1))
                if [[ ! " ${selected[@]} " =~ " $index " ]]; then
                    selected+=($index)
                fi
            fi
        done
    done
    
    if [ ${#selected[@]} -eq 0 ]; then
        print_color $YELLOW "No packages selected. Returning to main menu."
        return
    fi
    
    print_color $GREEN "🔄 Installing selected packages..."
    echo
    
    for index in "${selected[@]}"; do
        run_script "${scripts[$index]}"
    done
    
    print_color $GREEN "🎉 Selected packages installation completed!"
}

# Function to install all except selected
install_all_except() {
    local scripts=($(scan_scripts))
    local excluded=()
    
    while true; do
        print_header
        print_color $WHITE "Select packages to EXCLUDE from installation:"
        echo
        
        for i in "${!scripts[@]}"; do
            local script_name="${scripts[$i]}"
            local description=$(get_script_info "$script_name")
            local marker=""
            if [[ " ${excluded[@]} " =~ " $i " ]]; then
                marker=" ✗"
            fi
            printf "  %2d) %-20s - %s%s\n" $((i+1)) "$script_name" "$description" "$marker"
        done
        
        echo
        print_color $YELLOW "Excluded: ${excluded[@]}"
        print_color $WHITE "Enter package numbers to exclude (space-separated) or 'done' to proceed: "
        read -r input
        
        if [ "$input" = "done" ]; then
            break
        fi
        
        # Parse input and add to excluded
        for num in $input; do
            if [[ "$num" =~ ^[0-9]+$ ]] && [ "$num" -ge 1 ] && [ "$num" -le "${#scripts[@]}" ]; then
                local index=$((num-1))
                if [[ ! " ${excluded[@]} " =~ " $index " ]]; then
                    excluded+=($index)
                fi
            fi
        done
    done
    
    print_color $GREEN "🔄 Installing all packages except excluded ones..."
    echo
    
    for i in "${!scripts[@]}"; do
        if [[ ! " ${excluded[@]} " =~ " $i " ]]; then
            run_script "${scripts[$i]}"
        else
            print_color $YELLOW "⏭️  Skipping ${scripts[$i]} (excluded)"
        fi
    done
    
    print_color $GREEN "🎉 Installation completed!"
}

# Main function
main() {
    # Check if running as root
    if [ "$EUID" -eq 0 ]; then
        print_color $RED "❌ Please don't run this script as root. It will use sudo when needed."
        exit 1
    fi
    
    # Authenticate sudo access
    authenticate_sudo
    
    # Create scripts folder if it doesn't exist
    if [ ! -d "$SCRIPTS_FOLDER" ]; then
        print_color $YELLOW "📁 Creating scripts folder..."
        mkdir -p "$SCRIPTS_FOLDER"
    fi
    
    while true; do
        show_main_menu
        print_color $WHITE "Enter your choice: "
        read -r choice
        
        case $choice in
            [Aa])
                install_all
                break
                ;;
            [Ss])
                select_specific
                break
                ;;
            [Ee])
                install_all_except
                break
                ;;
            [Qq])
                print_color $YELLOW "👋 Goodbye!"
                exit 0
                ;;
            *)
                print_color $RED "❌ Invalid choice. Please try again."
                sleep 2
                ;;
        esac
    done
    
    echo
    print_color $GREEN "✅ Setup completed! Please reboot your system for all changes to take effect."
}

# Run main function
main "$@"
