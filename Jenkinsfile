pipeline {
    agent any

    stages {

        stage('System Cleanup') {
            steps {
                script {
                    sh 'docker rm -f crud-mongodb crud-backend crud-frontend crud-nginx || true'
                    sh 'docker-compose down --remove-orphans || true'
                }
            }
        }

        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/RISHIKUMAR206/deploy-full-stack-mean-application-project.git'
            }
        }

        stage('Security Scan (Trivy)') {
            steps {
                script {
                    sh 'trivy fs . || true'
                    sh 'mkdir -p trivy-reports'
                    sh 'trivy fs . --output trivy-reports/jenkins-fs-scan.txt || true'
                }
            }
        }

        stage('Docker Deployment') {
            steps {
                sh 'docker-compose up -d --build'
            }
        }
    }

    post {
        success {
            echo 'Bhai Success! Application deployed successfully!'
        }

        failure {
            echo 'Deployment Fail ho gayi. Console Output check kar!'
        }
    }
}
