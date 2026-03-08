pipeline {
    agent any

    environment {
        IMAGE_NAME = "php-devops-app"
        CONTAINER_NAME = "php-container"
        PORT = "8082"
        ACC_ID = '180935779261'
    }

    stages {

        stage('Clean Workspace') {
            steps {
                cleanWs()
            }
        }

        // stage('Checkout Code') {
        //     steps {
        //         git branch: 'main', url: 'https://github.com/shahabsb94/PHP--Infrastructure-.git'
        //     }
        // }

        // stage('Build Docker Image') {
        //     steps {
        //         sh '''
        //         docker build -t $IMAGE_NAME .
        //         '''
        //     }
        // }

        stage('Docker Login') {
            steps {
                script{
                    withAWS(region: 'us-east-1', credentials: 'aws-creds') {
                        sh """
                            aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin ${ACC_ID}.dkr.ecr.us-east-1.amazonaws.com
                        """
                    }
                }
            }
        }

        stage('Debug Workspace') {
            steps {
                sh 'pwd'
                sh 'ls -la'
            }
        }

        stage('Docker Build') {
            steps {
                script{
                    withAWS(region: 'us-east-1', credentials: 'aws-creds') {
                        sh """
                            docker build -t ${ACC_ID}.dkr.ecr.us-east-1.amazonaws.com/${IMAGE_NAME}:latest .
                        """
                    }
                }
            }
        }

        stage('Docker Image Push to ECR ') {
            steps {
                script{
                    withAWS(region: 'us-east-1', credentials: 'aws-creds') {
                        sh """
                            docker push ${ACC_ID}.dkr.ecr.us-east-1.amazonaws.com/${IMAGE_NAME}:latest

                        """
                    }
                }
            }
        }

        stage('Stop Old Container') {
            steps {
                sh '''
                docker rm -f $CONTAINER_NAME || true
                '''
            }
        }

        stage('Deploy Container') {
            steps {
                sh '''
                docker run -d -p $PORT:80 --name $CONTAINER_NAME $IMAGE_NAME
                '''
            }
        }

        stage('Verify Deployment') {
            steps {
                sh '''
                docker ps
                '''
            }
        }
    }

    post {
        success {
            echo "Deployment successful 🚀"
        }
        failure {
            echo "Pipeline failed ❌"
        }
    }
}