pipeline {
    agent any
    environment {
        IMAGE_NAME = 'yolov4_inference_image'
        OUTPUT_DIR = 'output'
    }
    triggers {
        githubPush()  // Triggers the pipeline on each push to GitHub
    }
    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/ariharasudhanm/AIops.git', branch: 'main'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build(IMAGE_NAME, '-f Dockerfile .')
                }
            }
        }
        stage('Run Inference in Docker Container') {
            steps {
                script {
                    docker.image(IMAGE_NAME).inside("--gpus all -v ${pwd()}/${OUTPUT_DIR}:/app/${OUTPUT_DIR}") {
                        sh 'python3 inference.py'
                    }
                }
            }
        }
    }
    post {
        success {
            echo 'Inference completed successfully. Check the output directory for results.'
        }
        failure {
            echo 'The inference process failed.'
        }
    }
}