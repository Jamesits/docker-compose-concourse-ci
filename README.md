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
fly --target example-server status
fly --target example-server userinfo
fly --target example-server workers

fly --target example-server set-pipeline -p hello-world -c .\test-fixtures\hello-world.yml
fly --target example-server unpause-pipeline -p hello-world
fly --target example-server trigger-job --job hello-world/hello-world-job --watch
```
