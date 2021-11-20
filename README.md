Docker compose example deployment for [Concourse CI](https://concourse-ci.org/).

Notes:
- full scalable deployment options provided
- not secure by default, hardcoded keys everywhere
- somehow works

Deployment:

```
cd full
./generate_keys.sh
docker-compose -f docker-compose.yml -f docker-compose.worker.yml -f docker-compose.watchtower.yml --remove-orphans -d up
```

Testing:

```
fly --target example-server login --concourse-url http://localhost:8080
fly --target example-server workers
```
