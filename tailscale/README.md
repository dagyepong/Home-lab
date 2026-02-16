# Tailscale Mesh VPN

Authenticate and connect to the tailscale network

```bash
docker-compose exec tailscale tailscale up
```

Get status all clients

```bash
docker exec tailscale tailscale status
```

## Access PiHole over tailscale

```bash
docker-compose exec tailscale tailscale up --accept-dns=false
```

Set DNS servers on [tailscale's console](https://login.tailscale.com/admin/dns)
Under Global nameservers, add a custom IP, which would be the Pi's local IP

Enable the `Override local DNS` to override any local DNS settings
Also disable key expiry to prevent DNS interruptions when tailscale re-authenticates

https://tailscale.com/kb/1114/pi-hole/

The same can be done with [NextDNS](https://nextdns.io/)
https://tailscale.com/kb/1218/nextdns/

## Sharing machines

Go to the [tailscale console](https://login.tailscale.com/admin/machines)

Select the machine to share and click on share, which will create a link which can be shared with other users
![](https://i.imgur.com/R6Yzm7N.png)

https://tailscale.com/kb/1084/sharing/#sharing--magicdns

## Setup exit node and subnet routes

**Exit node**

Advertise as exit node

```bash
> docker exec tailscale tailscale up --advertise-exit-node
Warning: IPv6 forwarding is disabled.
Subnet routes and exit nodes may not work correctly.
See https://tailscale.com/s/ip-forwarding
```

> Enabling masquerading is also required for setting up a subnet router

```bash
> _ firewall-cmd --add-masquerade --zone=public
success
> _ firewall-cmd --list-all
public (active)
  target: default
...
  masquerade: yes
...
```

This will still complain about IPv6 forwarding. Solution is to eiher disable IPv6 or add a rich rule for IPv6

```bash
> _ firewall-cmd --add-rich-rule='rule family=ipv6 masquerade'
success
> _ firewall-cmd --list-all
...
  rich rules:
        rule family="ipv6" masquerade
```

```bash
> _ sysctl -w net.ipv6.conf.all.disable_ipv6=1
> _ sysctl -w net.ipv6.conf.default.disable_ipv6=1
```

Now `docker exec tailscale tailscale up --advertise-exit-node` will be executed without any error

This means if I enable exit node on a client, I can use tailscale as a full tunnel VPN as opposed to the default split tunnel mode

**Add Subnet routing**

Add the option `--advertise-routes=192.x.x.0/24` to

> 0 is to advertise entore subnet and /24 is the subnet mask for 255.255.255.0

Both the above configs can be verified by the [machines page on the admin console](https://login.tailscale.com/admin/machines)

![machines_overview](./images/machines_overview.png)

This can also be verified via teh status command

```bash
> docker exec tailscale tailscale status
x.x.x.x  niflheim             user.name@ linux   idle; offers exit node
...
```

Next, enable both the subnet and the exit node config under `edit route settings`
![](./images/route_settings.png)

### Using the exit node on other clients

#### Linux

This will use (in my case) niflheim as the exit node for all the requests

```bash
> _ tailscale up --exit-node [exitnode-hostname or IP]
```

To stop

```bash
> _ tailscale up --exit-node ''
```

The `--accept-routes` option will accept advertised routes from other clients, since by default linux devices don't

#### Windows

Select the hostname from menu of the tailscale tray icon to start using an exit node

#### Android

Select the hostname from the menu in the top right corner to start using an exit node

## References

[Exit Nodes (route all traffic) · Tailscale](https://tailscale.com/kb/1103/exit-nodes/)
[Subnet routers and traffic relay nodes · Tailscale](https://tailscale.com/kb/1019/subnets/)
[Tailscale CLI · Tailscale](https://tailscale.com/kb/1080/cli/#up)
[Docker Compose - Tailscale](https://docs.ibracorp.io/tailscale/tailscale/docker-compose)
[Subnet routers and traffic relay nodes · Tailscale](https://tailscale.com/kb/1019/subnets/)

[Using Tailscale for Home Lab VPN Connectivity - Lostdomain](https://lostdomain.org/2022/09/12/using-tailscale-for-home-lab-vpn-connectivity/)
[MagicDNS · Tailscale](https://tailscale.com/kb/1081/magicdns/)
[How NAT traversal works · Tailscale](https://tailscale.com/blog/how-nat-traversal-works/)
[Hosting a Minecraft server without extra hardware | siraben’s musings](https://siraben.dev/2022/08/01/tailscale-iptables.html?utm_content=August+Newsletter&utm_medium=email_action&utm_source=customer.io)
[Network access controls (ACLs) · Tailscale](https://tailscale.com/kb/1018/acls/)
[Tailscale VPN in Docker Without Elevated Privileges - Asselin.Engineer](https://asselin.engineer/tailscale-docker?utm_content=August+Newsletter&utm_medium=email_action&utm_source=customer.io)
[Tailscale Pi-hole Setup · Erraticbits](https://www.erraticbits.ca/post/2022/tailscale_pihole/?utm_content=August+Newsletter&utm_medium=email_action&utm_source=customer.io)
[How to Set Up Tailscale on Docker in 2023 - WunderTech](https://www.wundertech.net/how-to-set-up-tailscale-on-docker/)
[Build a Tailscale exit node with firewalld · Major Hayden](https://major.io/2022/10/27/build-a-tailscale-exit-node-with-firewalld/)