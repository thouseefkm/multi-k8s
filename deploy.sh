#!/usr/bin/env bash
docker build -t thouseefkm/multi-client:latest -t thouseefkm/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t thouseefkm/multi-server:latest -t thouseefkm/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t thouseefkm/multi-worker:latest -t thouseefkm/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push thouseefkm/multi-client:latest
docker push thouseefkm/multi-server:latest
docker push thouseefkm/multi-worker:latest

docker push thouseefkm/multi-client:$SHA
docker push thouseefkm/multi-server:$SHA
docker push thouseefkm/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=thouseefkm/multi-server:$SHA
kubectl set image deployments/client-deployment client=thouseefkm/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=thouseefkm/multi-worker:$SHA
