# Mediastack

Services involved

-   Jellyseer
-   Sonarr
-   Radarr
-   Jackett
-   Bazarr
-   Transmission
-   Flaresolverr

## Jackett

-   Set a admin password
-   Add a couple new indexers

## Transmission

-   Set the downloads dir to `/data/downloads`
-   Set the incomplete downloads dir to `/data/incomplete`
-   Check port config

## Radarr

-   Set credentials
    -   Settings -> General -> AuthN -> Login Form
-   Set download client

    -   Settings -> Download Clients -> Select transmission
        -   Name: Transmission
        -   Host: transmission, Port: 9091
        -   Test connection

-   Indexers

    -   Settings -> Indexers -> New Indexer -> Torznab (custom -> jackett)
    -   From Jackett, copy the Torznab Feed for the specific index into the URL field
    -   From jackett, copy the API key into teh API field
    -   Test and save

-   Media management
    -   Settings -> Media management -> Show Advanced
    -   [x] Rename Movies
    -   [x] Replace illegal chars
    -   [x] Delete empty folders
    -   [x] Use hardlinks
    -   [x] Unmonitor delete movies
    -   Set movie name format and movie folder format
    -   Add Root folder -> `/data/movies`

## Sonarr

Same steps as Radarr

## Bazarr

## Jellyseer

-   Setup `sonarr` and `radarr` using the hostnames for internal only communication

## Flaresolverr

Helps bypass cloudflare
