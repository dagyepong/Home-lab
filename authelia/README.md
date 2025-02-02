
# Notes

You have to put the configuration files from the directory `config` here to your Docker volume bind mount.

```bash
mkdir -p authelia-demo/{data,config}
cd authelia-demo
```


# Generate Password


```bash

docker run --rm authelia/authelia:latest authelia crypto hash generate argon2 --password 'password'

```

