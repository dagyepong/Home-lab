# Persistently mounting file systems

List all the block devices currently connected/ mounted

```bash
> lsblk --fs
NAME        FSTYPE FSVER LABEL       UUID                                 FSAVAIL FSUSE% MOUNTPOINTS
sda
└─sda1      exfat  1.0   Ultra Touch 5FB1-E1EC                             151.3G    92% /media/hdd
mmcblk0
├─mmcblk0p1 vfat   FAT16 BOOT_EOS    BBA8-CA00                             201.6M    21% /boot
└─mmcblk0p2 ext4   1.0   ROOT_EOS    920ac2b4-b1c1-4829-9f4f-27ce23b11a27     43G    22% /
```

```bash
> lsblk --fs /dev/sda1
NAME FSTYPE FSVER LABEL       UUID                                 FSAVAIL FSUSE% MOUNTPOINTS
sda1 exfat  1.0   Ultra Touch 5FB1-E1EC                             151.3G    92% /media/hdd
```

Even this works for specific data

```bash
lsblk -o NAME,FSTYPE,UUID,MOUNTPOINTS
```

Create a mount point thats readable by everyone

```bash
> _ mkdir -p /media
> _ chown -R abraxas:abraxas /media
#or
> _ chmod 777 -R .
```

Editing `/etc/fstab` to mount this on boot to `/media/segateHdd`

```bash
> sudo nano /etc/fstab

UUID=5FB1-E1EC          /media/segateHdd                exfat           defaults        0 0
```

```bash
> sudo findmnt --verify
   [W] your fstab has been modified, but systemd still uses the old version;
       use 'systemctl daemon-reload' to reload

0 parse errors, 0 errors, 1 warning
```

Added `nofail,x-systemd.device-timeout=9` so that if the device doesn't exist then the system will wait for 9 seconds and move on

```bash
UUID=5FB1-E1EC          /media/segateHdd                exfat           defaults,nofail,x-systemd.device-timeout=9      0 0
```

Can also add  `uid=2002,gid=2003` to mount the disk as a non root user

```bash
> l /media/
Permissions Size User    Date Modified Name
drwxr-xr-x     - abraxas 10 May 18:55  segateHdd
```

Final fstab

```bash
❯ _ cat /etc/fstab
[sudo] password for abraxas:
# /dev/mmcblk0p2 LABEL=ROOT_EOS
UUID=920ac2b4-b1c1-4829-9f4f-27ce23b11a27       /               ext4            rw,relatime     0 1

# /dev/mmcblk0p1 LABEL=BOOT_EOS
UUID=BBA8-CA00          /boot           vfat            rw,relatime,fmask=0022,dmask=0022,codepage=437,iocharset=ascii,shortname=mixed,errors=remount-ro        0 2

UUID=5FB1-E1EC          /media/segateHdd                exfat           defaults,uid=2002,gid=2003,nofail,x-systemd.device-timeout=9            0 0
```

## Troubleshooting Read-only FS

`sudo: unable to open ..: Read-only file system` -> [src](https://askubuntu.com/a/197468)

```bash
> sudo fsck -Af -M

# Use the EXT4 specific fsck if the above is stuck at the banner
> sudo fsck.ext4 -f /dev/sda1
```

Remount disk in read write mode if its mounted as read-only, which happens sometimes due to errors

```bash
sudo mount -vo remount,rw /
```

dmesg gives more info on the error

```bash
dmesg | grep "EXT4-fs error"
```

---
---

## Related Links

- [Chapter 26. Persistently mounting file systems Red Hat Enterprise Linux 8 | Red Hat Customer Portal](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/managing_file_systems/assembly_persistently-mounting-file-systems_managing-file-systems)
- [How do I disable mounting of a filesystem if the hardware has failed. - Red Hat Customer Portal](https://access.redhat.com/solutions/343003)
- [Auto Mount Drive in Ubuntu Server 22.04 at Startup](https://developerinsider.co/auto-mount-drive-in-ubuntu-server-22-04-at-startup/)
