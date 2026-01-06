*This project has been created as part of the 42 curriculum by akajjou.*

## Description
This project, **Inception**, is a System Administration project that aims to broaden the knowledge of system administration by using **Docker**. The goal is to virtualize several Docker images, building a small infrastructure composed of different services that interact with each other.

Instead of using a single container, the project requires orchestrating multiple containers using **Docker Compose** to create a network of services. Each service runs in a dedicated container:

- **NGINX**: Acts as the main entry point (TLS v1.2/v1.3 only).
- **WordPress**: Running with PHP-FPM.
- **MariaDB**: Stores the website's database.
- **Bonus Services**:
  - **Redis**: Caching for WordPress.
  - **FTP Server**: For file transfer.
  - **Adminer**: Database management interface.
  - **Cadvisor**: For monitoring container resource usage.
  - **Static Website**: A simple custom website.

The architecture ensures that containers communicate over a dedicated Docker network, with proper volume management for persistence.

## Instructions

### Prerequisites
- **Linux** (Debian/Ubuntu recommended)
- **Docker Engine**
- **Docker Compose**
- **Make**
- **Sudo privileges** (for Docker and modifying `/etc/hosts`)

### Installation & Execution

1.  **Clone the Repository**:
    ```bash
    git clone https://github.com/your-repo/inception.git
    cd inception
    ```

2.  **Configure Domain**:
    Add the domain `akajjou.42.fr` to your `/etc/hosts` file to point to localhost:
    ```bash
    sudo sh -c 'echo "127.0.0.1 akajjou.42.fr" >> /etc/hosts'
    ```

3.  **Run the Project**:
    Use the provided `Makefile` to build and start the infrastructure.
    ```bash
    make
    ```
    This command will:
    - Create the necessary data directories (e.g., `/home/akajjou/data/mariadb`, `/home/akajjou/data/wordpress`).
    - Build the Docker images.
    - Start the containers in the background.

4.  **Stop and Clean**:
    - To stop the containers:
      ```bash
      make down
      ```
    - To stop and remove images/containers/networks:
      ```bash
      make clean
      ```
    - To completely purge everything (including persistent volumes):
      ```bash
      make fclean
      ```

### Accessing Services
Once the containers are running, you can access the services via:
- **WordPress**: [https://akajjou.42.fr](https://akajjou.42.fr)
- **Adminer**: [http://akajjou.42.fr:8080](http://akajjou.42.fr:8080)
- **Cadvisor**: [http://akajjou.42.fr:8081](http://akajjou.42.fr:8081)
- **Static Site**: [http://akajjou.42.fr:4242](http://akajjou.42.fr:4242)
- **FTP**: Ensure an FTP client is installed (e.g., FileZilla or CLI ftp) and connect to port `21`.

## Resources

### References
- [Docker Documentation](https://docs.docker.com/)
- [Docker Compose Documentation](https://docs.docker.com/compose/)
- [NGINX Documentation](https://nginx.org/en/docs/)
- [WordPress Docker Official Image](https://hub.docker.com/_/wordpress)
- [MariaDB Docker Official Image](https://hub.docker.com/_/mariadb)

### AI Usage
Artificial Intelligence tools were used in the development of this project for the following tasks:
- **Code Optimization**: AI helped optimize existing Dockerfiles and shell scripts for better performance and adherence to best practices.
- **Debugging**: Assisted in identifying configuration errors within `docker-compose.yml` and service inter-communication issues.
