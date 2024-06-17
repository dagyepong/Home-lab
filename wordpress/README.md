### **Create Config Paths:**

```bash

mkdir -p /opt/stacks/wordpress

cd /opt/staks/wordpress
## make config directory##
mkdir config
## create empy files##
touch ./config/wp_php.ini
touch ./config/pma_php.ini
touch ./config/pma_config.php
```

### ** Alter PhP Variables:**

```bash

nano ./config/wp_php.ini
```

### **Paste in this Variable:**

```py
file_uploads = On
memory_limit = 256M
upload_max_filesize = 64M
post_max_size = 64M
max_execution_time = 300
max_input_time = 1000
```

### **Redis Cache:**

```bash

nano wp-config.php
```

#### **Paste this code:**

```py
define('WP_REDIS_HOST', 'redis-wp');
define('WP_REDIS_PORT', '6379');
```

**Note:** wp-config.php is located into the volume you created for WordPress under ./wp-app

```py

docker compose up
```

### **Verify Backups:**

In the backup directory where you have the stack or docker compose file you should have a backup directory with database backups you should check and see if they were generated:

**Example:**

```py
/opt/stacks/wordpress# cd backups/
/opt/stacks/wordpress/backups# ls -ltr
total 16
-rw------- 1 10000 10000 495 Feb 21 09:26 mysql_wordpress_wp-db_20240221-092619.sql.gz
-rw------- 1 10000 10000  87 Feb 21 09:26 mysql_wordpress_wp-db_20240221-092619.sql.gz.sha1
-rw------- 1 10000 10000 495 Feb 21 09:32 mysql_wordpress_wp-db_20240221-093228.sql.gz
-rw------- 1 10000 10000  87 Feb 21 09:32 mysql_wordpress_wp-db_20240221-093228.sql.gz.sha1
lrwxrwxrwx 1 10000 10000  44 Feb 21 09:32 latest-mysql_wordpress_wp-db -> mysql_wordpress_wp-db_20240221-093228.sql.gz
```
