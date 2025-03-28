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
                sh 'mvn clean test'
            }
        }

        stage('Code Coverage') {
            steps {
                sh '''
                    mvn clean verify sonar:sonar -Dsonar.projectKey=Adham \
                     -Dsonar.projectName='Adham' \
                     -Dsonar.token=${token} \
                     -Dsonar.coverage.jacoco.xmlReportPaths=target/site/jacoco/jacoco.xml
                '''
            }
        }
    }
}
