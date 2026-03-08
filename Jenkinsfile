pipeline {
    agent any

    stages {

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t php-devops-app .'
            }
        }

        stage('Stop Old Container') {
            steps {
                sh 'docker rm -f php-container || true'
            }
        }

        stage('Deploy Container') {
            steps {
                sh 'docker run -d -p 8082:80 --name php-container php-devops-app'
            }
        }

    }
}