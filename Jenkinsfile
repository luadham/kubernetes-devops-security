pipeline {
  agent any

  stages {
      stage('Build Artifact') {
            steps {
              sh "mvn clean package -DskipTests=true"
              archive 'target/*.jar' //
            }
        }   
      stage('Test Application') {
            steps {
              sh "mvn test"
            }
        }
      stage('Dockerized The Application') {
        steps {
          echo "Current GIT Commit is ${env.GIT_COMMIT}"
          sh "docker build -t luadham:javaapp:${env.GIT_COMMIT}"
        }
      }
  }
}
