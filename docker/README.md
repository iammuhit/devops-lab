## DevOps Lab :: Docker

### Commands
```bash
ssh-keygen -t rsa -b 4096 -f id_rsa -C "dev@example.com" -N ""
ssh -i path/to/id_rsa user@hostname -p 22

docker network ls
docker network inspect network-name
docker network rm network-name

docker builder prune --all
docker compose build --no-cache --parallel
docker compose up -d --build
docker compose down --volumes

docker image ls
docker image prune
docker image rm image-name
docker scout quickview image-name

docker container ls -a
docker container inspect container-id
docker container stop container-id
docker container rm container-id
docker container rm $(docker ps -q)
```
