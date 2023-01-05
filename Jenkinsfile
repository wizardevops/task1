pipeline {
  agent any
  environment {
    registry = "943775559597.dkr.ecr.eu-central-1.amazonaws.com/docker-task1"
  }
  stages {
    stage ('Checkout') {
      steps {
        checkout scmGit(branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/wizardevops/task1.git']])
      }
    }
    stage ('Docker Build') {
      steps {
        script {
          dockerImage = docker.build registry
        }
      }
    }
    stage ('Pushing to ECR') {
      steps {
        script {
          sh 'aws ecr get-login-password --region eu-central-1 | docker login --username AWS --password-stdin 943775559597.dkr.ecr.us-east-2.amazonaws.com'
          sh 'docker push 943775559597.dkr.ecr.eu-central-1.amazonaws.com/docker-task1'
        }
      }
    }
    stage ('Stop Previous Container') {
      steps {
        sh 'docker ps -f name=task1 -q | xargs --no-run-if-empty docker container stop'
        sh 'docker container ls -a -f name=task1 -q | xargs -r docker container rm'
      }
    }
    stage ('Docker Run') {
      steps {
        script {
          sh 'docker run -d -p 8096:5000 --rm --name task1 943775559597.dkr.ecr.eu-central-1.amazonaws.com/docker-task1:latest
        }
      }
    }
  }
}
