## Home brewed deployment steps - AnKumar

# build and push docker images with tags `latest` and `GIT_COMMIT_SHA`
docker build -t anuragkumarak1995/multi-client:latest -t anuragkumarak1995/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t anuragkumarak1995/multi-server:latest -t anuragkumarak1995/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t anuragkumarak1995/multi-worker:latest -t anuragkumarak1995/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push anuragkumarak1995/multi-client:latest
docker push anuragkumarak1995/multi-server:latest
docker push anuragkumarak1995/multi-worker:latest
docker push anuragkumarak1995/multi-client:$SHA
docker push anuragkumarak1995/multi-server:$SHA
docker push anuragkumarak1995/multi-worker:$SHA

# update configurations of kubernetes cluster in gcloud using kubectl which is configured in travis ci
kubectl apply -f ./k8s/

# update deployment images in gcloud kubernetes
kubectl set image deployments/client-deployment client=anuragkumarak1995/multi-client:$SHA
kubectl set image deployments/server-deployment server=anuragkumarak1995/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=anuragkumarak1995/multi-worker:$SHA
