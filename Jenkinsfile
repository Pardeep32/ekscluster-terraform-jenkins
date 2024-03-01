pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        AWS_DEFAULT_REGION = "ca-central-1"
    }
    stages {
        stage('Checkout SCM'){
            steps{
                script{
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/Pardeep32/ekscluster-terraform-jenkins.git']])    
                }
            }
        }
        stage('Initializing Terraform'){
            steps{
                script{
                    dir('EKS cluster'){
                        sh 'terraform init'
                    }
                }
            }
        }
        
        stage('Previewing the Infra using Terraform'){
            steps{
                script{
                    dir('EKS cluster'){
                        sh 'terraform plan'
                    }
                    input(message: "Are you sure to proceed?", ok: "Proceed")
                }
            }
        }
        stage('Creating/Destroying an EKS Cluster'){
            steps{
                script{
                    dir('EKS cluster') {
                        sh 'terraform $Action --auto-approve'
                    }
                }
            }
        }
        
    }
}
