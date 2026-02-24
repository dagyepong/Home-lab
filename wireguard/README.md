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

