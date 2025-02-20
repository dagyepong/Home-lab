

####**EXAMPLE SERVICE WITH LABELS:**


```bash




version: '3'
services:
  pihole:
    container_name: pihole
    image: pihole/pihole:latest
    ports:
      - "53:53/tcp"
      - "53:53/udp"
      - "80:80/tcp"
    volumes:
      - './etc-pihole:/etc/pihole'
      - './etc-dnsmasq.d:/etc/dnsmasq.d'
    labels:
      - "nautical-backup.enable=true"
      - "nautical-backup.stop-before-backup=true"

```
