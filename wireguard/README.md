Configuring and Using Wireguard and Wireguard UI¶
After deployment, use the Wireguard UI to manage your Wireguard VPN settings, including adding and configuring VPN clients.

Post Up

```bash
iptables -A FORWARD -i wg0 -j ACCEPT; iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
```

Post Down

```bash
iptables -D FORWARD -i wg0 -j ACCEPT; iptables -t nat -D POSTROUTING -o eth0 -j MASQUERADE
```




wg-easy


Check That /lib/modules Is Mounted and Accessible
Run this on your host machine:

```bash
ls /lib/modules
```

If you get No such file or directory, your kernel modules aren’t installed or your system doesn’t expose them (common on minimal/Cloud images).

Install them:

```bash
sudo apt update && sudo apt install -y linux-modules-extra-$(uname -r) wireguard
sudo modprobe wireguard
sudo modprobe iptable_nat
```

Check That ~/.amnezia-wg-easy Exists and Is Writable
Run:
```bash
mkdir -p ~/.amnezia-wg-easy
chmod 755 ~/.amnezia-wg-easy
```

If You Still See “no configuration file provided: not found”
That means Amnezia is expecting a config file inside ~/.amnezia-wg-easy — but it’s empty or missing.

Run this to initialize it:
```bash
mkdir -p ~/.amnezia-wg-easy
touch ~/.amnezia-wg-easy/wg0.conf
```
