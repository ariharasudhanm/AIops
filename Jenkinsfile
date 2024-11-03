pipeline {
    agent any
    stages {
        stage('Verify Docker Access') {
            steps {
                echo "Checking Docker version..."
                sh 'docker --version'
            }
        }
    }
}