pipeline {
    agent any
    stages {
        stage('Build Artifact') {
            steps {
                sh 'mvn clean package -DskipTests=true'
                archive 'target/*.jar'
            }
        }
        stage('Start Unit Test') {
            steps {
                sh 'mvn clean test jacoco:report'
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
                dockerImage = "luadham/JavaApp:${GIT_COMMIT}"
            }
            steps {
                sh "docker build -t ${dockerImage}"
                withDockerRegistry(credentialsId: 'docker-hub') {
                    sh "docker push ${dockerImage}"
                }
            }
        }
    }
}
