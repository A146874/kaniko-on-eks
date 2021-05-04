# Create docker context as a config map
echo -e 'FROM ubuntu \nRUN echo "created from tarball"' > Dockerfile
tar -cf - Dockerfile | gzip -1 > docker-context.tar.gz
kubectl create configmap my-docker-context --from-file=docker-context.tar.gz -n mlcore

# Deploy
kubectl apply -f job.yaml -n $K8S_NAMESPACE

# Check status
kubectl get job kaniko-build-example -n $K8S_NAMESPACE
kubectl describe job kaniko-build-example -n $K8S_NAMESPACE
kubectl logs job/kaniko-build-example -n $K8S_NAMESPACE

# Clean up
kubectl delete configmap my-docker-context -n $K8S_NAMESPACE
kubectl delete -f job.yaml -n $K8S_NAMESPACE