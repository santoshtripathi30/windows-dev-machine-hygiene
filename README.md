# Dev Machine Cleanup Utility

A production-safe Windows batch automation script for cleaning and maintaining a developer workstation.

This utility removes cache files, temporary folders, browser artifacts, IDE caches, package manager caches, and optionally performs system-level cleanup when run with Administrator privileges.

---

## 🚀 Purpose

Developer machines accumulate cache, temp files, and build artifacts over time.  
This utility helps:

- Reclaim disk space
- Improve system responsiveness
- Maintain clean development environments
- Apply safe operational cleanup practices

---

## 🔧 What Gets Cleaned

### User-Level Cleanup

- Google Chrome cache (all profiles)
- Microsoft Edge cache (all profiles)
- Visual Studio cache
- VS Code cache
- JetBrains IDE caches
- npm cache
- yarn cache
- pip cache
- NuGet cache
- Azure Functions tools cache
- User Temp folder (files + subfolders)
- Windows thumbnail cache
- Windows Error Reports (user scope)

---

### Admin-Level Cleanup (When Run as Administrator)

- Windows Temp (contents only, root folder preserved)
- Windows Update cache (service-safe stop/start)
- System-level Windows Error Reports queue
- Docker system prune (only if daemon is running)

If not executed with admin privileges, system-level cleanup is skipped safely.

---

## 🛡 Safety Controls

- Detects Administrator privileges automatically
- Skips system-level operations when not elevated
- Hard-stops if Chrome, Edge, or VS Code are running
- Validates Docker daemon before pruning
- Cleans contents only for system directories
- Uses structured function-based batch scripting

---

## 🏗 Technical Highlights

- Modular function design using `call :CleanFolder`
- Proper delayed expansion handling (`!errorlevel!`)
- Service stop/start coordination for Windows Update
- Defensive scripting to prevent accidental system impact
- Safe folder recreation logic for non-system caches

---

## ▶ Usage

1. Download the script
2. Run using Command Prompt

For full cleanup:

Right-click → **Run as Administrator**

---

## 📌 Why This Project

This project demonstrates:

- Windows automation scripting
- Defensive DevOps practices
- Operational safety controls
- Developer workstation hygiene automation
- Real-world scripting discipline

---
