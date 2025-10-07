## DevOps Lab

### Commands
```bash
ssh-keygen -t rsa -b 4096 -f id_rsa -C "dev@example.com" -N ""
ssh -i vms/master-node/keys/id_rsa docker@localhost -p 2202

docker compose up -d --build
docker compose down --volumes
docker network inspect docker-vms
```
