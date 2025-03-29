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

        // stage('Code Coverage') {
        //     steps {
        //         timeout(time: 60, unit: 'SECONDS') {
        //             withSonarQubeEnv('SonarQubeServer') {
        //                 sh '''
        //                     mvn clean verify sonar:sonar -Dsonar.projectKey=Adham \
        //                     -Dsonar.projectName='Adham' \
        //                     -Dsonar.coverage.jacoco.xmlReportPaths=target/site/jacoco/jacoco.xml
        //                 '''
        //             }
        //             waitForQualityGate abortPipeline: true
        //         }
        //     }
        // }

        stage('OWASP Dependency Check') {
            steps {
                sh "mvn dependency-check:check"
                dependencyCheckPublisher pattern: 'target/dependency-check-report.html'
            }
        }
    }
}
