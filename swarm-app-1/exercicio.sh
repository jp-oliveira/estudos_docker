docker network create --driver overlay frontend
docker network create --driver overlay backend

# vote
docker service create --name vote --replicas 2 --network frontend  -p 80:80 bretfisher/examplevotingapp_vote

#redis
docker service create --name redis --replicas 1 --network frontend redis:3.2

#worker
docker service create --name worker --replicas 2 --network frontend --network backend bretfisher/examplevotingapp_worker

#db
docker service create --name db --replicas 1 --network backend -e POSTGRES_HOST_AUTH_METHOD=trust --mount type=volume,source=db-data,target=/var/lib/postgresql/data postgres:9.4

#result
docker service create --name result --replicas 1 --network backend -p 5001:80 bretfisher/examplevotingapp_result
#é só uma réplica pq trabalha com websockets,que por sua vez devem ser consistentes,
#i.e., não podem ter replicas.
