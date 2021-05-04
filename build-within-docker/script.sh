echo -e "FROM ubuntu\nRUN echo 'It worked'" > Dockerfile

docker run \
    -v $(pwd):/workspace \
    $AWS_ACCOUNT_NUM.dkr.ecr.$AWS_REGION.amazonaws.com/kaniko:latest \
    --no-push \
    # --destination=$AWS_ACCOUNT_NUM.dkr.ecr.$AWS_REGION.amazonaws.com/dummy \
    --dockerfile /workspace/Dockerfile
