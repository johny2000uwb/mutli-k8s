docker build -t johny2000uwb/multi-client:latest -t johny2000uwb/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t johny2000uwb/multi-server:latest -t johny2000uwb/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t johny2000uwb/multi-worker:latest -t johny2000uwb/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push johny2000uwb/multi-client:latest
docker push johny2000uwb/multi-server:latest
docker push johny2000uwb/multi-worker:latest

docker push johny2000uwb/multi-client:$SHA
docker push johny2000uwb/multi-server:$SHA
docker push johny2000uwb/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=johny2000uwb/multi-server:$SHA
kubectl set image deployments/client-deployment client=johny2000uwb/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=johny2000uwb/worker-server:$SHA