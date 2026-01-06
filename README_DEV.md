# Developer Guide - Inception 🛠️

## 📂 Project Structure

```
inception/
├── Makefile                # Automation commands
├── srcs/
│   ├── docker-compose.yml  # Orchestration configuration
│   ├── .env                # Environment variables configuration
│   ├── requirements/       # Service definitions
│   │   ├── mariadb/        # Database
│   │   ├── wordpress/      # CMS + PHP-FPM
│   │   ├── nginx/          # Web Server + TLS
│   │   └── bonus/
│   │       ├── redis/
│   │       ├── adminer/
│   │       ├── static_site/
│   │       ├── ftp/        # vsftpd
│   │       └── cadvisor/   # Google Cadvisor
│   └── secrets/            # (GitIgnored) Runtime secrets
```

## 🏗 Architecture Details

### Network Topology
- **Network Name**: `inception` (Driver: `bridge`)
- **Isolation**: Services communicate via this internal network using container names as hostnames.
- **External Access**:
  - Nginx: `443`
  - Adminer: `8080`
  - Cadvisor: `8081`
  - Static Site: `4242`
  - FTP: `21` (+ Passive `21100-21110`)

### 💾 Volume Management
Data persistence is handled via mapping host directories to container volumes:
- **MariaDB**: `/home/akajjou/data/mariadb` ➡ `/var/lib/mysql`
- **WordPress**: `/home/akajjou/data/wordpress` ➡ `/var/www/html`
- **FTP**: Shares the `wordpress` volume to allow file modification.

### 🔑 Security & Secrets
We avoid environment variables for sensitive data.
- **Secrets Path**: `./srcs/secrets` on host ➡ `/run/secrets` in containers.
- **Entrypoints**: Scripts in `tools/` directories read these files at startup to configure the services sequentially.

---

## 🐛 Debugging Tips

### View Logs
To see what's happening inside the containers:
```bash
make logs             # All logs
make logs-ftp         # FTP logs
```

### Enter a Container
To open a shell inside a running container:
```bash
docker exec -it wordpress /bin/bash
docker exec -it ftp /bin/sh
```

### Check Database Connection
From the workspace container:
```bash
docker exec -it wordpress mysql -h mariadb -u wpuser -p
```
