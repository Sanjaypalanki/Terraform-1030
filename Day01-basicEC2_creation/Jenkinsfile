pipeline {
    agent any

    environment {
        AWS_REGION = 'us-east-1'
        TF_DIR = 'terraform'
        AWS_CREDENTIALS_ID = 'aws-creds-id'      // Jenkins AWS credentials
        SSH_KEY = 'ec2-ssh-key'                  // Jenkins SSH private key credentials
        EC2_USER = 'ec2-user'                    // Default for Amazon Linux
        JAR_NAME = 'myapp.jar'
    }
 triggers {
        githubPush() // Auto trigger when code is pushed to GitHub (webhook needed)
    }
    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Java App') {
            steps {
                sh 'mvn clean package'
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

        stage('Terraform Apply EC2') {
            steps {
                dir("${TF_DIR}") {
                    sh 'terraform apply -auto-approve'
                }
            }
        }

        stage('Deploy to EC2') {
            steps {
                script {
                    def publicIp = sh(script: "terraform -chdir=${TF_DIR} output -raw public_ip", returnStdout: true).trim()

                    withCredentials([sshUserPrivateKey(credentialsId: "${SSH_KEY}", keyFileVariable: 'KEYFILE')]) {
                        sh """
                            scp -o StrictHostKeyChecking=no -i $KEYFILE target/${JAR_NAME} ${EC2_USER}@${publicIp}:/home/${EC2_USER}/
                            ssh -o StrictHostKeyChecking=no -i $KEYFILE ${EC2_USER}@${publicIp} 'nohup java -jar /home/${EC2_USER}/${JAR_NAME} > app.log 2>&1 &'
                        """
                    }
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}
