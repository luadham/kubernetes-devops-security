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
        stage('Code Coverage') {
            steps {
                echo "$token"
                sh '''
                    mvn clean verify sonar:sonar -Dsonar.projectKey=Adham \
                     -Dsonar.projectName='Adham' \
                     -Dsonar.token=${token}
                '''
            }
        }
    }
}
