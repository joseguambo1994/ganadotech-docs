podman run --rm -it -p 8080:8080 -v "$(pwd):/usr/local/structizr:Z" structurizr/structurizr local

# Remove pod
podman ps --format "table {{.ID}} {{.Names}} {{.Ports}}" | Select-String -Pattern "8080"
podman kill ae694f7dbc66
podman rm ae694f7dbc66