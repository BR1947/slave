pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Building...'
                // Add your build steps here, e.g., compiling code, downloading dependencies
            }
        }
        
        stage('Test') {
            steps {
                echo 'Testing...'
                // Add your test steps here, e.g., running unit tests, static code analysis
            }
        }
        
        stage('Deploy') {
            steps {
                echo 'Deploying...'
                // Add your deployment steps here, e.g., copying files, restarting services
            }
        }
    }

    post {
        always {
            echo 'This will always run'
        }
        success {
            echo 'This will run only if the pipeline succeeds'
        }
        failure {
            echo 'This will run only if the pipeline fails'
        }
    }
}
