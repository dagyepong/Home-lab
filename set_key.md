SSH into your server (or open your local terminal) and run:

```bash
gpg --full-generate-key
```

When prompted, make the following selections:

Kind of key: Select (9) ECC and ECC (sign and encrypt) or (4) RSA if you prefer classic compatibility.

Elliptic Curve: Select (1) Curve 25519 (Ed25519).

Expiration: Set it to 1y or 2y (1 or 2 years). It’s best practice to let keys expire so you're forced to rotate them if lost.

Real Name: Your name or blog handle (e.g., nana).

Email Address: Your blog’s primary administrative email address (e.g., admin@linuxpad.blog).

Type a strong, unique passphrase when prompted. This passphrase encrypts your private key on your local disk.



List your secret keys to find your unique Key ID:

```bash
gpg --list-secret-keys --keyid-format=long
```

Look for the line starting with sec. The string of characters after the slash is your Key ID (e.g., sec   ed25519/ABC123XYZ7890123).

Export your public key to a text file using that ID:

```bash
gpg --armor --export ABC123XYZ7890123 > linuxpad_pubkey.asc
```

vscode integration:


Here is a complete, streamlined reference guide of the entire setup you just built. This covers everything from generating the key on your server to configuring it on your Gentoo laptop and integrating it with VS Code.

Part 1: On the Remote Server
1. Export the Secret Key
Since the key was generated here, you need to export the private cryptographic block to transfer it to your laptop.

```bash
gpg --armor --export-secret-keys FF0825B4A1F7B871
```
Copy the entire output block, ensuring it begins with -----BEGIN PGP PRIVATE KEY BLOCK-----.

Part 2: On the Gentoo Laptop
2. Import the Secret Key
Create a temporary file, paste the private key block inside it, and ingest it into your laptop's keyring:

```bash
nano ~/linuxpad_key.asc
```
# [Paste the private key block, then Save & Exit]

```bash
gpg --import ~/linuxpad_key.asc
rm ~/linuxpad_key.asc
```
3. Verify the Key is Local
Confirm that your laptop successfully reads both the public and secret parts of the key:

```bash
gpg --list-secret-keys --keyid-format=long
```
You should see sec ed25519/FF0825B4A1F7B871 in the output.

4. Configure GnuPG Agent Defaults
Configure your local GPG agent to allow background applications (like VS Code) to prompt for passwords, and extend the password caching timeout so you rarely have to re-enter it.

Edit or create the agent configuration file:

```bash
nano ~/.gnupg/gpg-agent.conf
```
Add these lines:

```bash
allow-loopback-pinentry
max-cache-ttl 60480000
default-cache-ttl 60480000
```
5. Configure GnuPG Internal Loopback
Force GPG to handle password entries inline within the active environment context.

Edit or create the main GPG configuration file:

```bash
nano ~/.gnupg/gpg.conf
```
Add this line:

```bash
pinentry-mode loopback
```
6. Restart the GPG Service
Flush the background processes to apply your new configuration changes immediately:

```bash
gpgconf --kill gpg-agent
gpg-connect-agent reloadagent /bye
```
7. Configure Git Globally
Clean out old override paths and map Git explicitly to your Gentoo GPG binary and Key ID:

```bash
# Clear any legacy or broken openpgp sub-program paths
git config --global --unset gpg.openpgp.program

# Set the correct global parameters
git config --global gpg.program /usr/bin/gpg
git config --global user.signingkey FF0825B4A1F7B871
git config --global commit.gpgsign true
git config --global gpg.format openpgp
git config --global core.askpass ""
```
Part 3: Verification & Daily Use
8. Audit Your Configuration
Verify that your global Git configs match this exact layout:

```bash
git config --list --show-origin | grep gpg
```
Expected Output:

```bash
file:/home/nana/.gitconfig      commit.gpgsign=true
file:/home/nana/.gitconfig      gpg.format=openpgp
file:/home/nana/.gitconfig      gpg.program=/usr/bin/gpg
```
9. Test Commit via Terminal
Navigate to your repository and execute a signed test commit:

```bash
cd ~/Documents/Home-lab
git commit --allow-empty -m "Gentoo GPG verification"
```
Type your passphrase when prompted.

Verify the signature status on the commit history:

```bash
git log --show-signature -1
```
Look for: gpg: Good signature from "Dennis Agyepong <owarenana06@gmail.com>".

10. Open VS Code
Restart the VS Code application completely. It will inherit this working environment, allowing you to use the standard built-in Source Control commit button seamlessly without any further errors.