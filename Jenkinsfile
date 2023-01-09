pipeline {
  agent any
  environment {
    dockerImage = ''
    registry = 'wizardevops/task1'
    registryCredential = 'dockerhub_id'
  }
  stages {
    stage ('Checkout') {
      steps {
        checkout scmGit(branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/wizardevops/task1.git']])
      }
    }
    stage ('Test') {
      steps {
        sh "ls -la"
      }
    }
    stage ('Docker build') {
      steps {
        script {
          sh '-S docker build -t wizardevops/task1:latest .'
        }
      }
    }
    stage('Docker Push') {
      steps {
        script {
          docker.withRegistry('',registryCredential) {
            dockerImage.push()
          }
        }
      }
    }
    stage ('Pushing to ECR') {
      steps {
        script {
          sh 'aws ecr get-login-password --region eu-central-1 | docker login --username AWS --password-stdin 943775559597.dkr.ecr.eu-central-1.amazonaws.com'
          sh 'docker tag wizardevops/task1:latest 943775559597.dkr.ecr.eu-central-1.amazonaws.com/task1'
          sh 'docker push 943775559597.dkr.ecr.eu-central-1.amazonaws.com/task1'
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
          sh 'docker run -p 8096:80 --name task1 943775559597.dkr.ecr.eu-central-1.amazonaws.com/task1'
        }
      }
    }
    stage('Run playbook') {
      steps {
        script {
          ansiblePlaybook 'playbook_deploy_ECR.yaml'
        }
      }
    }
  }
}
