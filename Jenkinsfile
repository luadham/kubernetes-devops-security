pipeline {
    agent any
    environment {
        token = credentials('sonar-qube-token')
    }
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

        stage('Code Coverage') {
            steps {
                withSonarQubeEnv(credentialsId: token) {
                    sh '''
                        mvn clean verify sonar:sonar -Dsonar.projectKey=Adham \
                        -Dsonar.projectName='Adham' \
                        -Dsonar.coverage.jacoco.xmlReportPaths=target/site/jacoco/jacoco.xml
                    '''
                }
            }
        }
    }
}
