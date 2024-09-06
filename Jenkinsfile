pipeline{
    agent any
    tools{
        maven 'maven3'
    }
    environment {
        AWS_REGION = 'ap-south-1' // Update region accordingly
    }
    
    stages{
        
        stage('Clone Git Repository'){
            steps{
                git branch: 'main', credentialsId: 'git_credentials', url: 'https://github.com/Shubhuk7051/java_app.git'
            }
        }
        
        stage('Build'){
            steps{
                sh 'mvn clean package'
            }
        }
        
        stage('Deploy to AWS CodeDeploy'){
            steps{
                withCredentials([aws(accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'aws_secrets', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                    script{
                        def applicationName= 'simple_web'
                        def deploymentGroupName = 'simple_web_CD'
                    
                        awsCodeDeploy applicationName: applicationName,
                                deploymentGroupName: deploymentGroupName,
                                region: "${env.AWS_REGION}"
                    }
                }
                
            }
        }
    }
}