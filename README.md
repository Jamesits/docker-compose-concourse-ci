Docker compose example deployment for [Concourse CI](https://concourse-ci.org/).

Notes:
- full scalable deployment options provided
- just enough config for running hello world pipelines and verify HA setups
- **NOT secure** by default, hardcoded keys everywhere
- Open Policy Agent set up by default to deny all privileged actions against a worker
- somehow works

Deployment:

First edit `CONCOURSE_EXTERNAL_URL` in `full/concourse_web.env`, then use the following script.

```
cd full
./generate_keys.sh
docker-compose -f docker-compose.yml -f docker-compose.worker.yml -f docker-compose.watchtower.yml up -d --remove-orphans
```

Testing:

```
fly --target example-server login --concourse-url http://localhost:8080
fly --target example-server status
fly --target example-server userinfo
fly --target example-server workers --details

fly --target example-server set-pipeline -p hello-world -c .\test-fixtures\hello-world.yml
fly --target example-server unpause-pipeline -p hello-world
fly --target example-server trigger-job --job hello-world/hello-world-job --watch
```

Memory Usage (empty server):
- Nginx: 5MiB
- web node: 25MiB per node
- worker node: 42MiB per node
- PostgreSQL: 100MiB
- OPA: 22MiB
