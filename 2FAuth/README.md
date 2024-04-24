## Configuration Details and Customization¶

Ports: The default port for accessing 2FAuth is 8000, which you can change according to your network setup.
Environment Variables: Provides detailed configuration for the app's operation, including:
APP_NAME: Customizable to change the name of your 2FAuth application.
APP_KEY: Critical for encryption; use php artisan key:generate to create a secure key.
SITE_OWNER: Your email address for site ownership verification.
APP_URL and ASSET_URL: Set these to match your installation's external address.
LOG_CHANNEL and LOG_LEVEL: Configure how and where your logs are stored and their verbosity.
DB_DATABASE: Specifies the path to your SQLite database.
MAIL_* settings: Configure according to your mail service provider for email functionalities.
WEBAUTHN_USER_VERIFICATION: Controls the behavior of user verification during WebAuthn authentication.
## Deployment Instructions¶

Prepare Environment:
Ensure the volume directory (./2fauth) exists on your host to store persistent data. Make this manually, otherwise it will be owned by root and it can lead to permission issues
Environment Configuration:
Fill in or adjust the environment variables in the docker-compose.yml file as necessary. Pay special attention to secure values like APP_KEY.
Starting the Service:
Deploy 2FAuth by running docker-compose up -d from the directory containing your docker-compose.yml file.
Notes¶

Security: Keep your APP_KEY secure and confidential. If you change this key, all existing data encrypted with the old key will be lost.
Mail Configuration: It's crucial to configure the mail settings correctly to enable features like email verification and notifications.
Ports Adjustment: You're free to adjust the port mappings to fit your network environment and avoid conflicts with other services.
This setup provides a robust foundation for deploying 2FAuth, ensuring you have a private, secure 2FA management system.