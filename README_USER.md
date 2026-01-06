# User Guide - Inception 🚀

## Welcome
This project hosts a set of services for you to valid/test the Inception infrastructure.

## 🌐 Accessing Services

Once the infrastructure is up (see "Quick Start"), you can access the following services in your browser:

### 📝 WordPress (Blog)
- **URL**: [https://akajjou.42.fr](https://akajjou.42.fr)
- **Description**: A fully functional WordPress site.
- **Login**:
  - **Admin User**: `akajjou_owner`
  - **Standard User**: `akajjou`
  - *Passwords are managed securely via secrets.*

### 🗄️ Adminer (Database Manager)
- **URL**: [http://akajjou.42.fr:8080](http://akajjou.42.fr:8080)
- **Description**: Web interface to manage the MariaDB database.
- **Login Details**:
  - **System**: MySQL
  - **Server**: `mariadb`
  - **Username**: `wpuser` (or `root`)
  - **Database**: `wordpress`

### 📄 Static Website
- **URL**: [http://akajjou.42.fr:4242](http://akajjou.42.fr:4242)
- **Description**: A simplistic static HTML page to demonstrate an extra service.

---

## ⚠️ Important Notes

### Browser Security Warning
Since we use a **self-signed SSL certificate**, your browser will warn you that the connection is not private.
- **Action**: Click "Advanced" -> "Proceed to akajjou.42.fr (unsafe)" to view the site. This is normal for this development environment.

### Persistence
Your data (WordPress posts, Database entries) is saved on your machine in `/home/akajjou/data`. It will survive restarts unless you run the "Full Clean" command.
