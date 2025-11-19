#!/usr/bin/env bash
# customsh.sh - Advanced Custom Shell with Enhanced Features
# Author: College Project
# Description: A feature-rich custom shell implementation

# Configuration
SCRIPTS_DIR="./scripts"
HISTORY_FILE=".customsh_history"
CONFIG_FILE=".customshrc"
MAX_HISTORY=1000
JOBS=()
SHELL_PID=$$

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color
BOLD='\033[1m'

# Initialize
mkdir -p "$SCRIPTS_DIR"
touch "$HISTORY_FILE"
[ -f "$CONFIG_FILE" ] && source "$CONFIG_FILE"

# Environment variables
export CUSTOMSH_VERSION="2.0"
export CUSTOMSH_PATH="$(pwd)"

# Signal handling
trap 'echo -e "\n${YELLOW}Use 'exit' to quit the shell${NC}"' SIGINT

# Load history
load_history() {
    if [ -f "$HISTORY_FILE" ]; then
        mapfile -t HISTORY < "$HISTORY_FILE"
    else
        HISTORY=()
    fi
}

# Save command to history
save_to_history() {
    local cmd="$1"
    [ -z "$cmd" ] && return
    echo "$cmd" >> "$HISTORY_FILE"
    # Keep only last MAX_HISTORY lines
    tail -n "$MAX_HISTORY" "$HISTORY_FILE" > "${HISTORY_FILE}.tmp"
    mv "${HISTORY_FILE}.tmp" "$HISTORY_FILE"
}

# Display help
show_help() {
    echo -e "${BOLD}${CYAN}═══════════════════════════════════════════════════════════════${NC}"
    echo -e "${BOLD}${GREEN}        CustomShell v${CUSTOMSH_VERSION} - Advanced Shell Commands${NC}"
    echo -e "${BOLD}${CYAN}═══════════════════════════════════════════════════════════════${NC}"
    echo ""
    echo -e "${BOLD}${YELLOW}Navigation & File Operations:${NC}"
    echo -e "  ${GREEN}cd${NC} <dir>              Change directory"
    echo -e "  ${GREEN}pwd${NC}                   Print working directory"
    echo -e "  ${GREEN}ls${NC} [options]          List directory contents"
    echo -e "  ${GREEN}mkdir${NC} <dir>           Create directory"
    echo -e "  ${GREEN}touch${NC} <file>          Create empty file"
    echo -e "  ${GREEN}rm${NC} <file>             Remove file"
    echo -e "  ${GREEN}cp${NC} <src> <dest>       Copy file"
    echo -e "  ${GREEN}mv${NC} <src> <dest>       Move/rename file"
    echo -e "  ${GREEN}cat${NC} <file>            Display file contents"
    echo ""
    echo -e "${BOLD}${YELLOW}Shell Management:${NC}"
    echo -e "  ${GREEN}exit${NC}                  Exit shell"
    echo -e "  ${GREEN}clear${NC}                 Clear screen"
    echo -e "  ${GREEN}history${NC}               Show command history"
    echo -e "  ${GREEN}alias${NC} <name>=<cmd>   Create command alias"
    echo -e "  ${GREEN}export${NC} <VAR>=<val>   Set environment variable"
    echo -e "  ${GREEN}env${NC}                   Show environment variables"
    echo -e "  ${GREEN}jobs${NC}                  List background jobs"
    echo -e "  ${GREEN}bg${NC} <job_id>           Resume job in background"
    echo -e "  ${GREEN}fg${NC} <job_id>           Bring job to foreground"
    echo ""
    echo -e "${BOLD}${YELLOW}Custom Scripts:${NC}"
    echo -e "  ${GREEN}list${NC}                  List all available scripts"
    echo -e "  ${GREEN}run${NC} <script>          Execute a custom script"
    echo -e "  ${GREEN}info${NC} <script>         Show script information"
    echo ""
    echo -e "${BOLD}${YELLOW}System Information:${NC}"
    echo -e "  ${GREEN}sysinfo${NC}               Display system information"
    echo -e "  ${GREEN}whoami${NC}                Show current user"
    echo -e "  ${GREEN}date${NC}                  Display current date/time"
    echo -e "  ${GREEN}uptime${NC}                Show system uptime"
    echo ""
    echo -e "${BOLD}${YELLOW}Advanced Features:${NC}"
    echo -e "  ${GREEN}help${NC}                  Show this help message"
    echo -e "  ${GREEN}version${NC}               Show shell version"
    echo -e "  ${GREEN}|${NC}                     Pipe output (cmd1 | cmd2)"
    echo -e "  ${GREEN}>${NC}                     Redirect output (cmd > file)"
    echo -e "  ${GREEN}>>${NC}                    Append output (cmd >> file)"
    echo -e "  ${GREEN}&${NC}                     Run in background (cmd &)"
    echo ""
    echo -e "${BOLD}${CYAN}═══════════════════════════════════════════════════════════════${NC}"
}

