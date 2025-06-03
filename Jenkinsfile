pipeline {
  agent any

  parameters {
    choice(name: 'ACTION', choices: ['apply', 'destroy'], description: 'Choose Terraform actionss to perform')
  }

  environment {
    GOOGLE_APPLICATION_CREDENTIALS = "${WORKSPACE}\\terraform-sa.json"
  }

  stages {
    stage('Checkout') {
      steps {
        git url: 'https://github.com/sails-gowthamssd/terraform-gcp-jenkins-infra.git', branch: 'main'
      }
    }

    stage('Prepare Credentials') {
      steps {
        withCredentials([file(credentialsId: 'TERRAFORM_SA_KEY', variable: 'TF_SA_KEY')]) {
          bat 'copy %TF_SA_KEY% terraform-sa.json'
        }
      }
    }

    stage('Terraform Init') {
      steps {
        dir('gke-helloworld') {
          bat 'terraform init'
        }
      }
    }

    stage('Terraform Plan') {
      steps {
        dir('gke-helloworld') {
          bat "terraform plan -var-file=terraform.tfvars"
        }
      }
    }

    stage('Terraform Apply or Destroy') {
      steps {
        script {
          if (params.ACTION == 'apply') {
            input message: "Approve apply?"
            dir('gke-helloworld') {
              bat "terraform apply -auto-approve -var-file=terraform.tfvars"
            }
          } else if (params.ACTION == 'destroy') {
            input message: "Approve destroy?"
            dir('gke-helloworld') {
              bat "terraform destroy -auto-approve -var-file=terraform.tfvars"
            }
          }
        }
      }
    }
  }

  post {
    cleanup {
      bat 'del terraform-sa.json'
    }
  }
}
