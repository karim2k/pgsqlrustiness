# 🐘 PostgreSQL Post-Install Checker for Ubuntu

This is a simple Bash script to help verify the integrity of your PostgreSQL installation on Ubuntu after setup. It checks:

- ✅ PostgreSQL service status
- ✅ Required packages
- ✅ PostgreSQL system user
- ✅ Configuration files (`postgresql.conf`, `pg_hba.conf`)
- ✅ Authentication method
- ✅ Existing roles (users)
- ✅ Basic usage advice

## 📦 Requirements

- Ubuntu 20.04 or newer
- PostgreSQL installed (`sudo apt install postgresql`)
- `bash` shell

## 🚀 Usage

1. Clone the repository or copy the script:
   ```bash
   git clone https://github.com/yourusername/postgres-checker.git
   cd postgres-checker
