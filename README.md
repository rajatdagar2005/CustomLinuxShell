# 🐧 CustomShell v2.0 – Advanced Linux-Like Shell Environment

CustomShell v2.0 is a fully interactive, feature-rich custom shell written in Bash.  
It provides a Linux-like terminal experience with enhanced functionality, custom commands, automation tools, system utilities, and developer-friendly features.

---

## 🚀 Features

### 🔹 **1. Linux-Style Navigation & File Control**
- `cd <dir>` – Change directory  
- `pwd` – Show current directory  
- `ls` – List directory contents  
- `mkdir` – Create directory  
- `touch` – Create empty file  
- `rm` – Remove file  
- `mv`, `cp`, `cat` etc.  

### 🔹 **2. Shell Management**
- `clear` – Clear screen  
- `exit` – Exit shell  
- `history` – Command history  
- `alias <name>=<cmd>` – Create aliases  
- `export VAR=value` – Set environment variables  
- `env` – View environment  

### 🔹 **3. System Information Commands**
- `sysinfo` – Show system info  
- `whoami` – Current user  
- `uptime` – System uptime  
- `date` – Current date/time  

### 🔹 **4. Advanced Shell Features**
- Pipelining: `cmd1 | cmd2`  
- Output Redirection:  
  - `>` write output to file  
  - `>>` append output  
- Background Jobs:  
  - `&` run in background  
  - `jobs`, `bg`, `fg`  

### 🔹 **5. Custom Built-In Scripts**
The shell includes 14+ ready-made utility scripts:

| Script Name              | Description |
|--------------------------|-------------|
| **BackupTool.sh**        | Backup & restore utility |
| **Calculator.sh**        | Simple arithmetic calculator |
| **ColorDemo.sh**         | Terminal color demonstration |
| **DirectorySize.sh**     | Shows size of folders |
| **DiskUsage.sh**         | Disk usage info |
| **EnvironmentManager.sh**| Manage environment variables |
| **FileInfo.sh**          | Detailed file/folder info |
| **HistoryViewer.sh**     | Searchable history viewer |
| **NetworkInfo.sh**       | Network configuration |
| **ProcessManager.sh**    | Process viewer |
| **SystemInfo.sh**        | Complete system information |
| **TextEditor.sh**        | Minimal text editor |
| **Timer.sh**             | Countdown timer |

---

## 📦 Installation

Clone the repository:

```sh
git clone https://github.com/rajatdagar2005/custom-linux-shell.git
cd custom-linux-shell
