# Flutter Authentication App
Junior Web Programmer Technical Test – Coralis Studio

This repository contains a Flutter mobile application for user authentication
(Register, Login, and Forgot Password) integrated with a backend API and a
MySQL database.

The project is fully runnable on a fresh machine by following the instructions
below and can be executed on an Android Emulator.

---

## Setup Project (Fresh Machine – Copy & Run)

### Prerequisites
Pastikan software berikut sudah terinstall di mesin Anda:

- Flutter SDK 3.22+
- Dart 3.4+
- Node.js 18+
- MySQL 8+
- Android Studio (Android Emulator)
- Git

Cek instalasi:
```bash
flutter --version
node --version
mysql --version
git --version
```
## Struktur project
.
├── frontend/          # Flutter mobile application
├── backend/           # Backend API (Node.js + Express)
├── database/          # MySQL dump file
│   └── coralis_auth.sql
├── README.md
└── .gitignore

## Database setup
### 1. Create databases
``` CREATE DATABASE coralis_auth; ```

### 2. Import MySQL dump file
mysql -u root -p coralis_auth < database/coralis_auth.sql

## Backend setup
### 1. Navigate to backend directory
cd backend

### 2. Install dependecy
npm install
