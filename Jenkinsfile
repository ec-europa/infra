#!groovy
node {
  checkout scm
  stage('Build Docker reference image') {
    sh 'docker build -t fpfis/php56 docker/fpfis-php56'
  }
}
