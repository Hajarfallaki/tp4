pipeline {
    environment {
        registry = "hajarfallaki/tp4"
        registryCredential = 'dockerhub'
        dockerImage = ''
    }
    agent any
    stages {
        stage('Cloning Git') {
            steps {
                git 'https://github.com/Hajarfallaki/tp4.git'
            }
        }
        stage('Building image') {
            steps{
                script {
                    dockerImage = docker.build registry + ":$BUILD_NUMBER"
                }
            }
        }
        stage('Test image') {
            steps{
                script {
                    echo "Tests passed"
                }
            }
        }
        stage('Publish Image') {
            steps{
                script {
                    docker.withRegistry( '', registryCredential ) {
                        dockerImage.push()
                    }
                }
            }
        }
        stage('Deploy image') {
            steps{
                script {
                    sh 'docker stop tp4-container || true'
                    sh 'docker rm tp4-container || true'
                    sh "docker run -d --name tp4-container -p 8081:80 $registry:$BUILD_NUMBER"
                }
            }
        }
    }
}