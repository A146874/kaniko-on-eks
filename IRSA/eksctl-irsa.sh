# Create k8s service account with ECR permissions
eksctl create iamserviceaccount \
    --name pipeline-deployment \
    --namespace $K8S_NAMESPACE \
    --cluster $K8S_CLUSTER \
    --attach-policy-arn arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser \
    --approve \
    --override-existing-serviceaccounts

kubectl describe sa pipeline-deployment -n $K8S_NAMESPACE