pipeline {
    agent any

    environment {
        TF_DIR = 'Day01-basicEC2_creation'
        AWS_CREDENTIALS_ID = 'aws-creds-id'     // Jenkins credentials ID for AWS IAM user
    }

    triggers {
        githubPush() // Auto trigger when code is pushed to GitHub (webhook needed)
    }

    stages {

        stage('Checkout Code') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/Sanjaypalanki/Terraform-1030.git'
            }
        }

        stage('Terraform Init') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: "${AWS_CREDENTIALS_ID}"]]) {
                    dir("${TF_DIR}") {
                        sh 'terraform init'
                    }
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                dir("${TF_DIR}") {
                    sh 'terraform plan -out=tfplan'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                input message: 'Do you want to apply the Terraform plan?'
                dir("${TF_DIR}") {
                    sh 'terraform apply tfplan'
                }
            }
        }
    }

    post {
        success {
            echo 'Terraform EC2 provisioning completed.'
        }
        failure {
            echo 'Pipeline failed.'
        }
    }
}
