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

## Clone Repository
```bash
git clone https://github.com/fahriilman123/auth-app.git
cd auth-app
```

## Database setup
### 1. Create databases
```bash
CREATE DATABASE coralis_auth;
```

### 2. Import MySQL dump file
```bash
mysql -u root -p coralis_auth < database/coralis_auth.sql
```

## Backend setup
### 1. Navigate to backend directory
```bash
cd backend
```

### 2. Install dependecy
```bash
npm install
```

### 3. create environtment file
```bash
copy .env.example .env
```

### 4. Configure .env
```bash
PORT=3000
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=your_mysql_password
DB_NAME=coralis_auth
JWT_SECRET=your_jwt_secret
```

### 5. Run backend server
```bash
npm run dev
```

### Flutter setup
### 1. Run android emulator

### 2. Navigate to auth_app directory
```bash
cd auth_app
```

### 3. Install dependecy
```bash
flutter pub get
```

### 4. Run flutter app
```bash
flutter run
```

## Feature Implemented
### Register
* User registration using email and password
* Passwords are stored using bcrypt hashing
* User data is stored in MySQL

### Login
* Login using email and password
* JWT-based authentication
* Redirect to home/dashboard after successful login

### Forgot Password
* Request password reset using email
* Backend generates a reset token
* User can set a new password and login again
