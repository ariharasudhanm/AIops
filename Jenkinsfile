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
                git url: 'https://github.com/ariharasudhanm/AIops.git', branch: 'main', credentialsId: '5f6485dc-4f86-4596-b76a-ecd94da74aa2'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build --no-cache -t yolov4_inference_image -f Dockerfile .'
                }
            }
        }

           stage('Check GPU Access') {
            steps {
                script {
                    docker.image(IMAGE_NAME).inside("--gpus all") {
                        // Run nvidia-smi to verify GPU access
                        sh 'nvidia-smi'
                    }
                }
            }
        }

        stage('Run Inference in Docker Container') {
            steps {
                script {
                    docker.image(IMAGE_NAME).inside("--gpus all -v ${env.WORKSPACE}/${OUTPUT_DIR}:/app/${OUTPUT_DIR}") {
                        sh 'python3 inference_yolov4.py'
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
