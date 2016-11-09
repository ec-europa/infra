#!groovy
node {
  stage('Build Docker image') {
    sh 'composer install'
    sh './vendor/bin/phing build docker-create-instance'
  }
}
