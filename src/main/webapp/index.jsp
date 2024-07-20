<html>
<body>
<h2>pipeline {
    agent { label 'slave' }
    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub_id')
    }
    stages {
        stage('Git clone') {
            steps {
                git 'https://github.com/BR1947/demo-java.git'
            }
        }
        stage('Check Docker Installation and Permissions') {
            steps {
                script {
                    def dockerInstalled = sh(script: 'command -v docker', returnStatus: true)
                    if (dockerInstalled != 0) {
                        echo 'Docker not found, installing Docker...'
                        sh '''
                            set -e
                            if [ -x "$(command -v apt-get)" ]; then
                                sudo apt-get update
                                sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
                                curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
                                sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
                                sudo apt-get update
                                sudo apt-get install -y docker-ce
                            elif [ -x "$(command -v yum)" ]; then
                                sudo yum install -y yum-utils
                                sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
                                sudo yum install -y docker-ce docker-ce-cli containerd.io
                                sudo systemctl start docker
                                sudo systemctl enable docker
                            else
                                echo "Unsupported OS. Install Docker manually."
                                exit 1
                            fi
                        '''
                    } else {
                        echo 'Docker is already installed.'
                    }
                    // Add Jenkins user to Docker group
                    sh 'sudo usermod -aG docker jenkins || true' // Continue if usermod fails
                    // Restart Docker service
                    sh 'sudo systemctl restart docker || true'
                    // Restart Jenkins service
                    sh 'sudo systemctl restart jenkins || true'
                    // Verify Docker installation and permissions
                    sh 'docker --version'
                    sh 'docker ps || true' // Continue if docker ps fails
                }
            }
        }
        stage('Build') {
            steps {
                script {
                    sh 'chmod +x bin/build'
                    sh 'ls -l bin'
                    sh './bin/build .'
                }
            }
        }
        stage('Login') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'dockerhub_id', usernameVariable: 'DOCKERHUB_USER', passwordVariable: 'DOCKERHUB_PASS')]) {
                        sh 'echo $DOCKERHUB_PASS | docker login -u $DOCKERHUB_USER --password-stdin'
                    }
                }
            }
        }
        stage('Tag and Push') {
            steps {
                script {
                    def buildNumber = env.BUILD_NUMBER
                    sh "docker tag demo-java br1947/dockertestimages:demo-java-${buildNumber}"
                    sh "docker push br1947/dockertestimages:demo-java-${buildNumber}"
                }
            }
        }
    }
    post {
        always {
            sh 'docker logout || true' // Ensure docker logout always runs and continues even if it fails
        }
    }
}
: src/main/webapp/index.jsp</h2>
</body>
</html>
