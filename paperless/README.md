## Key Components of the Configuration¶

## Services:¶

Broker (Redis): Acts as the message broker for Paperless-ngx.
DB (Postgres): The database server for storing Paperless-ngx data.
Webserver (Paperless-ngx): The main Paperless-ngx service providing the web interface and document processing.
Gotenberg: Provides document conversion services, enhancing Paperless-ngx's ability to consume various file formats.
Tika: Offers content analysis and metadata extraction, further extending support for document types.


### create these directories:
* data
* media
* pgdata
* redisdata
* consume
* export
### Login credentials:
To login, create a superuser with this command:
```bash
docker compose run --rm webserver createsuperuser
```

