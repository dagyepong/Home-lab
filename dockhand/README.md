Quick Fix: Grant Permission Manually
Run this command to grant the required permission directly on the existing database:

```bash
docker exec dockhand-postgres psql -U dockhand -d dockhand -c "GRANT CREATE ON DATABASE dockhand TO dockhand;"
```

```bash
docker compose up -d
```

#### **Hawser:**

🔒 Security Reminder

🌐 Access Dockhand
Visit https://dockhand.linuxpad.blog in your browser.

⚙️ How to Connect a Remote Host with Hawser (Edge Mode)
Since Edge mode is so useful for remote hosts without a public IP, here is the general workflow:

Obtain a Hawser Token: In your Dockhand UI, navigate to Environments > Add. Choose the "Hawser Agent" connection method. Dockhand will generate a unique, one-time token.

Install Hawser on the Remote Host: SSH into the Docker host you want to manage and run the official installation script:

```bash
curl -fsSL https://raw.githubusercontent.com/Finsys/hawser/main/scripts/install.sh | bash
```

Configure the Agent for Edge Mode: You need to edit the Hawser configuration file. Locate it at /etc/hawser/config. For Edge mode, you will:

Set the MODE="edge".

Set the DOCKHAND_SERVER_URL to the WebSocket address of your Dockhand instance, like wss://dockhand.linuxpad.blog/api/hawser/connect.

Set the TOKEN to the one you generated in Step 1.

Start the Hawser Service: Enable and start the agent so it runs in the background:

```bash
sudo systemctl enable hawser && sudo systemctl start hawser
```

Verify the Connection: Go back to your Dockhand UI. The remote host should now appear as an available environment, ready for you to manage its containers, images, and stacks directly from your central dashboard.
