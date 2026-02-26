Note on PASSWORD_HASH: This version requires a bcrypt hash instead of a plaintext password for security. You can generate one using the command:

```bash
docker run ghcr.io/wg-easy/wg-easy wgpw 'YOUR_PASSWORD'
```

