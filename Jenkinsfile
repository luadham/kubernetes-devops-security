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

        stage('Vulnrability Scanning') {
            steps {
                parallel(
                    'Run OWASP Dependency': {
                         sh 'mvn dependency-check:check'
                         dependencyCheckPublisher pattern: 'target/dependency-check-report.html'
                    },
                    'Run Trivy Scan': {
                        sh 'bash trivy-image-scan.sh'
                    },
                    'Run OPA Conftest': {
                        sh '''
                            docker run --rm -v $(pwd):/project openpolicyagent/conftest \
                            test --policy dockerfile-security.rego Dockerfile
                        '''
                    }
                )
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
