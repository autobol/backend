pipeline {
    agent {docker {image 'gcr.io/kaniko-project/executor:latest'}}

    environment{
      GRADLE_VERSION = "6.6.1"
    }
  
    stages {
        stage('Build and publish') {
            steps {
                sh''' 
                  mkdir -p /kaniko/.docker
                  echo "{\"auths\":{\"${DOCKER_REGISTRY}\":{\"auth\":\"$(printf "%s:%s" "${DOCKER_USER}" "${DOCKER_PASS}" | base64 | tr -d '\n')\"}}}" > /kaniko/.docker/config.json
                  pwd
                  >-
                  /kaniko/executor
                  --context .
                  --build-arg "GRADLE_VERSION=$GRADLE_VERSION"
                  --dockerfile "./Dockerfile"
                  --destination "${DOCKER_REGISTRY}/backend:jenk"
                  --destination "${DOCKER_REGISTRY}/backend:latest"
                '''
            }
        }
    }
}
