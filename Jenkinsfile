pipeline {
  agent any

  stages {
    stage('Checkout') {
      steps {
        git url: 'https://github.com/sails-gowthamssd/terraform-gcp-jenkins-infra.git', branch: 'main'
      }
    }

    stage('Prepare Credentials') {
      steps {
        withCredentials([file(credentialsId: 'TERRAFORM_SA_KEY', variable: 'TF_SA_KEY')]) {
          sh '''
            cp $TF_SA_KEY terraform-sa.json
            export GOOGLE_APPLICATION_CREDENTIALS=$PWD/terraform-sa.json
            terraform -version
          '''
        }
      }
    }

    stage('Terraform Init') {
      steps {
        dir('infra') {
          sh 'terraform init'
        }
      }
    }

    stage('Terraform Plan') {
      steps {
        dir('infra') {
          sh 'terraform plan -var-file=terraform.tfvars'
        }
      }
    }

    stage('Terraform Apply') {
      steps {
        input message: "Approve apply?"
        dir('infra') {
          sh 'terraform apply -auto-approve -var-file=terraform.tfvars'
        }
      }
    }
  }

  post {
    cleanup {
      sh 'rm -f terraform-sa.json'
    }
  }
}
