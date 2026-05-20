### Welcome to self-hosted image for your websites!!


### Domain

`Note:` Make sure to point yout domain to the ip in order to register an account

### Account Approval

Copy the id generated and paste in with these commands:

```bash
docker exec -it slink slink user:activate --email=votremail@test.com
```

```bash
docker exec -it slink slink user:activate --uuid=replace_with_id
```


#### **Tor:**

Prerequisites (One‑time)
Ensure Traefik is attached to the traefik network (it already is, from your merged compose).

Get your .onion address from the Tor container:

```bash
docker exec tor cat /var/lib/tor/myservice/hostname
```

Copy the output (e.g., geabt5wzimq6fzqu2atnuqvcey7ygiy5u4xa5fqxrotcb4ncix64zcqd.onion).

Replace abcdef1234567890.onion in the label above with that exact address.

Restart Traefik to pick up the tor entrypoint (if not already done):

```bash
docker-compose restart traefik
```

Start the Service
```bash
docker-compose up -d slink
```

Then check that Traefik sees the new routers:

```bash
docker logs traefik | grep "slink"
```

You should see entries for slink-http, slink-https, and slink-tor.

Testing
Clearnet (with Authelia) → https://slink.nanaoware.online – you’ll be prompted to log in.

Tor (anonymous) → http://abcdef1234567890.onion in Tor Browser – no login required.

If you want the Tor route to also require Authelia, add ,authelia@docker to the slink-tor middlewares (but that defeats the purpose for most use cases).



What if you want multiple services (each with its own .onion address)?
You would add more blocks to torrc:

```bash
# For slink
HiddenServiceDir /var/lib/tor/slink/
HiddenServicePort 80 traefik:8081

# For another service
HiddenServiceDir /var/lib/tor/otherservice/
HiddenServicePort 80 traefik:8081
```

Then you would get each address with:

```bash
docker exec tor cat /var/lib/tor/slink/hostname
docker exec tor cat /var/lib/tor/otherservice/hostname
```

🧹 Redis warning (optional fix)
On your host (not inside containers), run:

```bash
echo 'vm.overcommit_memory = 1' | sudo tee -a /etc/sysctl.conf
sudo sysctl -p
```