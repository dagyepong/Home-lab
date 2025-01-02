
Before launching Docker Compose, I created the external network manually.


```bash
sudo docker network create proxy
```


#### **Integrating CrowdSec:**

By default, Crowdsec proposes some local dashboards through a Metabase Docker container, but it also provides a console managed at https://app.crowdsec.net.

For the sake of this tutorial, I’m only going to show you the CrowdSec Console.

Before adding the CrowdSec container, prepare the folder to host the logs and at the same time create a directory for the CrowdSec configuration.

```bash

sudo mkdir /var/log/crowdsec && sudo chown -R $USER:$USER /var/log/crowdsec
sudo mkdir /opt/crowdsec
sudo mkdir /opt/crowdsec-db
```


#### **Repository Installation-Crowdsec:**

```bash

curl -s https://install.crowdsec.net | sudo sh
```

```bash

apt install crowdsec
```

```bash

sudo apt install crowdsec-firewall-bouncer-iptables
```

#### **Crowdsec Enrollment:**

```bash

sudo cscli console enroll $ENROLLMENT_KEY
```
Accept & Restart Crowdsec

```bash

sudo systemctl restart crowdsec
```



`Note:` Remediation Components are used to apply security measures, such as blocking malicious IP addresses. They act in response to signals and decisions taken by LAPI, which are based on log analysis performed by parsers.

So, let’s generate a key for the Traefik Remediation Component.

```bash

sudo docker exec crowdsec cscli bouncers add traefik-bouncer
```

Modify the Crowdsec acquisition file which allows it to specify which logs to parse.

```bash
---
filenames:
  - /var/log/crowdsec/traefik.log
labels:
  type: traefik
  ```

Path to file is /opt/crowdsec/acquis.yaml. and add the above lines to the file

```bash

sudo nano /opt/crowdsec/acquis.yaml
```

To verify that everything’s OK and that public IPs have been transferred, use the Docker logs.

```bash
sudo docker logs crowdsec
```
