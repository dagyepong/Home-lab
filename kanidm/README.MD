 Create /etc/kanidm/ on the Docker host and put server.toml, chain.pem, and key.pem in it. Your Compose bind mount makes that host directory available inside the container at /data/, matching the paths in server.toml:

 Create chain.pem and key.pem before starting Kanidm. Your server.toml requires both files, and Kanidm won’t start without them. 
kanidm.github.io

For your current setup—Traefik serves the public certificate, then connects to Kanidm over HTTPS—you can create a self-signed certificate for the internal Traefik-to-Kanidm connection. If you’re using auth.linuxpad.blog, run this on the Docker host:

```bash
sudo mkdir -p /etc/kanidm

sudo openssl req -x509 -newkey rsa:3072 -sha256 -days 365 -nodes \
  -keyout /etc/kanidm/key.pem \
  -out /etc/kanidm/chain.pem \
  -subj "/CN=auth.linuxpad.blog" \
  -addext "subjectAltName=DNS:auth.linuxpad.blog"
```

```bash
sudo chmod 600 /etc/kanidm/key.pem
```
Don't foget to put server.toml in /etc/kanidm

