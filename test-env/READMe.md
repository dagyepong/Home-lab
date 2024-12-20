
#### **Start Services:(CORE)**
```bash
docker compose --profile core up -d
```


### **Stop Sservices:(CORE)**
```bash
docker compose --profile core down
```

#### **Logs:**

```bash
docker compose --profile core logs -ft
```
### **Start & update all services:**
```bash
docker compose --profile all pull
docker compose --profile all up -d
```

### **create network:**

```bash
docker network create proxy ghost
```

#### **Logs:**

```shell
docker compose --profile all logs -ft
```

### move or copy all.yaml files to app directory and start the service up!