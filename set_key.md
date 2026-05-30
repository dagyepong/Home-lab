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

