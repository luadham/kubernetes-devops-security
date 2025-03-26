pipeline {
  agent any

  stages {
      stage('Build Artifact') {
            steps {
              sh "mvn clean package -DskipTests=true"
              archive 'target/*.jar' //
            }
        }   
      stage('Dockerized The Application') {
        steps {
          sh "docker ps -a"
          echo "Current GIT Commit is ${env.GIT_COMMIT}"
          sh "docker build -t luadham/javaapp:${env.GIT_COMMIT} ."
          withDockerRegistry(credentialsId: 'docker-hub') {
            sh "docker push luadham/javaapp:${env.GIT_COMMIT}" //
          }
        }
      }
  }
}
