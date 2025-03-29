pipeline {
    agent any
    stages {
        stage('Build Artifact') {
            steps {
                sh 'mvn clean package -DskipTests=true'
                archiveArtifacts 'target/*.jar'
            }
        }
        stage('Start Unit Test') {
            steps {
                sh 'mvn test jacoco:report'
            }
        }

        stage('OWASP Dependency Check') {
            steps {
                sh "mvn dependency-check:check"
                dependencyCheckPublisher pattern: 'target/dependency-check-report.html'
            }
        }

        stage('Docker Build') {
            environment {
                dockerImage = "luadham/javaapp:${GIT_COMMIT}"
            }
            steps {
                sh "docker build -t ${dockerImage} ."
                withDockerRegistry(credentialsId: 'docker-hub', url: '') {
                    sh "docker push ${dockerImage}"
                }
            }
        }
    }
}
