### Create onlyoffice config file:

```bash
sudo mkdir -p data customize onlyoffice-dist onlyoffice-conf
```

### Give Permissions:

```bash
sudo chown -R 4001:4001 data customize onlyoffice-dist onlyoffice-conf
```

### Create logs folder:

```bash
sudo mkdir data/logs
```

`Note`💡: Wait 5 minutes before continuing the tutorial because onlyoffice will be deployed.

We will give the necessary rights to the data file:

```bash
sudo chown -R 4001:4001 data
```

### Restart cryptpad:

```bash
docker restart cryptpad
```

`Note`: After creating the user profile, copy the key and paste it in the `config.js` admin_key..