## DevOps Lab

### Commands
```bash
ssh-keygen -t rsa -b 4096 -f id_rsa_master -C "dev@example.com" -N ""
ssh -i vms/keys/id_rsa_master docker@localhost -p 2202

docker builder prune --all
docker compose build --no-cache --parallel
docker compose up -d --build
docker compose down --volumes
docker network inspect docker-vms
```
