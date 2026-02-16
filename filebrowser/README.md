# Filebrowser

## Mounting additional directories

Filebrowser allows only one directory, but I wanted to mount both my home directory and my external drive.

Mount a `srv` dir to the `/srv` dir of teh container
Then mount any additional directories to `/srv/**`
All the mounted directories will be availabl at `URL/files/`

> Currently the conatienr is run as root. While this is unsafe, it prevents any permission errors.

## 413 File entity too large Error

If using a proxy like NPM, uploading a file > 2 GB will return a 413 error

Fix: Add this to the nginx configuration in the advanced tab

```
client_max_body_size 0;
```
This sets the maximum accepted body size of client request to undefined
