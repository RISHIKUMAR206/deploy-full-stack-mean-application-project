pipeline {
    agent any

    stages {
        stage('System Cleanup') {
            steps {
                script {
                    // Purane containers aur ports saaf karne ke liye
                    sh 'sudo systemctl stop apache2 || true'
                    sh 'sudo docker rm -f crud-mongodb crud-backend crud-frontend crud-nginx || true'
                    sh 'sudo docker-compose down --remove-orphans || true'
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
                    // Code scan aur Image scan dono automate kar diye
                    sh 'trivy fs . || true'
                    // Scan reports folder update karne ke liye
                    sh 'mkdir -p trivy-reports'
                    sh 'trivy fs . --output trivy-reports/jenkins-fs-scan.txt || true'
                }
            }
        }

        stage('Docker Deployment') {
            steps {
                // Containers ko build aur start karne ke liye
                sh 'sudo docker-compose up -d --build'
            }
        }
    }

    post {
        success {
            echo 'Bhai Success! Application live hai: http://localhost:8081'
        }
        failure {
            echo 'Deployment Fail ho gayi. Console Output check kar!'
        }
    }
}
