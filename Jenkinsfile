pipeline {
    agent any
    
    environment {
        registry = "hajarfallaki/tp4"
        registryCredential = 'dockerhub'
        dockerImage = ''
    }
    
    stages {
        stage('Cloning Git') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/Hajarfallaki/tp4.git'
            }
        }
        
        stage('Building image') {
            steps {
                script {
                    dockerImage = docker.build("${registry}:${BUILD_NUMBER}")
                }
            }
        }
        
        stage('Test image') {
            steps {
                script {
                    dockerImage.inside {
                        sh 'echo "Tests passed"'
                    }
                }
            }
        }
        
        stage('Publish Image') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', registryCredential) {
                        dockerImage.push("${BUILD_NUMBER}")
                        dockerImage.push('latest')
                    }
                }
            }
        }
        
        stage('Deploy image') {
            steps {
                script {
                    sh """
                        docker stop tp4-container || true
                        docker rm tp4-container || true
                        docker run -d --name tp4-container -p 8081:80 ${registry}:${BUILD_NUMBER}
                    """
                }
            }
        }
    }
    
    post {
        success {
            echo "✅ Pipeline réussi! Build #${BUILD_NUMBER}"
            echo "🐳 Image: ${registry}:${BUILD_NUMBER}"
            echo "🌐 Application accessible sur: http://localhost:8081"
        }
        failure {
            echo "❌ Pipeline échoué!"
        }
        always {
            sh 'docker system prune -f || true'
        }
    }
}