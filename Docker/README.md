### **Description**

This is the updated docker-compose repo of all the media, home, and web server apps described on SmartHomeBeginner.com. 


```bash

mkdir -p Docker/appdata
cd Docker

## create .env file & give permission
touch /home/nana/docker/.env
sudo chown root:root /home/anand/docker/.env
sudo chmod 600 /home/nana/docker/.env
## create the ultimate compose file

touch /home/nana/docker/docker-compose-udms.yml

mkdir -p compose/udms
mkdir logs
mkdir scripts
mkdir secrets

## set permissions
sudo chown root:root /home/nana/docker/secrets
sudo chmod 600 /home/nana/docker/secrets

mkdir shared
```


## **Docker Root Folder Permissions:**

Assuming that you have created the files and folders listed above, let us set the right permissions for them. We will need acl for this. If it is not installed, install it using:

1
```bash
sudo apt install acl
```
Next, set the permission for /home/anand/docker folder (anand being the username of the user) as follows:

```bash
sudo chmod 775 /home/nana/docker
sudo setfacl -Rdm u:nana:rwx /home/nana/docker
sudo setfacl -Rm u:nana:rwx /home/nana/docker
sudo setfacl -Rdm g:docker:rwx /home/nana/docker
sudo setfacl -Rm g:docker:rwx /home/nana/docker
```

You may also have to set acls on your media folder or the DATADIR path you will define in the later steps or apps such a sonarr, radarr, etc. may through permissions error.
The above commands provide access to the contents of the docker root folder (both existing and new stuff) to the docker group. Some may disagree with the liberal permissions above but again this is for home use and it is restrictive enough.

**Note:** After doing the above, you will notice a "+" at the end of permissions (e.g. drwxrwxr-x+) for docker root folder and its contents (as in the picture above). This indicates that ACL is set for the folder/file.

### **Prepare Traefik 3 Folders and Files:**

Finally, we need to create new folders for Traefik and ACME in the docker appdata folder (/home/user/docker/appdata) described previously:

1
2
3
4
```yml
mkdir traefik3
mkdir traefik3/acme
mkdir traefik3/rules
```

Next, let's create an empty file for Traefik to store our LetsEnrypt certificate. Create acme.json empty file inside appdata/traefik3/acme folder using the following command

1
```bash
touch acme.json
```
Set proper permission for acme.json file using the following command (from inside appdata/traefik3/acme):

1
```bash
chmod 600 acme.json
```


Similarly, we are going to create log files for Traefik to write logs to. I store all my logs in a centralized location (/home/user/docker/logs). Let's create a few additional folders for this specific host:

1
2
```bash
mkdir /home/nana/docker/logs/udms
mkdir /home/nana/docker/logs/udms/traefik
```
Next, from within the logs/udms/traefik folder, let us create empty log files:

1
2
```bash
touch traefik.log
touch access.log
```

```py

sudo docker compose -f /home/nana/docker/docker-compose-udms.yml up -d
```