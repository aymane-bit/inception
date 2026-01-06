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
│   │   └── bonus/          # Redis, Adminer, Static Site
│   └── secrets/            # (GitIgnored) Runtime secrets
```

## 🏗 Architecture Details

### Network Topology
- **Network Name**: `inception` (Driver: `bridge`)
- **Isolation**: Services communicate via this internal network using container names as hostnames (e.g., `wordpress` can ping `mariadb`).
- **External Access**:
  - Nginx: `443` (Host: `443`)
  - Adminer: `8080` (Host: `8080`)
  - Static Site: `4242` (Host: `4242`)

### 💾 Volume Management
Data persistence is handled via mapping host directories to container volumes:
- **MariaDB**: `/home/akajjou/data/mariadb` ➡ `/var/lib/mysql`
- **WordPress**: `/home/akajjou/data/wordpress` ➡ `/var/www/html`

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
make logs-wordpress   # Specific service
```

### Enter a Container
To open a shell inside a running container:
```bash
docker exec -it wordpress /bin/bash
docker exec -it mariadb /bin/bash
```

### Check Database Connection
From the workspace container:
```bash
docker exec -it wordpress mysql -h mariadb -u wpuser -p
```

### Rebuild Specific Service
If you modify a Dockerfile (e.g., Nginx), rebuild only that service:
```bash
docker compose -f srcs/docker-compose.yml up -d --no-deps --build nginx
```
