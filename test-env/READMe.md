
#### **Start Services:'**
```bash
docker compose --profile core up -d
```


### **Stop Sservices:**
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