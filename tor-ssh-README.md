Setting up SSH over a dedicated Tor hidden service is an excellent way to add a robust, anonymous backchannel to your server, especially for managing it from restrictive networks that might block standard SSH ports. Since you're already running a Tor container, the process is quite elegant. Here is a full guide to get it working with your existing setup.

🧭 The Path to a Hidden SSH Service
The core idea is simple: you'll add a few lines to your Tor container's configuration to create a new hidden service. This service will point to the SSH daemon already running on your server. No new Docker containers or complex software are required.

The configuration is straightforward. You'll edit the torrc file (located in ./tor/torrc on your host) and add a few lines to tell Tor about your new hidden service.

```bash
# ... your other hidden service configs (e.g., for Nextcloud) ...
# SSH hidden service configuration
HiddenServiceDir /var/lib/tor/ssh/
HiddenServicePort 22 [::1]:22
```
This block does two things:

HiddenServiceDir: Specifies the directory where Tor will store the keys and the hostname (your .onion address) for this service. Any name after /var/lib/tor/ works; here, it's ssh.

HiddenServicePort: This line tells Tor that any connection to its virtual port 22 should be forwarded to port 22 on [::1] (IPv6 localhost). We use [::1] to include both IPv6 and IPv4 localhost.

After adding these lines, restart the Tor container for the changes to take effect. Immediately after, you can retrieve the new SSH .onion address using docker exec.

```bash
docker exec tor cat /var/lib/tor/ssh/hostname
```
This command will output a long string ending in .onion, which is your new anonymous endpoint. Keep this address secure; anyone with it can attempt to connect to your SSH server.

⚙️ Connecting from Your Client
To connect to this hidden service, your client must route its SSH traffic through the Tor network. The most reliable way is using the torsocks tool, which forces an application to use the Tor SOCKS proxy.

Install torsocks: On your client machine, use your system's package manager.

On Debian/Ubuntu: sudo apt install torsocks

On Arch Linux: sudo pacman -S torsocks

On Fedora: sudo dnf install torsocks

Connect via SSH: Use torsocks as a wrapper for your standard SSH command. Replace your_username and the .onion address with your own.

```bash
torsocks ssh your_username@your_onion_address.onion
```
🛡️ Making the Connection More Robust and Secure
This setup works, but we can refine it for a better and safer experience.

1. Configure the SSH Daemon for Tor
By default, your SSH server listens on all network interfaces. Since the SSH traffic from the Tor container will reach it via localhost, we can restrict the SSH daemon to only listen on localhost:22. This is a great security practice because it prevents external SSH connections from the wider internet, while still allowing your localhost-based Tor connection.

To do this, edit your SSH server's configuration file (usually /etc/ssh/sshd_config) and set the ListenAddress directive:

```bash
ListenAddress 127.0.0.1
ListenAddress ::1
```
After making the change, restart the SSH service with sudo systemctl restart sshd. Your SSH server will now only accept connections from the local machine.

2. Use Public Key Authentication
Relying on password authentication over Tor is not ideal. If you haven't already, set up SSH key-based authentication for your user. It's more secure, and you won't need to type a password.

Generate an SSH key (if you don't have one): On your client machine, run ssh-keygen -t ed25519.

Copy your public key to the server: With your standard (non-Tor) SSH access, use ssh-copy-id your_username@your_clearnet_server_ip to add your public key to the server's authorized_keys file.

Once completed, your torsocks ssh command will be passwordless and more secure.

📝 Step-by-Step Recap
On your server: Add the hidden service configuration block to ./tor/torrc.

On your server: Restart the Tor container with docker-compose restart tor.

On your server: Retrieve your new .onion address: docker exec tor cat /var/lib/tor/ssh/hostname.

(Optional, but recommended): Configure your SSH daemon to listen only on localhost:127.0.0.1 and ::1, then restart the SSH service.

On your client: Install torsocks.

On your client: Connect with torsocks ssh your_user@your_onion_address.onion.

This method is a powerful addition to any homelab. It provides a secure, anonymous, and network-agnostic way to manage your server from anywhere in the world.