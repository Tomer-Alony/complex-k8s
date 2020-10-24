docker build -t sturs23/complex-k8s-client:latest -t sturs23/complex-k8s-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t sturs23/complex-k8s-server:latest -t sturs23/complex-k8s-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t sturs23/complex-k8s-worker:latest -t sturs23/complex-k8s-worker:$GIT_SHA -f ./worker/Dockerfile ./worker
docker push -t sturs23/complex-k8s-worker:latest sturs23/complex-k8s-worker:$GIT_SHA
docker push -t sturs23/complex-k8s-server:latest sturs23/complex-k8s-server:$GIT_SHA
docker push -t sturs23/complex-k8s-client:latest sturs23/complex-k8s-client:$GIT_SHA
kubectl apply -f ./k8s

kubectl set image deployments/server-deployment server=sturs23/complex-k8s-server:$GIT_SHA
kubectl set image deployments/client-deployment client=sturs23/complex-k8s-client:$GIT_SHA
kubectl set image deployments/worker-deployment worker=sturs23/complex-k8s-worker:$GIT_SHA