# List available scripts
list_scripts() {
    echo -e "${BOLD}${CYAN}Available Custom Scripts:${NC}"
    echo -e "${CYAN}═══════════════════════════════════════${NC}"
    
    if [ -z "$(ls -A "$SCRIPTS_DIR" 2>/dev/null)" ]; then
        echo -e "${YELLOW}No scripts found in $SCRIPTS_DIR${NC}"
        return
    fi
    
    for script in "$SCRIPTS_DIR"/*; do
        if [ -f "$script" ]; then
            local name=$(basename "$script")
            local desc=""
            # Try to extract description from script
            if [ -r "$script" ]; then
                desc=$(grep -m 1 "^# Description:" "$script" | cut -d: -f2- | xargs)
            fi
            printf "${GREEN}%-20s${NC} %s\n" "$name" "$desc"
        fi
    done
    echo -e "${CYAN}═══════════════════════════════════════${NC}"
}

# Show script info
script_info() {
    local script="$SCRIPTS_DIR/$1"
    if [ ! -f "$script" ]; then
        echo -e "${RED}Error: Script '$1' not found${NC}"
        return 1
    fi
    
    echo -e "${BOLD}${CYAN}Script Information: $1${NC}"
    echo -e "${CYAN}═══════════════════════════════════════${NC}"
    
    # Extract metadata from script comments
    grep -E "^# (Description|Author|Usage|Version):" "$script" | while read line; do
        echo -e "${GREEN}${line}${NC}"
    done
    
    echo -e "${CYAN}═══════════════════════════════════════${NC}"
}

# Run script
run_script() {
    local script="$SCRIPTS_DIR/$1"
    if [ -f "$script" ]; then
        if [ -x "$script" ]; then
            bash "$script"
        else
            chmod +x "$script"
            bash "$script"
        fi
    else
        echo -e "${RED}Error: Script '$1' not found${NC}"
        echo -e "${YELLOW}Use 'list' to see available scripts${NC}"
        return 1
    fi
}

# Show command history
show_history() {
    if [ -f "$HISTORY_FILE" ]; then
        local count=1
        while IFS= read -r line; do
            printf "${CYAN}%4d${NC}  %s\n" "$count" "$line"
            ((count++))
        done < "$HISTORY_FILE" | tail -n 50
    else
        echo -e "${YELLOW}No history available${NC}"
    fi
}

# Execute command with piping support
execute_command() {
    local cmd="$1"
    
    # Handle background processes
    if [[ "$cmd" == *"&" ]]; then
        cmd="${cmd%&}"
        eval "$cmd" &
        local job_pid=$!
        JOBS+=("$job_pid:$cmd")
        echo -e "${GREEN}[Job started] PID: $job_pid${NC}"
        return
    fi
    
    # Handle output redirection
    if [[ "$cmd" == *">"* ]]; then
        eval "$cmd"
        return
    fi
    
    # Handle piping
    if [[ "$cmd" == *"|"* ]]; then
        eval "$cmd"
        return
    fi
    
    # Normal execution
    eval "$cmd"
}

# List background jobs
list_jobs() {
    if [ ${#JOBS[@]} -eq 0 ]; then
        echo -e "${YELLOW}No background jobs${NC}"
        return
    fi
    
    echo -e "${BOLD}${CYAN}Background Jobs:${NC}"
    for i in "${!JOBS[@]}"; do
        local job="${JOBS[$i]}"
        local pid="${job%%:*}"
        local cmd="${job#*:}"
        if kill -0 "$pid" 2>/dev/null; then
            echo -e "${GREEN}[$i] Running${NC} PID: $pid - $cmd"
        else
            echo -e "${YELLOW}[$i] Completed${NC} PID: $pid - $cmd"
        fi
    done
}

# Show system information
show_sysinfo() {
    echo -e "${BOLD}${CYAN}═══════════════════════════════════════${NC}"
    echo -e "${BOLD}${GREEN}System Information${NC}"
    echo -e "${BOLD}${CYAN}═══════════════════════════════════════${NC}"
    echo -e "${YELLOW}OS:${NC}          $(uname -s)"
    echo -e "${YELLOW}Kernel:${NC}      $(uname -r)"
    echo -e "${YELLOW}Architecture:${NC} $(uname -m)"
    echo -e "${YELLOW}Hostname:${NC}    $(hostname)"
    echo -e "${YELLOW}User:${NC}        $(whoami)"
    echo -e "${YELLOW}Shell:${NC}       CustomShell v${CUSTOMSH_VERSION}"
    echo -e "${YELLOW}Directory:${NC}   $(pwd)"
    echo -e "${CYAN}═══════════════════════════════════════${NC}"
}

# Main execution loop
load_history

echo -e "${BOLD}${CYAN}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${BOLD}${GREEN}   Welcome to CustomShell v${CUSTOMSH_VERSION} - Advanced Shell Environment${NC}"
echo -e "${BOLD}${CYAN}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${YELLOW}Type 'help' for available commands${NC}\n"

while true; do
    # Display prompt with current directory
    printf "${BOLD}${GREEN}CustomShell${NC} ${BLUE}[$(basename "$(pwd)")]${NC} ${MAGENTA}▶${NC} "
    read -r input
    
    # Skip empty input
    [ -z "$input" ] && continue
    
    # Save to history
    save_to_history "$input"
    
    # Parse command and arguments
    read -r cmd args <<< "$input"
    
    case "$cmd" in
        cd)
            if [ -z "$args" ]; then
                cd ~ 2>/dev/null || echo -e "${RED}Error: Cannot change to home directory${NC}"
            else
                cd "$args" 2>/dev/null || echo -e "${RED}Error: Directory '$args' not found${NC}"
            fi
            ;;
        pwd)
            pwd
            ;;
        ls)
            ls $args
            ;;
        mkdir)
            mkdir -p $args 2>/dev/null || echo -e "${RED}Error: Cannot create directory${NC}"
            ;;
        touch)
            touch $args 2>/dev/null || echo -e "${RED}Error: Cannot create file${NC}"
            ;;
        rm)
            rm $args 2>/dev/null || echo -e "${RED}Error: Cannot remove file${NC}"
            ;;
        cp)
            cp $args 2>/dev/null || echo -e "${RED}Error: Copy failed${NC}"
            ;;
        mv)
            mv $args 2>/dev/null || echo -e "${RED}Error: Move failed${NC}"
            ;;
        cat)
            cat $args 2>/dev/null || echo -e "${RED}Error: Cannot read file${NC}"
            ;;
        clear)
            clear
            ;;
        exit)
            echo -e "${GREEN}Goodbye! Thanks for using CustomShell${NC}"
            exit 0
            ;;
        help)
            show_help
            ;;
        version)
            echo -e "${GREEN}CustomShell version ${CUSTOMSH_VERSION}${NC}"
            ;;
        list)
            list_scripts
            ;;
        run)
            run_script "$args"
            ;;
        info)
            script_info "$args"
            ;;
        history)
            show_history
            ;;
        jobs)
            list_jobs
            ;;
        sysinfo)
            show_sysinfo
            ;;
        whoami)
            whoami
            ;;
        date)
            date
            ;;
        uptime)
            uptime
            ;;
        export)
            export $args
            ;;
        env)
            env | sort
            ;;
        alias)
            if [ -z "$args" ]; then
                alias
            else
                alias $args
            fi
            ;;
        "")
            ;;
        *)
            # Try to execute as system command or with pipes/redirection
            execute_command "$input"
            if [ $? -ne 0 ]; then
                echo -e "${RED}Error: Unknown command '$cmd'. Type 'help' for available commands.${NC}"
            fi
            ;;
    esac
done
