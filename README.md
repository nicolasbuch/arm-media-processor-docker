# arm-media-processor-docker

## Usage

``

**Usage**

Please note that you need a filebot license
```
docker run -d \
    --name=<container name>
    -v <path to data>:/data \
    -v <path to filebot license>:/license/filebot.psm \
    nicolasbuch/media-converter
```

Please note that this container uses unrar (non-free) to handle extraction of .rar files