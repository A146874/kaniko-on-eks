KANIKO_REPOSITORY=$(aws ecr create-repository \
  --repository-name kaniko \
  --region $AWS_REGION \
  --query 'repository.repositoryUri' \
  --output text)

mkdir kaniko
cd kaniko

cat > Dockerfile<<EOF
FROM gcr.io/kaniko-project/executor:debug
COPY ./config.json /kaniko/.docker/config.json
EOF

cat > config.json<<EOF
{ "credsStore": "ecr-login" }
EOF

docker build -t $KANIKO_REPOSITORY .
docker push $KANIKO_REPOSITORY