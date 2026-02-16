# SMB Share for windows

A simple SMB server container to transfer file between a windows client

`-u "0:0:root:root:toor" -s "SmbShare:/share/folder:ro:root"`
This command creates share named `SmbShare` with read-only access, change to `rw` for read-write

The share can be access using the credentials `root:toor`

The password (`toor` here) can be anything, but the user (`root` here) needs to match a user on the host with access to the bound volume.

> _Using root isn't a good idea_, buts acts as a catchall
