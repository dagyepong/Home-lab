### **Description**

This is the updated docker-compose repo of all the media, home, and web server apps described on SmartHomeBeginner.com. 

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
mkdir /home/anand/docker/logs/udms
mkdir /home/anand/docker/logs/udms/traefik
```
Next, from within the logs/udms/traefik folder, let us create empty log files:

1
2
```bash
touch traefik.log
touch access.log
```
