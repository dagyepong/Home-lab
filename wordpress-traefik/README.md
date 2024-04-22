# WordPress with Let's Encrypt Using Docker Compose

📙 The complete installation guide is available on my [website](https://www.heyvaldemar.com/install-wordpress-using-docker-compose/).

❗ Change variables in the `.env` to meet your requirements.

💡 Note that the `.env` file should be in the same directory as `wordpress-traefik-letsencrypt-docker-compose.yml`.

Create networks for your services before deploying the configuration using the commands:

`docker network create traefik-network`

`docker network create wordpress-network`

Deploy WordPress using Docker Compose:

`docker compose -f wordpress-traefik-letsencrypt-docker-compose.yml -p wordpress up -d`

# Backups

The `backups` container in the configuration is responsible for the following:

1. **Database Backup**: Creates compressed backups of the MariaDB database using pg_dump.
Customizable backup path, filename pattern, and schedule through variables like `MARIADB_BACKUPS_PATH`, `MARIADB_BACKUP_NAME`, and `BACKUP_INTERVAL`.

2. **Application Data Backup**: Compresses and stores backups of the application data on the same schedule. Controlled via variables such as `DATA_BACKUPS_PATH`, `DATA_BACKUP_NAME`, and `BACKUP_INTERVAL`.

3. **Backup Pruning**: Periodically removes backups exceeding a specified age to manage storage. Customizable pruning schedule and age threshold with `MARIADB_BACKUP_PRUNE_DAYS` and `DATA_BACKUP_PRUNE_DAYS`.

By utilizing this container, consistent and automated backups of the essential components of your instance are ensured. Moreover, efficient management of backup storage and tailored backup routines can be achieved through easy and flexible configuration using environment variables.

# wordpress-restore-database.sh Description

This script facilitates the restoration of a database backup:

1. **Identify Containers**: It first identifies the service and backups containers by name, finding the appropriate container IDs.

2. **List Backups**: Displays all available database backups located at the specified backup path.

3. **Select Backup**: Prompts the user to copy and paste the desired backup name from the list to restore the database.

4. **Stop Service**: Temporarily stops the service to ensure data consistency during restoration.

5. **Restore Database**: Executes a sequence of commands to drop the current database, create a new one, and restore it from the selected compressed backup file.

6. **Start Service**: Restarts the service after the restoration is completed.

To make the `wordpress-restore-database.shh` script executable, run the following command:

`chmod +x wordpress-restore-database.sh`

Usage of this script ensures a controlled and guided process to restore the database from an existing backup.

# wordpress-restore-application-data.sh Description

This script is designed to restore the application data:

1. **Identify Containers**: Similarly to the database restore script, it identifies the service and backups containers by name.

2. **List Application Data Backups**: Displays all available application data backups at the specified backup path.

3. **Select Backup**: Asks the user to copy and paste the desired backup name for application data restoration.

4. **Stop Service**: Stops the service to prevent any conflicts during the restore process.

5. **Restore Application Data**: Removes the current application data and then extracts the selected backup to the appropriate application data path.

6. **Start Service**: Restarts the service after the application data has been successfully restored.

To make the `wordpress-restore-application-data.sh` script executable, run the following command:

`chmod +x wordpress-restore-application-data.sh`

By utilizing this script, you can efficiently restore application data from an existing backup while ensuring proper coordination with the running service.

