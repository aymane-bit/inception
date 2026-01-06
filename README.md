# Inception 🐳

*System Administration & Docker Orchestration Project*

## 📝 Overview
This project involves setting up a small infrastructure composed of different services using **Docker** and **Docker Compose**. The goal is to build a group of Docker containers that interact with each other in a virtualized environment.

**Services:**
- **NGINX**: Web server (TLS v1.2/v1.3)
- **WordPress** + **php-fpm**: Content Management System
- **MariaDB**: SQL Database
- **Redis** (Bonus): Cache for WordPress
- **Adminer** (Bonus): Database management tool
- **Static Website** (Bonus): HTML/CSS showpage

## 🛠 Prerequisites
- **Linux** (Debian/Ubuntu/VM)
- **Docker Engine**
- **Docker Compose**
- **Make**
- **Sudo privileges**

## 🚀 Installation & Usage

1. **Clone the repository:**
   ```bash
   git clone <repo-url> inception
   cd inception
   ```

2. **Setup Domain:**
   Add the following line to your `/etc/hosts` file to map the domain to localhost:
   ```
   127.0.0.1 akajjou.42.fr
   ```

3. **Build and Run:**
   Use the Makefile to setup directories and launch the cluster:
   ```bash
   make
   ```
   This command will:
   - Create valid data directories in `/home/akajjou/data`
   - Build custom Docker images
   - Start the network

4. **Access the Services:**
   - **WordPress**: [https://akajjou.42.fr](https://akajjou.42.fr)
   - **Adminer**: [http://akajjou.42.fr:8080](http://akajjou.42.fr:8080)
   - **Static Site**: [http://akajjou.42.fr:4242](http://akajjou.42.fr:4242)

## 📋 Commands

| Command | Description |
|OS|Action|
|---|---|
| `make` / `make all` | Setup directories, build images, and run containers in the background. |
| `make build` | Specific build of Docker images. |
| `make up` | Start services (detached mode). |
| `make down` | Stop and remove containers and network. |
| `make stop` | Stop containers without removing them. |
| `make start` | Start stopped containers. |
| `make clean` | Stop services and remove Docker images/networks (preserves volumes). |
| `make fclean` | **Deep clean**: Removes everything including data volumes (`/home/akajjou/data`). |
| `make logs` | View logs of all services. |
| `make re` | Rebuild everything from scratch (`fclean` + `all`). |

## 🏗 Architecture
All containers run on a custom bridge network (`inception`).
- **MariaDB** stores data in a persistent volume.
- **WordPress** connects to MariaDB and Redis.
- **NGINX** acts as the entrypoint, serving WordPress over HTTPS.

## 🔒 Security
- **Secrets**: Credentials are managed via Docker secrets (mounted in `/run/secrets`), not environment variables.
- **SSL**: Self-signed certificates are generated automatically on startup if missing.
